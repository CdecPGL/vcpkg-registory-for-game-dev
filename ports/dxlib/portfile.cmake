# Specify version
set(MAJOR_VERSION 3)
set(MINOR_VERSION 24b)
set(VERSION ${MAJOR_VERSION}.${MINOR_VERSION})

# Prepair sources
vcpkg_download_distfile(ARCHIVE
    URLS "https://dxlib.xsrv.jp/DxLib/DxLib_VC${MAJOR_VERSION}_${MINOR_VERSION}.zip"
    FILENAME "dxlib-${VERSION}.zip"
    SHA512 5d3f164cfb201d71ff2274dd12d5d0a65f09e6c4b31a20ae5a6a48560c3a08db876297e6c0e7eab8de31979d4addfbd1cfe2a65d8cf65bc5dc596e079f54d5f4
)
vcpkg_extract_source_archive(EXTRACTED_DIR
    ARCHIVE ${ARCHIVE}
)

if(${VCPKG_LIBRARY_LINKAGE} MATCHES "static")
        set(REL_LIB_LINKAGE "MT")
        set(DEB_LIB_LINKAGE "MTd")
        message(NOTICE "VCPKG_LIBRARY_LINKAGE is static")
elseif(${VCPKG_LIBRARY_LINKAGE} MATCHES "dynamic")
        set(REL_LIB_LINKAGE "MD")
        set(DEB_LIB_LINKAGE "MDd")
        message(NOTICE "VCPKG_LIBRARY_LINKAGE is dynamic")
else()
        message(FATAL_ERROR "Unknown VCPKG_LIBRARY_LINKAGE: ${VCPKG_LIBRARY_LINKAGE}")
endif()

#In distributed library files of dxlib, each library is named as follows:
# <LIB_NAME><WIDE_CHARACTER_LABEL>_<VS_VERSION>_<ARCHITECTURE>_<TARGET>.lib
# - <LIB_NAME>: Name of library
# - <WIDE_CHARACTER_LABEL>: W or empty (not wide character)
# - <VS_VERSION>: vc6, vc8, vs2012, vs2013, vs2015 or empty (for vs2019 or later)
#    - empty is for vs2010 or former
#    - vs2015 is for vs2015 or later
# - <ARCHITECTURE>: x64, x86 or empty
#    - empty is same as "x86" and used when vs version is empty
# - <TARGET>: d, MT, MD, MTd, MDd or empty
#     - "d" is same as "MTd" and used when vs version is empty
#     - empty is same as "MT" and used when vs version is empty
#     - "MD" and "MDd" is not used when vs version is empty
# These conditions are defined in "DxDataTypeWin.h".
# We ignore libraries not for vs2015 or later to make this file simple.
# We also ignore wide character libraries whose name includes "W" to avoid LNK2005.
list(APPEND LIB_NAMES DxLib)
list(APPEND LIB_NAMES DxDrawFunc)
list(APPEND LIB_NAMES DxUseCLib)
list(APPEND LIB_NAMES libbulletcollision)
list(APPEND LIB_NAMES libbulletdynamics)
list(APPEND LIB_NAMES libbulletmath)
list(APPEND LIB_NAMES libtiff)
list(APPEND LIB_NAMES libpng)
list(APPEND LIB_NAMES zlib)
list(APPEND LIB_NAMES libjpeg)
list(APPEND LIB_NAMES ogg_static)
list(APPEND LIB_NAMES vorbis_static)
list(APPEND LIB_NAMES vorbisfile_static)
list(APPEND LIB_NAMES libtheora_static)
list(APPEND LIB_NAMES opus)
list(APPEND LIB_NAMES opusfile)
list(APPEND LIB_NAMES silk_common)
list(APPEND LIB_NAMES celt)

################################
# Install headers
################################
file(GLOB INDLUDES ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/*.h)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

################################
# Install libraries for release
################################
foreach(LIB_NAME IN LISTS LIB_NAMES)
    list(APPEND REL_LIBS ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/${LIB_NAME}_vs2015_${TRIPLET_SYSTEM_ARCH}_${REL_LIB_LINKAGE}.lib)
endforeach()
file(INSTALL ${REL_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

################################
# Install libraries for debug
################################
foreach(LIB_NAME IN LISTS LIB_NAMES)
    list(APPEND DEB_LIBS ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/${LIB_NAME}_vs2015_${TRIPLET_SYSTEM_ARCH}_${DEB_LIB_LINKAGE}.lib)
endforeach()
file(INSTALL ${DEB_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

################################
# Install copyright
################################
file(INSTALL ${EXTRACTED_DIR}/DxLib.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/dxlib RENAME copyright)
