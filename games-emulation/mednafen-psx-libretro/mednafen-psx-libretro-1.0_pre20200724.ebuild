# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-psx-libretro"
LIBRETRO_COMMIT_SHA="52710212f35b7254eeb11b541d7f16b581b406a9"

inherit libretro-core

DESCRIPTION="Standalone port/fork of Mednafen PSX to the Libretro API."
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_install() {
    LIBRETRO_CORE_LIB_FILE="${S}/mednafen_psx_libretro.so" \
	libretro-core_src_install
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}