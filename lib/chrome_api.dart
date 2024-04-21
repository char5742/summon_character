import 'dart:js_interop';

@JS()
external JSChrome get chrome;

@JS()
@staticInterop
class JSChrome {}

extension JSChromeJS on JSChrome {
  external JSRuntime runtime;
  external JSTabs tabs;
  external JSChromeStorage storage;
}

extension type JSRuntime._(JSObject _) {
  external JSString getURL(String path);
  external JSRuntimeOnMessage onMessage;
}

extension type JSRuntimeOnMessage._(JSObject _) {
  external JSVoid addListener(JSFunction callback);
}

extension type JSTabs._(JSObject _) {
  external JSVoid query(JSObject queryInfo, JSTabsQueryCallback callback);
  external JSTabsJSOnactivated onActivated;
  external JSPromise sendMessage(
    int tabId,
    String message, [
    JSObject? options,
    JSFunction? responseCallback,
  ]);
}

extension type JSTabsQueryCallback._(JSFunction _) implements JSFunction {
  external JSTabsQueryCallback(JSArray<Tab> tabs);
}

extension type JSTabsJSOnactivated._(JSObject _) {
  external JSVoid addListener(JSTabsJSOnactivatedCallback callback);
}

extension type JSTabsJSOnactivatedCallback._(JSFunction _)
    implements JSFunction {
  external JSTabsJSOnactivatedCallback(ActiveInfo activeInfo);
}

extension type ActiveInfo._(JSObject _) implements JSObject {
  external factory ActiveInfo({
    int tabId,
  });
  external int tabId;
}

extension type Tab._(JSObject _) implements JSObject {
  external factory Tab({
    int id,
  });
  external int id;
}

extension type JSChromeStorage._(JSObject _) {
  external JSStorageArea get local;
}

extension type JSStorageArea._(JSObject _) {
  external JSPromise<JSAny?> get(String key);
  external JSPromise set(JSObject items);
  external JSStorageAreaOnChanged onChanged;
}

extension type JSStorageAreaOnChanged._(JSObject _) {
  external JSVoid addListener(JSFunction callback);
}

extension type JSPosition._(JSObject _) implements JSObject {
  external factory JSPosition({
    num top,
    num left,
  });
  external num get top;
  external num get left;
}
