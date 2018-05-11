CC=gcc
CFLAGS   = -Wall -Wextra -mtune=native `sdl2-config --cflags`
LDFLAGS  = `sdl2-config --libs` -lSDL2_image -lm

.SUFFIXES:
.SUFFIXES: .c .o

srcdir	 =src/

compress: make_sdl2_light_c.tar
	bzip2 -z --force make_sdl2_light_c.tar

make_sdl2_light_c.tar: cp_files
	cd temp;tar rvf ../make_sdl2_light_c.tar *

.PHONY: all install
.PHONY: cp_files dirs

dirs:
	mkdir -p temp/assets
	mkdir -p temp/src

cp_files: dirs
	 cp -r assets/* temp/assets
	 cp src/* temp/src
	 cp template/* temp

.PHONY: make_sdl2_light_c.tar.bz2 compress

.PHONY: install
install: make_sdl2_light_c.tar.bz2
	mkdir -p /home/$(USER)/.local/share/kdevappwizard/templates
	cp make_sdl2_light_c.tar.bz2 /home/$(USER)/.local/share/kdevappwizard/templates

test:	$(srcdir)helper.c $(srcdir)main.c
	$(CC) $(CFLAGS) $? -o $@ $(LDFLAGS)

.PHONY: clean
clean:
	@rm -rf temp test make_sdl2_light_c.tar.bz2 2>/dev/null || true

