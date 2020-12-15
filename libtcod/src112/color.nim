#
# BSD 3-Clause License
#
# Copyright © 2008-2019, Jice and the libtcod contributors.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

type
  Color* {.bycopy.} = tuple [r, g, b: uint8] ## An three channel color.
  ColorRGB* = Color
  ColorRGBA* {.bycopy.} = tuple [r, g, b, a: uint8] ## A four channel color.

template `==`*(c1, c2: Color): bool =
  ((c1.r == c2.r) and (c1.g == c2.g) and (c1.b == c2.b))

template `!=`*(c1, c2: Color): bool =
  (not (c1 == c2))


#  constructors

template colorRGB*(r, g, b: int): Color =
  (uint8(r), uint8(g), uint8(b))

proc colorRGB*(
  r, g, b: uint8): Color {.
    cdecl, importc: "TCOD_color_RGB", dynlib: LIB_NAME.}

proc colorHSV*(
  hue, saturation, value: cfloat): Color {.
    cdecl, importc: "TCOD_color_HSV", dynlib: LIB_NAME.}


#  basic operations

proc colorEquals*(
  c1, c2: Color): bool {.
    cdecl, importc: "TCOD_color_equals", dynlib: LIB_NAME.}

proc colorAdd*(
  c1, c2: Color): Color {.
    cdecl, importc: "TCOD_color_add", dynlib: LIB_NAME.}

proc colorSubtract*(
  c1, c2: Color): Color {.
    cdecl, importc: "TCOD_color_subtract", dynlib: LIB_NAME.}

proc colorMultiply*(
  c1, c2: Color): Color {.
    cdecl, importc: "TCOD_color_multiply", dynlib: LIB_NAME.}

proc colorMultiplyScalar*(
  c1: Color; value: cfloat): Color {.
    cdecl, importc: "TCOD_color_multiply_scalar", dynlib: LIB_NAME.}

when defined(windows): # WINDOWS BUGFIX
 proc color_lerp*(c1, c2: Color, coef: cfloat): Color {.inline.} =
   result.r = uint8(cfloat(c1.r) + cfloat(int(c2.r) - int(c1.r)) * coef)
   result.g = uint8(cfloat(c1.g) + cfloat(int(c2.g) - int(c1.g)) * coef)
   result.b = uint8(cfloat(c1.b) + cfloat(int(c2.b) - int(c1.b)) * coef)
else:
  proc colorLerp*(
    c1, c2: Color; coef: cfloat): Color {.
      cdecl, importc: "TCOD_color_lerp", dynlib: LIB_NAME.}


#  HSV transformations

proc colorSetHSV*(
  color: ptr Color; hue, saturation, value: cfloat) {.
    cdecl, importc: "TCOD_color_set_HSV", dynlib: LIB_NAME.}

proc colorGetHSV*(
  color: Color; hue, saturation, value: ptr cfloat) {.
    cdecl, importc: "TCOD_color_get_HSV", dynlib: LIB_NAME.}

proc colorGetHue*(
  color: Color): cfloat {.
    cdecl, importc: "TCOD_color_get_hue", dynlib: LIB_NAME.}

proc colorSetHue*(
  color: ptr Color; hue: cfloat) {.
    cdecl, importc: "TCOD_color_set_hue", dynlib: LIB_NAME.}

proc colorGetSaturation*(
  color: Color): cfloat {.
    cdecl, importc: "TCOD_color_get_saturation", dynlib: LIB_NAME.}

proc colorSetSaturation*(
  color: ptr Color; saturation: cfloat) {.
    cdecl, importc: "TCOD_color_set_saturation", dynlib: LIB_NAME.}

proc colorGetValue*(
  color: Color): cfloat {.
    cdecl, importc: "TCOD_color_get_value", dynlib: LIB_NAME.}

proc colorSetValue*(
  color: ptr Color; value: cfloat) {.
    cdecl, importc: "TCOD_color_set_value", dynlib: LIB_NAME.}

proc colorShiftHue*(
  color: ptr Color; hshift: cfloat) {.
    cdecl, importc: "TCOD_color_shift_hue", dynlib: LIB_NAME.}

proc colorScaleHSV*(
  color: ptr Color; saturationCoef, valueCoef: cfloat) {.
    cdecl, importc: "TCOD_color_scale_HSV", dynlib: LIB_NAME.}


