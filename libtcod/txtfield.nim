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


type
  PText* = pointer


#TCODLIB_API TCOD_text_t TCOD_text_init(int x, int y, int w, int h, int max_chars);
proc text_init*(x, y, w, h, max_chars: int): PText {.cdecl, importc: "TCOD_text_init", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_text_set_properties(TCOD_text_t txt, int cursor_char, int blink_interval, const char * prompt, int tab_size);
proc text_set_properties*(txt: PText, cursor_char, blink_interval: int, prompt: cstring, tab_size: int) {.cdecl, importc: "TCOD_text_set_properties", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_text_set_colors(TCOD_text_t txt, TCOD_color_t fore, TCOD_color_t back, float back_transparency);
proc text_set_colors*(txt: PText, fore, back: TColor, back_transparency: float32) {.cdecl, importc: "TCOD_text_set_colors", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_text_update(TCOD_text_t txt, TCOD_key_t key);
proc text_update*(txt: PText, key: TKey): bool {.cdecl, importc: "TCOD_text_update", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_text_render(TCOD_text_t txt, TCOD_console_t con);
proc text_render*(txt: PText, con: PConsole) {.cdecl, importc: "TCOD_text_render", dynlib: LIB_NAME.}

#TCODLIB_API const char * TCOD_text_get(TCOD_text_t txt);
proc text_get*(txt: PText): cstring {.cdecl, importc: "TCOD_text_get", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_text_reset(TCOD_text_t txt);
proc text_reset*(txt: PText) {.cdecl, importc: "TCOD_text_reset", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_text_delete(TCOD_text_t txt);
proc text_delete*(txt: PText) {.cdecl, importc: "TCOD_text_delete", dynlib: LIB_NAME.}

