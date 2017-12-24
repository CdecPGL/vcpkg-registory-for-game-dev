# Additional Packages for Vcpkg

Windows用C++パッケージマネージャvcpkgの、標準では含まれていないパッケージを置いているリポジトリです。
vcpkgの詳細については[vcpkgのリポジトリ](https://github.com/Microsoft/vcpkg)をご覧ください。

## 使用方法

1. [vcpkgのリポジトリ](https://github.com/Microsoft/vcpkg)に従ってvcpkgをインストール
1. インストールしたいパッケージのポートディレクトリを"[本リポジトリのルート]/ports/"から探す
1. 見つけたポートディレクトリを"[vcpkgのルート]/ports"下にコピーする
1. vcpkgのルートディレクトリに移動し以下のコマンドを実行してインストール:

```:ps
vcpkg.exe install [パッケージ名]:[トリプレット]
```

Vcpkgの使用方法についての詳細は[vcpkgのリポジトリ](https://github.com/Microsoft/vcpkg)をご覧ください。

## パッケージ

現在、本リポジトリには6つのパッケージが含まれています。
以下の一覧において、それぞれのラインは"[vcpkgでのパッケージ名]: [パッケージ名] [バージョン] (対応トリプレット)"のように構成されています。

- dxlib: [DXライブラリ](http://dxlib.o.oo7.jp/) 3.19 (x86-windows-static, x64-windows-static)
- effekseer: [Effekseer](https://effekseer.github.io/jp/) 1.30 (x86-windows-static)
- effekseer-12x: [Effekseer](https://effekseer.github.io/jp/) 1.22 (x86-windows-static)
- effekseer-for-dxlib: [EffekseerForDXライブラリ](https://effekseer.github.io/jp/) 1.32 (x86-windows-static)
- effekseer-for-dxlib-12x: [EffekseerForDXライブラリ](https://effekseer.github.io/jp/) 1.22 (x86-windows-static)
- lua-intf: [LuaIntf](https://github.com/SteveKChiu/lua-intf) 2017/01/06のコミット (全て)

effekseerとeffekseer-12x、effekseer-for-dxlibとeffekseer-for-dxlib-12x は共存させることはできません。

## ライセンス

本リポジトリのコードは[MITライセンス](./LICENSE)の下で公開しています。