proc colorGenMap*(
  map: ptr Color; nbKey: cint; keyColor: ptr Color; keyIndex: ptr cint) {.
    cdecl, importc: "TCOD_color_gen_map", dynlib: LIB_NAME.}
  ##  Color map.


#  color names

const
  COLOR_RED*: cint        = 0
  COLOR_FLAME*: cint      = 1
  COLOR_ORANGE*: cint     = 2
  COLOR_AMBER*: cint      = 3
  COLOR_YELLOW*: cint     = 4
  COLOR_LIME*: cint       = 5
  COLOR_CHARTREUSE*: cint = 6
  COLOR_GREEN*: cint      = 7
  COLOR_SEA*: cint        = 8
  COLOR_TURQUOISE*: cint  = 9
  COLOR_CYAN*: cint       = 10
  COLOR_SKY*: cint        = 11
  COLOR_AZURE*: cint      = 12
  COLOR_BLUE*: cint       = 13
  COLOR_HAN*: cint        = 14
  COLOR_VIOLET*: cint     = 15
  COLOR_PURPLE*: cint     = 16
  COLOR_FUCHSIA*: cint    = 17
  COLOR_MAGENTA*: cint    = 18
  COLOR_PINK*: cint       = 19
  COLOR_CRIMSON*: cint    = 20
  COLOR_NB*: cint         = 21

#  color levels

const
  COLOR_DESATURATED*: cint  = 0
  COLOR_LIGHTEST*: cint     = 1
  COLOR_LIGHTER*: cint      = 2
  COLOR_LIGHT*: cint        = 3
  COLOR_NORMAL*: cint       = 4
  COLOR_DARK*: cint         = 5
  COLOR_DARKER*: cint       = 6
  COLOR_DARKEST*: cint      = 7
  COLOR_LEVELS*: cint       = 8


var COLORS* {.importc: "TCOD_colors", dynlib: LIB_NAME.}:
    array[COLOR_NB, array[COLOR_LEVELS, Color]] ##  Color array

#  grey levels

var BLACK* {.importc: "TCOD_black", dynlib: LIB_NAME.}: Color

var DARKEST_GREY* {.importc: "TCOD_darkest_grey", dynlib: LIB_NAME.}: Color

var DARKER_GREY* {.importc: "TCOD_darker_grey", dynlib: LIB_NAME.}: Color

var DARK_GREY* {.importc: "TCOD_dark_grey", dynlib: LIB_NAME.}: Color

var GREY* {.importc: "TCOD_grey", dynlib: LIB_NAME.}: Color

var LIGHT_GREY* {.importc: "TCOD_light_grey", dynlib: LIB_NAME.}: Color

var LIGHTER_GREY* {.importc: "TCOD_lighter_grey", dynlib: LIB_NAME.}: Color

var LIGHTEST_GREY* {.importc: "TCOD_lightest_grey", dynlib: LIB_NAME.}: Color

var DARKEST_GRAY* {.importc: "TCOD_darkest_gray", dynlib: LIB_NAME.}: Color

var DARKER_GRAY* {.importc: "TCOD_darker_gray", dynlib: LIB_NAME.}: Color

var DARK_GRAY* {.importc: "TCOD_dark_gray", dynlib: LIB_NAME.}: Color

var GRAY* {.importc: "TCOD_gray", dynlib: LIB_NAME.}: Color

var LIGHT_GRAY* {.importc: "TCOD_light_gray", dynlib: LIB_NAME.}: Color

var LIGHTER_GRAY* {.importc: "TCOD_lighter_gray", dynlib: LIB_NAME.}: Color

var LIGHTEST_GRAY* {.importc: "TCOD_lightest_gray", dynlib: LIB_NAME.}: Color

var WHITE* {.importc: "TCOD_white", dynlib: LIB_NAME.}: Color

#  sepia

var DARKEST_SEPIA* {.importc: "TCOD_darkest_sepia", dynlib: LIB_NAME.}: Color

var DARKER_SEPIA* {.importc: "TCOD_darker_sepia", dynlib: LIB_NAME.}: Color

var DARK_SEPIA* {.importc: "TCOD_dark_sepia", dynlib: LIB_NAME.}: Color

