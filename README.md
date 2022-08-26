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
