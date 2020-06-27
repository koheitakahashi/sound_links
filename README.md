# Sound Linksとは

「Sound Links」とは、使っている音楽プラットフォームが違うことにより、他の人と楽曲を共有しづらいという問題を解決するための、音楽配信プラットフォーム横断検索サービスです。

ユーザーは楽曲名でSpotify・Apple Music・YouTubeを検索することができ、その楽曲を共有するためのプラットフォーム固有のURLを、ボタン一つでクリップボードにコピーできます。

## インストール

```sh
$ bin/setup
$ rails server
```

## テスト

```sh
$ bundle exec rspec
```

## Lint

Rubocopを実行します

```sh
$ bundle exec rubocop
```

## 注意

本アプリを動かすためには、Spotify・Apple Music・YouTube、それぞれのAPIキーを取得する必要があります。

以下を参考に取得してください。

[Web API \| Spotify for Developers](https://developer.spotify.com/documentation/web-api/)

[Apple Music API \| Apple Developer Documentation](https://developer.apple.com/documentation/applemusicapi)

[YouTube Data API  \|  Google Developers](https://developers.google.com/youtube/v3)