var SEPIA* {.importc: "TCOD_sepia", dynlib: LIB_NAME.}: Color

var LIGHT_SEPIA* {.importc: "TCOD_light_sepia", dynlib: LIB_NAME.}: Color

var LIGHTER_SEPIA* {.importc: "TCOD_lighter_sepia", dynlib: LIB_NAME.}: Color

var LIGHTEST_SEPIA* {.importc: "TCOD_lightest_sepia", dynlib: LIB_NAME.}: Color

#  standard colors

var RED* {.importc: "TCOD_red", dynlib: LIB_NAME.}: Color

var FLAME* {.importc: "TCOD_flame", dynlib: LIB_NAME.}: Color

var ORANGE* {.importc: "TCOD_orange", dynlib: LIB_NAME.}: Color

var AMBER* {.importc: "TCOD_amber", dynlib: LIB_NAME.}: Color

var YELLOW* {.importc: "TCOD_yellow", dynlib: LIB_NAME.}: Color

var LIME* {.importc: "TCOD_lime", dynlib: LIB_NAME.}: Color

var CHARTREUSE* {.importc: "TCOD_chartreuse", dynlib: LIB_NAME.}: Color

var GREEN* {.importc: "TCOD_green", dynlib: LIB_NAME.}: Color

var SEA* {.importc: "TCOD_sea", dynlib: LIB_NAME.}: Color

var TURQUOISE* {.importc: "TCOD_turquoise", dynlib: LIB_NAME.}: Color

var CYAN* {.importc: "TCOD_cyan", dynlib: LIB_NAME.}: Color

var SKY* {.importc: "TCOD_sky", dynlib: LIB_NAME.}: Color

var AZURE* {.importc: "TCOD_azure", dynlib: LIB_NAME.}: Color

var BLUE* {.importc: "TCOD_blue", dynlib: LIB_NAME.}: Color

var HAN* {.importc: "TCOD_han", dynlib: LIB_NAME.}: Color

var VIOLET* {.importc: "TCOD_violet", dynlib: LIB_NAME.}: Color

var PURPLE* {.importc: "TCOD_purple", dynlib: LIB_NAME.}: Color

var FUCHSIA* {.importc: "TCOD_fuchsia", dynlib: LIB_NAME.}: Color

var MAGENTA* {.importc: "TCOD_magenta", dynlib: LIB_NAME.}: Color

var PINK* {.importc: "TCOD_pink", dynlib: LIB_NAME.}: Color

var CRIMSON* {.importc: "TCOD_crimson", dynlib: LIB_NAME.}: Color

#  dark colors

var DARK_RED* {.importc: "TCOD_dark_red", dynlib: LIB_NAME.}: Color

var DARK_FLAME* {.importc: "TCOD_dark_flame", dynlib: LIB_NAME.}: Color

var DARK_ORANGE* {.importc: "TCOD_dark_orange", dynlib: LIB_NAME.}: Color

var DARK_AMBER* {.importc: "TCOD_dark_amber", dynlib: LIB_NAME.}: Color

var DARK_YELLOW* {.importc: "TCOD_dark_yellow", dynlib: LIB_NAME.}: Color

var DARK_LIME* {.importc: "TCOD_dark_lime", dynlib: LIB_NAME.}: Color

var DARK_CHARTREUSE* {.importc: "TCOD_dark_chartreuse", dynlib: LIB_NAME.}: Color

var DARK_GREEN* {.importc: "TCOD_dark_green", dynlib: LIB_NAME.}: Color

var DARK_SEA* {.importc: "TCOD_dark_sea", dynlib: LIB_NAME.}: Color

var DARK_TURQUOISE* {.importc: "TCOD_dark_turquoise", dynlib: LIB_NAME.}: Color

var DARK_CYAN* {.importc: "TCOD_dark_cyan", dynlib: LIB_NAME.}: Color

var DARK_SKY* {.importc: "TCOD_dark_sky", dynlib: LIB_NAME.}: Color

var DARK_AZURE* {.importc: "TCOD_dark_azure", dynlib: LIB_NAME.}: Color

var DARK_BLUE* {.importc: "TCOD_dark_blue", dynlib: LIB_NAME.}: Color

var DARK_HAN* {.importc: "TCOD_dark_han", dynlib: LIB_NAME.}: Color

