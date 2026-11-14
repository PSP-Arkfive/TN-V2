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

#ifndef __EXECUTABLE_PATCH_H__
#define __EXECUTABLE_PATCH_H__


extern int (* _sceKernelCheckExecFile)(void *buf, SceLoadCoreExecFileInfo *execInfo);
extern int (* _sceKernelProbeExecutableObject)(void *buf, SceLoadCoreExecFileInfo *execInfo);
extern int (* PspUncompress)(void *buf, SceLoadCoreExecFileInfo *execInfo, u32 *newSize);
extern int (* PartitionCheck)(u32 *param, SceLoadCoreExecFileInfo *execInfo);

int sceKernelCheckExecFilePatched(void *buf, SceLoadCoreExecFileInfo *execInfo);
int sceKernelProbeExecutableObjectPatched(void *buf, SceLoadCoreExecFileInfo *execInfo);
int PspUncompressPatched(void *buf, SceLoadCoreExecFileInfo *execInfo, u32 *newSize);
int PartitionCheckPatched(u32 *param, SceLoadCoreExecFileInfo *execInfo);

#endif