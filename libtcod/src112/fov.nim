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

# import fov_types


proc mapNew*(
  width, height: cint): Map {.
    cdecl, importc: "TCOD_map_new", dynlib: LIB_NAME.}
  ##  Allocate a new map.

proc mapClear*(
  map: Map; transparent: bool = false; walkable: bool = false) {.
    cdecl, importc: "TCOD_map_clear", dynlib: LIB_NAME.}
  ##  Set all cells as solid rock (cannot see through nor walk).

proc mapCopy*(
  source, dest: Map) {.
    cdecl, importc: "TCOD_map_copy", dynlib: LIB_NAME.}
  ##  Copy a map to another, reallocating it when needed.

proc mapSetProperties*(
  map: Map; x, y: cint; isTransparent, isWalkable: bool) {.
    cdecl, importc: "TCOD_map_set_properties", dynlib: LIB_NAME.}
  ##  Change a cell properties.

proc mapDelete_internal(
  map: Map) {.
    cdecl, importc: "TCOD_map_delete", dynlib: LIB_NAME.}

proc mapDelete*(map: var Map) =
  ##  Destroy a map.
  ##
  if map != nil:
    mapDelete_internal(map)
    map = nil

proc mapComputeFov*(
  map: Map; playerX, playerY: cint;
  maxRadius: cint = 0;
  lightWalls: bool = true;
  algo: FovAlgorithm = FOV_BASIC) {.
    cdecl, importc: "TCOD_map_compute_fov", dynlib: LIB_NAME.}
  ##  Calculate the field of view
  ##  (potentially visible cells from ``playerX, playerY``).

proc mapIsInFov*(
  map: Map; x, y: cint): bool {.
    cdecl, importc: "TCOD_map_is_in_fov", dynlib: LIB_NAME.}
  ##  Check if a cell is in the last computed field of view.

proc mapSetInFov*(
  map: Map; x, y: cint; fov: bool) {.
    cdecl, importc: "TCOD_map_set_in_fov", dynlib: LIB_NAME.}


proc mapIsTransparent*(
  map: Map; x, y: cint): bool {.
    cdecl, importc: "TCOD_map_is_transparent", dynlib: LIB_NAME.}
  ##  Retrieve properties from the map.

proc mapIsWalkable*(
  map: Map; x, y: cint): bool {.
    cdecl, importc: "TCOD_map_is_walkable", dynlib: LIB_NAME.}

proc mapGetWidth*(
  map: Map): cint {.
    cdecl, importc: "TCOD_map_get_width", dynlib: LIB_NAME.}

proc mapGetHeight*(
  map: Map): cint {.
    cdecl, importc: "TCOD_map_get_height", dynlib: LIB_NAME.}

proc mapGetNbCells*(
  map: Map): cint {.
    cdecl, importc: "TCOD_map_get_nb_cells", dynlib: LIB_NAME.}

