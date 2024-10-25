NCURSES_SRC := https://ftp.gnu.org/gnu/ncurses/ncurses-6.4.tar.gz

NCURSES_X86_64_CONFIG_ARGS = --without-libtool --without-shared\
    --without-manpages --without-tests --without-tack\
    --without-ada --without-cxx --without-cxx-binding\
    --without-tests --with-termlib --with-ticlib\
    --without-dlsym --without-pcre2 --without-sysmouse\
    --with-curses-h --disable-stripping --enable-widec\
    --disable-lib-suffixes\
    --prefix=$$(COSMOS)\
    --sysconfdir=/zip --datarootdir=/zip/usr/share\
    CFLAGS="-Os"

NCURSES_AARCH64_CONFIG_ARGS = $(NCURSES_X86_64_CONFIG_ARGS) --build=aarch64

$(eval $(call DOWNLOAD_SOURCE,lib/ncurses,$(NCURSES_SRC)))
# build calls bash during tinfo build, need a cosmo bash
# this gets downloaded by the cosmo script
$(eval $(call SPECIFY_DEPS,cli/mawk))
$(eval $(call AUTOTOOLS_BUILD,lib/ncurses,$(NCURSES_X86_64_CONFIG_ARGS),$(NCURSES_AARCH64_CONFIG_ARGS)))

o/lib/ncurses/built.fat: FATTEN_COMMAND = $(DUMMYLINK0)
