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


#typedef bool (*TCOD_line_listener_t) (int x, int y);
type
  PLineListener* = proc(x, y: int): bool {.cdecl.}


#TCODLIB_API void TCOD_line_init(int xFrom, int yFrom, int xTo, int yTo);
proc line_init*(xFrom, yFrom, xTo, yTo: int) {.cdecl, importc: "TCOD_line_init", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_line_step(int *xCur, int *yCur); # advance one step. returns true if we reach destination
proc line_step*(xCur, yCur: ptr int): bool {.cdecl, importc: "TCOD_line_step", dynlib: LIB_NAME.}

# atomic callback function. Stops when the callback returns false
#TCODLIB_API bool TCOD_line(int xFrom, int yFrom, int xTo, int yTo, TCOD_line_listener_t listener);
proc line*(xFrom, yFrom, xTo, yTo: int, listener: PLineListener): bool {.cdecl, importc: "TCOD_line", dynlib: LIB_NAME.}


# thread-safe versions
type
  PBresenhamData* = ptr TBresenhamData
  TBresenhamData*{.bycopy.} = object
    stepx*: int32
    stepy*: int32
    e*: int32
    deltax*: int32
    deltay*: int32
    origx*: int32
    origy*: int32
    destx*: int32
    desty*: int32


#TCODLIB_API void TCOD_line_init_mt(int xFrom, int yFrom, int xTo, int yTo, TCOD_bresenham_data_t *data);
proc line_init_mt*(xFrom, yFrom, xTo, yTo, data: PBresenhamData) {.cdecl, importc: "TCOD_line_init_mt", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_line_step_mt(int *xCur, int *yCur, TCOD_bresenham_data_t *data);
proc line_step_mt*(xCur, yCur: ptr int, data: PBresenhamData): bool {.cdecl, importc: "TCOD_line_step_mt", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_line_mt(int xFrom, int yFrom, int xTo, int yTo, TCOD_line_listener_t listener, TCOD_bresenham_data_t *data);
proc line_mt*(xFrom, yFrom, xTo, yTo: int, listener: PLineListener, data: PBresenhamData): bool {.cdecl, importc: "TCOD_line_mt", dynlib: LIB_NAME.}

