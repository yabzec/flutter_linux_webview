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

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'linux_webview_controller.dart';
import 'linux_navigation_delegate.dart';
import 'linux_webview_widget_impl.dart';
import 'linux_webview_cookie_manager.dart';
import 'webview_linux_widget.dart';

/// Linux implementation of [WebViewPlatform].
class LinuxWebView extends WebViewPlatform {
  /// Registers this class as the default instance of [WebViewPlatform].
  static void registerWith() {
    WebViewPlatform.instance = LinuxWebView();
  }

  @override
  LinuxWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) {
    return LinuxWebViewController(params);
  }

  @override
  LinuxNavigationDelegate createPlatformNavigationDelegate(
    PlatformNavigationDelegateCreationParams params,
  ) {
    return LinuxNavigationDelegate(params);
  }

  @override
  LinuxWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) {
    return LinuxWebViewWidget(params);
  }

  @override
  LinuxWebViewCookieManager createPlatformCookieManager(
    PlatformWebViewCookieManagerCreationParams params,
  ) {
    return LinuxWebViewCookieManager(params);
  }

  // ===== Legacy v3 API support (for backward compatibility) =====

  /// Legacy build method for webview_flutter v3 compatibility.
  /// 
  /// This method is deprecated and will be removed in a future version.
  /// Use the new v4 API with WebViewController and WebViewWidget instead.
  @override
  Widget build({
    required BuildContext context,
    required CreationParams creationParams,
    required WebViewPlatformCallbacksHandler webViewPlatformCallbacksHandler,
    required JavascriptChannelRegistry javascriptChannelRegistry,
    WebViewPlatformCreatedCallback? onWebViewPlatformCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) {
    return WebViewLinuxWidget(
      onWebViewPlatformCreated: onWebViewPlatformCreated,
      callbacksHandler: webViewPlatformCallbacksHandler,
      javascriptChannelRegistry: javascriptChannelRegistry,
      creationParams: creationParams,
    );
  }

  /// Legacy clearCookies method for webview_flutter v3 compatibility.
  /// 
  /// This method is deprecated and will be removed in a future version.
  /// Use WebViewCookieManager instead.
  @override
  Future<bool> clearCookies() async {
    final manager = LinuxWebViewCookieManager(
      const PlatformWebViewCookieManagerCreationParams(),
    );
    return manager.clearCookies();
  }
}
