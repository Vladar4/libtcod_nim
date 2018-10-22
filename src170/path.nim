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

# import fov_types

type
  PathProc* = proc (
    xFrom, yFrom, xTo, yTo: cint; userData: pointer): cfloat {.cdecl.}
  Path* = pointer


const
  DEFAULT_DIAGONAL_COST*: cfloat = 1.41


proc pathNewUsingMap*(
  map: Map; diagonalCost: cfloat = DEFAULT_DIAGONAL_COST): Path {.
    cdecl, importc: "TCOD_path_new_using_map", dynlib: LIB_NAME.}

proc pathNewUsingProcedure*(
  mapWidth, mapHeight: cint; procedure: PathProc;
  userData: pointer; diagonalCost: cfloat = DEFAULT_DIAGONAL_COST): Path {.
    cdecl, importc: "TCOD_path_new_using_function", dynlib: LIB_NAME.}

proc pathCompute*(
  path: Path; ox, oy, dx, dy: cint): bool {.
    cdecl, importc: "TCOD_path_compute", dynlib: LIB_NAME.}

proc pathWalk*(
  path: Path; x, y: ptr cint; recalculateWhenNeeded: bool): bool {.
    cdecl, importc: "TCOD_path_walk", dynlib: LIB_NAME.}

proc pathIsEmpty*(
  path: Path): bool {.
    cdecl, importc: "TCOD_path_is_empty", dynlib: LIB_NAME.}

proc pathSize*(
  path: Path): cint {.
    cdecl, importc: "TCOD_path_size", dynlib: LIB_NAME.}

proc pathReverse*(
  path: Path) {.
    cdecl, importc: "TCOD_path_reverse", dynlib: LIB_NAME.}

proc pathGet*(
  path: Path; index: cint; x, y: ptr cint) {.
    cdecl, importc: "TCOD_path_get", dynlib: LIB_NAME.}

proc pathGetOrigin*(
  path: Path; x, y: ptr cint) {.
    cdecl, importc: "TCOD_path_get_origin", dynlib: LIB_NAME.}

proc pathGetDestination*(
  path: Path; x, y: ptr cint) {.
    cdecl, importc: "TCOD_path_get_destination", dynlib: LIB_NAME.}

proc pathDelete_internal(
  path: Path) {.
    cdecl, importc: "TCOD_path_delete", dynlib: LIB_NAME.}

proc pathDelete*(path: var Path) =
  if path != nil:
    pathDelete_internal(path)
    path = nil


#  Dijkstra stuff - by Mingos

type
  Dijkstra* = pointer

proc dijkstraNew*(
  map: Map; diagonalCost: cfloat = DEFAULT_DIAGONAL_COST): Dijkstra {.
    cdecl, importc: "TCOD_dijkstra_new", dynlib: LIB_NAME.}

proc dijkstraNewUsingProcedure*(
  mapWidth, mapHeight: cint; procedure: PathProc;
  userData: pointer; diagonalCost: cfloat = DEFAULT_DIAGONAL_COST): Dijkstra {.
    cdecl, importc: "TCOD_dijkstra_new_using_function", dynlib: LIB_NAME.}

proc dijkstraCompute*(
  dijkstra: Dijkstra; rootX, rootY: cint) {.
    cdecl, importc: "TCOD_dijkstra_compute", dynlib: LIB_NAME.}

proc dijkstraGetDistance*(
  dijkstra: Dijkstra; x, y: cint): cfloat {.
    cdecl, importc: "TCOD_dijkstra_get_distance", dynlib: LIB_NAME.}

proc dijkstraPathSet*(
  dijkstra: Dijkstra; x, y: cint): bool {.
    cdecl, importc: "TCOD_dijkstra_path_set", dynlib: LIB_NAME.}

proc dijkstraIsEmpty*(
  path: Dijkstra): bool {.
    cdecl, importc: "TCOD_dijkstra_is_empty", dynlib: LIB_NAME.}

proc dijkstraSize*(
  path: Dijkstra): cint {.
    cdecl, importc: "TCOD_dijkstra_size", dynlib: LIB_NAME.}

proc dijkstraReverse*(
  path: Dijkstra) {.
    cdecl, importc: "TCOD_dijkstra_reverse", dynlib: LIB_NAME.}

proc dijkstraGet*(
  path: Dijkstra; index: cint; x, y: ptr cint) {.
    cdecl, importc: "TCOD_dijkstra_get", dynlib: LIB_NAME.}

proc dijkstraPathWalk*(
  dijkstra: Dijkstra; x, y: ptr cint): bool {.
    cdecl, importc: "TCOD_dijkstra_path_walk", dynlib: LIB_NAME.}

proc dijkstraDelete_internal(
  dijkstra: Dijkstra) {.
    cdecl, importc: "TCOD_dijkstra_delete", dynlib: LIB_NAME.}

proc dijkstraDelete*(dijkstra: var Dijkstra) =
  if dijkstra != nil:
    dijkstraDelete_internal(dijkstra)
    dijkstra = nil

