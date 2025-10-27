// Copyright (c) 2023 ACCESS CO., LTD. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of ACCESS CO., LTD. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'dart:ui';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'webview_linux_widget.dart';

/// Linux implementation of [PlatformWebViewController].
class LinuxWebViewController extends PlatformWebViewController {
  /// Creates a new [LinuxWebViewController].
  LinuxWebViewController(PlatformWebViewControllerCreationParams params)
      : super.implementation(params);

  WebViewLinuxPlatformController? _controller;

  /// Sets the underlying platform controller instance.
  /// This is called by the widget when the native webview is created.
  void setPlatformController(WebViewLinuxPlatformController controller) {
    _controller = controller;
  }

  WebViewLinuxPlatformController get _platformController {
    if (_controller == null) {
      throw StateError('WebView controller has not been initialized yet');
    }
    return _controller!;
  }

  @override
  Future<void> loadFile(String absoluteFilePath) {
    return _platformController.loadFile(absoluteFilePath);
  }

  @override
  Future<void> loadFlutterAsset(String key) {
    return _platformController.loadFlutterAsset(key);
  }

  @override
  Future<void> loadHtmlString(String html, {String? baseUrl}) {
    return _platformController.loadHtmlString(html, baseUrl: baseUrl);
  }

  @override
  Future<void> loadRequest(LoadRequestParams params) {
    return _platformController.loadRequest(WebViewRequest(
      uri: params.uri,
      method: params.method,
      headers: params.headers,
      body: params.body,
    ));
  }

  @override
  Future<String?> currentUrl() {
    return _platformController.currentUrl();
  }

  @override
  Future<bool> canGoBack() {
    return _platformController.canGoBack();
  }

  @override
  Future<bool> canGoForward() {
    return _platformController.canGoForward();
  }

  @override
  Future<void> goBack() {
    return _platformController.goBack();
  }

  @override
  Future<void> goForward() {
    return _platformController.goForward();
  }

  @override
  Future<void> reload() {
    return _platformController.reload();
  }

  @override
  Future<void> clearCache() {
    return _platformController.clearCache();
  }

  @override
  Future<void> clearLocalStorage() {
    // Not implemented in the platform controller
    throw UnimplementedError('clearLocalStorage is not implemented on Linux');
  }

  @override
  Future<void> setPlatformNavigationDelegate(
      PlatformNavigationDelegate handler) {
    // Navigation delegate handling is done through the legacy callback handler
    // This is a no-op for now as the platform controller uses the old pattern
    return Future.value();
  }

  @override
  Future<String> runJavaScriptReturningResult(String javaScript) {
    return _platformController.runJavascriptReturningResult(javaScript);
  }

  @override
  Future<void> runJavaScript(String javaScript) {
    return _platformController.runJavascript(javaScript);
  }

  @override
  Future<String?> getTitle() {
    return _platformController.getTitle();
  }

  @override
  Future<void> scrollTo(int x, int y) {
    return _platformController.scrollTo(x, y);
  }

  @override
  Future<void> scrollBy(int x, int y) {
    return _platformController.scrollBy(x, y);
  }

  @override
  Future<Offset> getScrollPosition() async {
    final x = await _platformController.getScrollX();
    final y = await _platformController.getScrollY();
    return Offset(x.toDouble(), y.toDouble());
  }

  @override
  Future<void> enableZoom(bool enabled) {
    // Zoom is controlled via CEF startup flags, not dynamically
    // This is a no-op on Linux
    return Future.value();
  }

  @override
  Future<void> setBackgroundColor(Color color) {
    // Background color is set at creation time, not dynamically
    // This is a no-op on Linux
    return Future.value();
  }

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) {
    // JavaScript mode is controlled via CEF settings, not dynamically changeable
    // This is a no-op on Linux
    return Future.value();
  }

  @override
  Future<void> setUserAgent(String? userAgent) {
    // User agent is set via CEF startup flags, not dynamically
    // This is a no-op on Linux
    return Future.value();
  }

  @override
  Future<void> addJavaScriptChannel(
    JavaScriptChannelParams javaScriptChannelParams,
  ) {
    // TODO: Implement JavaScript channels
    throw UnimplementedError('JavaScript channels are not yet implemented on Linux');
  }

  @override
  Future<void> removeJavaScriptChannel(String javaScriptChannelName) {
    // TODO: Implement JavaScript channels
    throw UnimplementedError('JavaScript channels are not yet implemented on Linux');
  }
}
