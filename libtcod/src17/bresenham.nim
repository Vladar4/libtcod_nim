#
# libtcod
# Copyright (c) 2008-2018 Jice & Mingos & rmtew
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * The name of Jice or Mingos may not be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY JICE, MINGOS AND RMTEW ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL JICE, MINGOS OR RMTEW BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

type
  LineListener* = proc (x, y: cint): bool {.cdecl.} ##  \
    ##  A callback to be passed to ``line``
    ##
    ##  The points given to the callback include both the starting and ending
    ##  positions.
    ##
    ##  As long as this callback returns true it will be called with the
    ##  next ``x,y`` point on the line.
    ##

proc lineInit*(
  xFrom, yFrom, xTo, yTo: cint) {.
    cdecl, importc: "TCOD_line_init", dynlib: LIB_NAME, deprecated.}

proc lineStep*(
  xCur, yCur: ptr cint): bool {.
    cdecl, importc: "TCOD_line_step", dynlib: LIB_NAME, deprecated.}
  ##  Advance one step.
  ##
  ##  ``Returns`` `true` if we reach destination.
  ##

proc line*(
  xFrom, yFrom, xTo, yTo: cint; listener: LineListener): bool {.
    cdecl, importc: "TCOD_line", dynlib: LIB_NAME.}
  ##  Atomic callback procedure. Stops when the callback returns false.
  ##


type
  BresenhamData* {.bycopy.} = object ## \
    ##  A struct used for computing a bresenham line.
    ##
    stepx*, stepy*: cint
    e*: cint
    deltax*, deltay*: cint
    origx*, origy*: cint
    destx*, desty*: cint


proc lineInitMt*(
  xFrom, yFrom, xTo, yTo: cint; data: ptr BresenhamData) {.
    cdecl, importc: "TCOD_line_init_mt", dynlib: LIB_NAME.}

proc lineStepMt*(
  xCur, yCur: ptr cint; data: ptr BresenhamData): bool {.
    cdecl, importc: "TCOD_line_step_mt", dynlib: LIB_NAME.}

proc lineMt*(
  xFrom, yFrom, xTo, yTo: cint;
  listener: LineListener; data: ptr BresenhamData): bool {.
    cdecl, importc: "TCOD_line_mt", dynlib: LIB_NAME, deprecated.}

