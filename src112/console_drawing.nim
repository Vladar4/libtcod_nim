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

proc consoleRect*(
  con: Console; x, y, w, h: cint; clear: bool;
  flag: BkgndFlag = BKGND_DEFAULT) {.
    cdecl, importc: "TCOD_console_rect", dynlib: LIB_NAME.}
  ##  Draw a rectangle onto a console.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The starting region, the left-most position being `0`.
  ##
  ##  ``y``     The starting region, the top-most position being `0`.
  ##
  ##  ``rw``    The width of the rectangle.
  ##
  ##  ``rh``    The height of the rectangle.
  ##
  ##  ``clear`` If true the drawing region will be filled with spaces.
  ##
  ##  ``flag``  The blending flag to use.

proc consoleHline*(
  con: Console; x, y, l: cint;
  flag: BkgndFlag = BKGND_DEFAULT) {.
    cdecl, importc: "TCOD_console_hline", dynlib: LIB_NAME.}
  ##  Draw a horizontal line using the default colors.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The starting X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The starting Y coordinate, the top-most position being `0`.
  ##
  ##  ``l``     The width of the line.
  ##
  ##  ``flag``  The blending flag.
  ##
  ##  This function makes assumptions about the fonts character encoding.
  ##  It will fail if the font encoding is not `cp437`.

proc consoleVline*(
  con: Console; x, y, l: cint;
  flag: BkgndFlag = BKGND_DEFAULT) {.
    cdecl, importc: "TCOD_console_vline", dynlib: LIB_NAME.}
  ##  Draw a vertical line using the default colors.
  ##
  ##  ``con``   A console pointer.
  ##
  ##  ``x``     The starting X coordinate, the left-most position being `0`.
  ##
  ##  ``y``     The starting Y coordinate, the top-most position being `0`.
  ##
  ##  ``l``     The height of the line.
  ##
  ##  ``flag``  The blending flag.
  ##
  ##  This function makes assumptions about the fonts character encoding.
  ##  It will fail if the font encoding is not `cp437`.

