import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewPage extends StatefulWidget {
  final String title;
  final String url;

  ViewPage({
    @required this.title,
    @required this.url,
  });

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'.toUpperCase()),
        ),
        body: WebView(
          debuggingEnabled: false,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
