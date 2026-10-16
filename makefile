CC= gcc
CXX= g++
CCLD= g++

CCFLAGS:= -MMD -O2 -ggdb -I. -DNDEBUG
LDFLAGS= -Wl,-O3
LDLIBS= 

CXXFLAGS= $(CCFLAGS) -std=gnu++2c -fexceptions
CFLAGS= $(CCFLAGS) -std=gnu2x

OBJS:= casefusefold.o

DEPS= $(OBJS:.o=.d)

PKGS= fuse3 icu-uc

PREFIX ?= /opt/casefusefold

.PHONY: clean install

CCFLAGS:= $(CCFLAGS) $(shell pkg-config --cflags $(PKGS))

casefusefold: LDLIBS+= $(shell pkg-config --libs $(PKGS))
casefusefold: $(OBJS)
	$(CCLD) $(CXXFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@

-include $(DEPS)

clean:
	$(RM) casefusefold $(OBJS)

install: casefusefold
	install -Dsm755 casefusefold -t $(PREFIX)/bin
