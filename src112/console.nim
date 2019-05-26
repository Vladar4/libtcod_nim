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

# import color, console_types, image, list

template bkgndAlpha*(alpha: untyped): untyped =
  ((BkgndFlag)(BKGND_ALPH.uint8 or (((uint8)(alpha * 255)) shl 8)))

template bkgndAddalpha*(alpha: untyped): untyped =
  ((BkgndFlag)(BKGND_ADDA.uint8 or (((uint8)(alpha * 255)) shl 8)))

proc consoleSetCustomFont*(
  fontFile: cstring;
  flags: cint = FONT_LAYOUT_ASCII_INCOL;
  nbCharHoriz: cint = 0;
  nbCharVertic: cint = 0) {.
    cdecl, importc: "TCOD_console_set_custom_font", dynlib: LIB_NAME.}

proc consoleMapAsciiCodeToFont*(
  asciiCode, fontCharX, fontCharY: cint) {.
    cdecl, importc: "TCOD_console_map_ascii_code_to_font", dynlib: LIB_NAME.}

proc consoleMapAsciiCodesToFont*(
  asciiCode, nbCodes, fontCharX, fontCharY: cint) {.
    cdecl, importc: "TCOD_console_map_ascii_codes_to_font", dynlib: LIB_NAME.}

proc consoleMapStringToFont*(
  s: cstring; fontCharX, fontCharY: cint) {.
    cdecl, importc: "TCOD_console_map_string_to_font", dynlib: LIB_NAME.}

# proc consoleMapStringToFontUTF is located in the console_printing.nim

proc consoleSetDirty*(
  x, y, w, h: cint) {.
    cdecl, importc: "TCOD_console_set_dirty", dynlib: LIB_NAME.}

proc consoleFlush*() {.
    cdecl, importc: "TCOD_console_flush", dynlib: LIB_NAME.}

proc consoleSetColorControl*(
  con: Colctrl; fore, back: Color) {.
    cdecl, importc: "TCOD_console_set_color_control", dynlib: LIB_NAME.}

proc consoleCheckForKeypress*(
  flags: cint): Key {.
    cdecl, importc: "TCOD_console_check_for_keypress", dynlib: LIB_NAME.}

proc consoleWaitForKeypress*(
  flush: bool): Key {.
    cdecl, importc: "TCOD_console_wait_for_keypress", dynlib: LIB_NAME.}

proc consoleIsKeyPressed*(
  key: Keycode): bool {.
    cdecl, importc: "TCOD_console_is_key_pressed", dynlib: LIB_NAME.}

proc consoleFromFile*(
  filename: cstring): Console {.
    cdecl, importc: "TCOD_console_from_file", dynlib: LIB_NAME.}
  ##  ASCII paint file support

proc consoleLoadAsc*(
  con: Console; filename: cstring): bool {.
    cdecl, importc: "TCOD_console_load_asc", dynlib: LIB_NAME.}

proc consoleLoadApf*(
  con: Console; filename: cstring): bool {.
    cdecl, importc: "TCOD_console_load_apf", dynlib: LIB_NAME.}

proc consoleSaveAsc*(
  con: Console; filename: cstring): bool {.
    cdecl, importc: "TCOD_console_save_asc", dynlib: LIB_NAME.}

proc consoleSaveApf*(
  con: Console; filename: cstring): bool {.
    cdecl, importc: "TCOD_console_save_apf", dynlib: LIB_NAME.}

proc consoleCredits*() {.
    cdecl, importc: "TCOD_console_credits", dynlib: LIB_NAME.}

proc consoleCreditsReset*() {.
    cdecl, importc: "TCOD_console_credits_reset", dynlib: LIB_NAME.}

proc consoleCreditsRender*(
  x, y: cint; alpha: bool): bool {.
    cdecl, importc: "TCOD_console_credits_render", dynlib: LIB_NAME.}

proc consoleSetKeyboardRepeat*(
  initialDelay, interval: cint) {.
    cdecl, importc: "TCOD_console_set_keyboard_repeat", dynlib: LIB_NAME,
    deprecated: "This function is a stub an will do nothing".}

proc consoleDisableKeyboardRepeat*() {.
    cdecl, importc: "TCOD_console_disable_keyboard_repeat", dynlib: LIB_NAME,
    deprecated: "This function is a stub and will do nothing".}

