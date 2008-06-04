BIN=gaspaint
SRC=callbacks.c drawarea.c drawing.c event.c main.c ui.c
HDR=callbacks.h config.h drawarea.h drawing.h event.h main.h public.h ui.h

all:
	gcc ${SRC} -o ../bin/${BIN} `pkg-config --libs --cflags gtk+-2.0 gtkglext-1.0` -lglut


run:
	cd ../bin/ && ./${BIN}

clean:
	rm -rf ${BIN};

count:
	wc -l ${SRC} ${HDR}
