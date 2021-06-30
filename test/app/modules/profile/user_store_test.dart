import 'package:flutter_test/flutter_test.dart';
import 'package:iesbgram/app/modules/profile/user_store.dart';
 
void main() {
  late UserStore store;

  setUpAll(() {
    store = UserStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}