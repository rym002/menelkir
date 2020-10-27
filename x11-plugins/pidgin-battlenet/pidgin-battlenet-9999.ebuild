# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Libpurple (Pidgin) plugin for Battle.net"
HOMEPAGE="https://github.com/EionRobb/purple-battlenet"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="libressl"

DEPEND="net-im/pidgin
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"

