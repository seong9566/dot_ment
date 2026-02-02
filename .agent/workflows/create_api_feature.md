---
description: 새 API Feature 생성 - Data/Domain/Presentation 전체 레이어 구조 생성
---

# 새 API Feature 생성 Workflow

## 사전 준비
1. API 스펙 문서 확인 (`docs/api/`)
2. Feature/Action 이름 확정 (예: `sell`/`ticket`)

---

## Step 1: 디렉토리 구조

```
lib/features/<feature>/
├── data/
│   ├── datasources/<feature>_remote_data_source.dart
│   ├── dto/request/<feature>_<action>_req_dto.dart
│   ├── dto/response/<feature>_<action>_resp_dto.dart
│   └── repositories/<feature>_repository_impl.dart
├── domain/
│   ├── entities/<feature>_<action>_entity.dart
│   ├── repositories/<feature>_repository.dart
│   └── usecases/get_<feature>_<action>_usecase.dart
└── presentation/
    ├── providers/<feature>_providers_di.dart
    ├── ui_models/<feature>_<action>_ui_model.dart  # ★ UiModel 필수
    ├── viewmodels/
    │   ├── <feature>_<action>_state.dart           # ★ State 분리
    │   └── <feature>_<action>_viewmodel.dart
    ├── views/<feature>_<action>_view.dart
    └── widgets/<feature>_<widget_name>.dart     # ★ 위젯 분리
```

---

## Step 2: Data Layer

### Response DTO (@freezed 필수)
```dart
@freezed
abstract class <Feature><Action>RespDto with _$<Feature><Action>RespDto {
  const factory <Feature><Action>RespDto({required int id, required String name}) = _;
  factory <Feature><Action>RespDto.fromJson(Map<String, dynamic> json) => _$...FromJson(json);
}

extension <Feature><Action>RespDtoX on <Feature><Action>RespDto {
  <Feature><Action>Entity toEntity() => <Feature><Action>Entity(id: id, name: name);
}
```

### Request DTO (@freezed 금지)
```dart
class <Feature><Action>ReqDto {
  final int categoryId;
  const <Feature><Action>ReqDto({required this.categoryId});
  
  Map<String, dynamic> toMap() => {'categoryId': categoryId};  // GET용
  Map<String, dynamic> toJson() => {'categoryId': categoryId}; // POST용
}
```

### RemoteDataSource
```dart
class <Feature>RemoteDataSourceImpl implements <Feature>RemoteDataSource {
  final Dio _dio;
  
  // GET: queryParameters
  Future<BaseResponse<List<RespDto>>> getList(ReqDto req) => safeApiCall(
    apiCall: (opt) => _dio.get(endpoint, queryParameters: req.toMap(), options: opt),
    dataParser: (json) => (json as List).map((e) => RespDto.fromJson(e)).toList(),
  );
  
  // POST/PUT/DELETE: data (body)
  Future<BaseResponse<RespDto>> create(ReqDto req) => safeApiCall(
    apiCall: (opt) => _dio.post(endpoint, data: req.toJson(), options: opt),
    dataParser: (json) => RespDto.fromJson(json),
  );
}
```

### Repository (Domain 파라미터 → DTO 변환)
```dart
class <Feature>RepositoryImpl implements <Feature>Repository {
  // 리스트 조회: mapListOrEmpty 사용
  Future<List<Entity>> getList({required int categoryId}) async {
    final reqDto = ReqDto(categoryId: categoryId);
    final response = await _remoteDataSource.getList(reqDto);
    return response.mapListOrEmpty((dto) => dto.toEntity());
  }

  // 상세 조회: mapOrThrow 사용
  Future<Entity> getDetail(int id) async {
    final response = await _remoteDataSource.getDetail(id);
    return response.mapOrThrow(
      (dto) => dto.toEntity(),
      errorMessage: '정보를 불러오는데 실패했습니다.',
    );
  }
}
```

---

## Step 3: Domain Layer (DTO 사용 금지)