var DARK_VIOLET* {.importc: "TCOD_dark_violet", dynlib: LIB_NAME.}: Color

var DARK_PURPLE* {.importc: "TCOD_dark_purple", dynlib: LIB_NAME.}: Color

var DARK_FUCHSIA* {.importc: "TCOD_dark_fuchsia", dynlib: LIB_NAME.}: Color

var DARK_MAGENTA* {.importc: "TCOD_dark_magenta", dynlib: LIB_NAME.}: Color

var DARK_PINK* {.importc: "TCOD_dark_pink", dynlib: LIB_NAME.}: Color

var DARK_CRIMSON* {.importc: "TCOD_dark_crimson", dynlib: LIB_NAME.}: Color

#  darker colors

var DARKER_RED* {.importc: "TCOD_darker_red", dynlib: LIB_NAME.}: Color

var DARKER_FLAME* {.importc: "TCOD_darker_flame", dynlib: LIB_NAME.}: Color

var DARKER_ORANGE* {.importc: "TCOD_darker_orange", dynlib: LIB_NAME.}: Color

var DARKER_AMBER* {.importc: "TCOD_darker_amber", dynlib: LIB_NAME.}: Color

var DARKER_YELLOW* {.importc: "TCOD_darker_yellow", dynlib: LIB_NAME.}: Color

var DARKER_LIME* {.importc: "TCOD_darker_lime", dynlib: LIB_NAME.}: Color

var DARKER_CHARTREUSE* {.importc: "TCOD_darker_chartreuse", dynlib: LIB_NAME.}: Color

var DARKER_GREEN* {.importc: "TCOD_darker_green", dynlib: LIB_NAME.}: Color

var DARKER_SEA* {.importc: "TCOD_darker_sea", dynlib: LIB_NAME.}: Color

var DARKER_TURQUOISE* {.importc: "TCOD_darker_turquoise", dynlib: LIB_NAME.}: Color

var DARKER_CYAN* {.importc: "TCOD_darker_cyan", dynlib: LIB_NAME.}: Color

var DARKER_SKY* {.importc: "TCOD_darker_sky", dynlib: LIB_NAME.}: Color

var DARKER_AZURE* {.importc: "TCOD_darker_azure", dynlib: LIB_NAME.}: Color

var DARKER_BLUE* {.importc: "TCOD_darker_blue", dynlib: LIB_NAME.}: Color

var DARKER_HAN* {.importc: "TCOD_darker_han", dynlib: LIB_NAME.}: Color

var DARKER_VIOLET* {.importc: "TCOD_darker_violet", dynlib: LIB_NAME.}: Color

var DARKER_PURPLE* {.importc: "TCOD_darker_purple", dynlib: LIB_NAME.}: Color

var DARKER_FUCHSIA* {.importc: "TCOD_darker_fuchsia", dynlib: LIB_NAME.}: Color

var DARKER_MAGENTA* {.importc: "TCOD_darker_magenta", dynlib: LIB_NAME.}: Color

var DARKER_PINK* {.importc: "TCOD_darker_pink", dynlib: LIB_NAME.}: Color

var DARKER_CRIMSON* {.importc: "TCOD_darker_crimson", dynlib: LIB_NAME.}: Color

#  darkest colors

var DARKEST_RED* {.importc: "TCOD_darkest_red", dynlib: LIB_NAME.}: Color

var DARKEST_FLAME* {.importc: "TCOD_darkest_flame", dynlib: LIB_NAME.}: Color

var DARKEST_ORANGE* {.importc: "TCOD_darkest_orange", dynlib: LIB_NAME.}: Color

var DARKEST_AMBER* {.importc: "TCOD_darkest_amber", dynlib: LIB_NAME.}: Color

var DARKEST_YELLOW* {.importc: "TCOD_darkest_yellow", dynlib: LIB_NAME.}: Color

var DARKEST_LIME* {.importc: "TCOD_darkest_lime", dynlib: LIB_NAME.}: Color

var DARKEST_CHARTREUSE* {.importc: "TCOD_darkest_chartreuse", dynlib: LIB_NAME.}: Color

var DARKEST_GREEN* {.importc: "TCOD_darkest_green", dynlib: LIB_NAME.}: Color

