import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {

  final String url;
  final String title;

  const AppWebView({required this.url, required this.title, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateAppWebView();
}

class _StateAppWebView extends State<AppWebView> {

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold))),
      body: Stack(
            children: [
              Container(color:Colors.white,child: const Center(child: CircularProgressIndicator())),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  color: Colors.white,
                  child: WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.disabled,
                    onWebViewCreated: (WebViewController webViewController) async {

                    },
                    onProgress: (int progress) {

                    },
                    javascriptChannels: const <JavascriptChannel>{

                    },

                    onPageStarted: (String url) {

                    },
                    onPageFinished: (String url) {
                      setState(() {
                        _visible=true;
                      });
                    },
                    gestureNavigationEnabled: true, ),
                ),
              ),
            ],
          )
    );
  }
}