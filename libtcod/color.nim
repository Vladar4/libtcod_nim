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
  TColor*{.bycopy.} = tuple [r, g, b: uint8]


#constructors
template color_RGB*(r, g, b: int): TColor =
  (uint8(r), uint8(g), uint8(b))

#TCODLIB_API TCOD_color_t TCOD_color_RGB(uint8 r, uint8 g, uint8 b);
proc color_RGB*(r, g, b: uint8): TColor {.cdecl, importc: "TCOD_color_RGB", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_color_HSV(float h, float s, float v);
proc color_HSV*(h, s, v: float32): TColor {.cdecl, importc: "TCOD_color_", dynlib: LIB_NAME.}


# basic operations
#TCODLIB_API bool TCOD_color_equals (TCOD_color_t c1, TCOD_color_t c2);
proc color_equals*(c1, c2: TColor): bool {.cdecl, importc: "TCOD_color_equals", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_color_add (TCOD_color_t c1, TCOD_color_t c2);
proc color_add*(c1, c2: TColor): TColor {.cdecl, importc: "TCOD_color_add", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_color_subtract (TCOD_color_t c1, TCOD_color_t c2);
proc color_subtract*(c1, c2: TColor): TColor {.cdecl, importc: "TCOD_color_subtract", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_color_multiply (TCOD_color_t c1, TCOD_color_t c2);
proc color_multiply*(c1, c2: TColor): TColor {.cdecl, importc: "TCOD_color_multiply", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_color_multiply_scalar (TCOD_color_t c1, float value);
proc color_multiply_scalar*(c1: TColor, value: float32): TColor {.cdecl, importc: "TCOD_color_multiply_scalar", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_color_lerp (TCOD_color_t c1, TCOD_color_t c2, float coef);
when defined(windows): # WINDOWS BUGFIX
 proc color_lerp*(c1, c2: TColor, coef: float32): TColor {.inline.} =
   result.r = uint8(float32(c1.r) + float32(int(c2.r) - int(c1.r)) * coef)
   result.g = uint8(float32(c1.g) + float32(int(c2.g) - int(c1.g)) * coef)
   result.b = uint8(float32(c1.b) + float32(int(c2.b) - int(c1.b)) * coef) 
else:
  proc color_lerp*(c1, c2: TColor, coef: float32): TColor {.cdecl, importc: "TCOD_color_lerp", dynlib: LIB_NAME.}


# HSV transformations
#TCODLIB_API void TCOD_color_set_HSV (TCOD_color_t *c,float h, float s, float v);
proc color_set_HSV*(c: ptr TColor, h, s, v: float32) {.cdecl, importc: "TCOD_color_set_HSV", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_color_get_HSV (TCOD_color_t c,float * h, float * s, float * v);
proc color_get_HSV*(c: TColor, h, s, v: ptr float32) {.cdecl, importc: "TCOD_color_get_HSV", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_color_get_hue (TCOD_color_t c);
proc color_get_hue*(c: TColor): float32 {.cdecl, importc: "TCOD_color_get_hue", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_color_set_hue (TCOD_color_t *c, float h);
proc color_set_hue*(c: ptr TColor, h: float32) {.cdecl, importc: "TCOD_color_set_hue", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_color_get_saturation (TCOD_color_t c);
proc color_get_saturation*(c: TColor): float32 {.cdecl, importc: "TCOD_color_get_saturation", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_color_set_saturation (TCOD_color_t *c, float s);
proc color_set_saturation*(c: ptr TColor, s: float32) {.cdecl, importc: "TCOD_color_set_saturation", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_color_get_value (TCOD_color_t c);
proc color_get_value*(c: TColor): float32 {.cdecl, importc: "TCOD_color_get_value", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_color_set_value (TCOD_color_t *c, float v);
proc color_set_value*(c: ptr TColor, v: float32) {.cdecl, importc: "TCOD_color_set_value", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_color_shift_hue (TCOD_color_t *c, float hshift);
proc color_shift_hue*(c: ptr TColor, hshift: float32) {.cdecl, importc: "TCOD_color_shift_hue", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_color_scale_HSV (TCOD_color_t *c, float scoef, float vcoef);
proc color_scale_HSV*(c: ptr TColor, scoef, vcoef: float32) {.cdecl, importc: "TCOD_color_scale_HSV", dynlib: LIB_NAME.}


# color map
#TCODLIB_API void TCOD_color_gen_map(TCOD_color_t *map, int nb_key, TCOD_color_t const *key_color, int const *key_index);
proc color_gen_map*(map: ptr TColor, nb_key: int, key_color: ptr TColor, key_index: ptr int) {.cdecl, importc: "TCOD_color_gen_map", dynlib: LIB_NAME.}


const
  COLOR_RED* = 0
  COLOR_FLAME* = 1
  COLOR_ORANGE* = 2
  COLOR_AMBER* = 3
  COLOR_YELLOW* = 4
  COLOR_LIME* = 5
  COLOR_CHARTREUSE* = 6
  COLOR_GREEN* = 7
  COLOR_SEA* = 8
  COLOR_TURQUOISE* = 9
  COLOR_CYAN* = 10
  COLOR_SKY* = 11
  COLOR_AZURE* = 12
  COLOR_BLUE* = 13
  COLOR_HAN* = 14
  COLOR_VIOLET* = 15
  COLOR_PURPLE* = 16
  COLOR_FUCHSIA* = 17
  COLOR_MAGENTA* = 18
  COLOR_PINK* = 19
  COLOR_CRIMSON* = 20
  COLOR_NB* = 21
  COLOR_NB_HIGH* = 20

  COLOR_DESATURATED* = 0
  COLOR_LIGHTEST* = 1
  COLOR_LIGHTER* = 2
  COLOR_LIGHT* = 3
  COLOR_NORMAL* = 4
  COLOR_DARK* = 5
  COLOR_DARKER* = 6
  COLOR_DARKEST* = 7
  COLOR_LEVELS* = 8
  COLOR_LEVELS_HIGH* = 7

  # COLORS
  # color values
  BLACK* = (0'u8, 0'u8, 0'u8)
  DARKEST_GREY* = (31'u8, 31'u8, 31'u8)
  DARKER_GREY* = (63'u8, 63'u8, 63'u8)
  DARK_GREY* = (95'u8, 95'u8, 95'u8)
  GREY* = (127'u8, 127'u8, 127'u8)
  LIGHT_GREY* = (159'u8, 159'u8, 159'u8)
  LIGHTER_GREY* = (191'u8, 191'u8, 191'u8)
  LIGHTEST_GREY* = (223'u8, 223'u8, 223'u8)
  WHITE*: TColor = (255'u8, 255'u8, 255'u8)

  DARKEST_SEPIA* = (31'u8, 24'u8, 15'u8)
  DARKER_SEPIA* = (63'u8, 50'u8, 31'u8)
  DARK_SEPIA* = (94'u8, 75'u8, 47'u8)
  SEPIA* = (127'u8, 101'u8, 63'u8)
  LIGHT_SEPIA* = (158'u8, 134'u8, 100'u8)
  LIGHTER_SEPIA* = (191'u8, 171'u8, 143'u8)
  LIGHTEST_SEPIA* = (222'u8, 211'u8, 195'u8)

  # desaturated
  DESATURATED_RED* = (127'u8, 63'u8, 63'u8)
  DESATURATED_FLAME* = (127'u8, 79'u8, 63'u8)
  DESATURATED_ORANGE* = (127'u8, 95'u8, 63'u8)
  DESATURATED_AMBER* = (127'u8, 111'u8, 63'u8)
  DESATURATED_YELLOW* = (127'u8, 127'u8, 63'u8)
  DESATURATED_LIME* = (111'u8, 127'u8, 63'u8)
  DESATURATED_CHARTREUSE* = (95'u8, 127'u8, 63'u8)
  DESATURATED_GREEN* = (63'u8, 127'u8, 63'u8)
  DESATURATED_SEA* = (63'u8, 127'u8, 95'u8)
  DESATURATED_TURQUOISE* = (63'u8, 127'u8, 111'u8)
  DESATURATED_CYAN* = (63'u8, 127'u8, 127'u8)
  DESATURATED_SKY* = (63'u8, 111'u8, 127'u8)
  DESATURATED_AZURE* = (63'u8, 95'u8, 127'u8)
  DESATURATED_BLUE* = (63'u8, 63'u8, 127'u8)
  DESATURATED_HAN* = (79'u8, 63'u8, 127'u8)
  DESATURATED_VIOLET* = (95'u8, 63'u8, 127'u8)
  DESATURATED_PURPLE* = (111'u8, 63'u8, 127'u8)
  DESATURATED_FUCHSIA* = (127'u8, 63'u8, 127'u8)
  DESATURATED_MAGENTA* = (127'u8, 63'u8, 111'u8)
  DESATURATED_PINK* = (127'u8, 63'u8, 95'u8)
  DESATURATED_CRIMSON* = (127'u8, 63'u8, 79'u8)

  # lightest
  LIGHTEST_RED* = (255'u8, 191'u8, 191'u8)
  LIGHTEST_FLAME* = (255'u8, 207'u8, 191'u8)
  LIGHTEST_ORANGE* = (255'u8, 223'u8, 191'u8)
  LIGHTEST_AMBER* = (255'u8, 239'u8, 191'u8)
  LIGHTEST_YELLOW* = (255'u8, 255'u8, 191'u8)
  LIGHTEST_LIME* = (239'u8, 255'u8, 191'u8)
  LIGHTEST_CHARTREUSE* = (223'u8, 255'u8, 191'u8)
  LIGHTEST_GREEN* = (191'u8, 255'u8, 191'u8)
  LIGHTEST_SEA* = (191'u8, 255'u8, 223'u8)
  LIGHTEST_TURQUOISE* = (191'u8, 255'u8, 239'u8)
  LIGHTEST_CYAN* = (191'u8, 255'u8, 255'u8)
  LIGHTEST_SKY* = (191'u8, 239'u8, 255'u8)
  LIGHTEST_AZURE* = (191'u8, 223'u8, 255'u8)
  LIGHTEST_BLUE* = (191'u8, 191'u8, 255'u8)
  LIGHTEST_HAN* = (207'u8, 191'u8, 255'u8)
  LIGHTEST_VIOLET* = (223'u8, 191'u8, 255'u8)
  LIGHTEST_PURPLE* = (239'u8, 191'u8, 255'u8)
  LIGHTEST_FUCHSIA* = (255'u8, 191'u8, 255'u8)
  LIGHTEST_MAGENTA* = (255'u8, 191'u8, 239'u8)
  LIGHTEST_PINK* = (255'u8, 191'u8, 223'u8)
  LIGHTEST_CRIMSON* = (255'u8, 191'u8, 207'u8)

  # lighter
  LIGHTER_RED* = (255'u8, 127'u8, 127'u8)
  LIGHTER_FLAME* = (255'u8, 159'u8, 127'u8)
  LIGHTER_ORANGE* = (255'u8, 191'u8, 127'u8)
  LIGHTER_AMBER* = (255'u8, 223'u8, 127'u8)
  LIGHTER_YELLOW* = (255'u8, 255'u8, 127'u8)
  LIGHTER_LIME* = (223'u8, 255'u8, 127'u8)
  LIGHTER_CHARTREUSE* = (191'u8, 255'u8, 127'u8)
  LIGHTER_GREEN* = (127'u8, 255'u8, 127'u8)
  LIGHTER_SEA* = (127'u8, 255'u8, 191'u8)
  LIGHTER_TURQUOISE* = (127'u8, 255'u8, 223'u8)
  LIGHTER_CYAN* = (127'u8, 255'u8, 255'u8)
  LIGHTER_SKY* = (127'u8, 223'u8, 255'u8)
  LIGHTER_AZURE* = (127'u8, 191'u8, 255'u8)
  LIGHTER_BLUE* = (127'u8, 127'u8, 255'u8)
  LIGHTER_HAN* = (159'u8, 127'u8, 255'u8)
  LIGHTER_VIOLET* = (191'u8, 127'u8, 255'u8)
  LIGHTER_PURPLE* = (223'u8, 127'u8, 255'u8)
  LIGHTER_FUCHSIA* = (255'u8, 127'u8, 255'u8)
  LIGHTER_MAGENTA* = (255'u8, 127'u8, 223'u8)
  LIGHTER_PINK* = (255'u8, 127'u8, 191'u8)
  LIGHTER_CRIMSON* = (255'u8, 127'u8, 159'u8)

  # light
  LIGHT_RED* = (255'u8, 63'u8, 63'u8)
  LIGHT_FLAME* = (255'u8, 111'u8, 63'u8)
  LIGHT_ORANGE* = (255'u8, 159'u8, 63'u8)
  LIGHT_AMBER* = (255'u8, 207'u8, 63'u8)
  LIGHT_YELLOW* = (255'u8, 255'u8, 63'u8)
  LIGHT_LIME* = (207'u8, 255'u8, 63'u8)
  LIGHT_CHARTREUSE* = (159'u8, 255'u8, 63'u8)
  LIGHT_GREEN* = (63'u8, 255'u8, 63'u8)
  LIGHT_SEA* = (63'u8, 255'u8, 159'u8)
  LIGHT_TURQUOISE* = (63'u8, 255'u8, 207'u8)
  LIGHT_CYAN* = (63'u8, 255'u8, 255'u8)
  LIGHT_SKY* = (63'u8, 207'u8, 255'u8)
  LIGHT_AZURE* = (63'u8, 159'u8, 255'u8)
  LIGHT_BLUE* = (63'u8, 63'u8, 255'u8)
  LIGHT_HAN* = (111'u8, 63'u8, 255'u8)
  LIGHT_VIOLET* = (159'u8, 63'u8, 255'u8)
  LIGHT_PURPLE* = (207'u8, 63'u8, 255'u8)
  LIGHT_FUCHSIA* = (255'u8, 63'u8, 255'u8)
  LIGHT_MAGENTA* = (255'u8, 63'u8, 207'u8)
  LIGHT_PINK* = (255'u8, 63'u8, 159'u8)
  LIGHT_CRIMSON* = (255'u8, 63'u8, 111'u8)

  # normal
  RED* = (255'u8, 0'u8, 0'u8)
  FLAME* = (255'u8, 63'u8, 0'u8)
  ORANGE* = (255'u8, 127'u8, 0'u8)
  AMBER* = (255'u8, 191'u8, 0'u8)
  YELLOW* = (255'u8, 255'u8, 0'u8)
  LIME* = (191'u8, 255'u8, 0'u8)
  CHARTREUSE* = (127'u8, 255'u8, 0'u8)
  GREEN* = (0'u8, 255'u8, 0'u8)
  SEA* = (0'u8, 255'u8, 127'u8)
  TURQUOISE* = (0'u8, 255'u8, 191'u8)
  CYAN* = (0'u8, 255'u8, 255'u8)
  SKY* = (0'u8, 191'u8, 255'u8)
  AZURE* = (0'u8, 127'u8, 255'u8)
  BLUE* = (0'u8, 0'u8, 255'u8)
  HAN* = (63'u8, 0'u8, 255'u8)
  VIOLET* = (127'u8, 0'u8, 255'u8)
  PURPLE* = (191'u8, 0'u8, 255'u8)
  FUCHSIA* = (255'u8, 0'u8, 255'u8)
  MAGENTA* = (255'u8, 0'u8, 191'u8)
  PINK* = (255'u8, 0'u8, 127'u8)
  CRIMSON* = (255'u8, 0'u8, 63'u8)

  # dark
  DARK_RED* = (191'u8, 0'u8, 0'u8)
  DARK_FLAME* = (191'u8, 47'u8, 0'u8)
  DARK_ORANGE* = (191'u8, 95'u8, 0'u8)
  DARK_AMBER* = (191'u8, 143'u8, 0'u8)
  DARK_YELLOW* = (191'u8, 191'u8, 0'u8)
  DARK_LIME* = (143'u8, 191'u8, 0'u8)
  DARK_CHARTREUSE* = (95'u8, 191'u8, 0'u8)
  DARK_GREEN* = (0'u8, 191'u8, 0'u8)
  DARK_SEA* = (0'u8, 191'u8, 95'u8)
  DARK_TURQUOISE* = (0'u8, 191'u8, 143'u8)
  DARK_CYAN* = (0'u8, 191'u8, 191'u8)
  DARK_SKY* = (0'u8, 143'u8, 191'u8)
  DARK_AZURE* = (0'u8, 95'u8, 191'u8)
  DARK_BLUE* = (0'u8, 0'u8, 191'u8)
  DARK_HAN* = (47'u8, 0'u8, 191'u8)
  DARK_VIOLET* = (95'u8, 0'u8, 191'u8)
  DARK_PURPLE* = (143'u8, 0'u8, 191'u8)
  DARK_FUCHSIA* = (191'u8, 0'u8, 191'u8)
  DARK_MAGENTA* = (191'u8, 0'u8, 143'u8)
  DARK_PINK* = (191'u8, 0'u8, 95'u8)
  DARK_CRIMSON* = (191'u8, 0'u8, 47'u8)

  # darker
  DARKER_RED* = (127'u8, 0'u8, 0'u8)
  DARKER_FLAME* = (127'u8, 31'u8, 0'u8)
  DARKER_ORANGE* = (127'u8, 63'u8, 0'u8)
  DARKER_AMBER* = (127'u8, 95'u8, 0'u8)
  DARKER_YELLOW* = (127'u8, 127'u8, 0'u8)
  DARKER_LIME* = (95'u8, 127'u8, 0'u8)
  DARKER_CHARTREUSE* = (63'u8, 127'u8, 0'u8)
  DARKER_GREEN* = (0'u8, 127'u8, 0'u8)
  DARKER_SEA* = (0'u8, 127'u8, 63'u8)
  DARKER_TURQUOISE* = (0'u8, 127'u8, 95'u8)
  DARKER_CYAN* = (0'u8, 127'u8, 127'u8)
  DARKER_SKY* = (0'u8, 95'u8, 127'u8)
  DARKER_AZURE* = (0'u8, 63'u8, 127'u8)
  DARKER_BLUE* = (0'u8, 0'u8, 127'u8)
  DARKER_HAN* = (31'u8, 0'u8, 127'u8)
  DARKER_VIOLET* = (63'u8, 0'u8, 127'u8)
  DARKER_PURPLE* = (95'u8, 0'u8, 127'u8)
  DARKER_FUCHSIA* = (127'u8, 0'u8, 127'u8)
  DARKER_MAGENTA* = (127'u8, 0'u8, 95'u8)
  DARKER_PINK* = (127'u8, 0'u8, 63'u8)
  DARKER_CRIMSON* = (127'u8, 0'u8, 31'u8)

  # darkest
  DARKEST_RED* = (63'u8, 0'u8, 0'u8)
  DARKEST_FLAME* = (63'u8, 15'u8, 0'u8)
  DARKEST_ORANGE* = (63'u8, 31'u8, 0'u8)
  DARKEST_AMBER* = (63'u8, 47'u8, 0'u8)
  DARKEST_YELLOW* = (63'u8, 63'u8, 0'u8)
  DARKEST_LIME* = (47'u8, 63'u8, 0'u8)
  DARKEST_CHARTREUSE* = (31'u8, 63'u8, 0'u8)
  DARKEST_GREEN* = (0'u8, 63'u8, 0'u8)
  DARKEST_SEA* = (0'u8, 63'u8, 31'u8)
  DARKEST_TURQUOISE* = (0'u8, 63'u8, 47'u8)
  DARKEST_CYAN* = (0'u8, 63'u8, 63'u8)
  DARKEST_SKY* = (0'u8, 47'u8, 63'u8)
  DARKEST_AZURE* = (0'u8, 31'u8, 63'u8)
  DARKEST_BLUE* = (0'u8, 0'u8, 63'u8)
  DARKEST_HAN* = (15'u8, 0'u8, 63'u8)
  DARKEST_VIOLET* = (31'u8, 0'u8, 63'u8)
  DARKEST_PURPLE* = (47'u8, 0'u8, 63'u8)
  DARKEST_FUCHSIA* = (63'u8, 0'u8, 63'u8)
  DARKEST_MAGENTA* = (63'u8, 0'u8, 47'u8)
  DARKEST_PINK* = (63'u8, 0'u8, 31'u8)
  DARKEST_CRIMSON* = (63'u8, 0'u8, 15'u8)

  # metallic
  BRASS* = (191'u8, 151'u8, 96'u8)
  COPPER* = (197'u8, 136'u8, 124'u8)
  GOLD* = (229'u8, 191'u8, 0'u8)
  SILVER* = (203'u8, 203'u8, 203'u8)

  # miscellaneous
  CELADON* = (172'u8, 255'u8, 175'u8)
  PEACH* = (255'u8, 159'u8, 127'u8)


  # color array
  colors*: array[0..COLOR_NB_HIGH, array[0..COLOR_LEVELS_HIGH, TColor]] = [
    [DESATURATED_RED, LIGHTEST_RED, LIGHTER_RED, LIGHT_RED, RED, DARK_RED, DARKER_RED, DARKEST_RED],
    [DESATURATED_FLAME, LIGHTEST_FLAME, LIGHTER_FLAME, LIGHT_FLAME, FLAME, DARK_FLAME, DARKER_FLAME, DARKEST_FLAME],
    [DESATURATED_ORANGE, LIGHTEST_ORANGE, LIGHTER_ORANGE, LIGHT_ORANGE, ORANGE, DARK_ORANGE, DARKER_ORANGE, DARKEST_ORANGE],
    [DESATURATED_AMBER, LIGHTEST_AMBER, LIGHTER_AMBER, LIGHT_AMBER, AMBER, DARK_AMBER, DARKER_AMBER, DARKEST_AMBER],
    [DESATURATED_YELLOW, LIGHTEST_YELLOW, LIGHTER_YELLOW, LIGHT_YELLOW, YELLOW, DARK_YELLOW, DARKER_YELLOW, DARKEST_YELLOW],
    [DESATURATED_LIME, LIGHTEST_LIME, LIGHTER_LIME, LIGHT_LIME, LIME, DARK_LIME, DARKER_LIME, DARKEST_LIME],
    [DESATURATED_CHARTREUSE, LIGHTEST_CHARTREUSE, LIGHTER_CHARTREUSE, LIGHT_CHARTREUSE, CHARTREUSE, DARK_CHARTREUSE, DARKER_CHARTREUSE, DARKEST_CHARTREUSE],
    [DESATURATED_GREEN, LIGHTEST_GREEN, LIGHTER_GREEN, LIGHT_GREEN, GREEN, DARK_GREEN, DARKER_GREEN, DARKEST_GREEN],
    [DESATURATED_SEA, LIGHTEST_SEA, LIGHTER_SEA, LIGHT_SEA, SEA, DARK_SEA, DARKER_SEA, DARKEST_SEA],
    [DESATURATED_TURQUOISE, LIGHTEST_TURQUOISE, LIGHTER_TURQUOISE, LIGHT_TURQUOISE, TURQUOISE, DARK_TURQUOISE, DARKER_TURQUOISE, DARKEST_TURQUOISE],
    [DESATURATED_CYAN, LIGHTEST_CYAN, LIGHTER_CYAN, LIGHT_CYAN, CYAN, DARK_CYAN, DARKER_CYAN, DARKEST_CYAN],
    [DESATURATED_SKY, LIGHTEST_SKY, LIGHTER_SKY, LIGHT_SKY, SKY, DARK_SKY, DARKER_SKY, DARKEST_SKY],
    [DESATURATED_AZURE, LIGHTEST_AZURE, LIGHTER_AZURE, LIGHT_AZURE, AZURE, DARK_AZURE, DARKER_AZURE, DARKEST_AZURE],
    [DESATURATED_BLUE, LIGHTEST_BLUE, LIGHTER_BLUE, LIGHT_BLUE, BLUE, DARK_BLUE, DARKER_BLUE, DARKEST_BLUE],
    [DESATURATED_HAN, LIGHTEST_HAN, LIGHTER_HAN, LIGHT_HAN, HAN, DARK_HAN, DARKER_HAN, DARKEST_HAN],
    [DESATURATED_VIOLET, LIGHTEST_VIOLET, LIGHTER_VIOLET, LIGHT_VIOLET, VIOLET, DARK_VIOLET, DARKER_VIOLET, DARKEST_VIOLET],
    [DESATURATED_PURPLE, LIGHTEST_PURPLE, LIGHTER_PURPLE, LIGHT_PURPLE, PURPLE, DARK_PURPLE, DARKER_PURPLE, DARKEST_PURPLE],
    [DESATURATED_FUCHSIA, LIGHTEST_FUCHSIA, LIGHTER_FUCHSIA, LIGHT_FUCHSIA, FUCHSIA, DARK_FUCHSIA, DARKER_FUCHSIA, DARKEST_FUCHSIA],
    [DESATURATED_MAGENTA, LIGHTEST_MAGENTA, LIGHTER_MAGENTA, LIGHT_MAGENTA, MAGENTA, DARK_MAGENTA, DARKER_MAGENTA, DARKEST_MAGENTA],
    [DESATURATED_PINK, LIGHTEST_PINK, LIGHTER_PINK, LIGHT_PINK, PINK, DARK_PINK, DARKER_PINK, DARKEST_PINK],
    [DESATURATED_CRIMSON, LIGHTEST_CRIMSON, LIGHTER_CRIMSON, LIGHT_CRIMSON, CRIMSON, DARK_CRIMSON, DARKER_CRIMSON, DARKEST_CRIMSON]
    ]

