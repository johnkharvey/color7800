# Makefile for "Color Utility"

#==================
# Global Variables
#==================
# Latest as of 12/24/2022 - https://github.com/dasm-assembler/dasm/tags
DASM_VERSION=2.20.14.1

# Latest as of 12/24/2022 - https://github.com/7800-devtools/a7800/tags
A7800_VERSION=v5.2

# For a7800sign; latest as of 12/24/2022 - http://7800.8bitdev.org/index.php/7800AsmDevKit
DEVKIT_VERSION=0.20.1
DEVKIT_URL=http://7800.8bitdev.org/images/6/60/7800AsmDevKit-0.20.1-osx-x64.tar.gz

#=========
# Aliases
#=========
# 7800-specific build tools
DASM=bin/dasm/dasm
7800SIGN=bin/devkit_tools/7800basic/7800sign

# 7800-specific runtime tools
A7800=bin/a7800/a7800

# OS-level Tools
WGET=/opt/homebrew/bin/wget
TAR=/usr/bin/tar
UNZIP=/usr/bin/unzip
SLEEP=/bin/sleep

#===============
# Build Targets
#===============
.PHONY:	all run clean megaclean setup

all:	out/color.a78

# Special variable to only initialize tools.  Not generally used.
setup:  ${WGET} ${7800SIGN} ${DASM} ${A7800}

${WGET}:
	brew install wget

${7800SIGN}:	${WGET} ${TAR}
	mkdir -p bin/devkit_tools
	wget -O bin/devkit_tools/7800AsmDevKit.tar.gz ${DEVKIT_URL}
	cd bin/devkit_tools && tar xvf 7800AsmDevKit.tar.gz
	# Do a touch so it doesn't keep appearing out-of-date
	find bin/devkit_tools/ -type f -exec touch {} +
	rm -f bin/devkit_tools/7800AsmDevKit.tar.gz

${DASM}:	${WGET} ${TAR}
	mkdir -p bin/dasm
	wget -O bin/dasm/dasm.tar.gz https://github.com/dasm-assembler/dasm/releases/download/${DASM_VERSION}/dasm-${DASM_VERSION}-osx-x64.tar.gz
	tar xvf bin/dasm/dasm.tar.gz --directory bin/dasm/
        # Do a touch so it doesn't keep appearing out-of-date
	find bin/dasm/ -type f -exec touch {} +
	rm -f bin/dasm/dasm.tar.gz

out:
	mkdir -p out

#================
# Binary targets
#================

out/color.bin:	src/color.asm out
	echo "\n###### Creating color.bin... ######"
	${DASM} src/color.asm -f3 -oout/color.bin -sout/color.symbol.txt -lout/color.annotated_source.txt

out/color.a78:	src/cartridge_header_color.asm out/color.bin ${7800SIGN} out
	echo "\n###### Signing color.bin... ######"
	${7800SIGN} -w out/color.bin
	echo "\n\n###### Creating color.a78... ######"
	${DASM} src/cartridge_header_color.asm -f3 -oout/color.a78

#===============
# Run Targets
#===============

${A7800}:	${WGET} ${TAR}
	echo "Checking a7800 emulator..."
	# Download and install
	mkdir -p tmp/
	wget -O tmp/a7800.tgz https://github.com/7800-devtools/a7800/releases/download/${A7800_VERSION}/a7800-osx-${A7800_VERSION}.tgz
	cd tmp && tar zxf a7800.tgz
	mkdir -p bin/a7800
	cp tmp/a7800-osx/a7800 bin/a7800/a7800
	rm -rf tmp
	# Configure our ini file
	mkdir -p ~/.a7800
	./bin/a7800/a7800 -cc
	mv a7800.ini ~/.a7800
	#rm -f ui.ini plugin.ini
	# We need the 7800.rom file (found here: https://atariage.com/forums/topic/268458-a7800-the-atari-7800-emulator/)
	wget -O bin/a7800/Additional_Files_a7800_v0188-01.zip https://atariage.com/forums/applications/core/interface/file/attachment.php?id=521608
	cd bin/a7800 && unzip -o Additional_Files_a7800_v0188-01.zip
	rm -f bin/a7800/Additional_Files_a7800_v0188-01.zip

run:	${A7800}
	cd bin/a7800 && ./a7800 a7800 -cart ../../out/color.a78

debug:	${A7800}
	cd bin/a7800 && ./a7800 a7800 -cart ../../out/color.a78 -debug

devel:	${A7800}
	cd bin/a7800 && ./a7800 a7800dev -cart ../../out/color.a78


#===============
# Clean Targets
#===============
clean:
	rm -rf out
	rm -rf tmp

megaclean:	clean
	#brew uninstall wget
	rm -rf bin/devkit_tools
	rm -rf bin/dasm
	rm -rf bin/a7800
	#rm -rf ~/.a7800
	#sudo rm -rf /Volumes/SDL2/SDL2.framework
