# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-gba-libretro"
LIBRETRO_COMMIT_SHA="5fccbb2be361c60a176a033f5a6f735c1cea783b"

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen VBA/GBA. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/beetle-gba-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_gba

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "gba_bios.bin (GBA BIOS)"
		elog ""
		ewarn ""
	fi
}