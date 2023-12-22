include(vcpkg_common_functions)

# Currently, only support "x[x86|64]-windows-static"
if((NOT ${TARGET_TRIPLET} MATCHES "x86-windows-static") AND (NOT ${TARGET_TRIPLET} MATCHES "x64-windows-static"))
        message(FATAL_ERROR "A supported triplet is only x86-windows-static and x64-windows-static.")
endif()

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/EffekseerForDXLib_170e_324b)
vcpkg_download_distfile(ARCHIVE
    URLS "https://effekseer.sakura.ne.jp/Releases/EffekseerForDXLib_170e_324b.zip"
    FILENAME "effekseer-for-dxlib-1.70e.zip"
    SHA512 979e71a03e6700128ec97ec232df214506e4a10f6e1bc0120f9fa497bb4a26a87d544231a1e1801222a5054931012ce692de5d065fb64c015a2f969034e0ecc3
)
vcpkg_extract_source_archive(${ARCHIVE})

# Copy libraries
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/Effekseer_vs2022_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9_vs2022_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX11_vs2022_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib_vs2022_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/Effekseer_vs2022_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9_vs2022_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX11_vs2022_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib_vs2022_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Handle copyright (EffekseerForDXLibのリポジトリにLICENSEがないので、Effekseerのもので代用)
file(DOWNLOAD https://github.com/effekseer/Effekseer/blob/master/LICENSE ${SOURCE_PATH}/LICENSE)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/effekseer-for-dxlib RENAME copyright)
