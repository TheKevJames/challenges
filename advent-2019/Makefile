SRC_FILES := $(wildcard ./*.erl)
OBJ_FILES := $(patsubst ./%.erl,./%.beam,$(SRC_FILES))

.SUFFIXES: .beam .erl

.erl.beam:
	erlc -Wall $<

all: $(OBJ_FILES)
