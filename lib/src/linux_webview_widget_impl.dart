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

import 'package:flutter/widgets.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'linux_webview_controller.dart';
import 'linux_navigation_delegate.dart';
import 'webview_linux_widget.dart';

/// Linux implementation of [PlatformWebViewWidget].
class LinuxWebViewWidget extends PlatformWebViewWidget {
  /// Creates a new [LinuxWebViewWidget].
  LinuxWebViewWidget(PlatformWebViewWidgetCreationParams params)
      : super.implementation(params);

  @override
  Widget build(BuildContext context) {
    final controller = params.controller as LinuxWebViewController;
    final navigationDelegate = params.platformNavigationDelegate as LinuxNavigationDelegate?;

    // Create a legacy-style callbacks handler from the new navigation delegate
    final callbacksHandler = _LegacyCallbacksHandler(navigationDelegate);

    // Create the legacy creation params
    // Note: In v4 API, initialUrl and backgroundColor are set through controller
    // For backward compatibility with the legacy widget, we use empty/default values
    final creationParams = CreationParams(
      webSettings: WebSettings(
        javascriptMode: JavascriptMode.unrestricted,
        hasNavigationDelegate: navigationDelegate != null,
        hasProgressTracking: true,
        debuggingEnabled: false,
        gestureNavigationEnabled: false,
        allowsInlineMediaPlayback: false,
        userAgent: WebSettings.autoDetect,
      ),
    );

    return WebViewLinuxWidget(
      creationParams: creationParams,
      callbacksHandler: callbacksHandler,
      javascriptChannelRegistry: _EmptyJavascriptChannelRegistry(),
      onWebViewPlatformCreated: (WebViewPlatformController platformController) {
        // Connect the new-style controller to the legacy platform controller
        controller.setPlatformController(platformController as WebViewLinuxPlatformController);
      },
    );
  }
}

/// Adapts the new PlatformNavigationDelegate to the legacy WebViewPlatformCallbacksHandler.
class _LegacyCallbacksHandler extends WebViewPlatformCallbacksHandler {
  _LegacyCallbacksHandler(this._delegate);

  final LinuxNavigationDelegate? _delegate;

  @override
  void onPageStarted(String url) {
    _delegate?.onPageStarted(url);
  }

  @override
  void onPageFinished(String url) {
    _delegate?.onPageFinished(url);
  }

  @override
  void onProgress(int progress) {
    _delegate?.onProgress(progress);
  }

  @override
  void onWebResourceError(WebResourceError error) {
    _delegate?.onWebResourceError(error);
  }

  @override
  FutureOr<bool> onNavigationRequest({required String url, required bool isForMainFrame}) {
    // Navigation delegate not yet fully implemented on Linux
    return true;
  }
}

/// Empty javascript channel registry for compatibility.
class _EmptyJavascriptChannelRegistry extends JavascriptChannelRegistry {
  @override
  void onJavascriptChannelMessage(String channel, String message) {
    // JavaScript channels not yet implemented on Linux
  }
}
