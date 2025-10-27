# flutter_linux_webview_example

## About the example apps

There are several example apps as shown below.

Note: If you are using Flutter prior to version 3.10, the example apps will fail to compile and require some editing. See each example app.

### webview_flutter v4 API (Recommended)
- **lib/v4_example.dart**
  - Example using the new webview_flutter v4 API with WebViewController and WebViewWidget
  - Shows the recommended modern approach for new applications
  - Demonstrates navigation delegate callbacks and progress tracking

### webview_flutter v3 API (Legacy, but still supported)
- **lib/simple_example.dart**
  - The simplest example app that displays a single WebView using v3 API
  - Maintained for backward compatibility
- **lib/main.dart**
  - This came from webview_flutter v3.0.4 example
  - Uses the legacy WebView widget pattern
- **lib/multiple_webviews_example.dart**
  - Simple demo of dynamically adding and removing webviews
  - This app is not well maintained

---

- **integration_test/flutter_linux_webview_test.dart**
  - Integration tests from webview_flutter v3.0.4 example
  - Currently uses v3 API pattern
  - Note: Integration tests for v4 API are not yet implemented

## How to run

### Build and run

```shell
# Run v4 example (recommended)
$ flutter run -t lib/v4_example.dart

# Or run simple v3 example
$ flutter run -t lib/simple_example.dart

# Release build and run
$ flutter run --release -t lib/v4_example.dart
```

You can add `-v` option for verbose outputs.

### Only Building

For debug build:

```shell
# Debug build
$ flutter build linux --debug -t lib/simple_example.dart
# To run:
$ build/linux/x64/debug/bundle/flutter_linux_webview_example
```

For release build:

```shell
# Release build
$ flutter build linux -t lib/webview_sample.dart
# To run:
$ build/linux/x64/release/bundle/flutter_linux_webview_example
```

## Clean build artifacts and Flutter cache

```shell
$ flutter clean
```

## Run the test

```shell
$ flutter test integration_test/flutter_linux_webview_test.dart
```
