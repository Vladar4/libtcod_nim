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
  BkgndFlag* {.size: sizeof(cint).} = enum
    BKGND_NONE, BKGND_SET, BKGND_MULTIPLY, BKGND_LIGHTEN, BKGND_DARKEN,
    BKGND_SCREEN, BKGND_COLOR_DODGE, BKGND_COLOR_BURN, BKGND_ADD, BKGND_ADDA,
    BKGND_BURN, BKGND_OVERLAY, BKGND_ALPH, BKGND_DEFAULT


type
  Alignment* {.size: sizeof(cint).} = enum  ##  \
    ##  Print justification options.
    ##
    LEFT, RIGHT, CENTER

  ConsoleTile* {.bycopy.} = object
    ch*: cint       ## The Unicode codepoint for this tile.
    fg*: ColorRGBA  ## The tile glyph color, rendered on top of the background
    bg*: ColorRGBA  ## The tile background color, rendered behind the glyph.

  Console* = ptr ConsoleObj
  ConsoleObj* {.bycopy.} = object   ##  \
    ##  Private console object.
    ##
    ##  All attributes should be considered private.
    ##
    w*, h*: cint            ##  \
      ##  Console width and height (in characters, not pixels.)
    tiles*: ptr ConsoleTile ##  \
      ##  A contiguous array of console tiles.
    bkgndFlag*: BkgndFlag ##  \
      ##  Default background operator for print & printRect procedures.
    alignment*: Alignment ##  \
      ##  Default alignment for print & printRect procedures.
    fore*, back*: Color   ##  \
      ##  Foreground (text) and background colors.
    hasKeyColor*: bool    ##  \
      ##  `true` if a key color is being used.
    keyColor*: Color      ##  \
      ##  The current key color for this console.

proc consoleNew*(
  w, h: cint): Console {.
    cdecl, importc: "TCOD_console_new", dynlib: LIB_NAME.}
  ##  Return a new console with a specific number of columns and rows.
  ##
  ##  ``w`` Number of columns.
  ##
  ##  ``h`` Number of rows.
  ##
  ##  ``Return`` a pointer to the new console, or `nil` on error.

proc consoleGetWidth*(
  con: Console): cint {.
    cdecl, importc: "TCOD_console_get_width", dynlib: LIB_NAME.}
  ##  ``Return`` the width of a console.

proc consoleGetHeight*(
  con: Console): cint {.
    cdecl, importc: "TCOD_console_get_height", dynlib: LIB_NAME.}
  ##  ``Return`` the height of a console.

proc consoleSetKeyColor*(
  con: Console; col: Color) {.
    cdecl, importc: "TCOD_console_set_key_color", dynlib: LIB_NAME.}

proc consoleBlit*(
  src: Console; xSrc, ySrc, wSrc, hSrc: cint;
  dst: Console; xDst, yDst: cint;
  foregroundAlpha: cfloat = 1.0;
  backgroundAlpha: cfloat = 1.0) {.
    cdecl, importc: "TCOD_console_blit", dynlib: LIB_NAME.}
  ##  Blit from one console to another.
  ##
  ##  ``src``   Pointer to the source console.
  ##
  ##  ``xSrc``  The left region of the source console to blit from.
  ##
  ##  ``ySrc``  The top region of the source console to blit from.
  ##
  ##  ``wSrc``  The width of the region to blit from.
  ##            If `0` then it will fill to the maximum width.
  ##
  ##  ``hSrc``  The height of the region to blit from.
  ##            If `0` then it will fill to the maximum height.
  ##
  ##  ``dst``   Pointer to the destination console.
  ##
  ##  ``xDst``  The left corner to blit onto the destination console.
  ##
  ##  ``yDst``  The top corner to blit onto the destination console.
  ##
  ##  ``foregroundAlpha`` Foreground blending alpha.
  ##
  ##  ``backgroundAlpha`` Background blending alpha.
  ##
  ##  If the source console has a key color, this function will use it.

proc consoleBlitKeyColor*(
  src: Console; xSrc, ySrc, wSrc, hSrc: cint;
  dst: Console; xDst, yDst: cint;
  foregroundAlpha: cfloat = 1.0;
  backgroundAlpha: cfloat = 1.0;
  keyColor: ptr Color) {.
    cdecl, importc: "TCOD_console_blit_key_color", dynlib: LIB_NAME.}

proc consoleDelete_internal(
  console: Console) {.
    cdecl, importc: "TCOD_console_delete", dynlib: LIB_NAME.}

proc consoleDelete*(con: var Console) =
  ##  Delete a console.
  ##
  ##  ``con`` A console pointer.
  ##
  ##  If the console being deleted is the root console,
  ##  then the display will be uninitialized.
  if not (con == nil):
    consoleDelete_internal(con)
    con = nil
proc consoleSetDefaultBackground*(
  con: Console; col: Color) {.
    cdecl, importc: "TCOD_console_set_default_background", dynlib: LIB_NAME.}

proc consoleSetDefaultForeground*(
  con: Console; col: Color) {.
    cdecl, importc: "TCOD_console_set_default_foreground", dynlib: LIB_NAME.}

proc consoleClear*(
  con: Console) {.
    cdecl, importc: "TCOD_console_clear", dynlib: LIB_NAME.}
  ##  Clear a console to its default colors and the space character code.
  ##

proc consoleSetCharBackground*(
  con: Console; x, y: cint; col: Color; flag: BkgndFlag = BKGND_SET) {.
    cdecl, importc: "TCOD_console_set_char_background", dynlib: LIB_NAME.}
  ##  Blend a background color onto a console tile.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The Y coordinate, the top-most position being `0`.
  ##
  ##  ``col``   The background color to blend.
  ##
  ##  ``flag``  The blend mode to use.

