# Vcpkg Registory for Game Dev

[READMEの日本語版はこちら](./README_JP.md)

This repository is a vcpkg registry which contains packages for game development which are not included in the public curated registry.
If you want to know details of vcpkg, please visit [the repository of vcpkg](https://github.com/Microsoft/vcpkg).

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

Currently, there are following packages in this repository.

- dxlib: [DX Library](http://dxlib.o.oo7.jp/)
    - Latest Version: 3.24-b
    - Supported Triplets: x86-windows, x86-windows-static, x64-windows, x64-windows-static
    - Supported Platforms: Windows (Visual Studio 2015 or later)
- effekseer-for-dxlib: [EffekseerForDX Library](https://github.com/effekseer/EffekseerForDXLib)
    - Latest Version: 1.70-e
    - Supported Triplets: x86-windows-static, x64-windows-static
    - Supported Platforms: Windows (Visual Studio 2019 or later)
- lua-intf: [LuaIntf](https://github.com/SteveKChiu/lua-intf)
    - Latest Version: 2021-12-24
    - Supported Triplets: All
    - Supported Platforms: All

## Registry Management

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
