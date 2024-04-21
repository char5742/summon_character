import 'dart:js_interop';

import 'chrome_api.dart';

void main() {
  chrome.tabs.onActivated.addListener((ActiveInfo activeInfo) {
    chrome.tabs.query(
        {}.toJSBox,
        (JSArray<Tab> tabs) {
          for (final tab in tabs.toDart) {
            if (tab.id != activeInfo.tabId) {
              chrome.tabs
                  .sendMessage(tab.id, "stopCharacter();")
                  .toDart
                  .catchError((_) => null);
            } else {
              chrome.tabs
                  .sendMessage(tab.id, "startCharacter();")
                  .toDart
                  .catchError((_) => null);
            }
          }
        }.toJS as JSTabsQueryCallback);
  }.toJS as JSTabsJSOnactivatedCallback);
}
