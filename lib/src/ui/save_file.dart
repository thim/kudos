import 'dart:async';
import 'dart:developer';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

class FileSaverWeb {
  static Future<bool> downloadFile(Uint8List bytes, String name, String type) async {
    bool _success = false;
    try {
      String _url = Url.createObjectUrlFromBlob(Blob([bytes], type));
      HtmlDocument htmlDocument = document;
      AnchorElement anchor = htmlDocument.createElement('a') as AnchorElement;
      anchor.href = _url;
      anchor.style.display = name;
      anchor.download = name;
      document.body!.children.add(anchor);
      anchor.click();
      document.body!.children.remove(anchor);
      _success = true;
    } catch (e) {
      log(e.toString());
    }
    return _success;
  }
}
