# Vcpkg Registory for Game Dev

本リポジトリは、vcpkgのパブリックキュレーションレジストリには含まれていないゲーム開発関連のパッケージを含むvcpkgレジストリです。
vcpkgのパブリックキュレーションレジストリに含まれていないパッケージを提供するvcpkgレジストリです。

## 使用方法

対象プロジェクトの`vcpkg-configuration.json`において、`registories`に以下を追加します。

```json
    {
      "kind": "git",
      "repository": "https://github.com/CdecPGL/vcpkg-registory-for-game-dev",
      "baseline": "<本リポジトリの特定のコミットハッシュ>",
      "packages": [ "dxlib", "effekseer-for-dxlib", "lua-intf" ]
    }
```

これにより、本リポジトリのパッケージをインストール可能になります。

```ps1
# マニフェストモード
vcpkg add port [パッケージ名]

# クラシックモード
vcpkg install [パッケージ名]:[トリプレット]
```

詳細については[vcpkgのドキュメント「チュートリアル: Git ベースのレジストリから依存関係をインストールする」](https://learn.microsoft.com/ja-jp/vcpkg/consume/git-registries)をご覧ください。

## パッケージ

現在、本リポジトリには以下のパッケージが含まれています。

- dxlib: [DXライブラリ](http://dxlib.o.oo7.jp/)
    - 最新バージョン: 3.24-b
    - 対応トリプレット: x86-windows, x86-windows-static, x64-windows, x64-windows-static
    - 対応プラットフォーム: Windows（Visual Studio 2015以降）
- effekseer-for-dxlib: [EffekseerForDXライブラリ](https://github.com/effekseer/EffekseerForDXLib)
    - 最新バージョン: 1.70-e
    - 対応トリプレット: x86-windows-static, x64-windows-static
    - 対応プラットフォーム: Windows（Visual Studio 2019以降）
- lua-intf: [LuaIntf](https://github.com/SteveKChiu/lua-intf)
    - 最新バージョン: 2021-12-24
    - 対応トリプレット: 全て
    - 対応プラットフォーム: 全て

## レジストリの管理

### パッケージの追加・更新方法

本リポジトリにパッケージを追加するには、以下の手順を踏みます。

1. `ports`ディレクトリのポートを追加・更新する
    - バージョンの変更を伴わない更新をした場合は、`vcpkg.json`の`port-number`をインクリメントする
    - バージョンの変更を伴う更新をした場合は、`vcpkg.json`の`port-number`を削除
1. `ports`ディレクトリの変更をコミットする
1. バージョンデータベースを更新する
    ```ps1
    vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version --all --verbose
    ```
1. バージョンデータベースの変更をコミットする

詳細については[vcpkgのドキュメント「チュートリアル: Git を使用してプライベート vcpkg レジストリにパッケージを発行する」](https://learn.microsoft.com/ja-jp/vcpkg/produce/publish-to-a-git-registry)をご覧ください。

## ライセンス

本リポジトリのコードは[MITライセンス](./LICENSE)の下で公開しています。
