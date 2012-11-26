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
  console_types


proc bkgnd_alpha*(alpha: float32): TBkgndFlag {.inline.} =
  return BKGND_ALPH or (int(alpha*255) shl 8)

proc bkgnd_addalpha*(alpha: float32): TBkgndFlag {.inline.} =
  return BKGND_ADDA or (int(alpha*255) shl 8)

type
  PConsole* = pointer

#TCODLIB_API void TCOD_console_init_root(int w, int h, const char * title, bool fullscreen, TCOD_renderer_t renderer);
proc console_init_root*(w, h: int, title: cstring, fullscreen=false, renderer=RENDERER_SDL) {.cdecl, importc: "TCOD_console_init_root", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_window_title(const char *title);
proc console_set_window_title*(title: cstring) {.cdecl, importc: "TCOD_console_set_window_title", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_fullscreen(bool fullscreen);
proc console_set_fullscreen*(fullscreen: bool) {.cdecl, importc: "TCOD_console_set_fullscreen", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_is_fullscreen();
proc console_is_fullscreen*(): bool {.cdecl, importc: "TCOD_console_is_fullscreen", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_is_window_closed();
proc console_is_window_closed*(): bool {.cdecl, importc: "TCOD_console_is_window_closed", dynlib: LIB_NAME.}




#TCODLIB_API void TCOD_console_set_custom_font(const char *fontFile, int flags,int nb_char_horiz, int nb_char_vertic);
proc console_set_custom_font*(fontFile: cstring, flags: int, nb_char_horiz=0, nb_char_vertic=0) {.cdecl, importc: "TCOD_console_set_custom_font", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_map_ascii_code_to_font(int asciiCode, int fontCharX, int fontCharY);
proc console_map_ascii_code_to_font*(asciiCode, fontCharX, fontCharY: int) {.cdecl, importc: "TCOD_console_map_ascii_code_to_int", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_map_ascii_codes_to_font(int asciiCode, int nbCodes, int fontCharX, int fontCharY)
proc console_map_ascii_codes_to_font*(asciiCode, nbCodes, fontCharX, fontCharY: int) {.cdecl, importc: "TCOD_console_map_ascii_codes_to_font", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_map_string_to_font(const char *s, int fontCharX, int fontCharY);
proc console_map_string_to_font*(s: cstring, fontCharX, fontCharY: int) {.cdecl, importc: "TCOD_console_map_string_to_font", dynlib: LIB_NAME.}



#TCODLIB_API void TCOD_console_set_dirty(int x, int y, int w, int h);
proc console_set_dirty*(x, y, w, h: int) {.cdecl, importc: "TCOD_console_set_dirty", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_default_background(TCOD_console_t con,TCOD_color_t col);
proc console_set_default_background*(con: PConsole, col: TColor) {.cdecl, importc: "TCOD_console_set_default_background", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_default_foreground(TCOD_console_t con,TCOD_color_t col);
proc console_set_default_foreground*(con: PConsole, col: TColor) {.cdecl, importc: "TCOD_console_set_default_foreground", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_clear(TCOD_console_t con);
proc console_clear*(con: PConsole) {.cdecl, importc: "TCOD_console_clear", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_char_background(TCOD_console_t con,int x, int y, TCOD_color_t col, TCOD_bkgnd_flag_t flag);
proc console_set_char_background*(con: PConsole, x, y: int, col: TColor, flag=BKGND_SET) {.cdecl, importc: "TCOD_console_set_char_background", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_char_foreground(TCOD_console_t con,int x, int y, TCOD_color_t col);
proc console_set_char_foreground*(con: PConsole, x, y: int, col: TColor) {.cdecl, importc: "TCOD_console_set_char_foreground", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_char(TCOD_console_t con,int x, int y, int c);
proc console_set_char*(con: PConsole, x, y, c: int) {.cdecl, importc: "TCOD_console_set_char", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_put_char(TCOD_console_t con,int x, int y, int c, TCOD_bkgnd_flag_t flag);
proc console_put_char*(con: PConsole, x, y, c: int, flag=BKGND_DEFAULT) {.cdecl, importc: "TCOD_console_put_char", dynlib: LIB_NAME.}
proc console_put_char*(con: PConsole, x, y: int, c: char, flag=BKGND_DEFAULT) {.inline.} = console_put_char(con, x, y, ord(c), flag)

#TCODLIB_API void TCOD_console_put_char_ex(TCOD_console_t con,int x, int y, int c, TCOD_color_t fore, TCOD_color_t back);
proc console_put_char_ex*(con: PConsole, x, y, c: int, fore, back: TColor) {.cdecl, importc: "TCOD_console_put_char_ex", dynlib: LIB_NAME.}
proc console_putc_har_ex*(con: PConsole, x, y: int, c: char, fore, back: TColor) {.inline.} = console_put_char_ex(con, x, y, ord(c), fore, back)


#TCODLIB_API void TCOD_console_set_background_flag(TCOD_console_t con,TCOD_bkgnd_flag_t flag);
proc console_set_background_flag*(con: PConsole, flag: TBkgndFlag) {.cdecl, importc: "TCOD_console_set_background_flag", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_bkgnd_flag_t TCOD_console_get_background_flag(TCOD_console_t con);
proc console_get_background_flag*(con: PConsole): TBkgndFlag {.cdecl, importc: "TCOD_console_get_background_flag", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_alignment(TCOD_console_t con,TCOD_alignment_t alignment);
proc console_set_alignment*(con: PConsole, alignment: TAlignment) {.cdecl, importc: "TCOD_console_set_alignment", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_alignment_t TCOD_console_get_alignment(TCOD_console_t con);
proc console_get_alginment*(con: PConsole): TAlignment {.cdecl, importc: "TCOD_console_get_alignment", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_print(TCOD_console_t con,int x, int y, const char *fmt, ...);
proc console_print*(con: PConsole, x, y: int, fmt: cstring) {.cdecl, importc: "TCOD_console_print", varargs, dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_print_ex(TCOD_console_t con,int x, int y, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const char *fmt, ...);
proc console_print_ex*(con: PConsole, x, y: int, flag: TBkgndFlag, alignment: TAlignment, fmt: cstring) {.cdecl, importc: "TCOD_console_print_ex", varargs, dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_console_print_rect(TCOD_console_t con,int x, int y, int w, int h, const char *fmt, ...);
proc console_print_rect*(con: PConsole, x, y, w, h: int, fmt: cstring): int {.cdecl, importc: "TCOD_console_print_rect", varargs, dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_console_print_rect_ex(TCOD_console_t con,int x, int y, int w, int h, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const char *fmt, ...);
proc console_print_rect_ex*(con: PConsole, x, y, w, h: int, flag: TBkgndFlag, alignment: TAlignment, fmt: cstring): int {.cdecl, importc: "TCOD_console_print_rect_ex", varargs, dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_console_get_height_rect(TCOD_console_t con,int x, int y, int w, int h, const char *fmt, ...);
proc console_get_height_rect*(con: PConsole, x, y, w, h: int, fmt: cstring): int {.cdecl, importc: "TCOD_console_get_height_rect", varargs, dynlib: LIB_NAME.}



#TCODLIB_API void TCOD_console_rect(TCOD_console_t con,int x, int y, int w, int h, bool clear, TCOD_bkgnd_flag_t flag);
proc console_rect*(con: PConsole, x, y, w, h: int, clear: bool, flag=BKGND_DEFAULT) {.cdecl, importc: "TCOD_console_rect", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_hline(TCOD_console_t con,int x,int y, int l, TCOD_bkgnd_flag_t flag);
proc console_hline*(con: PConsole, x, y, line: int, flag=BKGND_DEFAULT) {.cdecl, importc: "TCOD_console_hline", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_vline(TCOD_console_t con,int x,int y, int l, TCOD_bkgnd_flag_t flag);
proc console_vline*(con: PConsole, x, y, line: int, flag=BKGND_DEFAULT) {.cdecl, importc: "TCOD_console_vline", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_print_frame(TCOD_console_t con,int x,int y,int w,int h, bool empty, TCOD_bkgnd_flag_t flag, const char *fmt, ...);
proc console_print_frame*(con: PConsole, x, y, w, h: int, empty: bool, flag=BKGND_DEFAULT, fmt: cstring = nil) {.cdecl, importc: "TCOD_console_print_frame", varargs, dynlib: LIB_NAME.}



# unicode support
when not NO_UNICODE:
  #TCODLIB_API void TCOD_console_map_string_to_font_utf(const wchar_t *s, int fontCharX, int fontCharY);

  #TCODLIB_API void TCOD_console_print_utf(TCOD_console_t con,int x, int y, const wchar_t *fmt, ...);

  #TCODLIB_API void TCOD_console_print_ex_utf(TCOD_console_t con,int x, int y, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const wchar_t *fmt, ...);

  #TCODLIB_API int TCOD_console_print_rect_utf(TCOD_console_t con,int x, int y, int w, int h, const wchar_t *fmt, ...);

  #TCODLIB_API int TCOD_console_print_rect_ex_utf(TCOD_console_t con,int x, int y, int w, int h, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const wchar_t *fmt, ...);

  #TCODLIB_API int TCOD_console_get_height_rect_utf(TCOD_console_t con,int x, int y, int w, int h, const wchar_t *fmt, ...);



#TCODLIB_API TCOD_color_t TCOD_console_get_default_background(TCOD_console_t con);
proc console_get_default_background*(con: PConsole): TColor {.cdecl, importc: "TCOD_console_get_default_background", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_console_get_default_foreground(TCOD_console_t con);
proc console_get_default_foreground*(con: PConsole): TColor {.cdecl, importc: "TCOD_console_get_default_foreground", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_console_get_char_background(TCOD_console_t con,int x, int y);
proc console_get_char_background*(con: PConsole, x, y: int): TColor {.cdecl, importc: "TCOD_console_get_char_background", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_console_get_char_foreground(TCOD_console_t con,int x, int y);
proc console_get_char_foreground*(con: PConsole, x, y: int): TColor {.cdecl, importc: "TCOD_console_get_char_foreground", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_console_get_char(TCOD_console_t con,int x, int y);
proc console_get_char*(con: PConsole, x, y: int): int {.cdecl, importc: "TCOD_console_get_char", dynlib: LIB_NAME.}



#TCODLIB_API void TCOD_console_set_fade(uint8 val, TCOD_color_t fade);
proc console_set_fade*(val: uint8, fade: TColor) {.cdecl, importc: "TCOD_console_set_fade", dynlib: LIB_NAME.}

#TCODLIB_API uint8 TCOD_console_get_fade();
proc console_get_fade*(): uint8 {.cdecl, importc: "TCOD_console_get_fade", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_console_get_fading_color();
proc console_get_fading_color*(): TColor {.cdecl, importc: "TCOD_console_get_fading_color", dynlib: LIB_NAME.}



#TCODLIB_API void TCOD_console_flush();
proc console_flush*() {.cdecl, importc: "TCOD_console_flush", dynlib: LIB_NAME.}



#TCODLIB_API void TCOD_console_set_color_control(TCOD_colctrl_t con, TCOD_color_t fore, TCOD_color_t back);
proc console_set_color_control*(con: TColctrl, fore, back: TColor) {.cdecl, importc: "TCOD_console_set_color_control", dynlib: LIB_NAME.}



#TCODLIB_API TCOD_key_t TCOD_console_check_for_keypress(int flags);
proc console_check_for_keypress*(flags: int): TKey {.cdecl, importc: "TCOD_console_check_for_keypress", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_key_t TCOD_console_wait_for_keypress(bool flush);
proc console_wait_for_keypress*(flush: bool): TKey {.cdecl, importc: "TCOD_console_wait_for_keypress", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_keyboard_repeat(int initial_delay, int interval);
proc console_set_keyboard_repeat*(initial_delay, interval: int) {.cdecl, importc: "TCOD_console_set_keyboard_repeat", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_disable_keyboard_repeat();
proc console_disable_keyboard_repeat*() {.cdecl, importc: "TCOD_console_disable_keyboard_repeat", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_is_key_pressed(TCOD_keycode_t key);
proc console_is_key_pressed*(key: TKeycode): bool {.cdecl, importc: "TCOD_console_is_key_pressed", dynlib: LIB_NAME.}



# ASCII paint file support
#TCODLIB_API TCOD_console_t TCOD_console_from_file(const char *filename);
proc console_from_file*(filename: cstring): PConsole {.cdecl, importc: "TCOD_console_from_file", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_load_asc(TCOD_console_t con, const char *filename);
proc console_load_asc*(con: PConsole, filename: cstring): bool {.cdecl, importc: "TCOD_console_load_asc", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_load_apf(TCOD_console_t con, const char *filename);
proc console_load_apf*(con: PConsole, filename: cstring): bool {.cdecl, importc: "TCOD_console_load_apf", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_save_asc(TCOD_console_t con, const char *filename);
proc console_save_asc*(con: PConsole, filename: cstring): bool {.cdecl, importc: "TCOD_console_save_asc", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_save_apf(TCOD_console_t con, const char *filename);
proc console_save_apf*(con: PConsole, filename: cstring): bool {.cdecl, importc: "TCOD_console_save_apf", dynlib: LIB_NAME.}



#TCODLIB_API TCOD_console_t TCOD_console_new(int w, int h);
proc console_new*(w, h: int): PConsole {.cdecl, importc: "TCOD_console_new", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_console_get_width(TCOD_console_t con);
proc console_get_width*(con: PConsole): int {.cdecl, importc: "TCOD_console_get_width", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_console_get_height(TCOD_console_t con);
proc console_get_height*(con: PConsole): int {.cdecl, importc: "TCOD_console_get_height", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_set_key_color(TCOD_console_t con,TCOD_color_t col);
proc console_set_key_color*(con: PConsole, col: TColor) {.cdecl, importc: "TCOD_console_set_key_color", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_blit(TCOD_console_t src,int xSrc, int ySrc, int wSrc, int hSrc, TCOD_console_t dst, int xDst, int yDst, float foreground_alpha, float background_alpha);
proc console_blit*(src: PConsole, xSrc, ySrc, wSrc, hSrc: int, dst: PConsole, xDst, yDst: int, foreground_alpha=1.0'f32, background_alpha=1.0'f32) {.cdecl, importc: "TCOD_console_blit", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_delete(TCOD_console_t console);
proc console_delete*(con: PConsole) {.cdecl, importc: "TCOD_console_delete", dynlib: LIB_NAME.}



#TCODLIB_API void TCOD_console_credits();
proc console_credits*() {.cdecl, importc: "TCOD_console_credits", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_console_credits_reset();
proc console_credits_reset*() {.cdecl, importc: "TCOD_console_credits_reset", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_console_credits_render(int x, int y, bool alpha);
proc console_credits_render*(x, y: int, alpha: bool): bool {.cdecl, importc: "TCOD_console_credits_render", dynlib: LIB_NAME.}