### Entity (@freezed 필수)
```dart
@freezed
abstract class <Feature><Action>Entity with _$<Feature><Action>Entity {
  const factory <Feature><Action>Entity({required int id, required String name}) = _;
}
```

### Repository Interface (primitive 타입만)
```dart
abstract class <Feature>Repository {
  Future<List<Entity>> getList({required int categoryId, String? keyword});
  Future<Entity> getDetail(int id);
}
```

### UseCase
```dart
class Get<Feature><Action>ListUsecase {
  final <Feature>Repository _repository;
  Future<List<Entity>> call({required int categoryId}) => _repository.getList(categoryId: categoryId);
}
```

---

## Step 4: Provider DI
```dart
@riverpod <Feature>RemoteDataSource ds(ref) => <Feature>RemoteDataSourceImpl(ref.read(dioProvider));
@riverpod <Feature>Repository repo(ref) => <Feature>RepositoryImpl(ref.read(dsProvider));
@riverpod GetListUsecase usecase(ref) => GetListUsecase(ref.read(repoProvider));
```

---

## Step 5: Presentation Layer

### UiModel (@freezed abstract class, fromEntity 필수)
```dart
@freezed
abstract class <Feature><Action>UiModel with _$<Feature><Action>UiModel {
  const factory <Feature><Action>UiModel({
    required int id,
    required String title,
    required String formattedDate,  // UI용 변환된 데이터
  }) = _<Feature><Action>UiModel;

  factory <Feature><Action>UiModel.fromEntity(<Feature><Action>Entity entity) {
    return <Feature><Action>UiModel(
      id: entity.id,
      title: entity.title,
      formattedDate: DateFormat('yyyy.MM.dd').format(entity.date),
    );
  }
}
```

### State (별도 파일: `_state.dart`)
```dart
@freezed
abstract class <Feature><Action>State with _$<Feature><Action>State {
  const factory <Feature><Action>State({
    @Default([]) List<<Feature><Action>UiModel> items,  // UiModel 사용
    @Default(0) int totalCount,
    @Default(null) int? selectedId,
  }) = _<Feature><Action>State;
}
```

### ViewModel (Entity→UiModel 변환)
```dart
@riverpod
class <Feature><Action>ViewModel extends _$<Feature><Action>ViewModel {
  late int _param;  // Family 파라미터 저장

  @override
  Future<<Feature><Action>State> build(int param) async {
    _param = param;
    final entities = await ref.read(usecaseProvider).call(param);
    // Entity → UiModel 변환
    final uiModels = entities.map((e) => <Feature><Action>UiModel.fromEntity(e)).toList();
    return <Feature><Action>State(items: uiModels, totalCount: uiModels.length);
  }

  void select(int? id) {
    state.whenData((data) {
      state = AsyncValue.data(data.copyWith(selectedId: id));
    });
  }
}
```

> **주의**: `state.valueOrNull` 대신 `state.value` 사용

---

## Step 6: Build Runner

// turbo
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 체크리스트

| Layer | 항목 |
|-------|-----|
| **Data** | Response DTO: `@freezed abstract class`, `fromJson()`, `toEntity()` |
| | Request DTO: `toMap()`/`toJson()`, `@freezed` 금지 |
| | RemoteDataSource: GET→`queryParameters`, POST→`data` |
| | Repository: `mapListOrEmpty`/`mapOrThrow` 사용, try-catch 금지 |
| **Domain** | Entity: `@freezed abstract class` |
| | Repository Interface: primitive 타입만 |
| | UseCase: `.call()` 메서드 |
| **Presentation** | UiModel: `@freezed abstract class`, `fromEntity()` 필수 |
| | State: 별도 파일로 분리 (`_state.dart`) |
| | ViewModel: Entity→UiModel 변환, `state.value` 사용 |
| | Widget: 50줄 이상 시 `widgets/` 폴더로 분리 |
| | Provider DI: `@riverpod` |