import 'dart:io';

import 'package:dot_ment/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  String _getWebUrl() {
    // return AppConstants.naverUrl;
    // Android 에뮬레이터에서는 localhost 대신 10.0.2.2 사용
    if (Platform.isAndroid) {
      return AppConstants.webBaseUrl.replaceFirst("localhost", "10.0.2.2");
    }
    // iOS 시뮬레이터와 실제 디바이스에서는 localhost 사용
    return AppConstants.webBaseUrl;
  }

  @override
  void initState() {
    super.initState();
    final webUrl = _getWebUrl();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
                _errorMessage = null;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _errorMessage = null;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _errorMessage = null;
            });
          },
          onHttpError: (HttpResponseError error) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'HTTP Error: ${error.response?.statusCode}';
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Web Error: ${error.description}';
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(webUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_errorMessage != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                          _errorMessage = null;
                        });
                        _controller.reload();
                      },
                      child: const Text('다시 시도'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
