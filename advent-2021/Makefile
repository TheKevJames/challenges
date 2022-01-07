SESSION = "53616c7465645f5fab3137a1773524b73e030a7c6d57eda55b99d666db29fb218da6e254dd7dbdc1bd398e2f3d1c3a57"

# FLAGS := --stackTrace:on --lineTrace:on --checks:on --assertions:on --opt:none --warnings:on --hints:on --verbosity:3
FLAGS := --stackTrace:on --lineTrace:on --checks:on --assertions:on --opt:none
# FLAGS := -d:danger -d:release --opt:speed

INPUTS := $(shell seq -f 'in%02g' 1 1 25)
BINS := $(sort $(patsubst %.nim,./%,$(wildcard *.nim)))

all: README.rst

inputs: $(INPUTS)
$(INPUTS):
	curl -s --cookie "session=${SESSION}" "https://adventofcode.com/2021/day/$(patsubst 0%,%,$(subst in,,$@))/input" > $@

bins: $(BINS)
%: %.nim
	nim c $(FLAGS) $<

README.rst: README.src perf.rst
	cp $< $@
	echo '' >>$@
	cat $(word 2,$^) >>$@

perf.rst: perf.md
	pandoc -trst $< >$@

perf.md: $(BINS) $(INPUTS)
	hyperfine -w3 $(BINS) --export-markdown $@

clean:
	rm -f $(BINS)
