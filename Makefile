# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

BLD_PATH = build/
SRC_PATH = src/

SRC_FILE =${wildcard ${SRC_PATH}*.c}
OBJ_FILE =${patsubst ${SRC_PATH}%.c, ${BLD_PATH}%.o, ${SRC_FILE}}

${BLD_PATH}%.o : ${SRC_PATH}%.c
	${CC} -c ${CFLAGS} $^ -o $@

dwm: ${OBJ_FILE}
	${CC} -o ${BLD_PATH}$@ ${OBJ_FILE} ${LDFLAGS}

clean:
	@rm ${BLD_PATH}* -rf

install: dwm
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f ${BLD_PATH}dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < man/dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1

.PHONY: dwm clean install uninstall
