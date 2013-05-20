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


include
  fov_types


type
  PMap* = pointer


# allocate a new map
#TCODLIB_API TCOD_map_t TCOD_map_new(int width, int height);
proc map_new*(width, height: int): PMap {.cdecl, importc: "TCOD_map_new", dynlib: LIB_NAME.}

# set all cells as solid rock (cannot see through nor walk)
#TCODLIB_API void TCOD_map_clear(TCOD_map_t map, bool transparent, bool walkable);
proc map_clear*(map: PMap, transparent, walkable: bool) {.cdecl, importc: "TCOD_map_clear", dynlib: LIB_NAME.}

# copy a map to another, reallocating it when needed
#TCODLIB_API void TCOD_map_copy(TCOD_map_t source, TCOD_map_t dest);
proc map_copy*(source, dest: PMap) {.cdecl, importc: "TCOD_map_copy", dynlib: LIB_NAME.}

# change a cell properties
#TCODLIB_API void TCOD_map_set_properties(TCOD_map_t map, int x, int y, bool is_transparent, bool is_walkable);
proc map_set_properties*(map: PMap, x, y: int, is_transparent, is_walkable: bool) {.cdecl, importc: "TCOD_map_set_properties", dynlib: LIB_NAME.}

# destroy a map
#TCODLIB_API void TCOD_map_delete(TCOD_map_t map);
proc TCOD_map_delete(map: PMap) {.cdecl, importc: "TCOD_map_delete", dynlib: LIB_NAME.}
proc map_delete*(map: var PMap) =
  if map != nil:
    TCOD_map_delete(map)
    map = nil


# calculate the field of view (potentially visible cells from player_x,player_y)
#TCODLIB_API void TCOD_map_compute_fov(TCOD_map_t map, int player_x, int player_y, int max_radius, bool light_walls, TCOD_fov_algorithm_t algo);
proc map_compute_fov*(map: PMap, player_x, player_y: int, max_radius=0, light_walls=true, algo: TFOVAlgorithm = FOV_BASIC) {.cdecl, importc: "TCOD_map_compute_fov", dynlib: LIB_NAME.}


# check if a cell is in the last computed field of view
#TCODLIB_API bool TCOD_map_is_in_fov(TCOD_map_t map, int x, int y);
proc map_is_in_fov*(map: PMap, x, y: int): bool {.cdecl, importc: "TCOD_map_is_in_fov", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_map_set_in_fov(TCOD_map_t map, int x, int y, bool fov);
proc map_set_in_fov*(map: PMap, x, y: int, fov: bool) {.cdecl, importc: "TCOD_map_set_in_fov", dynlib: LIB_NAME.}


# retrieve properties from the map
#TCODLIB_API bool TCOD_map_is_transparent(TCOD_map_t map, int x, int y);
proc map_is_transparent*(map: PMap, x, y: int): bool {.cdecl, importc: "TCOD_map_is_transparent", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_map_is_walkable(TCOD_map_t map, int x, int y);
proc map_is_walkable*(map: PMap, x, y: int): bool {.cdecl, importc: "TCOD_map_is_walkable", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_map_get_width(TCOD_map_t map);
proc map_get_width*(map: PMap): int {.cdecl, importc: "TCOD_map_get_width", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_map_get_height(TCOD_map_t map);
proc map_get_height*(map: PMap): int {.cdecl, importc: "TCOD_map_get_height", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_map_get_nb_cells(TCOD_map_t map);
proc map_get_nb_cells*(map: PMap): int {.cdecl, importc: "TCOD_map_get_nb_cells", dynlib: LIB_NAME.}

