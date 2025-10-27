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

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

/// Linux implementation of [PlatformNavigationDelegate].
class LinuxNavigationDelegate extends PlatformNavigationDelegate {
  /// Creates a new [LinuxNavigationDelegate].
  LinuxNavigationDelegate(PlatformNavigationDelegateCreationParams params)
      : super.implementation(params);

  PageEventCallback? _onPageStarted;
  PageEventCallback? _onPageFinished;
  ProgressCallback? _onProgress;
  WebResourceErrorCallback? _onWebResourceError;
  NavigationRequestCallback? _onNavigationRequest;
  UrlChangeCallback? _onUrlChange;
  HttpAuthRequestCallback? _onHttpAuthRequest;

  @override
  Future<void> setOnPageStarted(PageEventCallback onPageStarted) async {
    _onPageStarted = onPageStarted;
  }

  @override
  Future<void> setOnPageFinished(PageEventCallback onPageFinished) async {
    _onPageFinished = onPageFinished;
  }

  @override
  Future<void> setOnProgress(ProgressCallback onProgress) async {
    _onProgress = onProgress;
  }

  @override
  Future<void> setOnWebResourceError(
      WebResourceErrorCallback onWebResourceError) async {
    _onWebResourceError = onWebResourceError;
  }

  @override
  Future<void> setOnNavigationRequest(
      NavigationRequestCallback onNavigationRequest) async {
    _onNavigationRequest = onNavigationRequest;
  }

  @override
  Future<void> setOnUrlChange(UrlChangeCallback onUrlChange) async {
    _onUrlChange = onUrlChange;
  }

  @override
  Future<void> setOnHttpAuthRequest(
      HttpAuthRequestCallback onHttpAuthRequest) async {
    _onHttpAuthRequest = onHttpAuthRequest;
  }

  /// Internal method to handle page started events.
  void onPageStarted(String url) {
    _onPageStarted?.call(url);
  }

  /// Internal method to handle page finished events.
  void onPageFinished(String url) {
    _onPageFinished?.call(url);
  }

  /// Internal method to handle progress events.
  void onProgress(int progress) {
    _onProgress?.call(progress);
  }

  /// Internal method to handle web resource errors.
  void onWebResourceError(WebResourceError error) {
    _onWebResourceError?.call(error);
  }

  /// Internal method to handle navigation requests.
  Future<NavigationDecision> onNavigationRequest(NavigationRequest request) async {
    if (_onNavigationRequest != null) {
      final decision = await _onNavigationRequest!(request);
      return decision;
    }
    return NavigationDecision.navigate;
  }
}
