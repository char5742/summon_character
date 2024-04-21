# summon_character
Chrome拡張機能「Summon Character」のリポジトリです。

## 概要
Chrome拡張機能「Summon Character」は、画面にキャラクターを召喚します。

## 使い方
1. このリポジトリをクローンします。
2. dartファイルをビルドします。
    ```bash
    $ dart compile js lib/summon_character.dart -o build/index.js
    ```
3. Chromeの拡張機能ページを開きます。
4. デベロッパーモードを有効にします。
5. 「パッケージ化されていない拡張機能を読み込む」から、クローンしたリポジトリを選択します。
6. 画面にキャラクターが召喚されます。