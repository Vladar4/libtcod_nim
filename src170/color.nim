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

type
  Color* {.bycopy.} = object ##  \
    ##  An RGB color struct.
    r*, g*, b*: uint8


#  constructors

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
  ##  Color map


#  color names

const
  COLOR_RED*          = 0
  COLOR_FLAME*        = 1
  COLOR_ORANGE*       = 2
  COLOR_AMBER*        = 3
  COLOR_YELLOW*       = 4
  COLOR_LIME*         = 5
  COLOR_CHARTREUSE*   = 6
  COLOR_GREEN*        = 7
  COLOR_SEA*          = 8
  COLOR_TURQUOISE*    = 9
  COLOR_CYAN*         = 10
  COLOR_SKY*          = 11
  COLOR_AZURE*        = 12
  COLOR_BLUE*         = 13
  COLOR_HAN*          = 14
  COLOR_VIOLET*       = 15
  COLOR_PURPLE*       = 16
  COLOR_FUCHSIA*      = 17
  COLOR_MAGENTA*      = 18
  COLOR_PINK*         = 19
  COLOR_CRIMSON*      = 20
  COLOR_NB*           = 21

#  color levels

const
  COLOR_DESATURATED*  = 0
  COLOR_LIGHTEST*     = 1
  COLOR_LIGHTER*      = 2
  COLOR_LIGHT*        = 3
  COLOR_NORMAL*       = 4
  COLOR_DARK*         = 5
  COLOR_DARKER*       = 6
  COLOR_DARKEST*      = 7
  COLOR_LEVELS*       = 8


var colors* {.importc: "TCOD_colors", dynlib: LIB_NAME.}:
    array[COLOR_NB, array[COLOR_LEVELS, Color]] ##  color array

#  grey levels

var black* {.importc: "TCOD_black", dynlib: LIB_NAME.}: Color

var darkestGrey* {.importc: "TCOD_darkest_grey", dynlib: LIB_NAME.}: Color

var darkerGrey* {.importc: "TCOD_darker_grey", dynlib: LIB_NAME.}: Color

var darkGrey* {.importc: "TCOD_dark_grey", dynlib: LIB_NAME.}: Color

var grey* {.importc: "TCOD_grey", dynlib: LIB_NAME.}: Color

var lightGrey* {.importc: "TCOD_light_grey", dynlib: LIB_NAME.}: Color

var lighterGrey* {.importc: "TCOD_lighter_grey", dynlib: LIB_NAME.}: Color

var lightestGrey* {.importc: "TCOD_lightest_grey", dynlib: LIB_NAME.}: Color

var darkestGray* {.importc: "TCOD_darkest_gray", dynlib: LIB_NAME.}: Color

var darkerGray* {.importc: "TCOD_darker_gray", dynlib: LIB_NAME.}: Color

var darkGray* {.importc: "TCOD_dark_gray", dynlib: LIB_NAME.}: Color

var gray* {.importc: "TCOD_gray", dynlib: LIB_NAME.}: Color

var lightGray* {.importc: "TCOD_light_gray", dynlib: LIB_NAME.}: Color

var lighterGray* {.importc: "TCOD_lighter_gray", dynlib: LIB_NAME.}: Color

var lightestGray* {.importc: "TCOD_lightest_gray", dynlib: LIB_NAME.}: Color

var white* {.importc: "TCOD_white", dynlib: LIB_NAME.}: Color

##  sepia

var darkestSepia* {.importc: "TCOD_darkest_sepia", dynlib: LIB_NAME.}: Color

var darkerSepia* {.importc: "TCOD_darker_sepia", dynlib: LIB_NAME.}: Color

var darkSepia* {.importc: "TCOD_dark_sepia", dynlib: LIB_NAME.}: Color

var sepia* {.importc: "TCOD_sepia", dynlib: LIB_NAME.}: Color

var lightSepia* {.importc: "TCOD_light_sepia", dynlib: LIB_NAME.}: Color

var lighterSepia* {.importc: "TCOD_lighter_sepia", dynlib: LIB_NAME.}: Color

var lightestSepia* {.importc: "TCOD_lightest_sepia", dynlib: LIB_NAME.}: Color

##  standard colors

var red* {.importc: "TCOD_red", dynlib: LIB_NAME.}: Color

var flame* {.importc: "TCOD_flame", dynlib: LIB_NAME.}: Color

var orange* {.importc: "TCOD_orange", dynlib: LIB_NAME.}: Color

var amber* {.importc: "TCOD_amber", dynlib: LIB_NAME.}: Color

var yellow* {.importc: "TCOD_yellow", dynlib: LIB_NAME.}: Color

