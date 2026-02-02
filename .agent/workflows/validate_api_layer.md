---
description: API 레이어 검증 - 아키텍처 규칙 준수 여부 확인
---

# API 레이어 검증 Workflow

## 검증 대상 파일

검증할 feature 디렉토리 내 다음 파일들을 분석:
- `data/dto/request/*.dart`, `data/dto/response/*.dart`
- `data/datasources/*_remote_data_source.dart`
- `data/repositories/*_repository_impl.dart`
- `domain/entities/*.dart`, `domain/repositories/*.dart`, `domain/usecases/*.dart`
- `presentation/providers/*_providers_di.dart`

---

## 검증 규칙

### 1. Request DTO
| 규칙 | 체크 |
|-----|-----|
| `@freezed` 사용 금지 | ❌ |
| `toMap()` 메서드 필수 (GET용) | ✅ |
| `toJson()` 메서드 필수 (POST용) | ✅ |

### 2. Response DTO
| 규칙 | 체크 |
|-----|-----|
| `@freezed` 사용 필수 | ✅ |
| `fromJson()` 팩토리 필수 | ✅ |
| `toEntity()` extension 필수 | ✅ |

### 3. RemoteDataSource
| 규칙 | 체크 |
|-----|-----|
| `safeApiCall` 패턴 사용 | ✅ |
| 반환 타입 `BaseResponse<DTO>` | ✅ |
| GET → `queryParameters` 사용 | ✅ |
| POST/PUT/DELETE → `data` (body) 사용 | ✅ |

### 4. Repository
| 규칙 | 체크 |
|-----|-----|
| Domain 파라미터 받음 (DTO 직접 받지 않음) | ✅ |
| 내부에서 ReqDto 생성 | ✅ |
| 리스트 조회: `mapListOrEmpty()` 사용 | ✅ |
| 상세 조회: `mapOrThrow()` 사용 | ✅ |
| try-catch 사용 금지 (safeApiCall에서 처리) | ❌ |

### 5. Domain Layer (Entity/Repository Interface/UseCase)
| 규칙 | 체크 |
|-----|-----|
| Entity: `@freezed` 사용 | ✅ |
| Repository Interface: primitive 타입만 (DTO 금지) | ✅ |
| UseCase: `.call()` 메서드, DTO 미사용 | ✅ |
| DTO/HTTP/UI import 금지 | ❌ |

### 6. Provider DI
| 규칙 | 체크 |
|-----|-----|
| `@riverpod` 사용 | ✅ |
| 순서: DataSource → Repository → UseCase | ✅ |

---

## 위반 예시

### RemoteDataSource
```dart
// ❌ 잘못된 예시
Future<UserRespDto> getUser() async {
  final response = await _dio.get('/users');
  return UserRespDto.fromJson(response.data);
}

// ✅ 올바른 예시
Future<BaseResponse<UserRespDto>> getUser(int id) => safeApiCall(
  apiCall: (opt) => _dio.get(endpoint, queryParameters: {'id': id}, options: opt),
  dataParser: (json) => UserRespDto.fromJson(json),
);
```

### Repository
```dart
// ❌ 잘못된 예시 - DTO를 직접 받음
Future<List<Entity>> getList(ReqDto req) async { ... }

// ✅ 올바른 예시 - 리스트 조회
Future<List<Entity>> getList({required int categoryId}) async {
  final reqDto = ReqDto(categoryId: categoryId);
  final response = await _remoteDataSource.getList(reqDto);
  return response.mapListOrEmpty((dto) => dto.toEntity());
}

// ✅ 올바른 예시 - 상세 조회
Future<Entity> getDetail(int id) async {
  final response = await _remoteDataSource.getDetail(id);
  return response.mapOrThrow(
    (dto) => dto.toEntity(),
    errorMessage: '정보를 불러오는데 실패했습니다.',
  );
}
```

### Domain Layer Import
```dart
// ❌ 금지
import 'package:dio/dio.dart';
import '../data/dto/response/user_resp_dto.dart';

// ✅ 허용
import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/user_entity.dart';
```

---

## 검증 결과 형식

```
### ✅ 통과
- [항목]: 규칙 준수

### ⚠️ 경고
- [항목]: 개선 권장

### ❌ 위반
- [항목]: [문제] → [해결방법]
```

---

## 빠른 검증 명령어

```bash
# safeApiCall 미사용 확인
grep -r "Future<.*RespDto>" lib/features/*/data/datasources/ --include="*.dart"

# Domain/Presentation에 BaseResponse 노출 확인
grep -r "BaseResponse" lib/features/*/domain/ lib/features/*/presentation/ --include="*.dart"

# Domain에 DTO import 확인
grep -r "import.*dto" lib/features/*/domain/ --include="*.dart"
```
