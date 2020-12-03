SESSION = "53616c7465645f5fb0d356f1d4662e56aeea1ed683840d1ab968b2eeac57df8f97125e6000644cc864d3dafb97b7a80b"

FLAGS := -d:release --opt:speed

INPUTS := $(shell seq -f 'in%02g' 1 1 25)
BINS := $(patsubst %.nim,./%,$(wildcard *.nim))

all: perf.md

inputs: $(INPUTS)
$(INPUTS):
	curl -s --cookie "session=${SESSION}" "https://adventofcode.com/2020/day/$(patsubst 0%,%,$(subst in,,$@))/input" > $@

bins: $(BINS)
%: %.nim
	nim c $(FLAGS) $<

perf.md: $(BINS) $(INPUTS)
	hyperfine -w3 $(BINS) --export-markdown $@

clean:
	rm -f $(BINS)