var lime* {.importc: "TCOD_lime", dynlib: LIB_NAME.}: Color

var chartreuse* {.importc: "TCOD_chartreuse", dynlib: LIB_NAME.}: Color

var green* {.importc: "TCOD_green", dynlib: LIB_NAME.}: Color

var sea* {.importc: "TCOD_sea", dynlib: LIB_NAME.}: Color

var turquoise* {.importc: "TCOD_turquoise", dynlib: LIB_NAME.}: Color

var cyan* {.importc: "TCOD_cyan", dynlib: LIB_NAME.}: Color

var sky* {.importc: "TCOD_sky", dynlib: LIB_NAME.}: Color

var azure* {.importc: "TCOD_azure", dynlib: LIB_NAME.}: Color

var blue* {.importc: "TCOD_blue", dynlib: LIB_NAME.}: Color

var han* {.importc: "TCOD_han", dynlib: LIB_NAME.}: Color

var violet* {.importc: "TCOD_violet", dynlib: LIB_NAME.}: Color

var purple* {.importc: "TCOD_purple", dynlib: LIB_NAME.}: Color

var fuchsia* {.importc: "TCOD_fuchsia", dynlib: LIB_NAME.}: Color

var magenta* {.importc: "TCOD_magenta", dynlib: LIB_NAME.}: Color

var pink* {.importc: "TCOD_pink", dynlib: LIB_NAME.}: Color

var crimson* {.importc: "TCOD_crimson", dynlib: LIB_NAME.}: Color

##  dark colors

var darkRed* {.importc: "TCOD_dark_red", dynlib: LIB_NAME.}: Color

var darkFlame* {.importc: "TCOD_dark_flame", dynlib: LIB_NAME.}: Color

var darkOrange* {.importc: "TCOD_dark_orange", dynlib: LIB_NAME.}: Color

var darkAmber* {.importc: "TCOD_dark_amber", dynlib: LIB_NAME.}: Color

var darkYellow* {.importc: "TCOD_dark_yellow", dynlib: LIB_NAME.}: Color

var darkLime* {.importc: "TCOD_dark_lime", dynlib: LIB_NAME.}: Color

var darkChartreuse* {.importc: "TCOD_dark_chartreuse", dynlib: LIB_NAME.}: Color

var darkGreen* {.importc: "TCOD_dark_green", dynlib: LIB_NAME.}: Color

var darkSea* {.importc: "TCOD_dark_sea", dynlib: LIB_NAME.}: Color

var darkTurquoise* {.importc: "TCOD_dark_turquoise", dynlib: LIB_NAME.}: Color

var darkCyan* {.importc: "TCOD_dark_cyan", dynlib: LIB_NAME.}: Color

var darkSky* {.importc: "TCOD_dark_sky", dynlib: LIB_NAME.}: Color

var darkAzure* {.importc: "TCOD_dark_azure", dynlib: LIB_NAME.}: Color

var darkBlue* {.importc: "TCOD_dark_blue", dynlib: LIB_NAME.}: Color

var darkHan* {.importc: "TCOD_dark_han", dynlib: LIB_NAME.}: Color

var darkViolet* {.importc: "TCOD_dark_violet", dynlib: LIB_NAME.}: Color

var darkPurple* {.importc: "TCOD_dark_purple", dynlib: LIB_NAME.}: Color

var darkFuchsia* {.importc: "TCOD_dark_fuchsia", dynlib: LIB_NAME.}: Color

var darkMagenta* {.importc: "TCOD_dark_magenta", dynlib: LIB_NAME.}: Color

var darkPink* {.importc: "TCOD_dark_pink", dynlib: LIB_NAME.}: Color

var darkCrimson* {.importc: "TCOD_dark_crimson", dynlib: LIB_NAME.}: Color

##  darker colors

var darkerRed* {.importc: "TCOD_darker_red", dynlib: LIB_NAME.}: Color

var darkerFlame* {.importc: "TCOD_darker_flame", dynlib: LIB_NAME.}: Color

var darkerOrange* {.importc: "TCOD_darker_orange", dynlib: LIB_NAME.}: Color

var darkerAmber* {.importc: "TCOD_darker_amber", dynlib: LIB_NAME.}: Color

var darkerYellow* {.importc: "TCOD_darker_yellow", dynlib: LIB_NAME.}: Color

var darkerLime* {.importc: "TCOD_darker_lime", dynlib: LIB_NAME.}: Color

var darkerChartreuse* {.importc: "TCOD_darker_chartreuse", dynlib: LIB_NAME.}: Color

var darkerGreen* {.importc: "TCOD_darker_green", dynlib: LIB_NAME.}: Color

