---
alwaysApply: true
---
# Forbidden Practices

## ❌ 절대 금지
- `setState` 사용 (모든 상태는 Riverpod로)
- `BuildContext`를 ViewModel에 전달
- `print()` 사용 (logger 사용)
- View에서 Repository 직접 호출
- `GetIt` 같은 Service Locator 패턴
- Manual provider 선언 (`Provider()`, `StateProvider()` 등)
- 하드코딩된 문자열, 색상, 스타일
- `Image.network` 직접 사용 (CachedNetworkImage 사용)
- 민감 정보 로깅 (token, password 등)
- `*.freezed.dart`, `*.g.dart` .gitignore 추가
- `Navigator.of(context).push()` 사용 (GoRouter 사용)

## ⚠️ 주의 필요
- `ref.read()` in build method (대신 `ref.watch()` 사용)
- `keepAlive: true` (메모리 누수 가능성)
- `shrinkWrap: true` (성능 저하 가능성)
- Global variables
- Deeply nested widgets (3단계 이상)
