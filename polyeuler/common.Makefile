SOURCES := $(wildcard *.cpp) $(wildcard *.py) $(wildcard *.scala)
TARGETS := $(patsubst %.scala,q%.class,$(patsubst %.py,%.pyc,$(patsubst %.cpp,%.o,$(SOURCES))))


all: $(TARGETS)


$(filter %.o,$(TARGETS)): %.o: %.cpp
	clang++ -O3 $< -o $@

$(filter %.pyc,$(TARGETS)): %.pyc: %.py
	python -m py_compile $<

$(filter %.class,$(TARGETS)): q%.class: %.scala
	scalac $<


clean:
	rm -f *.class
	rm -f *.o
	rm -f *.pyc