var darkerSea* {.importc: "TCOD_darker_sea", dynlib: LIB_NAME.}: Color

var darkerTurquoise* {.importc: "TCOD_darker_turquoise", dynlib: LIB_NAME.}: Color

var darkerCyan* {.importc: "TCOD_darker_cyan", dynlib: LIB_NAME.}: Color

var darkerSky* {.importc: "TCOD_darker_sky", dynlib: LIB_NAME.}: Color

var darkerAzure* {.importc: "TCOD_darker_azure", dynlib: LIB_NAME.}: Color

var darkerBlue* {.importc: "TCOD_darker_blue", dynlib: LIB_NAME.}: Color

var darkerHan* {.importc: "TCOD_darker_han", dynlib: LIB_NAME.}: Color

var darkerViolet* {.importc: "TCOD_darker_violet", dynlib: LIB_NAME.}: Color

var darkerPurple* {.importc: "TCOD_darker_purple", dynlib: LIB_NAME.}: Color

var darkerFuchsia* {.importc: "TCOD_darker_fuchsia", dynlib: LIB_NAME.}: Color

var darkerMagenta* {.importc: "TCOD_darker_magenta", dynlib: LIB_NAME.}: Color

var darkerPink* {.importc: "TCOD_darker_pink", dynlib: LIB_NAME.}: Color

var darkerCrimson* {.importc: "TCOD_darker_crimson", dynlib: LIB_NAME.}: Color

##  darkest colors

var darkestRed* {.importc: "TCOD_darkest_red", dynlib: LIB_NAME.}: Color

var darkestFlame* {.importc: "TCOD_darkest_flame", dynlib: LIB_NAME.}: Color

var darkestOrange* {.importc: "TCOD_darkest_orange", dynlib: LIB_NAME.}: Color

var darkestAmber* {.importc: "TCOD_darkest_amber", dynlib: LIB_NAME.}: Color

var darkestYellow* {.importc: "TCOD_darkest_yellow", dynlib: LIB_NAME.}: Color

var darkestLime* {.importc: "TCOD_darkest_lime", dynlib: LIB_NAME.}: Color

var darkestChartreuse* {.importc: "TCOD_darkest_chartreuse", dynlib: LIB_NAME.}: Color

var darkestGreen* {.importc: "TCOD_darkest_green", dynlib: LIB_NAME.}: Color

var darkestSea* {.importc: "TCOD_darkest_sea", dynlib: LIB_NAME.}: Color

var darkestTurquoise* {.importc: "TCOD_darkest_turquoise", dynlib: LIB_NAME.}: Color

var darkestCyan* {.importc: "TCOD_darkest_cyan", dynlib: LIB_NAME.}: Color

var darkestSky* {.importc: "TCOD_darkest_sky", dynlib: LIB_NAME.}: Color

var darkestAzure* {.importc: "TCOD_darkest_azure", dynlib: LIB_NAME.}: Color

var darkestBlue* {.importc: "TCOD_darkest_blue", dynlib: LIB_NAME.}: Color

var darkestHan* {.importc: "TCOD_darkest_han", dynlib: LIB_NAME.}: Color

var darkestViolet* {.importc: "TCOD_darkest_violet", dynlib: LIB_NAME.}: Color

var darkestPurple* {.importc: "TCOD_darkest_purple", dynlib: LIB_NAME.}: Color

var darkestFuchsia* {.importc: "TCOD_darkest_fuchsia", dynlib: LIB_NAME.}: Color

var darkestMagenta* {.importc: "TCOD_darkest_magenta", dynlib: LIB_NAME.}: Color

var darkestPink* {.importc: "TCOD_darkest_pink", dynlib: LIB_NAME.}: Color

var darkestCrimson* {.importc: "TCOD_darkest_crimson", dynlib: LIB_NAME.}: Color

##  light colors

var lightRed* {.importc: "TCOD_light_red", dynlib: LIB_NAME.}: Color

var lightFlame* {.importc: "TCOD_light_flame", dynlib: LIB_NAME.}: Color

var lightOrange* {.importc: "TCOD_light_orange", dynlib: LIB_NAME.}: Color

var lightAmber* {.importc: "TCOD_light_amber", dynlib: LIB_NAME.}: Color

var lightYellow* {.importc: "TCOD_light_yellow", dynlib: LIB_NAME.}: Color

var lightLime* {.importc: "TCOD_light_lime", dynlib: LIB_NAME.}: Color

var lightChartreuse* {.importc: "TCOD_light_chartreuse", dynlib: LIB_NAME.}: Color

var lightGreen* {.importc: "TCOD_light_green", dynlib: LIB_NAME.}: Color

