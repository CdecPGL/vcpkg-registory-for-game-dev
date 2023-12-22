# Specify reference in GitHub
set(GITHUB_REF 1e32fe01d3bbcb88633871634d9991ee0aa4952c)

include(vcpkg_common_functions)

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/lua-intf-${GITHUB_REF})
vcpkg_from_github(
    OUT_SOURCE_PATH ${SOURCE_PATH}
    REPO SteveKChiu/lua-intf
    REF ${GITHUB_REF}
    SHA512 00719bedc047c70642233c453398f515feeffcd5e572ccc862d7d90471d7cf15c413c1d15f8fe58384a567e6ab210936656c02355626934d661b776fe2016af6
    HEAD_REF master
)

# Copy libraries
file(GLOB INDLUDES ${SOURCE_PATH}/LuaIntf/*)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/lua-intf RENAME copyright)
