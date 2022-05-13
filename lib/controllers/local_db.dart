import 'package:get_storage/get_storage.dart';

class LocalDB {
  // LocalDB();
  static var box = GetStorage();

  static add(String key, dynamic value) async {
    await box.write(key, value);
    print(get(key));
  }

  static remove(String key) {
    box.remove(key);
  }

  static get(String key) {
    return box.read(key);
  }
}
