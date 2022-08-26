# riverpod-app

## 環境構築

### 1. gitソースコードのクローン

空のディレクトリで以下を実行する。gitHubへのアクセス行える状態であること。

```
`git clone [このリポジトリへのURL]`
```

### 2. Androidstudio導入

```
http://developer.android.com/sdk/index.html
```

上記URLから最新版をダウンロードしインストールまで行う


### 3. Flutter環境構築

```
https://docs.flutter.dev/development/tools/sdk/releases?tab=macos
```

上記URLからバージョン：2.10.4をダウンロードしインストール

・ファイルを解凍
作業ディレクトリを作成して、ダウンロードしたzipを解凍
※作業ディレクトリ名や作成場所は好きなところに作ってください。

```
mkdir ~/<ディレクトリ名>
cd ~/<ディレクトリ名>
unzip ~/Downloads/flutter_macos_1.20.3-stable.zip
```

・PATHを通す。

bashの場合

```
echo 'export PATH="$PATH:[ディレクトリ名]/flutter/bin"' >> ~/.bash_profile
source ~/.bash_profile
```

zshの場合

```
echo 'export PATH="$PATH:[PATH_TO_FLUTTER]/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

flutter upgrade
```
Flutter 3.0.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision f1875d570e (6 weeks ago) • 2022-07-13 11:24:16 -0700
Engine • revision e85ea0e79c
Tools • Dart 2.17.6 • DevTools 2.12.2

Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.0.5, on macOS 12.4 21F79 darwin-x64, locale ja-JP)
[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
[!] Xcode - develop for iOS and macOS (Xcode 13.4.1)
! CocoaPods 1.10.2 out of date (1.11.0 is recommended).
CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin usage on the Dart side.
Without CocoaPods, plugins will not work on iOS or macOS.
For more info, see https://flutter.dev/platform-plugins
To upgrade see https://guides.cocoapods.org/using/getting-started.html#installation for instructions.
[✓] Chrome - develop for the web
[✓] Android Studio (version 4.0)
[✓] Android Studio (version 2021.2)
[✓] VS Code (version 1.51.1)
[✓] Connected device (4 available)
[✓] HTTP Host Availability

```