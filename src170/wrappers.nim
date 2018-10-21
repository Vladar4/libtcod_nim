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
  console_types, image, mouse_types, parser

##  Wrappers to ease other languages integration.

type
  Colornum* = cuint

#  color module

proc colorEqualsWrapper*(
  c1, c2: Colornum): bool {.
    cdecl, importc: "TCOD_color_equals_wrapper", dynlib: LIB_NAME.}

proc colorAddWrapper*(
  c1, c2: Colornum): Colornum {.
    cdecl, importc: "TCOD_color_add_wrapper", dynlib: LIB_NAME.}

proc colorSubtractWrapper*(
  c1, c2: Colornum): Colornum {.
    cdecl, importc: "TCOD_color_subtract_wrapper", dynlib: LIB_NAME.}

proc colorMultiplyWrapper*(
  c1, c2: Colornum): Colornum {.
    cdecl, importc: "TCOD_color_multiply_wrapper", dynlib: LIB_NAME.}

proc colorMultiplyScalarWrapper*(
  c1: Colornum; value: cfloat): Colornum {.
    cdecl, importc: "TCOD_color_multiply_scalar_wrapper", dynlib: LIB_NAME.}

proc colorLerpWrapper*(
  c1, c2: Colornum; coef: cfloat): Colornum {.
    cdecl, importc: "TCOD_color_lerp_wrapper", dynlib: LIB_NAME.}

proc colorGetHSV_wrapper*(
  c: Colornum; h, s, v: ptr cfloat) {.
    cdecl, importc: "TCOD_color_get_HSV_wrapper", dynlib: LIB_NAME.}

proc colorGetHueWrapper*(
  c: Colornum): cfloat {.
    cdecl, importc: "TCOD_color_get_hue_wrapper", dynlib: LIB_NAME.}

proc colorGetSaturationWrapper*(
  c: Colornum): cfloat {.
    cdecl, importc: "TCOD_color_get_saturation_wrapper", dynlib: LIB_NAME.}

proc colorGetValueWrapper*(
  c: Colornum): cfloat {.
    cdecl, importc: "TCOD_color_get_value_wrapper", dynlib: LIB_NAME.}


#  console module
#[
proc consoleSetCustomFontWrapper*(
  fontFile: cstring;
  char_width, char_height, nb_char_horiz, nb_char_vertic: cint;
  chars_by_row: bool, keyColor: Colornum) {.
    cdecl, importc: "TCOD_console_set_custom_font_wrapper", dynlib: LIB_NAME.}
]#

proc consoleSetDefaultBackgroundWrapper*(
  con: Console; col: Colornum) {.
    cdecl, importc: "TCOD_console_set_default_background_wrapper",
    dynlib: LIB_NAME.}

proc consoleSetDefaultForegroundWrapper*(
  con: Console; col: Colornum) {.
    cdecl, importc: "TCOD_console_set_default_foreground_wrapper",
    dynlib: LIB_NAME.}

proc consoleGetDefaultBackgroundWrapper*(
  con: Console): Colornum {.
    cdecl, importc: "TCOD_console_get_default_background_wrapper",
    dynlib: LIB_NAME.}

proc consoleGetDefaultForegroundWrapper*(
  con: Console): Colornum {.
    cdecl, importc: "TCOD_console_get_default_foreground_wrapper",
    dynlib: LIB_NAME.}

proc consoleGetCharBackgroundWrapper*(
  con: Console; x, y: cint): Colornum {.
    cdecl, importc: "TCOD_console_get_char_background_wrapper",
    dynlib: LIB_NAME.}

proc consoleSetCharBackgroundWrapper*(
  con: ConsoleT; x, y: cint; col: Colornum; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_set_char_background_wrapper",
    dynlib: LIB_NAME.}

proc consoleGetCharForegroundWrapper*(
  con: Console; x, y: cint): Colornum {.
    cdecl, importc: "TCOD_console_get_char_foreground_wrapper",
    dynlib: LIB_NAME.}

proc consoleSetCharForegroundWrapper*(
  con: Console; x, y: cint; col: Colornum) {.
    cdecl, importc: "TCOD_console_set_char_foreground_wrapper",
    dynlib: LIB_NAME.}

proc consolePutCharExWrapper*(
  con: Console; x, y, c: cint; fore, back: Colornum) {.
    cdecl, importc: "TCOD_console_put_char_ex_wrapper", dynlib: LIB_NAME.}

proc consoleSetFadeWrapper*(
  val: uint8; fade: Colornum) {.
    cdecl, importc: "TCOD_console_set_fade_wrapper", dynlib: LIB_NAME.}

