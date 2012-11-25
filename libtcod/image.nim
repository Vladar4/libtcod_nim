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
  PImage* = pointer


#TCODLIB_API TCOD_image_t TCOD_image_new(int width, int height);
proc image_new*(width, height: int): PImage {.cdecl, importc: "TCOD_image_new", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_image_t TCOD_image_from_console(TCOD_console_t console);
proc image_from_console*(console: PConsole): PImage {.cdecl, importc: "TCOD_image_from_console", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_refresh_console(TCOD_image_t image, TCOD_console_t console);
proc image_refresh_console*(image: PImage, console: PConsole) {.cdecl, importc: "TCOD_image_refresh_console", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_image_t TCOD_image_load(const char *filename);
proc image_load*(filename: cstring): PImage {.cdecl, importc: "TCOD_image_load", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_clear(TCOD_image_t image, TCOD_color_t color);
proc image_clear*(image: PImage, color: TColor) {.cdecl, importc: "TCOD_image_clear", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_invert(TCOD_image_t image);
proc image_invert*(image: PImage) {.cdecl, importc: "TCOD_image_invert", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_hflip(TCOD_image_t image);
proc image_hflip*(image: PImage) {.cdecl, importc: "TCOD_image_hflip", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_rotate90(TCOD_image_t image, int numRotations);
proc image_rotate90*(image: PImage, numRotations=1) {.cdecl, importc: "TCOD_image_rotate90", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_vflip(TCOD_image_t image);
proc image_vflip*(image: PImage) {.cdecl, importc: "TCOD_image_vflip", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_scale(TCOD_image_t image, int neww, int newh);
proc image_scale*(image: PImage, neww, newh: int) {.cdecl, importc: "TCOD_image_scale", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_save(TCOD_image_t image, const char *filename);
proc image_save*(image: PImage, filename: cstring) {.cdecl, importc: "TCOD_image_save", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_get_size(TCOD_image_t image, int *w,int *h);
proc image_get_size*(image: PImage, w, h: ptr int) {.cdecl, importc: "TCOD_image_get_size", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_image_get_pixel(TCOD_image_t image,int x, int y);
proc image_get_pixel*(image: PImage, x, y: int): TColor {.cdecl, importc: "TCOD_image_get_pixel", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_image_get_alpha(TCOD_image_t image,int x, int y);
proc image_get_alpha*(image: PImage, x, y: int): int {.cdecl, importc: "TCOD_image_get_alpha", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_image_get_mipmap_pixel(TCOD_image_t image,float x0,float y0, float x1, float y1);
proc image_get_mipmap_pixel*(image: PImage, x0, y0, x1, y1: float32): TColor {.cdecl, importc: "TCOD_image_get_mipmap_pixel", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_put_pixel(TCOD_image_t image,int x, int y,TCOD_color_t col);
proc image_put_pixel*(image: PImage, x, y: int, col: TColor) {.cdecl, importc: "TCOD_image_put_pixel", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_blit(TCOD_image_t image, TCOD_console_t console, float x, float y, TCOD_bkgnd_flag_t bkgnd_flag, float scalex, float scaley, float angle);
proc image_blit*(image: PImage, console: PConsole, x, y: float32, bkgnd_flag: TBkgndFlag, scalex, scaley, angle: float32) {.cdecl, importc: "TCOD_image_blit", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_blit_rect(TCOD_image_t image, TCOD_console_t console, int x, int y, int w, int h, TCOD_bkgnd_flag_t bkgnd_flag);
proc image_blit_rect*(image: PImage, console: PConsole, x, y, w, h: int, bkgnd_flag: TBkgndFlag) {.cdecl, importc: "TCOD_image_blit_rect", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_blit_2x(TCOD_image_t image, TCOD_console_t dest, int dx, int dy, int sx, int sy, int w, int h);
proc image_blit_2x*(image: PImage, dest: PConsole, dx, dy: int, sx=0, sy=0, w=(-1), h=(-1)) {.cdecl, importc: "TCOD_image_blit_2x", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_delete(TCOD_image_t image);
proc image_delete*(image: PImage) {.cdecl, importc: "TCOD_image_delete", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_image_set_key_color(TCOD_image_t image, TCOD_color_t key_color);
proc image_set_key_color*(image: PImage, key_color: TColor) {.cdecl, importc: "TCOD_image_set_key_color", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_image_is_pixel_transparent(TCOD_image_t image, int x, int y);
proc image_is_pixel_transparent*(image: PImage, x, y: int): bool {.cdecl, importc: "TCOD_image_is_pixel_transparent", dynlib: LIB_NAME.}

