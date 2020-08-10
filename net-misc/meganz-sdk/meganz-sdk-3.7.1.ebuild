# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic qmake-utils autotools db-use vcs-snapshot

SRC_URI="https://github.com/${PN%-*}/${PN#*-}/archive/v${PV}.tar.gz"
RESTRICT="primaryuri"
KEYWORDS="amd64 x86"

DESCRIPTION="MEGA C++ SDK"
HOMEPAGE="https://github.com/meganz/sdk"

LICENSE="BSD-2"
SLOT="0/30608"
IUSE="examples ffmpeg freeimage fuse hardened inotify libuv mediainfo qt raw +sqlite test"
REQUIRED_USE="
	examples? ( sqlite )
	fuse? ( examples )
"
# tests require a working mega.nz account and login details provided via $MEGA_EMAIL and $MEGA_PWD
RESTRICT+=" test"

RDEPEND="
	dev-libs/crypto++
	sys-libs/zlib
	dev-libs/libpcre:3[cxx]
	dev-libs/openssl:0
	net-dns/c-ares
	net-misc/curl
	sqlite? ( dev-db/sqlite:3 )
	!sqlite? ( sys-libs/db:*[cxx] )
	examples? (
		sys-libs/readline:0
		fuse? ( sys-fs/fuse:0 )
	)
	freeimage? ( media-libs/freeimage )
	libuv? ( dev-libs/libuv )
	dev-libs/libsodium
	mediainfo? ( media-libs/libmediainfo )
	ffmpeg? ( virtual/ffmpeg )
	raw? ( media-libs/libraw )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"

S="${WORKDIR}/v${PV}"

pkg_setup() {
	use sqlite || append-cppflags "-I$(db_includedir)"
}

src_prepare() {
	default
	use qt && sed \
		-e '/SOURCES += src\// s:+:-:' \
		-e '/!exists.*config.h/ s:!::' \
		-e 's:CONFIG(USE_MEGAAPI) {:&\nLIBS += -lmega:' \
		-e '/^unix:!macx {/,/^}/d' \
		-i bindings/qt/sdk.pri
	use test && sed \
		-e 's:\$(GTEST_DIR)/lib/lib\([^ ]\+\)\.la:-l\1:g' \
		-e 's: tests/tool_purge_account::' \
		-i tests/include.am
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-chat
		$(use_enable inotify)
		$(use_enable hardened gcc-hardening)
		$(use_with libuv)
		$(use_with !sqlite db)
		$(use_with sqlite)
		$(use_enable examples)
		$(use_enable test tests)
		$(use_with freeimage)
		$(use_with fuse)
		$(use_with mediainfo libmediainfo)
		$(use_with ffmpeg)
		$(use_with raw libraw)
	)
	use test && myeconfargs+=(
		--with-gtest="${EPREFIX}/usr"
	)
	econf "${myeconfargs[@]}"
}

src_test() {
	export MEGA_EMAIL MEGA_PWD MEGA_EMAIL_AUX="${MEGA_EMAIL}" MEGA_PWD_AUX="${MEGA_PWD}"
	default
}

src_install() {
	default
	doheader -r include/mega

	use qt || return
	insinto /usr/share/${PN}/bindings/qt
	doins bindings/qt/*.{h,cpp,pri}
}