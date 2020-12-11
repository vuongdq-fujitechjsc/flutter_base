import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/core.dart';

import 'webview_event.dart';
import 'webview_state.dart';
import 'webview_bloc.dart';

class WebViewScreen extends StatelessWidget {
  final String title;
  final String url;
  final String token;

  WebViewScreen({
    this.title,
    this.url,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return WebViewForm(
      title,
      url,
      token,
    );
  }
}

class WebViewForm extends StatefulWidget {
  final String title;
  final String url;
  final String token;

  WebViewForm(
    this.title,
    this.url,
    this.token,
  );
  @override
  _WebViewFormState createState() => _WebViewFormState();
}

class _WebViewFormState extends BasePage<WebViewForm, WebviewBloc, AppBloc>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    LogUtils.debug('WebviewScreen - initState');
  }

  @override
  WebviewBloc getBlocData(BuildContext context) => WebviewBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => this.bloc,
      child: BlocConsumer<WebviewBloc, WebviewState>(
        builder: (context, state) {
          return MyNavigation(
            navigationData: NavigationData(
                isShowNavigation: true,
                navigationLeftButtonType: NavigationLeftButtonType.iconBack,
                navigationTitle: widget.title),
            bodyWidget: Scaffold(
              body: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webController) {
                  Map<String, String> headers = {
                    ConstantsCore.API_HEADER_KEY_1:
                        ConstantsCore.API_HEADER_VALUE_1 + widget.token,
                    ConstantsCore.API_HEADER_KEY_3:
                        ConstantsCore.API_HEADER_VALUE_3,
                  };
                  webController.loadUrl(
                    widget.url,
                    headers: headers,
                  );
                },
                onWebResourceError: (WebResourceError error) {
                  print('error');
                  print(error.errorCode);
                },
                onPageStarted: (String url) {
                  LogUtils.debug('Start load: $url');
                },
                onPageFinished: (String url) {
                  LogUtils.debug('Finish load: $url');
                },
                navigationDelegate: (navigation) async {
                  
                },
              ),
            ),
          );
        },
        listener: (context, state) => _handleWebviewState(context, state),
      ),
    );
  }

  _handleWebviewState(context, state) {}
}

class WebViewData {
  final String title;
  final String url;
  final String token;

  WebViewData({
    this.title,
    this.url,
    this.token,
  });
}
