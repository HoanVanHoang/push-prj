import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  WebView(
      initialUrl: 'https://flutter.dev',
    );
  }

}