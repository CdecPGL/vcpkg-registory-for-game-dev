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

#In distributed library files of dxlib, each library is named as follows:
# <LIB_NAME><WIDE_CHARACTER_LABEL>_<VS_VERSION>_<ARCHITECTURE>_<TARGET>.lib
# - <LIB_NAME>: Name of library
# - <WIDE_CHARACTER_LABEL>: W or empty (not wide character)
# - <VS_VERSION>: vc6, vc8, vs2012, vs2013, vs2015 or empty (for vs2019 or later)
# - <ARCHITECTURE>: x64 or empty
#    - empty is same as "x86" and "x86" is not used when vs version is vs2019 or later
# - <TARGET>: d, MT, MD, MTd, MDd or empty
#     - "d" is same as "MTd" and "MTd" is not used when vs version is vs2019 or later
#     - empty is same as "MT" and "MT" is not used when vs version is vs2019 or later
#     - "MD" and "MDd" is not used when vs version is vs2019 or later
# We ignore libraries not for vs2019 or later to make this file simple.
# We also ignore wide character libraries to avoid LNK2005.
if(${TRIPLET_SYSTEM_ARCH} MATCHES "x86")
        set(EXCLUDE_LIB_ARCH_SUFFIX "_x64")
elseif(${TRIPLET_SYSTEM_ARCH} MATCHES "x64")
        set(LIB_ARCH_SUFFIX "_x64")
else()
        message(FATAL_ERROR "Unsupported architecture: ${TRIPLET_SYSTEM_ARCH}")
endif()

################################
# Install headers
################################
file(GLOB INDLUDES ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/*${LIB_ARCH_SUFFIX}.h)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

################################
# Install libraries for release
################################
# Glob all libraries
# Result: <all label names><empty or "W"><empty | _(all vs versions)><empty | _(all architectures)><empty | _(all targets)>.lib
file(GLOB REL_LIBS ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/*.lib)
# Exclude libraries whose vs version is not vs2019_or_later (vc6, vc8, vs2012, vs2013, vs2015)
# Result: <all label names><empty | "W"><empty | _x64><empty | _d>.lib
list(FILTER REL_LIBS EXCLUDE REGEX "^.+_(vc6|vc8|vs2012|vs2013|vs2015).*\.lib$")
# Exclude libraries whose target is debug
# Result: <all label names><empty | "W"><empty | _x64>.lib
list(FILTER REL_LIBS EXCLUDE REGEX "^.+_d\.lib$")

# Exclude libraries whose architecture is ${LIB_ARCH_SUFFIX}
# Result: <all label names><empty | "W">${LIB_ARCH_SUFFIX}.lib
if(DEFINED LIB_ARCH_SUFFIX)
        list(FILTER REL_LIBS INCLUDE REGEX "^.+${LIB_ARCH_SUFFIX}\.lib$")
endif()
if(DEFINED EXCLUDE_LIB_ARCH_SUFFIX)
        list(FILTER REL_LIBS EXCLUDE REGEX "^.+${EXCLUDE_LIB_ARCH_SUFFIX}\.lib$")
endif()

# Exclude libraries for wide character
# Result: <all label names>${LIB_ARCH_SUFFIX}.lib
list(FILTER REL_LIBS EXCLUDE REGEX "^.+W${LIB_ARCH_SUFFIX}\.lib$")
# Exclude zlib because zlib will be installed as dependencies
# Result: <all label names without zlib>${LIB_ARCH_SUFFIX}.lib
list(FILTER REL_LIBS EXCLUDE REGEX "^.+\/zlib${LIB_ARCH_SUFFIX}\.lib$")
# Copy libraries for release
file(INSTALL ${REL_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

################################
# Install libraries for debug
################################
# Glob libraries for debug
# Result: <all label names><empty or "W"><empty | _(all vs versions)><empty | _(all architectures)>_d.lib
file(GLOB DEB_LIBS ${EXTRACTED_DIR}/プロジェクトに追加すべきファイル_VC用/*${LIB_ARCH_SUFFIX}_d.lib)
# Exclude libraries whose vs version is not vs2019_or_later (vc6, vc8, vs2012, vs2013, vs2015)
# Result: <all label names><empty | "W"><empty | _x64>_d.lib
list(FILTER DEB_LIBS EXCLUDE REGEX "^.+_(vc6|vc8|vs2012|vs2013|vs2015).*\.lib$")

# Exclude libraries whose architecture is ${LIB_ARCH_SUFFIX}
# Result: <all label names><empty | "W">${LIB_ARCH_SUFFIX}_d.lib
if(DEFINED LIB_ARCH_SUFFIX)
        list(FILTER DEB_LIBS INCLUDE REGEX "^.+${LIB_ARCH_SUFFIX}_d\.lib$")
endif()
if(DEFINED EXCLUDE_LIB_ARCH_SUFFIX)
        list(FILTER DEB_LIBS EXCLUDE REGEX "^.+${EXCLUDE_LIB_ARCH_SUFFIX}_d\.lib$")
endif()

# Exclude libraries for wide character
# Result: <all label names>${LIB_ARCH_SUFFIX}_d.lib
list(FILTER DEB_LIBS EXCLUDE REGEX "^.+W${LIB_ARCH_SUFFIX}_d\.lib$")
# Exclude zlib because zlib will be installed as dependencies
# Result: <all label names without zlib>${LIB_ARCH_SUFFIX}_d.lib
list(FILTER DEB_LIBS EXCLUDE REGEX "^.+\/zlib${LIB_ARCH_SUFFIX}_d\.lib$")
# Copy libraries for debug
file(INSTALL ${DEB_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

################################
# Install copyright
################################
file(INSTALL ${EXTRACTED_DIR}/DxLib.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/dxlib RENAME copyright)
