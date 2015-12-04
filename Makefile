#
# CC Debugger
# Fergus Noble (c) 2011
#

CC = sdcc
AS = sdas8051

CFLAGS = --model-small --opt-code-size

LDFLAGS_FLASH = \
	--out-fmt-ihx \
	--code-loc 0x0000 --code-size 0x1400 \
	--xram-loc 0xf000 --xram-size 0x300 \
	--iram-size 0x100

ASFLAGS = -plosgff

ifdef DEBUG
CFLAGS += --debug
endif

SRC = \
	src/main.c \
	src/usb.c \
	src/flash.c \
	src/intel_hex.c \
	src/hal.c \
	src/usb_descriptors.c 

ASM_SRC = src/start.asm

ADB = $(SRC:.c=.c.adb)
ASM = $(SRC:.c=.c.asm)
LNK = $(SRC:.c=.c.lnk)
LST = $(SRC:.c=.c.lst)
REL = $(SRC:.c=.c.rel)
RST = $(SRC:.c=.c.rst)
SYM = $(SRC:.c=.c.sym)

ASM_ADB = $(ASM_SRC:.asm=.adb)
ASM_LNK = $(ASM_SRC:.asm=.lnk)
ASM_LST = $(ASM_SRC:.asm=.lst)
ASM_REL = $(ASM_SRC:.asm=.rel)
ASM_RST = $(ASM_SRC:.asm=.rst)
ASM_SYM = $(ASM_SRC:.asm=.sym)

PROGS = CCBootloader.hex CCBootloader-rfcat-chronosdongle.hex CCBootloader-rfcat-donsdongle.hex CCBootloader-rfcat-ys1.hex CCBootloader-rfcat-srf.hex
PCDB = $(PROGS:.hex=.cdb)
PLNK = $(PROGS:.hex=.lnk)
PMAP = $(PROGS:.hex=.map)
PMEM = $(PROGS:.hex=.mem)
PAOM = $(PROGS:.hex=)

%.c.rel : %.c
	$(CC) -c $(CFLAGS) -o$*.c.rel $<

%.rel : %.asm
	$(AS) -c $(ASFLAGS) $<

all: $(PROGS)

CCBootloader.hex: $(REL) $(ASM_REL) Makefile
	$(CC) $(LDFLAGS_FLASH) $(CFLAGS) -o CCBootloader.hex $(ASM_REL) $(REL)

CCBootloader-rfcat-chronosdongle.hex: CFLAGS += -DRFCAT -DRFCAT_CHRONOS
CCBootloader-rfcat-chronosdongle.hex: $(REL) $(ASM_REL) Makefile
	$(CC) $(LDFLAGS_FLASH) $(CFLAGS) -o CCBootloader-rfcat-chronosdongle.hex $(ASM_REL) $(REL)

CCBootloader-rfcat-donsdongle.hex: CFLAGS += -DRFCAT -DRFCAT_DONSDONGLE
CCBootloader-rfcat-donsdongle.hex: $(REL) $(ASM_REL) Makefile
	$(CC) $(LDFLAGS_FLASH) $(CFLAGS) -o CCBootloader-rfcat-donsdongle.hex $(ASM_REL) $(REL)

CCBootloader-rfcat-ys1.hex: CFLAGS += -DRFCAT -DRFCAT_YARDSTICKONE
CCBootloader-rfcat-ys1.hex: $(REL) $(ASM_REL) Makefile
	$(CC) $(LDFLAGS_FLASH) $(CFLAGS) -o CCBootloader-rfcat-ys1.hex $(ASM_REL) $(REL)

CCBootloader-rfcat-srf.hex: CFLAGS += -DRFCAT -DRFCAT_SRFSTICK
CCBootloader-rfcat-srf.hex: $(REL) $(ASM_REL) Makefile
	$(CC) $(LDFLAGS_FLASH) $(CFLAGS) -o CCBootloader-rfcat-srf.hex $(ASM_REL) $(REL)

clean:
	rm -f $(ADB) $(ASM) $(LNK) $(LST) $(REL) $(RST) $(SYM)
	rm -f $(ASM_ADB) $(ASM_LNK) $(ASM_LST) $(ASM_REL) $(ASM_RST) $(ASM_SYM)
	rm -f $(PROGS) $(PCDB) $(PLNK) $(PMAP) $(PMEM) $(PAOM)

install: CCBootloader.hex
	goodfet.cc erase
	goodfet.cc flash CCBootloader.hex
	goodfet.cc verify CCBootloader.hex

installchronosdongle: CCBootloader-rfcat-chronosdongle.hex
	goodfet.cc erase
	goodfet.cc flash CCBootloader-rfcat-chronosdongle.hex
	goodfet.cc verify CCBootloader-rfcat-chronosdongle.hex

installdonsdongle: CCBootloader-rfcat-donsdongle.hex
	goodfet.cc erase
	goodfet.cc flash CCBootloader-rfcat-donsdongle.hex
	goodfet.cc verify CCBootloader-rfcat-donsdongle.hex

installys1dongle: CCBootloader-rfcat-ys1.hex
	goodfet.cc erase
	goodfet.cc flash CCBootloader-rfcat-ys1.hex
	goodfet.cc verify CCBootloader-rfcat-ys1.hex

installsrfdongle: CCBootloader-rfcat-srf.hex
	goodfet.cc erase
	goodfet.cc flash CCBootloader-rfcat-srf.hex
	goodfet.cc verify CCBootloader-rfcat-srf.hex
