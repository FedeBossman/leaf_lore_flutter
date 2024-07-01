import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:leaf_lore_flutter/main.dart'; 
import 'package:leaf_lore_flutter/features/dashboard/home_page.dart'; 
import 'package:leaf_lore_flutter/features/login/login_page.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigates to HomePage if user is authenticated', (WidgetTester tester) async {
    final mockAuth = MockFirebaseAuth();
    final mockUser = MockUser();

    when(mockAuth.authStateChanges()).thenAnswer((_) => Stream.value(mockUser));
    when(mockUser.emailVerified).thenReturn(true);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<FirebaseAuth>.value(value: mockAuth),
        ],
        child: MyApp('en_US', [Locale('en', 'US')]),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsOneWidget);
  });

  testWidgets('Navigates to LoginPage if user is not authenticated', (WidgetTester tester) async {
    final mockAuth = MockFirebaseAuth();

    when(mockAuth.authStateChanges()).thenAnswer((_) => Stream.value(null));

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<FirebaseAuth>.value(value: mockAuth),
        ],
        child: MyApp('en_US', [Locale('en', 'US')]),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
