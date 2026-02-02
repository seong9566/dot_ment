# 위젯 분리 규칙

## 🎯 목적
- 코드 재사용성 향상
- 가독성 개선
- 테스트 용이성 증가
- 파일 크기 관리

## 📋 분리 기준

### 1. Private Widget 클래스 분리
**규칙**: View 파일 내에 정의된 `_WidgetName` 형식의 private 위젯은 별도 파일로 분리

**분리 대상**:
- `StatelessWidget` 또는 `StatefulWidget`을 상속한 private 클래스
- 50줄 이상의 build 메서드를 가진 위젯
- 다른 화면에서도 재사용 가능한 UI 컴포넌트

**❌ 잘못된 예시**:
```dart
// user_list_view.dart
class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: users.map((user) => _UserCard(user: user)).toList(),
    );
  }
}

class _UserCard extends StatelessWidget {
  final User user;
  const _UserCard({required this.user});
  
  @override
  Widget build(BuildContext context) {
    // 50+ lines of UI code
  }
}
```

**✅ 올바른 예시**:
```dart
// user_list_view.dart
import 'package:app/features/user/presentation/widgets/user_card.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: users.map((user) => UserCard(user: user)).toList(),
    );
  }
}

// widgets/user_card.dart
class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    // UI code
  }
}
```

### 2. 파일 구조

**위젯 파일 위치**:
```
lib/
└── features/
    └── <feature>/
        └── presentation/
            ├── views/          # 화면 파일
            │   └── user_list_view.dart
            └── widgets/        # 재사용 가능한 위젯
                ├── user_card.dart
                └── user_avatar.dart
```

### 3. 네이밍 규칙

| 타입 | 네이밍 | 예시 |
|------|--------|------|
| View 파일 | `<screen_name>_view.dart` | `user_list_view.dart` |
| Widget 파일 | `<widget_name>.dart` | `user_card.dart` |
| Widget 클래스 | `PascalCase` (public) | `UserCard` |

**주의**: Private 위젯(`_WidgetName`)을 분리할 때는 public 클래스(`WidgetName`)로 변경

### 4. 모델 클래스 분리

**UI 전용 모델**: 위젯과 함께 export 가능
```dart
// widgets/event_card.dart
class EventItem {
  final String id;
  final String title;
  // ...
}

class EventCard extends StatelessWidget {
  final EventItem event;
  // ...
}
```

## ⚠️ 예외 사항

**분리하지 않아도 되는 경우**:
- 10줄 이하의 간단한 helper 위젯 (`_Divider`, `_Spacer` 등)
- 해당 화면에서만 사용되는 단순 wrapper 위젯
- 상태 관리 로직이 포함된 internal 위젯

**예시**:
```dart
// 이런 간단한 위젯은 분리하지 않아도 됨
class HomeView extends StatelessWidget {
  Widget _buildDivider() => const Divider(height: 1);
  
  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), child],
    );
  }
}
```

---

## 🎨 UI 빌드 메서드 분리 (가독성 향상)

### 규칙
**Scaffold 바로 하위 섹션은 별도 메서드로 분리**

Scaffold의 body에 있는 주요 UI 섹션들을 `_buildXxx()` 형식의 메서드로 분리하여 가독성을 높입니다.

### 분리 대상
- AppBar 커스터마이징이 복잡한 경우
- 검색바, 필터 섹션
- 리스트/그리드 위젯
- 하단 버튼/액션 영역
- 복잡한 Padding/Container 래핑

### ❌ 메서드 분리 전
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: '검색하세요',
              // ... 20줄의 decoration 코드
            ),
          ),
        ),
        // ... 50줄의 리스트 코드
        // ... 30줄의 버튼 코드
      ],
    ),
  );
}
```

### ✅ 메서드 분리 후
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        _buildSearchBar(),
        _buildFilterSection(),
        _buildEventList(),
        _buildNextButton(),
      ],
    ),
  );
}

/// 검색바 위젯
Widget _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: '검색하세요',
        // decoration 코드
      ),
    ),
  );
}

/// 공연 목록 리스트
Widget _buildEventList() {
  return Expanded(
    child: ListView.builder(
      // list builder 코드
    ),
  );
}
```

### 네이밍 규칙
- `_build` 접두사 사용
- 명확한 섹션명 (camelCase)
- 예: `_buildSearchBar()`, `_buildFilterSection()`, `_buildEventList()`

### 주석 규칙
- 각 메서드 위에 `///` 문서 주석 추가
- 간결하게 해당 섹션의 역할 설명

### 장점
- **가독성**: build 메서드가 간결해져 전체 구조 파악 용이
- **유지보수**: 각 섹션을 독립적으로 수정 가능
- **테스트**: 개별 섹션 단위 테스트 작성 용이

---


## 🏗️ 메서드 배치 순서

### 규칙
View 파일 내 메서드들은 다음과 같은 순서로 배치해야 합니다.

1. **상태 변수 및 Controller 선언**
2. **`initState`, `dispose` 등 생명주기 메서드**
3. **사용자 정의 함수 (Logic, Event Handler)**
   - 반환값이 `Widget`이 아닌 함수들 (예: `void`, `Future<void>`, `bool` 등)
   - **반드시 `build()` 메서드 위에 위치해야 합니다.**
4. **`build()` 메서드**
5. **UI 빌드 메서드 (`_buildXxx`)**

### ✅ 올바른 순서 예시
```dart
class _MyViewState extends State<MyView> {
  // 1. 변수/Controller
  final TextEditingController _controller = TextEditingController();

  // 2. 생명주기
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 3. 사용자 정의 함수 (Widget build 위에 위치)
  void _handleSubmit() {
    // 로직 처리
  }

  bool get _isValid => _controller.text.isNotEmpty;

  // 4. build 메서드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildInputSection(),
        ],
      ),
    );
  }

  // 5. UI 빌드 메서드
  Widget _buildInputSection() {
    return TextField(controller: _controller);
  }
}
```

---
## ✅ 체크리스트

### PR 전 자가 점검
- [ ] View 파일에 `_WidgetName` 형식의 클래스가 있는가?
- [ ] 해당 위젯이 50줄 이상인가?
- [ ] 다른 화면에서도 재사용 가능한가?
- [ ] 위젯이 `widgets/` 폴더에 분리되었는가?
- [ ] 분리된 위젯이 public 클래스인가?
- [ ] import 경로가 올바른가?

### 리뷰어 체크 포인트
- 위젯 분리가 적절히 되어 있는지 확인
- 파일 구조가 규칙을 따르는지 확인
- 재사용성과 가독성이 향상되었는지 평가

---

**작성일**: 2026-01-13  
**목적**: 코드 구조 개선 및 유지보수성 향상
