# Vcpkg Registory for Game Dev

[READMEの日本語版はこちら](./README_JP.md)

This repository is a vcpkg registry which contains packages for game development which are not included in the public curated registry.
If you want to know details of vcpkg, please visit [the repository of vcpkg](https://github.com/Microsoft/vcpkg).

All codes in this repository are targetting Visual Studio 2022.

## Usage

Add the following lines to `vcpkg-configuration.json` of your project.

```json
    {
      "kind": "git",
      "repository": "https://github.com/CdecPGL/vcpkg-registory-for-game-dev",
      "baseline": "<commit hash of this repository>",
      "packages": [ "dxlib", "effekseer-for-dxlib", "lua-intf" ]
    }
```

Then, you can install packages in this repository.

```ps1
# Manifest Mode
vcpkg add port [package name]

# Classic Mode
vcpkg install [package name]:[triplet]
```

For more details, please visit [vcpkg documentation "Tutorial: Install a dependency from a Git-based registry"](https://learn.microsoft.com/en-us/vcpkg/consume/git-registries).

## Packages

Currently, there are 3 packages in this repository.
Each line in bellow list consists of "[package name in vcpkg]: [package name] [version] (support triplets)".

- dxlib: [DXLibrary](http://dxlib.o.oo7.jp/) 3.24b (x86-windows-static, x64-windows-static)
- effekseer-for-dxlib: [EffekseerForDxLib](https://github.com/effekseer/EffekseerForDXLib) 1.70e (x86-windows-static, x64-windows-static)
- lua-intf: [LuaIntf](https://github.com/SteveKChiu/lua-intf) commit in Dec. 24, 2021 (all)

## Management of This Repository

### How to Add or Update a Package

To add or update a package in this repository, follow the steps below.

1. Add or update a port in `ports` directory.
    - If you update a port without changing its version, increment `port-number` in `vcpkg.json`.
    - If you update a port with changing its version, remove `port-number` in `vcpkg.json`.
1. Commit changes in `ports` directory.
1. Update version database.
    ```ps1
    vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version --all --verbose
    ```
1. Commit changes in version database.

For more details, please visit [vcpkg documentation "Tutorial: Publish packages to a private vcpkg registry using Git"](https://learn.microsoft.com/en-us/vcpkg/produce/publish-to-a-git-registry).

## License

The codes in this repository are lisenced under the [MIT License](./LICENSE).
