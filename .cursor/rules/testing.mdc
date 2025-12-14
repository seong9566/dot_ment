---
alwaysApply: true
---
# Testing

## Unit Tests (ViewModel & Repository)
```dart
// test/features/trainer/viewmodel/trainer_dashboard_viewmodel_test.dart
void main() {
  late ProviderContainer container;
  late MockTrainerRepository mockRepository;
  
  setUp(() {
    mockRepository = MockTrainerRepository();
    container = ProviderContainer(
      overrides: [
        trainerRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });
  
  tearDown(() {
    container.dispose();
  });
  
  test('초기 상태는 loading이어야 함', () {
    final state = container.read(trainerDashboardProvider);
    expect(state, isA<AsyncLoading>());
  });
  
  test('성공 시 trainer 리스트를 반환해야 함', () async {
    when(() => mockRepository.getTrainers())
        .thenAnswer((_) async => Right([mockTrainer]));
    
    final state = await container.read(trainerDashboardProvider.future);
    expect(state.trainers, [mockTrainer]);
  });
}
```

## Widget Tests
```dart
// test/features/trainer/view/trainer_dashboard_view_test.dart
void main() {
  testWidgets('Loading 상태일 때 CircularProgressIndicator 표시', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trainerDashboardProvider.overrideWith((ref) => 
            const AsyncValue.loading()),
        ],
        child: const MaterialApp(
          home: TrainerDashboardView(),
        ),
      ),
    );
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

## Golden Tests (UI Regression)
```dart
testWidgets('TrainerCard golden test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: TrainerCard(trainer: mockTrainer),
    ),
  );
  
  await expectLater(
    find.byType(TrainerCard),
    matchesGoldenFile('goldens/trainer_card.png'),
  );
});
```
