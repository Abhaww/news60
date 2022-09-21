import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news60/components/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  final String url;
  final onTap;
  WebScreen(
      {required this.url, required this.onTap});

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen>{
  bool loading = true;
  final Completer<WebViewController> _webViewController =
  Completer<WebViewController>();
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
    // Factory(() => HorizontalDragGestureRecognizer()),
  ].toSet();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft, color: AppColor.background,),
            onPressed: widget.onTap,
        ),
        actions: <Widget>[
          FutureBuilder<WebViewController>(
              future: _webViewController.future,
              builder: (BuildContext context,
                  AsyncSnapshot<WebViewController>? snapshot) {
                final bool webViewReady =
                    snapshot!.connectionState == ConnectionState.done;
                final WebViewController controller = snapshot.data!;
                return IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: !webViewReady
                      ? null
                      : () {
                    setState(() {
                      loading = true;
                    });
                    controller.reload();
                  },
                );
              }),
        ],
        title: Text(
          widget.url.split("/")[2],
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
        ),
      ),
      body: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loading
                ? SizedBox(height: 3, child: LinearProgressIndicator())
                : Container(),
            Expanded(
              child: WebView(
                gestureRecognizers: [
                  Factory(() => VerticalDragGestureRecognizer()),
                ].toSet(),
                initialUrl: widget.url,
                debuggingEnabled: true,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                onPageFinished: (d) {
                  setState(() {
                    loading = false;
                  });
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _webViewController.complete(webViewController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
