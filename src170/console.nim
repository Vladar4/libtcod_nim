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
  color, console_types, image, list

template bkgnd_Alpha*(alpha: untyped): untyped =
  ((BkgndFlag)(BKGND_ALPH or (((uint8)(alpha * 255)) shl 8)))

template bkgnd_Addalpha*(alpha: untyped): untyped =
  ((BkgndFlag)(BKGND_ADDA or (((uint8)(alpha * 255)) shl 8)))

proc consoleInitRoot*(
  w, h: cint; title: cstring; fullscreen: bool; renderer: Renderer) {.
    cdecl, importc: "TCOD_console_init_root", dynlib: LIB_NAME.}

proc consoleSetWindowTitle*(
  title: cstring) {.
    cdecl, importc: "TCOD_console_set_window_title", dynlib: LIB_NAME.}

proc consoleSetFullscreen*(
  fullscreen: bool) {.
    cdecl, importc: "TCOD_console_set_fullscreen", dynlib: LIB_NAME.}

proc consoleIsFullscreen*(): bool {.
    cdecl, importc: "TCOD_console_is_fullscreen", dynlib: LIB_NAME.}

proc consoleIsWindowClosed*(): bool {.
    cdecl, importc: "TCOD_console_is_window_closed", dynlib: LIB_NAME.}

proc consoleHasMouseFocus*(): bool {.
    cdecl, importc: "TCOD_console_has_mouse_focus", dynlib: LIB_NAME.}

proc consoleIsActive*(): bool {.
    cdecl, importc: "TCOD_console_is_active", dynlib: LIB_NAME.}

