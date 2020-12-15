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
  Tileset* = pointer


proc tilesetNew*(
  tileWidth: cint; tileHeight: cint): Tileset {.
    cdecl, importc: "TCOD_tileset_new", dynlib: LIB_NAME.}
  ##  Create a new tile-set with the given tile size.

proc tilesetDelete*(
  tileset: Tileset) {.
    cdecl, importc: "TCOD_tileset_delete", dynlib: LIB_NAME.}
  ##  Delete a tile-set.

proc tilesetGetTileWidth*(
  tileset: Tileset): cint {.
    cdecl, importc: "TCOD_tileset_get_tile_width_", dynlib: LIB_NAME.}
  ##  ``Return`` the pixel width of tiles in this tileset.
  ##
  ##  ``Note:`` The tileset functions are provisional,
  ##  the API may change in the future.

proc tilesetGetTileHeight*(
  tileset: Tileset): cint {.
    cdecl, importc: "TCOD_tileset_get_tile_height_", dynlib: LIB_NAME.}
  ##   ``Return`` the pixel height of tiles in this tileset.
  ##
  ##   ``Note:`` The tileset functions are provisional,
  ##   the API may change in the future.

proc tilesetGetTile*(
  tileset: Tileset; codepoint: cint; buffer: ptr ColorRGBA): cint {.
    cdecl, importc: "TCOD_tileset_get_tile_", dynlib: LIB_NAME.}
  ##  Fetch a tile, outputting its data to a pixel buffer.
  ##
  ##  ``codepoint`` is the index for the tile.  Unicode is recommend.
  ##
  ##  ``buffer`` is a pointer to a contiguous row-major array of pixels.
  ##  The tile data will be outputted here.  This pointer can be `nil`
  ##  if you only want to know if the tileset has a specific tile.
  ##
  ##  ``Returns`` `0` if the tile exists. Returns a negative value on an error
  ##  or if the tileset does not have a tile for this codepoint.
  ##
  ##  ``Note:`` The tileset functions are provisional,
  ##  the API may change in the future.

proc tilesetSetTile*(
  tileset: Tileset; codepoint: cint; buffer: ptr ColorRGBA): cint {.
    cdecl, importc: "TCOD_tileset_set_tile_", dynlib: LIB_NAME.}
  ##  Upload a tile from a pixel buffer into this tileset.
  ##
  ##  ``codepoint`` is the index for the tile.  Unicode is recommend.
  ##
  ##  ``buffer`` is a pointer to a contiguous row-major array of pixels.
  ##  This can not be `nil`.
  ##
  ##  ``Note:`` The tileset functions are provisional,
  ##  the API may change in the future.

#
# truetype
#

proc loadTruetypeFont*(
  path: cstring; tileWidth: cint; tileHeight: cint): Tileset {.
    cdecl, importc: "TCOD_load_truetype_font_", dynlib: LIB_NAME.}
  ##  Return a tileset from a TrueType font file.

proc tilesetLoadTruetype*(
  path: cstring; tileWidth: cint; tileHeight: cint): cint {.
    cdecl, importc: "TCOD_tileset_load_truetype_", dynlib: LIB_NAME.}
  ##   Set the global tileset from a TrueType font file.

