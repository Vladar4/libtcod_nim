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

proc consolePrint*(
  con: Console; x, y: cint; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_print", dynlib: LIB_NAME,
    deprecated: "Use consolePrintf() instead".}

proc consolePrintEx*(
  con: Console; x, y: cint; flag: BkgndFlag;
  alignment: Alignment; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_print_ex", dynlib: LIB_NAME,
    deprecated: "Use consolePrintfEx() instead".}

proc consolePrintRect*(
  con: Console; x, y, w, h: cint; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_print_rect", dynlib: LIB_NAME,
    deprecated: "Use consolePrintfRect() instead".}

proc consolePrintRectEx*(
  con: Console; x, y, w, h: cint; flag: BkgndFlag;
  alignment: Alignment; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_print_rect_ex", dynlib: LIB_NAME,
    deprecated: "Use consolePrintfRectEx() instead".}

proc consolePrintFrame*(
  con: Console; x, y, w, h: cint; empty: bool;
  flag: BkgndFlag; fmt: cstring = nil) {.
    varargs, cdecl, importc: "TCOD_console_print_frame", dynlib: LIB_NAME,
    deprecated: "Use consolePrintfFrame() instead".}

proc consoleGetHeightRect*(
  con: Console; x, y, w, h: cint; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_get_height_rect", dynlib: LIB_NAME,
    deprecated: "Used consoleGetHeightRectFmt() instead".}

when not defined(NO_UNICODE):

  when defined(linux):
    import unicode

    # modified for linux (cint) WideCString from Nim's system/widestrs.nim

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

  # end of linux fix block

  proc consoleMapStringToFontUtf*(
    s: WideCString; fontCharX, fontCharY: cint) {.
      cdecl, importc: "TCOD_console_map_string_to_font_utf", dynlib: LIB_NAME.}

  proc consoleMapStringToFontUtf*(s: string, fontCharX, fontCharY: cint) =
    var wcs = newWCS(s)
    consoleMapStringToFontUtf(wcs, fontCharX, fontCharY)


  proc consolePrintUtf*(
    con: Console; x, y: cint; fmt: WideCString) {.
      varargs, cdecl, importc: "TCOD_console_print_utf", dynlib: LIB_NAME,
      deprecated: "Use consolePrintf() instead".}

  proc consolePrintUtf*(con: Console, x, y: cint, fmt: string) {.deprecated.} =
    var wcs = newWCS(fmt)
    {.push warnings: off.}
    consolePrintUtf(con, x, y, wcs)
    {.pop.}

  proc consolePrintExUtf*(
    con: Console; x, y: cint; flag: BkgndFlag; alignment: Alignment;
    fmt: WideCString) {.
      varargs, cdecl, importc: "TCOD_console_print_ex_utf", dynlib: LIB_NAME,
      deprecated: "Use consolePrintfEx() instead".}

  proc consolePrintExUtf*(con: Console, x, y: cint, flag: BkgndFlag,
                          alignment: Alignment, fmt: string) {.deprecated.} =
    var wcs = newWCS(fmt)
    {.push warnings: off.}
    consolePrintExUtf(con, x, y, flag, alignment, wcs)
    {.pop.}


  proc consolePrintRectUtf*(
    con: Console; x, y, w, h: cint; fmt: WideCString): cint {.
      varargs, cdecl, importc: "TCOD_console_print_rect_utf", dynlib: LIB_NAME,
      deprecated: "Use consolePrintfRect() instead".}

  proc consolePrintRectUtf*(con: Console, x, y, w, h: cint,
                            fmt: string): cint {.deprecated.} =
    var wcs = newWCS(fmt)
    {.push warnings: off.}
    result = consolePrintRectUtf(con, x, y, w, h, wcs)
    {.pop.}


  proc consolePrintRectExUtf*(
    con: Console; x, y, w, h: cint; flag: BkgndFlag; alignment: Alignment;
    fmt: WideCString): cint {.
      varargs,
      cdecl, importc: "TCOD_console_print_rect_ex_utf", dynlib: LIB_NAME,
      deprecated: "Use consolePrintfRectEx() instead".}

  proc consolePrintRectExUtf*(con: Console, x, y, w, h: cint,
                              flag: BkgndFlag, alignment: Alignment,
                              fmt: string): cint {.deprecated.} =
    var wcs = newWCS(fmt)
    {.push warnings: off.}
    result = consolePrintRectExUtf(con, x, y, w, h, flag, alignment, wcs)
    {.pop.}


  proc consoleGetHeightRectUtf*(
    con: Console; x, y, w, h: cint; fmt: WideCString): cint {.
      varargs,
      cdecl, importc: "TCOD_console_get_height_rect_utf", dynlib: LIB_NAME,
      deprecated: "Use consoleGetHeightRectFmt() instead".}

  proc consoleGetHeightRectUtf*(con: Console, x, y, w, h: cint,
                                fmt: string): cint {.
      deprecated: "Use consoleGetHeightRectFmt() instead".} =
    var wcs = newWCS(fmt)
    {.push warnings: off.}
    result = console_get_height_rect_utf(con, x, y, w, h, wcs)
    {.pop.}

# ^ when not defined(NO_UNICODE)


#  UTF-8 functions

# TCODLIB_FORMAT(4, 5)
proc consolePrintf*(
  con: Console; x, y: cint; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_printf", dynlib: LIB_NAME.}

# TCODLIB_FORMAT(6, 7)
proc consolePrintfEx*(
  con: Console; x, y: cint; flag: BkgndFlag; alignment: Alignment;
  fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_printf_ex", dynlib: LIB_NAME.}

# TCODLIB_FORMAT(6, 7)
proc consolePrintfRect*(
  con: Console; x, y, w, h: cint; fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_printf_rect", dynlib: LIB_NAME.}

# TCODLIB_FORMAT(8, 9)
proc consolePrintfRectEx*(
  con: Console; x, y, w, h: cint; flag: BkgndFlag; alignment: Alignment;
  fmt: cstring): cint {.
    varargs, cdecl, importc: "TCOD_console_printf_rect_ex", dynlib: LIB_NAME.}

# TCODLIB_FORMAT(8, 9)
proc consolePrintfFrame*(
  con: Console; x, y, w, h: cint; empty: bool; flag: BkgndFlag; fmt: cstring) {.
    varargs, cdecl, importc: "TCOD_console_printf_frame", dynlib: LIB_NAME.}

# TCODLIB_FORMAT(6, 7)
proc consoleGetHeightRectFmt*(
  con: Console; x, y, w, h: cint; fmt: cstring): cint {.
    varargs,
    cdecl, importc: "TCOD_console_get_height_rect_fmt", dynlib: LIB_NAME.}


#  Private internal functions.
#[ REMOVED IN 1.10.6

proc consolePrintInternalUtf8*(
  con: Console; x, y, maxWidth, maxHeight: cint;
  flag: BkgndFlag; align: Alignment; string: ptr cuchar;
  canSplit: cint; countOnly: cint): cint {.
    cdecl, importc: "TCOD_console_print_internal_utf8_", dynlib: LIB_NAME.}
]#

