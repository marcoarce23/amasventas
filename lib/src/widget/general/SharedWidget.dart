import 'package:share/share.dart';

sharedImage(String imagePath, String nameImage, String nameAttachExtension,
    String extensionImage, String detail) async {
// final ByteData bytes = await rootBundle.load(imagePath);
//Share.share(text).
  // Share.file(nameImage, nameAttachExtension, bytes.buffer.asUint8List(),
  //     'image/$extensionImage',
  //     text: detail);
}

sharedText(String title, String text, String mimeType) async {
  Share.share(text); // .text(title, text, mimeType);
}
