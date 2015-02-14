all: lib widgets

lib:
	cd lib; gmake

widgets: lib
	cd widgets; gmake

clean:
	cd lib; make clean
	cd widgets; make clean

