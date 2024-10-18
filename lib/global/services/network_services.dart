//use dart.io to check for internet connection
import 'dart:io';

class NetworkServices {
  Future<bool> checkAirtableConnection() async {
    try {
      final result = await InternetAddress.lookup('airtable.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
