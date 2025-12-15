---
alwaysApply: true
---
# Naming Conventions

## 파일 및 폴더
- `snake_case`: `trainer_dashboard_view.dart`, `auth_repository.dart`

## 클래스
- `PascalCase`: `TrainerDashboardView`, `AuthRepository`
- ViewModel 접미사: `TrainerDashboardViewModel`
- Repository 접미사: `TrainerRepository`, `TrainerRepositoryImpl`
- Model 접미사: `TrainerModel` (data layer), `Trainer` (domain layer)

## 변수 및 메서드
- `camelCase`: `userName`, `fetchTrainers()`, `isLoading`

## 상수
- `lowerCamelCase`: `maxRetryCount`, `defaultTimeout`
- 클래스 내부 상수: `static const maxLength = 100;`

## Provider
```dart
// ✅ GOOD: 명확한 네이밍
@riverpod
FutureOr<List<Trainer>> trainerList(Ref ref) async { ... }

@riverpod
class TrainerDashboard extends _$TrainerDashboard { ... }

// 생성된 Provider: trainerListProvider, trainerDashboardProvider
```
