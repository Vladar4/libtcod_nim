#
# libtcod 1.5.1
# Copyright (c) 2008,2009,2010,2012 Jice & Mingos
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * The name of Jice or Mingos may not be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY JICE AND MINGOS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL JICE OR MINGOS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#


include
  mouse_types


#TCODLIB_API void TCOD_mouse_show_cursor(bool visible);
proc mouse_show_cursor*(visible: bool) {.cdecl, importc: "TCOD_mouse_show_cursor", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_mouse_t TCOD_mouse_get_status();
proc mouse_get_status*(): TMouse {.cdecl, importc: "TCOD_mouse_get_status", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_mouse_is_cursor_visible();
proc mouse_is_cursor_visible*(): bool {.cdecl, importc: "TCOD_mouse_is_cursor_visible", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_mouse_move(int x, int y);
proc mouse_move*(x, y: int) {.cdecl, importc: "TCOD_mouse_move", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_mouse_includes_touch(bool enable);
proc mouse_includes_touch*(enable: bool) {.cdecl, importc: "TCOD_mouse_includes_touch", dynlib: LIB_NAME.}

