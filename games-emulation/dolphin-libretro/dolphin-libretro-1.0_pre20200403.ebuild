# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/dolphin"
LIBRETRO_COMMIT_SHA="1fbd59911d1b718c142d6448dee3ede98152e395"

inherit libretro-core cmake-utils

DESCRIPTION="libretro implementation of Dolphin. (Nintendo GC/Wii)"
HOMEPAGE="https://github.com/libretro/dolphin"
KEYWORDS="amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE="opengl vulkan"

DEPEND="opengl? ( virtual/opengl )
		vulkan? ( media-libs/vulkan-loader:0= )"
RDEPEND="${DEPEND}
		dev-util/spirv-headers
		games-emulation/libretro-info"

S="${S}"/Source/Core/DolphinLibretro

src_compile() {
	myemakeargs=(
		$(usex opengl "HAVE_OPENGL_CORE=1" "HAVE_OPENGL_CORE=0")
		$(usex vulkan "HAVE_VULKAN=1" "HAVE_VULKAN=0")
		STATIC_LINKING=0
	)
	libretro-core_src_compile
}