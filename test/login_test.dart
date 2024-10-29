import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tetse/Screens/login.dart';
import 'package:tetse/Services/AuthService.dart';
import 'package:tetse/Services/AccessService.dart';
import 'package:tetse/Controller/LocationChecker.dart';

// Mock classes
class MockAuthService extends Mock implements AuthService {
  @override
  Future<User?> login(String email, String password) async => null;
}

class MockAccessService extends Mock implements AccessService {
  @override
  Future<void> registrarAcesso(bool sucesso) async {}
}

class MockLocationChecker extends Mock implements LocationChecker {
  @override
  Future<bool> isWithInRestrictedArea() async => false;
}

void main() {
  testWidgets('AuthScreen displays error message when not in restricted area', (WidgetTester tester) async {
    // Arrange
    final mockAuthService = MockAuthService();
    final mockAccessService = MockAccessService();
    final mockLocationChecker = MockLocationChecker();

    // Configuração correta do mock
    when(mockLocationChecker.isWithInRestrictedArea()).thenAnswer((_) async => false);
    when(mockAuthService.login("test@example.com", "password")).thenAnswer((_) async => null);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            Provider<AuthService>.value(value: mockAuthService),
            Provider<AccessService>.value(value: mockAccessService),
            Provider<LocationChecker>.value(value: mockLocationChecker),
          ],
          child: AuthScreen(),
        ),
      ),
    );

    // Simula entrada de dados e envio
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert
    expect(find.text('Você não está na área restrita.'), findsOneWidget);
  });
}
