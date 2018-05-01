CC=gcc
CFLAGS   = -Wall -Wextra -mtune=native `sdl2-config --cflags`
LDFLAGS  = `sdl2-config --libs` -lSDL2_image -lm

.SUFFIXES:
.SUFFIXES: .c .o

srcdir	 =src/

.PHONY: all
all: template

template: cp_files tar_files compress

dirs:
	mkdir -p temp/assets
	mkdir -p temp/src

cp_files: dirs
	 cp -r assets/* temp/assets
	 cp src/* temp/src
	 cp template/* temp

tar_files: cp_files
	cd temp;tar rvf make_sdl2_light_c.tar *
	
compress: cp_files tar_files
	bzip2 -z --force temp/make_sdl2_light_c.tar

install: template
	cp temp/make_sdl2_light_c.tar.bz2 /home/$(USER)/.local/share/kdevappwizard/templates

test:	$(srcdir)helper.c $(srcdir)main.c
	$(CC) $(CFLAGS) $? -o $@ $(LDFLAGS)

.PHONY: clean
clean:
	@rm -rf temp test 2>/dev/null || true

