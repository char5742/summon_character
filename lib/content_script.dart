import 'package:web/web.dart';
import 'dart:js_interop';

import 'character/chatacter.dart';
import 'chrome_api.dart';

void main() {
  final divElement = HTMLDivElement();
  final imgUrl = chrome.runtime.getURL("public/images/dog.png").toDart;
  final imageElement = HTMLImageElement();
  imageElement.src = imgUrl;
  divElement.append(imageElement);
  document.documentElement?.append(divElement);
  divElement.setAttribute("id", "summonCharacters");
  final character = Character.instance;
  character.applyPositionToStyle = (p0) {
    divElement.style.setProperty("--top", "${p0.top}vh");
    divElement.style.setProperty("--left", "${p0.left}vw");
  };
  character.startAction();

  chrome.runtime.onMessage
      .addListener((String method, JSObject sender, JSFunction sendResponse) {
    switch (method) {
      case "startCharacter();":
        character.startAction();
      case "stopCharacter();":
        character.stopAction();
    }
  }.toJS);
}