var DARKEST_SEA* {.importc: "TCOD_darkest_sea", dynlib: LIB_NAME.}: Color

var DARKEST_TURQUOISE* {.importc: "TCOD_darkest_turquoise", dynlib: LIB_NAME.}: Color

var DARKEST_CYAN* {.importc: "TCOD_darkest_cyan", dynlib: LIB_NAME.}: Color

var DARKEST_SKY* {.importc: "TCOD_darkest_sky", dynlib: LIB_NAME.}: Color

var DARKEST_AZURE* {.importc: "TCOD_darkest_azure", dynlib: LIB_NAME.}: Color

var DARKEST_BLUE* {.importc: "TCOD_darkest_blue", dynlib: LIB_NAME.}: Color

var DARKEST_HAN* {.importc: "TCOD_darkest_han", dynlib: LIB_NAME.}: Color

var DARKEST_VIOLET* {.importc: "TCOD_darkest_violet", dynlib: LIB_NAME.}: Color

var DARKEST_PURPLE* {.importc: "TCOD_darkest_purple", dynlib: LIB_NAME.}: Color

var DARKEST_FUCHSIA* {.importc: "TCOD_darkest_fuchsia", dynlib: LIB_NAME.}: Color

var DARKEST_MAGENTA* {.importc: "TCOD_darkest_magenta", dynlib: LIB_NAME.}: Color

var DARKEST_PINK* {.importc: "TCOD_darkest_pink", dynlib: LIB_NAME.}: Color

var DARKEST_CRIMSON* {.importc: "TCOD_darkest_crimson", dynlib: LIB_NAME.}: Color

#  light colors

var LIGHT_RED* {.importc: "TCOD_light_red", dynlib: LIB_NAME.}: Color

var LIGHT_FLAME* {.importc: "TCOD_light_flame", dynlib: LIB_NAME.}: Color

var LIGHT_ORANGE* {.importc: "TCOD_light_orange", dynlib: LIB_NAME.}: Color

var LIGHT_AMBER* {.importc: "TCOD_light_amber", dynlib: LIB_NAME.}: Color

var LIGHT_YELLOW* {.importc: "TCOD_light_yellow", dynlib: LIB_NAME.}: Color

var LIGHT_LIME* {.importc: "TCOD_light_lime", dynlib: LIB_NAME.}: Color

var LIGHT_CHARTREUSE* {.importc: "TCOD_light_chartreuse", dynlib: LIB_NAME.}: Color

var LIGHT_GREEN* {.importc: "TCOD_light_green", dynlib: LIB_NAME.}: Color

var LIGHT_SEA* {.importc: "TCOD_light_sea", dynlib: LIB_NAME.}: Color

var LIGHT_TURQUOISE* {.importc: "TCOD_light_turquoise", dynlib: LIB_NAME.}: Color

var LIGHT_CYAN* {.importc: "TCOD_light_cyan", dynlib: LIB_NAME.}: Color

var LIGHT_SKY* {.importc: "TCOD_light_sky", dynlib: LIB_NAME.}: Color

var LIGHT_AZURE* {.importc: "TCOD_light_azure", dynlib: LIB_NAME.}: Color

var LIGHT_BLUE* {.importc: "TCOD_light_blue", dynlib: LIB_NAME.}: Color

var LIGHT_HAN* {.importc: "TCOD_light_han", dynlib: LIB_NAME.}: Color

var LIGHT_VIOLET* {.importc: "TCOD_light_violet", dynlib: LIB_NAME.}: Color

var LIGHT_PURPLE* {.importc: "TCOD_light_purple", dynlib: LIB_NAME.}: Color

var LIGHT_FUCHSIA* {.importc: "TCOD_light_fuchsia", dynlib: LIB_NAME.}: Color

var LIGHT_MAGENTA* {.importc: "TCOD_light_magenta", dynlib: LIB_NAME.}: Color

var LIGHT_PINK* {.importc: "TCOD_light_pink", dynlib: LIB_NAME.}: Color

var LIGHT_CRIMSON* {.importc: "TCOD_light_crimson", dynlib: LIB_NAME.}: Color

#  lighter colors

var LIGHTER_RED* {.importc: "TCOD_lighter_red", dynlib: LIB_NAME.}: Color

