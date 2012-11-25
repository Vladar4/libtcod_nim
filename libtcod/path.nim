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


type
  PPathFunc* = proc(xFrom, yFrom, xTo, yTo: int, user_data: pointer): float32 {.cdecl.}
  PPath* = pointer

const
  DEFAULT_DIAGONAL_COST* = 1.41'f32

#TCODLIB_API TCOD_path_t TCOD_path_new_using_map(TCOD_map_t map, float diagonalCost);
proc path_new_using_map*(map: PMap, diagonalCost=DEFAULT_DIAGONAL_COST): PPath {.cdecl, importc: "TCOD_path_new_using_map", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_path_t TCOD_path_new_using_function(int map_width, int map_height, TCOD_path_func_t func, void *user_data, float diagonalCost);
proc path_new_using_function*(map_width, map_height: int, func: PPathFunc, user_data: pointer = nil, diagonalCost=DEFAULT_DIAGONAL_COST): PPath {.cdecl, importc: "TCOD_path_new_using_function", dynlib: LIB_NAME.}


#TCODLIB_API bool TCOD_path_compute(TCOD_path_t path, int ox,int oy, int dx, int dy);
proc path_compute*(path: PPath, ox, oy, dx, dy: int): bool {.cdecl, importc: "TCOD_path_compute", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_path_walk(TCOD_path_t path, int *x, int *y, bool recalculate_when_needed);
proc path_walk*(path: PPath, x, y: ptr int, recalculate_when_needed: bool): bool {.cdecl, importc: "TCOD_path_walk", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_path_is_empty(TCOD_path_t path);
proc path_is_empty*(path: PPath): bool {.cdecl, importc: "TCOD_path_is_empty", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_path_size(TCOD_path_t path);
proc path_size*(path: PPath): int {.cdecl, importc: "TCOD_path_size", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_path_reverse(TCOD_path_t path);
proc path_reverse*(path: PPath) {.cdecl, importc: "TCOD_path_reverse", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_path_get(TCOD_path_t path, int index, int *x, int *y);
proc path_get*(path: PPath, index: int, x, y: ptr int) {.cdecl, importc: "TCOD_path_get", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_path_get_origin(TCOD_path_t path, int *x, int *y);
proc path_get_origin*(path: PPath, x, y: ptr int) {.cdecl, importc: "TCOD_path_get_origin", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_path_get_destination(TCOD_path_t path, int *x, int *y);
proc path_get_destination*(path: PPath, x, y: ptr int) {.cdecl, importc: "TCOD_path_get_destination", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_path_delete(TCOD_path_t path);
proc path_delete*(path: PPath) {.cdecl, importc: "TCOD_path_delete", dynlib: LIB_NAME.}


# Dijkstra stuff - by Mingos

type
  PDijkstra* = pointer

#TCODLIB_API TCOD_dijkstra_t TCOD_dijkstra_new (TCOD_map_t map, float diagonalCost);
proc dijkstra_new*(map: PMap, diagonalCost=DEFAULT_DIAGONAL_COST): PDijkstra {.cdecl, importc: "TCOD_dijkstra_new", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_dijkstra_t TCOD_dijkstra_new_using_function(int map_width, int map_height, TCOD_path_func_t func, void *user_data, float diagonalCost);
proc dijkstra_new_using_function*(map_width, map_height: int, func: PPathFunc, user_data: pointer = nil, diagonalCost=DEFAULT_DIAGONAL_COST): PDijkstra {.cdecl, importc: "TCOD_dijkstra_new_using_function", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_dijkstra_compute (TCOD_dijkstra_t dijkstra, int root_x, int root_y);
proc dijkstra_compute*(dijkstra: PDijkstra, root_x, root_y: int) {.cdecl, importc: "TCOD_dijkstra_compute", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_dijkstra_get_distance (TCOD_dijkstra_t dijkstra, int x, int y);
proc dijkstra_get_distance*(dijkstra: PDijkstra, x, y: int): float32 {.cdecl, importc: "TCOD_dijkstra_get_distance", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_dijkstra_path_set (TCOD_dijkstra_t dijkstra, int x, int y);
proc dijkstra_path_set*(dijkstra: PDijkstra, x, y: int): bool {.cdecl, importc: "TCOD_dijkstra_path_set", dynlib: LIB_NAME.}


#TCODLIB_API bool TCOD_dijkstra_is_empty(TCOD_dijkstra_t path);
proc dijkstra_is_empty*(path: PDijkstra): bool {.cdecl, importc: "TCOD_dijkstra_is_empty", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_dijkstra_size(TCOD_dijkstra_t path);
proc dijkstra_size*(path: PDijkstra): int {.cdecl, importc: "TCOD_dijkstra_size", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_dijkstra_reverse(TCOD_dijkstra_t path);
proc dijkstra_reverse*(path: PDijkstra) {.cdecl, importc: "TCOD_dijkstra_reverse", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_dijkstra_get(TCOD_dijkstra_t path, int index, int *x, int *y);
proc dijkstra_get*(path: PDijkstra, index: int, x, y: ptr int) {.cdecl, importc: "TCOD_dijkstra_get", dynlib: LIB_NAME.}


#TCODLIB_API bool TCOD_dijkstra_path_walk (TCOD_dijkstra_t dijkstra, int *x, int *y);
proc dijkstra_path_walk*(dijkstra: PDijkstra, x, y: ptr int): bool {.cdecl, importc: "TCOD_dijkstra_path_walk", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_dijkstra_delete (TCOD_dijkstra_t dijkstra);
proc dijkstra_delete*(dijkstra: PDijkstra) {.cdecl, importc: "TCOD_dijkstra_delete", dynlib: LIB_NAME.}