proc consoleSetCharForeground*(
  con: Console; x, y: cint; col: Color) {.
    cdecl, importc: "TCOD_console_set_char_foreground", dynlib: LIB_NAME.}
  ##  Change the foreground color of a console tile.
  ##
  ##  ``con`` A console pointer.
  ##
  ##  ``x``   The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``   The Y coordinate, the top-most position being `0`.
  ##
  ##  ``col`` The foreground color to set.

proc consoleSetChar*(
  con: Console; x, y, c: cint) {.
    cdecl, importc: "TCOD_console_set_char", dynlib: LIB_NAME.}
  ##  Change a character on a console tile, without changing its colors.
  ##
  ##  ``con`` A console pointer.
  ##
  ##  ``x``   The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``   The Y coordinate, the top-most position being `0`.
  ##
  ##  ``c``   The character code to set.

template consoleSetChar*(con: Console; x, y: cint; c: char) =
  consoleSetChar(con, x, y, c.cint)

proc consolePutChar*(
  con: Console; x, y, c: cint; flag: BkgndFlag = BKGND_DEFAULT) {.
    cdecl, importc: "TCOD_console_put_char", dynlib: LIB_NAME.}
  ##  Draw a character on a console using the default colors.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The Y coordinate, the top-most position being `0`.
  ##
  ##  ``c``     The character code to place.
  ##
  ##  ``flag``  A ``BkgndFlag`` flag.

template consolePutChar*(con: Console; x, y: cint; c: char;
                         flag: BkgndFlag = BKGND_DEFAULT) =
  consolePutChar(con, x, y, c.cint, flag)

proc consolePutCharEx*(
  con: Console; x, y, c: cint; fore, back: Color) {.
    cdecl, importc: "TCOD_console_put_char_ex", dynlib: LIB_NAME.}
  ##  Draw a character on the console with the given colors.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The Y coordinate, the top-most position being `0`.
  ##
  ##  ``c``     The character code to place.
  ##
  ##  ``fore``  The foreground color.
  ##
  ##  ``back``  The background color.  This color will not be blended.

template consolePutCharEx*(con: Console; x, y: cint; c: char; fore, back: Color) =
  consolePutCharEx(con, x, y, c.cint, fore, back)

proc consoleSetBackgroundFlag*(
  con: Console; flag: BkgndFlag) {.
    cdecl, importc: "TCOD_console_set_background_flag", dynlib: LIB_NAME.}
  ##  Set a consoles default background flag.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``flag``  One of ``BkgndFlag``.

proc consoleGetBackgroundFlag*(
  con: Console): BkgndFlag {.
    cdecl, importc: "TCOD_console_get_background_flag", dynlib: LIB_NAME.}
  ##  ``Return`` a consoles default background flags.

proc consoleSetAlignment*(
  con: Console; alignment: Alignment) {.
    cdecl, importc: "TCOD_console_set_alignment", dynlib: LIB_NAME.}
  ##  Set a consoles default alignment.
  ##
  ##  ``con``       A console pointer.
  ##
  ##  ``alignment`` One of ``Alignment``.

proc consoleGetAlignment*(
  con: Console): Alignment {.
    cdecl, importc: "TCOD_console_get_alignment", dynlib: LIB_NAME.}
  ##  ``Return`` a consoles default alignment.

proc consoleGetDefaultBackground*(
  con: Console): Color {.
    cdecl, importc: "TCOD_console_get_default_background", dynlib: LIB_NAME.}

proc consoleGetDefaultForeground*(
  con: Console): Color {.
    cdecl, importc: "TCOD_console_get_default_foreground", dynlib: LIB_NAME.}

proc consoleGetCharBackground*(
  con: Console; x, y: cint): Color {.
    cdecl, importc: "TCOD_console_get_char_background", dynlib: LIB_NAME.}
  ##  Return the background color of a console at `x,y`.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The Y coordinate, the top-most position being `0`.
  ##
  ##  ``Return`` a ``Color`` tuple with a copy of the background color.

proc consoleGetCharForeground*(
  con: Console; x, y: cint): Color {.
    cdecl, importc: "TCOD_console_get_char_foreground", dynlib: LIB_NAME.}
  ##  Return the foreground color of a console at `x,y`.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The Y coordinate, the top-most position being `0`.
  ##
  ##  ``Return`` a ``Color`` tuple with a copy of the foreground color.

proc consoleGetChar*(
  con: Console; x, y: cint): cint {.
    cdecl, importc: "TCOD_console_get_char", dynlib: LIB_NAME.}
  ##  Return a character code of a console at `x,y`.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The Y coordinate, the top-most position being `0`.
  ##
  ##  ``Return`` the character code.

proc consoleSetFade*(
  val: uint8; fade: Color) {.
    cdecl, importc: "TCOD_console_set_fade", dynlib: LIB_NAME.}
  ##  Fade the color of the display.
  ##
  ##  ``val``     Where at `255` colors are normal
  ##              and at `0` colors are completely faded.
  ##
  ##  ``fadecol`` Color to fade towards.

proc consoleGetFade*(): uint8 {.
    cdecl, importc: "TCOD_console_get_fade", dynlib: LIB_NAME.}
  ##  ``Return`` the fade value.
  ##
  ##  ``Return`` at `255` colors are normal
  ##  and at `0` colors are completely faded.

proc consoleGetFadingColor*(): Color {.
    cdecl, importc: "TCOD_console_get_fading_color", dynlib: LIB_NAME.}
  ##  Return the fade color.
  ##
  ##  ``Return`` the current fading color.

proc consoleResize*(con: Console; w, h: cint) {.
    cdecl, importc: "TCOD_console_resize_", dynlib: LIB_NAME.}

