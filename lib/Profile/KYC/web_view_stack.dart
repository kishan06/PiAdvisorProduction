import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebViewStack extends StatefulWidget {
  WebViewStack({required this.controller, super.key});
  final Completer<WebViewController> controller;
  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  String link = Database().restoreLink();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },

          initialUrlRequest: URLRequest(url: Uri.tryParse(link)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              mediaPlaybackRequiresUserGesture: false,
              userAgent: 'random',
              //  debuggingEnabled: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            //  _webViewController = controller;
          },
          // onLoadStart: (InAppWebViewController controller, String url) {
          //   setState(() {
          //     this.url = url;
          //   });
          // },
          // onLoadStop: (InAppWebViewController controller, String url) async {
          //   setState(() {
          //     this.url = url;
          //   });
          // },
          // onProgressChanged: (InAppWebViewController controller, int progress) {
          //   setState(() {
          //     this.progress = progress / 100;
          //   });
          // },
        )
      ],
    );
  }
}