proc consoleGetFadingColorWrapper*(): Colornum {.
    cdecl, importc: "TCOD_console_get_fading_color_wrapper", dynlib: LIB_NAME.}

proc consoleSetColorControlWrapper*(
  con: Colctrl; fore, back: ColornumT) {.
    cdecl, importc: "TCOD_console_set_color_control_wrapper", dynlib: LIB_NAME.}

proc consoleCheckForKeypressWrapper*(
  holder: ptr Key; flags: cint): bool {.
    cdecl, importc: "TCOD_console_check_for_keypress_wrapper",
    dynlib: LIB_NAME.}

proc consoleWaitForKeypressWrapper*(
  holder: ptr Key; flush: bool) {.
    cdecl, importc: "TCOD_console_wait_for_keypress_wrapper", dynlib: LIB_NAME.}

proc consoleFillBackground*(
  con: Console; r, g, b: ptr cint) {.
    cdecl, importc: "TCOD_console_fill_background", dynlib: LIB_NAME.}

proc consoleFillForeground*(
  con: Console; r, g, b: ptr cint) {.
    cdecl, importc: "TCOD_console_fill_foreground", dynlib: LIB_NAME.}

proc consoleFillChar*(
  con: Console; arr: ptr cint) {.
    cdecl, importc: "TCOD_console_fill_char", dynlib: LIB_NAME.}

proc consoleDoubleHline*(
  con: Console; x, y, l: cint; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_double_hline", dynlib: LIB_NAME.}

proc consoleDoubleVline*(
  con: Console; x, y, l: cint; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_double_vline", dynlib: LIB_NAME.}

proc consolePrintDoubleFrame*(
  con: Console; x, y, w, h: cint; empty: bool; flag: BkgndFlag; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_print_double_frame",
    dynlib: LIB_NAME.}

proc consolePrintReturnString*(
  con: Console; x, y, rw, rh: cint; flag: BkgndFlag; align: Alignment;
  msg: cstring; canSplit, countOnly: bool): cstring {.
    cdecl, importc: "TCOD_console_print_return_string", dynlib: LIB_NAME.}

proc consoleSetKeyColorWrapper*(
  con: Console; c: Colornum) {.
    cdecl, importc: "TCOD_console_set_key_color_wrapper", dynlib: LIB_NAME.}

##  image module
proc imageClearWrapper*(
  image: Image; color: Colornum) {.
    cdecl, importc: "TCOD_image_clear_wrapper", dynlib: LIB_NAME.}

proc imageGetPixelWrapper*(
  image: Image; x, y: cint): Colornum {.
    cdecl, importc: "TCOD_image_get_pixel_wrapper", dynlib: LIB_NAME.}

proc imageGetMipmapPixelWrapper*(
  image: Image; x0, y0, x1, y1: cfloat): Colornum {.
    cdecl, importc: "TCOD_image_get_mipmap_pixel_wrapper", dynlib: LIB_NAME.}

proc imagePutPixelWrapper*(
  image: Image; x, y: cint; col: Colornum) {.
    cdecl, importc: "TCOD_image_put_pixel_wrapper", dynlib: LIB_NAME.}

proc imageSetKeyColorWrapper*(
  image: Image; keyColor: Colornum) {.
    cdecl, importc: "TCOD_image_set_key_color_wrapper", dynlib: LIB_NAME.}


#  mouse module

proc mouseGetStatusWrapper*(
  holder: ptr Mouse) {.
    cdecl, importc: "TCOD_mouse_get_status_wrapper", dynlib: LIB_NAME.}


#  parser module

proc parserGetColorPropertyWrapper*(
  parser: Parser; name: cstring): Colornum {.
    cdecl, importc: "TCOD_parser_get_color_property_wrapper", dynlib: LIB_NAME.}


#  namegen module

proc namegenGetNbSetsWrapper*(): cint {.
    cdecl, importc: "TCOD_namegen_get_nb_sets_wrapper", dynlib: LIB_NAME.}

proc namegenGetSetsWrapper*(
  sets: cstringArray) {.
    cdecl, importc: "TCOD_namegen_get_sets_wrapper", dynlib: LIB_NAME.}


#  sys module

proc sysGetCurrentResolutionX*(): cint {.
    cdecl, importc: "TCOD_sys_get_current_resolution_x", dynlib: LIB_NAME.}

proc sysGetCurrentResolutionY*(): cint {.
    cdecl, importc: "TCOD_sys_get_current_resolution_y", dynlib: LIB_NAME.}

