prefix ?= /usr/local/

.PHONY: all
all:
	echo "nothing to do, try 'make install'"

.PHONY: install
install:
	mkdir -p ${DESTDIR}${prefix}/bin
	install -m=0755 freestanding-pass ${DESTDIR}${prefix}/bin/freestanding-pass
	install -m=0755 freestanding-gpg ${DESTDIR}${prefix}/bin/freestanding-gpg
