---
alwaysApply: true
---
# Security

## 환경 변수 관리
```dart
// .env
API_URL=https://api.example.com
API_KEY=your_secret_key

// lib/core/config/env.dart
class Env {
  static String get apiUrl => dotenv.env['API_URL']!;
  static String get apiKey => dotenv.env['API_KEY']!;
}

// ✅ GOOD
final baseUrl = Env.apiUrl;

// ❌ BAD: 하드코딩
final baseUrl = 'https://api.example.com';
```

## Secure Storage
```dart
// ✅ GOOD: flutter_secure_storage로 민감 정보 저장
final storage = ref.watch(secureStorageProvider);
await storage.write(key: 'auth_token', value: token);
final token = await storage.read(key: 'auth_token');

// ✅ GOOD: shared_preferences로 비민감 정보 저장
final prefs = await SharedPreferences.getInstance();
await prefs.setString('theme_mode', 'dark');
```

## 로깅 보안
```dart
// ✅ GOOD: 민감 정보 제외
logger.d('Login successful for user: ${user.id}');

// ❌ BAD: 민감 정보 로깅
logger.d('Token: $authToken'); // 절대 금지
logger.d('Password: $password'); // 절대 금지
```
