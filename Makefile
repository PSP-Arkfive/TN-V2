PY = $(shell which python3)
PSPDEV = $(shell psp-config --pspdev-path)
BUILDTOOLS = $(PSPDEV)/share/psp-cfw-sdk/build-tools

all: _btcnf _rebootex _binary _systemctrl _popcorn _vshctrl _satelite _recovery _inferno
	mkdir -p dist/flash0/kd
	mkdir -p dist/flash0/vsh/module
	$(PY) $(BUILDTOOLS)/gz/pspgz.py dist/flash0/kd/systemctrl.prx $(BUILDTOOLS)/gz/SystemControl.hdr systemctrl/systemctrl.prx SystemControl 0x3007
	$(PY) $(BUILDTOOLS)/gz/pspgz.py dist/flash0/kd/vshctrl.prx $(BUILDTOOLS)/gz/SystemControl.hdr vshctrl/vshctrl.prx VshControl 0x3007
	$(PY) $(BUILDTOOLS)/gz/pspgz.py dist/flash0/kd/popcorn.prx $(BUILDTOOLS)/gz/SystemControl.hdr popcorn/popcorn.prx Popcorn 0x3007
	$(PY) $(BUILDTOOLS)/gz/pspgz.py dist/flash0/kd/inferno.prx $(BUILDTOOLS)/gz/SystemControl.hdr inferno/inferno.prx Inferno 0x3007
	cp satelite/satelite.prx dist/flash0/vsh/module/satelite.prx
	cp recovery/recovery.prx dist/flash0/vsh/module/recovery.prx
	cp btcnf/pspbtcnf_inferno/pspbtcnf.bin dist/flash0/kd/pspbtknf.bin
	cp btcnf/pspbtcnf_march33/pspbtcnf.bin dist/flash0/kd/pspbtlnf.bin
	cp btcnf/pspbtcnf_normal/pspbtcnf.bin dist/flash0/kd/pspbtjnf.bin
	cp btcnf/pspbtcnf_np9660/pspbtcnf.bin dist/flash0/kd/pspbtmnf.bin
	cp btcnf/pspbtcnf_recovery/pspbtcnf.bin dist/flash0/kd/pspbtrnf.bin
	$(PY) $(BUILDTOOLS)/pack/pack.py -p dist/FLASH0.TN flash0.txt -s

clean:
	make -C rebootex clean
	make -C binary clean
	make -C systemctrl clean
	make -C popcorn clean
	make -C vshctrl clean
	make -C satelite clean
	make -C recovery clean
	make -C inferno clean
	rm -f btcnf/pspbtcnf_inferno/pspbtcnf.bin
	rm -f btcnf/pspbtcnf_march33/pspbtcnf.bin
	rm -f btcnf/pspbtcnf_normal/pspbtcnf.bin
	rm -f btcnf/pspbtcnf_np9660/pspbtcnf.bin
	rm -f btcnf/pspbtcnf_recovery/pspbtcnf.bin
	rm -rf dist

_btcnf:
	$(PY) $(BUILDTOOLS)/btcnf.py build btcnf/pspbtcnf_inferno/pspbtcnf.txt
	$(PY) $(BUILDTOOLS)/btcnf.py build btcnf/pspbtcnf_march33/pspbtcnf.txt
	$(PY) $(BUILDTOOLS)/btcnf.py build btcnf/pspbtcnf_normal/pspbtcnf.txt
	$(PY) $(BUILDTOOLS)/btcnf.py build btcnf/pspbtcnf_np9660/pspbtcnf.txt
	$(PY) $(BUILDTOOLS)/btcnf.py build btcnf/pspbtcnf_recovery/pspbtcnf.txt

_rebootex:
	make -C rebootex
	bin2c rebootex/rebootex.bin systemctrl/rebootex.h rebootex

_binary:
	make -C binary
	bin2c binary/binary.bin systemctrl/binary.h binary

_systemctrl:
	make -C systemctrl

_popcorn:
	make -C popcorn

_vshctrl:
	make -C vshctrl

_inferno:
	make -C inferno

_satelite:
	make -C satelite

_recovery:
	make -C recovery
