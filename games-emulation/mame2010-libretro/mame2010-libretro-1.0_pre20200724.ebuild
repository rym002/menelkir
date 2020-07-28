# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/mame2010-libretro"
LIBRETRO_COMMIT_SHA="9b0e3b3384cc8e86e78870262f4027bdce9de0f4"

inherit libretro-core

DESCRIPTION="MAME (0.139) for libretro."
HOMEPAGE="https://github.com/libretro/mame2010-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}