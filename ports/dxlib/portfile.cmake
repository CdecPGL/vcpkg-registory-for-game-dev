# Specify version
set(MAJOR_VERSION 3)
set(MINOR_VERSION 24b)
set(VERSION ${MAJOR_VERSION}.${MINOR_VERSION})

include(vcpkg_common_functions)

# Currently, only support "x[x86|64]-windows-static"
if((NOT ${TARGET_TRIPLET} MATCHES "x86-windows-static") AND (NOT ${TARGET_TRIPLET} MATCHES "x64-windows-static"))
        message(FATAL_ERROR "A supported triplet is only x86-windows-static and x64-windows-static.")
endif()

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/DxLib_VC${MAJOR_VERSION}_${MINOR_VERSION}/DxLib_VC)
vcpkg_download_distfile(ARCHIVE
    URLS "https://dxlib.xsrv.jp/DxLib/DxLib_VC${MAJOR_VERSION}_${MINOR_VERSION}.zip"
    FILENAME "dxlib-${VERSION}.zip"
    SHA512 5d3f164cfb201d71ff2274dd12d5d0a65f09e6c4b31a20ae5a6a48560c3a08db876297e6c0e7eab8de31979d4addfbd1cfe2a65d8cf65bc5dc596e079f54d5f4
)
vcpkg_extract_source_archive(${ARCHIVE})

# Copy libraries (to avoid LNK2005, except wide character library whose name includes "W")
file(GLOB INDLUDES ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/*.h)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(GLOB REL_LIBS ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/*[0123456789abcdefghijklmnopqrstuvxyz]_vs2015_${TRIPLET_SYSTEM_ARCH}.lib)
file(INSTALL ${REL_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(GLOB DEB_LIBS ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/*[0123456789abcdefghijklmnopqrstuvxyz]_vs2015_${TRIPLET_SYSTEM_ARCH}_d.lib)
file(INSTALL ${DEB_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/DxLib.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/dxlib RENAME copyright)