var lightSea* {.importc: "TCOD_light_sea", dynlib: LIB_NAME.}: Color

var lightTurquoise* {.importc: "TCOD_light_turquoise", dynlib: LIB_NAME.}: Color

var lightCyan* {.importc: "TCOD_light_cyan", dynlib: LIB_NAME.}: Color

var lightSky* {.importc: "TCOD_light_sky", dynlib: LIB_NAME.}: Color

var lightAzure* {.importc: "TCOD_light_azure", dynlib: LIB_NAME.}: Color

var lightBlue* {.importc: "TCOD_light_blue", dynlib: LIB_NAME.}: Color

var lightHan* {.importc: "TCOD_light_han", dynlib: LIB_NAME.}: Color

var lightViolet* {.importc: "TCOD_light_violet", dynlib: LIB_NAME.}: Color

var lightPurple* {.importc: "TCOD_light_purple", dynlib: LIB_NAME.}: Color

var lightFuchsia* {.importc: "TCOD_light_fuchsia", dynlib: LIB_NAME.}: Color

var lightMagenta* {.importc: "TCOD_light_magenta", dynlib: LIB_NAME.}: Color

var lightPink* {.importc: "TCOD_light_pink", dynlib: LIB_NAME.}: Color

var lightCrimson* {.importc: "TCOD_light_crimson", dynlib: LIB_NAME.}: Color

##  lighter colors

var lighterRed* {.importc: "TCOD_lighter_red", dynlib: LIB_NAME.}: Color

var lighterFlame* {.importc: "TCOD_lighter_flame", dynlib: LIB_NAME.}: Color

var lighterOrange* {.importc: "TCOD_lighter_orange", dynlib: LIB_NAME.}: Color

var lighterAmber* {.importc: "TCOD_lighter_amber", dynlib: LIB_NAME.}: Color

var lighterYellow* {.importc: "TCOD_lighter_yellow", dynlib: LIB_NAME.}: Color

var lighterLime* {.importc: "TCOD_lighter_lime", dynlib: LIB_NAME.}: Color

var lighterChartreuse* {.importc: "TCOD_lighter_chartreuse", dynlib: LIB_NAME.}: Color

var lighterGreen* {.importc: "TCOD_lighter_green", dynlib: LIB_NAME.}: Color

var lighterSea* {.importc: "TCOD_lighter_sea", dynlib: LIB_NAME.}: Color

var lighterTurquoise* {.importc: "TCOD_lighter_turquoise", dynlib: LIB_NAME.}: Color

var lighterCyan* {.importc: "TCOD_lighter_cyan", dynlib: LIB_NAME.}: Color

var lighterSky* {.importc: "TCOD_lighter_sky", dynlib: LIB_NAME.}: Color

var lighterAzure* {.importc: "TCOD_lighter_azure", dynlib: LIB_NAME.}: Color

var lighterBlue* {.importc: "TCOD_lighter_blue", dynlib: LIB_NAME.}: Color

var lighterHan* {.importc: "TCOD_lighter_han", dynlib: LIB_NAME.}: Color

var lighterViolet* {.importc: "TCOD_lighter_violet", dynlib: LIB_NAME.}: Color

var lighterPurple* {.importc: "TCOD_lighter_purple", dynlib: LIB_NAME.}: Color

var lighterFuchsia* {.importc: "TCOD_lighter_fuchsia", dynlib: LIB_NAME.}: Color

var lighterMagenta* {.importc: "TCOD_lighter_magenta", dynlib: LIB_NAME.}: Color

var lighterPink* {.importc: "TCOD_lighter_pink", dynlib: LIB_NAME.}: Color

var lighterCrimson* {.importc: "TCOD_lighter_crimson", dynlib: LIB_NAME.}: Color

##  lightest colors

var lightestRed* {.importc: "TCOD_lightest_red", dynlib: LIB_NAME.}: Color

var lightestFlame* {.importc: "TCOD_lightest_flame", dynlib: LIB_NAME.}: Color

var lightestOrange* {.importc: "TCOD_lightest_orange", dynlib: LIB_NAME.}: Color

var lightestAmber* {.importc: "TCOD_lightest_amber", dynlib: LIB_NAME.}: Color

var lightestYellow* {.importc: "TCOD_lightest_yellow", dynlib: LIB_NAME.}: Color

var lightestLime* {.importc: "TCOD_lightest_lime", dynlib: LIB_NAME.}: Color

var lightestChartreuse* {.importc: "TCOD_lightest_chartreuse", dynlib: LIB_NAME.}: Color

