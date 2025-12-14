---
alwaysApply: true
---
# Performance Optimization

## 리스트 최적화
```dart
// ✅ GOOD: builder 사용
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(item: items[index]),
)

// ✅ GOOD: separated로 구분선 추가
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(item: items[index]),
  separatorBuilder: (context, index) => const Divider(),
)

// ❌ BAD: children으로 전체 리스트 생성
ListView(
  children: items.map((item) => ItemWidget(item: item)).toList(),
)
```

## 불필요한 rebuild 방지
```dart
// ✅ GOOD: const 생성자 사용
const Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Static Text'),
)

// ✅ GOOD: Consumer로 필요한 부분만 rebuild
Consumer(
  builder: (context, ref, child) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  },
)
```

## Heavy Computation 처리
```dart
// ✅ GOOD: compute 함수 사용
Future<List<Trainer>> parseTrainers(String jsonString) async {
  return compute(_parseTrainersInBackground, jsonString);
}

List<Trainer> _parseTrainersInBackground(String jsonString) {
  final parsed = jsonDecode(jsonString) as List;
  return parsed.map((json) => Trainer.fromJson(json)).toList();
}
```

## 이미지 최적화
```dart
// ✅ GOOD: 적절한 크기로 캐싱
CachedNetworkImage(
  imageUrl: url,
  memCacheWidth: 200, // 메모리 캐시 크기 제한
  memCacheHeight: 200,
)
```

## 추가 최적화 규칙
- `shrinkWrap: true`는 꼭 필요한 경우에만 사용
- Pagination/lazy loading을 대용량 리스트에 구현
- `const` 생성자를 최대한 활용하여 불필요한 rebuild 방지
