/*
	Adrenaline
	Copyright (C) 2016-2018, TheFloW

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <common.h>
#include "main.h"

int sctrlSEGetConfigEx(SEConfig *config, int size) {
	int k1 = pspSdkSetK1(0);
	
	memset(config, 0, size);
	SceUID fd = sceIoOpen("flash1:/config.cef", PSP_O_RDONLY, 0);
	if (fd < 0) {
		pspSdkSetK1(k1);
		return -1;
	}

	int read = sceIoRead(fd, config, size);

	sceIoClose(fd);
	pspSdkSetK1(k1);

	return read;
}

int sctrlSESetConfigEx(SEConfig *config, int size) {
	int k1 = pspSdkSetK1(0);
		
	SceUID fd = sceIoOpen("flash1:/config.cef", PSP_O_WRONLY | PSP_O_CREAT | PSP_O_TRUNC, 0777);
	if (fd < 0) {
		pspSdkSetK1(k1);
		return -1;
	}

	config->tncef.magic[0] = SECONFIG_MAGIC_TNCEF_1;
	config->tncef.magic[1] = SECONFIG_MAGIC_TNCEF_2;

	if (sceIoWrite(fd, config, size) < size) {
		sceIoClose(fd);
		pspSdkSetK1(k1);
		return -1;
	}

	sceIoClose(fd);
	pspSdkSetK1(k1);

	return 0;
}

int sctrlSEGetConfig(SEConfig *config) {
	return sctrlSEGetConfigEx(config, sizeof(SEConfigTNCEF));
}

int sctrlSESetConfig(SEConfig *config) {
	return sctrlSESetConfigEx(config, sizeof(SEConfigTNCEF));
}