var LIGHTER_FLAME* {.importc: "TCOD_lighter_flame", dynlib: LIB_NAME.}: Color

var LIGHTER_ORANGE* {.importc: "TCOD_lighter_orange", dynlib: LIB_NAME.}: Color

var LIGHTER_AMBER* {.importc: "TCOD_lighter_amber", dynlib: LIB_NAME.}: Color

var LIGHTER_YELLOW* {.importc: "TCOD_lighter_yellow", dynlib: LIB_NAME.}: Color

var LIGHTER_LIME* {.importc: "TCOD_lighter_lime", dynlib: LIB_NAME.}: Color

var LIGHTER_CHARTREUSE* {.importc: "TCOD_lighter_chartreuse", dynlib: LIB_NAME.}: Color

var LIGHTER_GREEN* {.importc: "TCOD_lighter_green", dynlib: LIB_NAME.}: Color

var LIGHTER_SEA* {.importc: "TCOD_lighter_sea", dynlib: LIB_NAME.}: Color

var LIGHTER_TURQUOISE* {.importc: "TCOD_lighter_turquoise", dynlib: LIB_NAME.}: Color

var LIGHTER_CYAN* {.importc: "TCOD_lighter_cyan", dynlib: LIB_NAME.}: Color

var LIGHTER_SKY* {.importc: "TCOD_lighter_sky", dynlib: LIB_NAME.}: Color

var LIGHTER_AZURE* {.importc: "TCOD_lighter_azure", dynlib: LIB_NAME.}: Color

var LIGHTER_BLUE* {.importc: "TCOD_lighter_blue", dynlib: LIB_NAME.}: Color

var LIGHTER_HAN* {.importc: "TCOD_lighter_han", dynlib: LIB_NAME.}: Color

var LIGHTER_VIOLET* {.importc: "TCOD_lighter_violet", dynlib: LIB_NAME.}: Color

var LIGHTER_PURPLE* {.importc: "TCOD_lighter_purple", dynlib: LIB_NAME.}: Color

var LIGHTER_FUCHSIA* {.importc: "TCOD_lighter_fuchsia", dynlib: LIB_NAME.}: Color

var LIGHTER_MAGENTA* {.importc: "TCOD_lighter_magenta", dynlib: LIB_NAME.}: Color

var LIGHTER_PINK* {.importc: "TCOD_lighter_pink", dynlib: LIB_NAME.}: Color

var LIGHTER_CRIMSON* {.importc: "TCOD_lighter_crimson", dynlib: LIB_NAME.}: Color

#  lightest colors

var LIGHTEST_RED* {.importc: "TCOD_lightest_red", dynlib: LIB_NAME.}: Color

var LIGHTEST_FLAME* {.importc: "TCOD_lightest_flame", dynlib: LIB_NAME.}: Color

var LIGHTEST_ORANGE* {.importc: "TCOD_lightest_orange", dynlib: LIB_NAME.}: Color

var LIGHTEST_AMBER* {.importc: "TCOD_lightest_amber", dynlib: LIB_NAME.}: Color

var LIGHTEST_YELLOW* {.importc: "TCOD_lightest_yellow", dynlib: LIB_NAME.}: Color

var LIGHTEST_LIME* {.importc: "TCOD_lightest_lime", dynlib: LIB_NAME.}: Color

var LIGHTEST_CHARTREUSE* {.importc: "TCOD_lightest_chartreuse", dynlib: LIB_NAME.}: Color

var LIGHTEST_GREEN* {.importc: "TCOD_lightest_green", dynlib: LIB_NAME.}: Color

var LIGHTEST_SEA* {.importc: "TCOD_lightest_sea", dynlib: LIB_NAME.}: Color

var LIGHTEST_TURQUOISE* {.importc: "TCOD_lightest_turquoise", dynlib: LIB_NAME.}: Color

var LIGHTEST_CYAN* {.importc: "TCOD_lightest_cyan", dynlib: LIB_NAME.}: Color

var LIGHTEST_SKY* {.importc: "TCOD_lightest_sky", dynlib: LIB_NAME.}: Color

var LIGHTEST_AZURE* {.importc: "TCOD_lightest_azure", dynlib: LIB_NAME.}: Color

var LIGHTEST_BLUE* {.importc: "TCOD_lightest_blue", dynlib: LIB_NAME.}: Color

