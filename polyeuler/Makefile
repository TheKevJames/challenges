FOLDERS := `find * -maxdepth 0 -type d`


all: build


build:
	for folder in $(FOLDERS); do \
		make -sC $$folder ; \
	done


test: build
	python polyeuler.py --tries 1


clean:
	for folder in $(FOLDERS); do \
		make -sC $$folder clean ; \
	done
