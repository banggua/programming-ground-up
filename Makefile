DIRS = chapter3 chapter4 chapter5 chapter6

all:
	cd chapter3 && make all && cd -
	cd chapter4 && make all && cd -
	cd chapter5 && make all && cd -
	cd chapter6 && make all && cd -
	cd chapter7 && make all && cd -

clean:
	cd chapter3 && make clean && cd -
	cd chapter4 && make clean && cd -
	cd chapter5 && make clean && cd -
	cd chapter6 && make clean && cd -
	cd chapter7 && make clean && cd -
