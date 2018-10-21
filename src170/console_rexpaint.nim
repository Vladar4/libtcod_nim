##
##  libtcod
##  Copyright (c) 2008-2018 Jice & Mingos & rmtew
##  All rights reserved.
##
##  Redistribution and use in source and binary forms, with or without
##  modification, are permitted provided that the following conditions are met:
##      * Redistributions of source code must retain the above copyright
##        notice, this list of conditions and the following disclaimer.
##      * Redistributions in binary form must reproduce the above copyright
##        notice, this list of conditions and the following disclaimer in the
##        documentation and/or other materials provided with the distribution.
##      * The name of Jice or Mingos may not be used to endorse or promote
##        products derived from this software without specific prior written
##        permission.
##
##  THIS SOFTWARE IS PROVIDED BY JICE, MINGOS AND RMTEW ``AS IS'' AND ANY
##  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
##  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
##  DISCLAIMED. IN NO EVENT SHALL JICE, MINGOS OR RMTEW BE LIABLE FOR ANY
##  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
##  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
##  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
##  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
##  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
##  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##

import
  console, console_types, list


proc consoleFromXp*(
  filename: cstring): Console {.
    cdecl, importc: "TCOD_console_from_xp", dynlib: LIB_NAME.}

proc consoleLoadXp*(
  con: Console; filename: cstring): bool {.
    cdecl, importc: "TCOD_console_load_xp", dynlib: LIB_NAME.}

proc consoleSaveXp*(
  con: Console; filename: cstring; compressLevel: cint): bool {.
    cdecl, importc: "TCOD_console_save_xp", dynlib: LIB_NAME.}

proc consoleListFromXp*(
  filename: cstring): List {.
    cdecl, importc: "TCOD_console_list_from_xp", dynlib: LIB_NAME.}

proc consoleListSaveXp*(
  consoleList: List; filename: cstring; compressLevel: cint): bool {.
    cdecl, importc: "TCOD_console_list_save_xp", dynlib: LIB_NAME.}

