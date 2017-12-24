# Additional Packages for Vcpkg

[READMEの日本語版はこちら](./README_JP.md)

Additional packages which are not inluded in default vcpkg.
vcpkg is a C++ package manager for Windows.
If you want to know details of vcpkg, please visit [the repository of vcpkg](https://github.com/Microsoft/vcpkg).

## Usage

1. Install vcpkg by following [the repository of vcpkg](https://github.com/Microsoft/vcpkg)
1. Find port directories of the packages you want from "[the root of this repository]/ports/".
1. Copy them to "[vcpkg root directory]/ports"
1. Move to the root directory of vcpkg and install the packages as bellow:

```:ps
vcpkg.exe install [the package name]:[triplet]
```

To get details about usage of vcpkg, please see [the repository of vcpkg](https://github.com/Microsoft/vcpkg).

## Packages

Currently,threre are 6 packages in this repository.
Each line in bellow list consists of "[package name in vcpkg]: [package name] [version] (support triplets)".

- dxlib: [DXLibrary](http://dxlib.o.oo7.jp/) 3.19 (x86-windows-static, x64-windows-static)
- effekseer: [Effekseer](https://effekseer.github.io/en/index.html) 1.30 (x86-windows-static)
- effekseer-12x: [Effekseer](https://effekseer.github.io/en/index.html) 1.22 (x86-windows-static)
- effekseer-for-dxlib: [EffekseerForDxLib](https://effekseer.github.io/en/index.html) 1.32 (x86-windows-static)
- effekseer-for-dxlib-12x: [EffekseerForDxLib](https://effekseer.github.io/en/index.html) 1.22 (x86-windows-static)
- lua-intf: [LuaIntf](https://github.com/SteveKChiu/lua-intf) commit in Jan. 6, 2017 (all)

effekseer and effekseer-12x, effekseer-for-dxlib and effekseer-for-dxlib-12x can not be installed at same time.

## License

The codes in this repository are lisenced unfer the [MIT License](./LICENSE).
