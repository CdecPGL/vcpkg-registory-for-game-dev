# Prepair sources
vcpkg_download_distfile(ARCHIVE
    URLS "https://effekseer.sakura.ne.jp/Releases/EffekseerForDXLib_170e_324b.zip"
    FILENAME "effekseer-for-dxlib-1.70e.zip"
    SHA512 979e71a03e6700128ec97ec232df214506e4a10f6e1bc0120f9fa497bb4a26a87d544231a1e1801222a5054931012ce692de5d065fb64c015a2f969034e0ecc3
)
vcpkg_extract_source_archive(EXTRACTED_DIR
    ARCHIVE ${ARCHIVE}
)

# Copy libraries
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/Effekseer.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/Effekseer.Modules.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/Effekseer.SIMD.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX11.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Use libraries for vs2019 because vs2019 verion is refered instead of vs2022 version in EffekseerForDXLib.h
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/Effekseer_vs2019_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9_vs2019_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX11_vs2019_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib_vs2019_${TRIPLET_SYSTEM_ARCH}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

# Use libraries for vs2019 because vs2019 verion is refered instead of vs2022 version in EffekseerForDXLib.h
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/Effekseer_vs2019_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9_vs2019_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX11_vs2019_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib_vs2019_${TRIPLET_SYSTEM_ARCH}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Handle copyright (EffekseerForDXLibのリポジトリにLICENSEがないので、Effekseerのもので代用)
file(DOWNLOAD https://github.com/effekseer/Effekseer/blob/master/LICENSE ${EXTRACTED_DIR}/LICENSE)
file(INSTALL ${EXTRACTED_DIR}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/effekseer-for-dxlib RENAME copyright)
