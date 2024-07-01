import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/features/profile/profile_page.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {
  @override
  // ignore: non_constant_identifier_names
  String profilePage_signOut = 'Sign Out';
  @override
  // ignore: non_constant_identifier_names
  String profilePage_noNameAvailable = 'No Name';
  @override
  // ignore: non_constant_identifier_names
  String profilePage_noEmailAvailable = 'No Email';
  @override
  // ignore: non_constant_identifier_names
  String profilePage_noUidAvailable = 'No UID';
}

class MockLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const MockLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return MockAppLocalizations();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

void main() {
  group('ProfilePage Tests', () {
    final user = MockUser(
      isAnonymous: false,
      uid: 'testuid',
      email: 'testuser@example.com',
      displayName: 'Test User',
    );
    final mockAuth = MockFirebaseAuth(mockUser: user, signedIn: true);

    testWidgets('displays user information correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            MockLocalizationsDelegate(),
          ],
          home: Provider<FirebaseAuth>(
            create: (_) => mockAuth,
            child: const ProfilePage(),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('testuser@example.com'), findsOneWidget);
      expect(find.text('testuid'), findsNothing);
    });

    testWidgets('sign out button is seen on the page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            MockLocalizationsDelegate(),
          ],
          home: Provider<FirebaseAuth>(
            create: (_) => mockAuth,
            child: const ProfilePage(),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('signs out when button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            MockLocalizationsDelegate(),
          ],
          home: Provider<FirebaseAuth>(
            create: (_) => mockAuth,
            child: const ProfilePage(),
          ),
        ),
      );

      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('signOutButton')));
      await tester.pump();

      verify(mockAuth.signOut()).called(1);
    });
  });
}
