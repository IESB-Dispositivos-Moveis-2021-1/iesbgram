import 'package:flutter_test/flutter_test.dart';
import 'package:iesbgram/app/modules/onboarding/onboarding_store.dart';
 
void main() {
  late OnboardingStore store;

  setUpAll(() {
    store = OnboardingStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}