proc consoleSetCustomFont*(
  fontFile: cstring; flags, nbCharHoriz, nbCharVertic: cint) {.
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

proc consoleSetDirty*(
  x, y, w, h: cint) {.
    cdecl, importc: "TCOD_console_set_dirty", dynlib: LIB_NAME.}

proc consoleSetDefaultBackground*(
  con: Console; col: Color) {.
    cdecl, importc: "TCOD_console_set_default_background", dynlib: LIB_NAME.}

proc consoleSetDefaultForeground*(
  con: Console; col: Color) {.
    cdecl, importc: "TCOD_console_set_default_foreground", dynlib: LIB_NAME.}

proc consoleClear*(
  con: Console) {.
    cdecl, importc: "TCOD_console_clear", dynlib: LIB_NAME.}

proc consoleSetCharBackground*(
  con: Console; x, y: cint; col: Color; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_set_char_background", dynlib: LIB_NAME.}

proc consoleSetCharForeground*(
  con: Console; x, y: cint; col: Color) {.
    cdecl, importc: "TCOD_console_set_char_foreground", dynlib: LIB_NAME.}

proc consoleSetChar*(
  con: Console; x, y, c: cint) {.
    cdecl, importc: "TCOD_console_set_char", dynlib: LIB_NAME.}

proc consolePutChar*(
  con: Console; x, y, c: cint; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_put_char", dynlib: LIB_NAME.}

proc consolePutCharEx*(
  con: Console; x, y, c: cint; fore, back: Color) {.
    cdecl, importc: "TCOD_console_put_char_ex", dynlib: LIB_NAME.}

proc consoleSetBackgroundFlag*(
  con: Console; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_set_background_flag", dynlib: LIB_NAME.}

proc consoleGetBackgroundFlag*(
  con: Console): BkgndFlag {.
    cdecl, importc: "TCOD_console_get_background_flag", dynlib: LIB_NAME.}

proc consoleSetAlignment*(
  con: Console; alignment: Alignment) {.
    cdecl, importc: "TCOD_console_set_alignment", dynlib: LIB_NAME.}

proc consoleGetAlignment*(
  con: Console): Alignment {.
    cdecl, importc: "TCOD_console_get_alignment", dynlib: LIB_NAME.}

proc consolePrint*(
  con: Console; x, y: cint; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_print", dynlib: LIB_NAME.}

proc consolePrintEx*(
  con: Console; x, y: cint; flag: BkgndFlag;
  alignment: Alignment; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_print_ex", dynlib: LIB_NAME.}

proc consolePrintRect*(
  con: Console; x, y, w, h: cint; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_print_rect", dynlib: LIB_NAME.}

proc consolePrintRectEx*(
  con: Console; x, y, w, h: cint; flag: BkgndFlag;
  alignment: Alignment; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_print_rect_ex", dynlib: LIB_NAME.}

proc consoleGetHeightRect*(
  con: Console; x, y, w, h: cint; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_get_height_rect", dynlib: LIB_NAME.}

proc consoleRect*(
  con: Console; x, y, w, h: cint; clear: bool; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_rect", dynlib: LIB_NAME.}

proc consoleHline*(
  con: Console; x, y, l: cint; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_hline", dynlib: LIB_NAME.}

proc consoleVline*(
  con: Console; x, y, l: cint; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_vline", dynlib: LIB_NAME.}

proc consolePrintFrame*(
  con: Console; x, y, w, h: cint; empty: bool; flag: BkgndFlagT;
  fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_print_frame", dynlib: LIB_NAME.}

when not defined(NO_UNICODE): ##  unicode support

  when defined(linux):
    import unicode

    # modified for linux (cint) WideCString from Nimrod's system/widestrs.nim

    type
      TUTF32Char = distinct cint
      WideCString = ref array[0..1_000_000, TUTF32Char]

    when not declared(c_strlen):
      proc c_strlen(a: cstring): cint {.nodecl, noSideEffect, importc: "strlen".}

    when true: # optimized procedure

      proc newWCS(s: string): WideCString =
        #if s.isNil: return nil # strings can't be nil anymore (Nim v0.18.1)
        let length = c_strlen(s)
        unsafeNew(result, length * 4 + 2)
        #result = cast[WideCString](alloc(length * 4 + 2))
        var d = 0
        for ch in runes(s):
          result[d] = TUTF32Char(ch)
          inc d
        result[d] = TUTF32Char(0'i32)

    else:
      const
        UNI_REPLACEMENT_CHAR = TUTF32Char(0xFFFD'i32)
        UNI_MAX_BMP = TRune(0x0000FFFF)
        UNI_MAX_UTF32 = TRune(0x7FFFFFFF)
        #UNI_MAX_LEGAL_UTF32 = TRune(0x0010FFFF)
        halfShift = 10
        halfBase = 0x0010000
        halfMask = 0x3FF
        UNI_SUR_HIGH_START = TRune(0xD800)
        #UNI_SUR_HIGH_END = TRune(0xDBFF)
        UNI_SUR_LOW_START = TRune(0xDC00)
        UNI_SUR_LOW_END = TRune(0xDFFF)

      proc newWCS(s: string): WideCString =
        #if s.isNil: return nil # strings can't be nil anymore (Nim v0.18.1)
        let length = c_strlen(s)
        unsafeNew(result, length * 4 + 2)
        #result = cast[WideCString](alloc(length * 4 + 2))
        var d = 0
        for ch in runes(s):
          if ch <=% UNI_MAX_BMP:
            if ch >=% UNI_SUR_HIGH_START and ch <=% UNI_SUR_LOW_END:
              result[d] = UNI_REPLACEMENT_CHAR
            else:
              result[d] = TUTF32Char(ch)
          elif ch >% UNI_MAX_UTF32:
            result[d] = UNI_REPLACEMENT_CHAR
          else:
            let ch = cint(ch) -% halfBase
            result[d] = TUTF32Char((ch shr halfShift) +% cint(UNI_SUR_HIGH_START))
            inc d
            result[d] = TUTF32Char((ch and halfMask) +% cint(UNI_SUR_LOW_START))
          inc d
        result[d] = TUTF32Char(0'i32)

  else: # windows
    template newWCS(s: string): WideCString = newWideCString(s)

  proc consoleMapStringToFontUtf*(
    s: WideCString; fontCharX, fontCharY: cint) {.
      cdecl, importc: "TCOD_console_map_string_to_font_utf", dynlib: LIB_NAME.}

  proc consolePrintUtf*(
    con: Console; x, y: cint; fmt: WideCString) {.
      varargs, cdecl, importc: "TCOD_console_print_utf", dynlib: LIB_NAME.}

  proc consolePrintExUtf*(
    con: Console; x, y: cint; flag: BkgndFlag; alignment: Alignment;
    fmt: WideCString) {.
      varargs, cdecl, importc: "TCOD_console_print_ex_utf", dynlib: LIB_NAME.}

  proc consolePrintRectUtf*(
    con: Console; x, y, w, h: cint; fmt: WideCString): cint {.
      varargs, cdecl, importc: "TCOD_console_print_rect_utf", dynlib: LIB_NAME.}

  proc consolePrintRectExUtf*(
    con: Console; x, y, w, h: cint; flag: BkgndFlag; alignment: Alignment;
    fmt: WideCString): cint {.
      varargs, cdecl, importc: "TCOD_console_print_rect_ex_utf",
      dynlib: LIB_NAME.}

  proc consoleGetHeightRectUtf*(
    con: Console; x, y, w, h: cint; fmt: WideCString): cint {.
      varargs, cdecl, importc: "TCOD_console_get_height_rect_utf",
      dynlib: LIB_NAME.}

# ^ when not defined(NO_UNICODE)


proc consoleGetDefaultBackground*(
  con: Console): Color {.
    cdecl, importc: "TCOD_console_get_default_background", dynlib: LIB_NAME.}

proc consoleGetDefaultForeground*(
  con: Console): Color {.
    cdecl, importc: "TCOD_console_get_default_foreground", dynlib: LIB_NAME.}

proc consoleGetCharBackground*(
  con: Console; x, y: cint): Color {.
    cdecl, importc: "TCOD_console_get_char_background", dynlib: LIB_NAME.}

proc consoleGetCharForeground*(
  con: Console; x, y: cint): Color {.
    cdecl, importc: "TCOD_console_get_char_foreground", dynlib: LIB_NAME.}

proc consoleGetChar*(
  con: Console; x, y: cint): cint {.
    cdecl, importc: "TCOD_console_get_char", dynlib: LIB_NAME.}

proc consoleGetBackgroundColorImage*(
  con: Console): Image {.
    cdecl, importc: "TCOD_console_get_background_color_image",
    dynlib: LIB_NAME.}

proc consoleGetForegroundColorImage*(
  con: Console): Image {.
    cdecl, importc: "TCOD_console_get_foreground_color_image",
    dynlib: LIB_NAME.}

proc consoleSetFade*(
  val: uint8; fade: Color) {.
    cdecl, importc: "TCOD_console_set_fade", dynlib: LIB_NAME.}

proc consoleGetFade*(): uint8 {.
    cdecl, importc: "TCOD_console_get_fade", dynlib: LIB_NAME.}

proc consoleGetFadingColor*(): Color {.
    cdecl, importc: "TCOD_console_get_fading_color", dynlib: LIB_NAME.}

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
  ##

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

proc consoleNew*(
  w, h: cint): Console {.
    cdecl, importc: "TCOD_console_new", dynlib: LIB_NAME.}

proc consoleGetWidth*(
  con: Console): cint {.
    cdecl, importc: "TCOD_console_get_width", dynlib: LIB_NAME.}

proc consoleGetHeight*(
  con: Console): cint {.
    cdecl, importc: "TCOD_console_get_height", dynlib: LIB_NAME.}

proc consoleSetKeyColor*(
  con: Console; col: Color) {.
    cdecl, importc: "TCOD_console_set_key_color", dynlib: LIB_NAME.}

proc consoleBlit*(
  src: Console; xSrc, ySrc, wSrc, hSrc: cint;
  dst: Console; xDst, yDst: cint;
  foregroundAlpha, backgroundAlpha: cfloat) {.
    cdecl, importc: "TCOD_console_blit", dynlib: LIB_NAME.}

proc consoleDelete*(
  console: Console) {.
    cdecl, importc: "TCOD_console_delete", dynlib: LIB_NAME.}

proc consoleCredits*() {.
    cdecl, importc: "TCOD_console_credits", dynlib: LIB_NAME.}

proc consoleCreditsReset*() {.
    cdecl, importc: "TCOD_console_credits_reset", dynlib: LIB_NAME.}

proc consoleCreditsRender*(
  x, y: cint; alpha: bool): bool {.
    cdecl, importc: "TCOD_console_credits_render", dynlib: LIB_NAME.}

