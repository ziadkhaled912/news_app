import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  final String url;
  final String title;
  WebViewScreen(
      this.url,
      this.title,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: url,
        allowsInlineMediaPlayback: true,
        // javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