var lightestGreen* {.importc: "TCOD_lightest_green", dynlib: LIB_NAME.}: Color

var lightestSea* {.importc: "TCOD_lightest_sea", dynlib: LIB_NAME.}: Color

var lightestTurquoise* {.importc: "TCOD_lightest_turquoise", dynlib: LIB_NAME.}: Color

var lightestCyan* {.importc: "TCOD_lightest_cyan", dynlib: LIB_NAME.}: Color

var lightestSky* {.importc: "TCOD_lightest_sky", dynlib: LIB_NAME.}: Color

var lightestAzure* {.importc: "TCOD_lightest_azure", dynlib: LIB_NAME.}: Color

var lightestBlue* {.importc: "TCOD_lightest_blue", dynlib: LIB_NAME.}: Color

var lightestHan* {.importc: "TCOD_lightest_han", dynlib: LIB_NAME.}: Color

var lightestViolet* {.importc: "TCOD_lightest_violet", dynlib: LIB_NAME.}: Color

var lightestPurple* {.importc: "TCOD_lightest_purple", dynlib: LIB_NAME.}: Color

var lightestFuchsia* {.importc: "TCOD_lightest_fuchsia", dynlib: LIB_NAME.}: Color

var lightestMagenta* {.importc: "TCOD_lightest_magenta", dynlib: LIB_NAME.}: Color

var lightestPink* {.importc: "TCOD_lightest_pink", dynlib: LIB_NAME.}: Color

var lightestCrimson* {.importc: "TCOD_lightest_crimson", dynlib: LIB_NAME.}: Color

##  desaturated

var desaturatedRed* {.importc: "TCOD_desaturated_red", dynlib: LIB_NAME.}: Color

var desaturatedFlame* {.importc: "TCOD_desaturated_flame", dynlib: LIB_NAME.}: Color

var desaturatedOrange* {.importc: "TCOD_desaturated_orange", dynlib: LIB_NAME.}: Color

var desaturatedAmber* {.importc: "TCOD_desaturated_amber", dynlib: LIB_NAME.}: Color

var desaturatedYellow* {.importc: "TCOD_desaturated_yellow", dynlib: LIB_NAME.}: Color

var desaturatedLime* {.importc: "TCOD_desaturated_lime", dynlib: LIB_NAME.}: Color

var desaturatedChartreuse* {.importc: "TCOD_desaturated_chartreuse", dynlib: LIB_NAME.}: Color

var desaturatedGreen* {.importc: "TCOD_desaturated_green", dynlib: LIB_NAME.}: Color

var desaturatedSea* {.importc: "TCOD_desaturated_sea", dynlib: LIB_NAME.}: Color

var desaturatedTurquoise* {.importc: "TCOD_desaturated_turquoise", dynlib: LIB_NAME.}: Color

var desaturatedCyan* {.importc: "TCOD_desaturated_cyan", dynlib: LIB_NAME.}: Color

var desaturatedSky* {.importc: "TCOD_desaturated_sky", dynlib: LIB_NAME.}: Color

var desaturatedAzure* {.importc: "TCOD_desaturated_azure", dynlib: LIB_NAME.}: Color

var desaturatedBlue* {.importc: "TCOD_desaturated_blue", dynlib: LIB_NAME.}: Color

var desaturatedHan* {.importc: "TCOD_desaturated_han", dynlib: LIB_NAME.}: Color

var desaturatedViolet* {.importc: "TCOD_desaturated_violet", dynlib: LIB_NAME.}: Color

var desaturatedPurple* {.importc: "TCOD_desaturated_purple", dynlib: LIB_NAME.}: Color

var desaturatedFuchsia* {.importc: "TCOD_desaturated_fuchsia", dynlib: LIB_NAME.}: Color

var desaturatedMagenta* {.importc: "TCOD_desaturated_magenta", dynlib: LIB_NAME.}: Color

var desaturatedPink* {.importc: "TCOD_desaturated_pink", dynlib: LIB_NAME.}: Color

var desaturatedCrimson* {.importc: "TCOD_desaturated_crimson", dynlib: LIB_NAME.}: Color

##  metallic

var brass* {.importc: "TCOD_brass", dynlib: LIB_NAME.}: Color

var copper* {.importc: "TCOD_copper", dynlib: LIB_NAME.}: Color

var gold* {.importc: "TCOD_gold", dynlib: LIB_NAME.}: Color

var silver* {.importc: "TCOD_silver", dynlib: LIB_NAME.}: Color

##  miscellaneous

var celadon* {.importc: "TCOD_celadon", dynlib: LIB_NAME.}: Color

var peach* {.importc: "TCOD_peach", dynlib: LIB_NAME.}: Color