var LIGHTEST_HAN* {.importc: "TCOD_lightest_han", dynlib: LIB_NAME.}: Color

var LIGHTEST_VIOLET* {.importc: "TCOD_lightest_violet", dynlib: LIB_NAME.}: Color

var LIGHTEST_PURPLE* {.importc: "TCOD_lightest_purple", dynlib: LIB_NAME.}: Color

var LIGHTEST_FUCHSIA* {.importc: "TCOD_lightest_fuchsia", dynlib: LIB_NAME.}: Color

var LIGHTEST_MAGENTA* {.importc: "TCOD_lightest_magenta", dynlib: LIB_NAME.}: Color

var LIGHTEST_PINK* {.importc: "TCOD_lightest_pink", dynlib: LIB_NAME.}: Color

var LIGHTEST_CRIMSON* {.importc: "TCOD_lightest_crimson", dynlib: LIB_NAME.}: Color

#  desaturated

var DESATURATED_RED* {.importc: "TCOD_desaturated_red", dynlib: LIB_NAME.}: Color

var DESATURATED_FLAME* {.importc: "TCOD_desaturated_flame", dynlib: LIB_NAME.}: Color

var DESATURATED_ORANGE* {.importc: "TCOD_desaturated_orange", dynlib: LIB_NAME.}: Color

var DESATURATED_AMBER* {.importc: "TCOD_desaturated_amber", dynlib: LIB_NAME.}: Color

var DESATURATED_YELLOW* {.importc: "TCOD_desaturated_yellow", dynlib: LIB_NAME.}: Color

var DESATURATED_LIME* {.importc: "TCOD_desaturated_lime", dynlib: LIB_NAME.}: Color

var DESATURATED_CHARTREUSE* {.importc: "TCOD_desaturated_chartreuse", dynlib: LIB_NAME.}: Color

var DESATURATED_GREEN* {.importc: "TCOD_desaturated_green", dynlib: LIB_NAME.}: Color

var DESATURATED_SEA* {.importc: "TCOD_desaturated_sea", dynlib: LIB_NAME.}: Color

var DESATURATED_TURQUOISE* {.importc: "TCOD_desaturated_turquoise", dynlib: LIB_NAME.}: Color

var DESATURATED_CYAN* {.importc: "TCOD_desaturated_cyan", dynlib: LIB_NAME.}: Color

var DESATURATED_SKY* {.importc: "TCOD_desaturated_sky", dynlib: LIB_NAME.}: Color

var DESATURATED_AZURE* {.importc: "TCOD_desaturated_azure", dynlib: LIB_NAME.}: Color

var DESATURATED_BLUE* {.importc: "TCOD_desaturated_blue", dynlib: LIB_NAME.}: Color

var DESATURATED_HAN* {.importc: "TCOD_desaturated_han", dynlib: LIB_NAME.}: Color

var DESATURATED_VIOLET* {.importc: "TCOD_desaturated_violet", dynlib: LIB_NAME.}: Color

var DESATURATED_PURPLE* {.importc: "TCOD_desaturated_purple", dynlib: LIB_NAME.}: Color

var DESATURATED_FUCHSIA* {.importc: "TCOD_desaturated_fuchsia", dynlib: LIB_NAME.}: Color

var DESATURATED_MAGENTA* {.importc: "TCOD_desaturated_magenta", dynlib: LIB_NAME.}: Color

var DESATURATED_PINK* {.importc: "TCOD_desaturated_pink", dynlib: LIB_NAME.}: Color

var DESATURATED_CRIMSON* {.importc: "TCOD_desaturated_crimson", dynlib: LIB_NAME.}: Color

#  metallic

var BRASS* {.importc: "TCOD_brass", dynlib: LIB_NAME.}: Color

var COPPER* {.importc: "TCOD_copper", dynlib: LIB_NAME.}: Color

var GOLD* {.importc: "TCOD_gold", dynlib: LIB_NAME.}: Color

var SILVER* {.importc: "TCOD_silver", dynlib: LIB_NAME.}: Color

#  miscellaneous

var CELADON* {.importc: "TCOD_celadon", dynlib: LIB_NAME.}: Color

var PEACH* {.importc: "TCOD_peach", dynlib: LIB_NAME.}: Color

