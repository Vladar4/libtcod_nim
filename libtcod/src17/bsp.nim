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

# import mersenne_types, tree

type
  Bsp* = ptr BspObj
  BspObj* {.bycopy.} = object ##  \
    ##
    tree*: TreeObj        ##  pseudo oop : bsp inherit tree
    x*, y*, w*, h*: cint  ##  node position & size
    position*: cint       ##  position of splitting
    level*: uint8         ##  level in the tree
    horizontal*: bool     ##  horizontal splitting ?

  BspCallback* = proc (node: Bsp; userData: pointer): bool {.cdecl.}

proc bspNew*(): Bsp {.
    cdecl, importc: "TCOD_bsp_new", dynlib: LIB_NAME.}

proc bspNewWithSize*(
  x, y, w, h: cint): Bsp {.
    cdecl, importc: "TCOD_bsp_new_with_size", dynlib: LIB_NAME.}

proc bspDelete_internal(
  node: Bsp) {.
    cdecl, importc: "TCOD_bsp_delete", dynlib: LIB_NAME.}

proc bspDelete*(node: var Bsp) =
  if not (node == nil):
    bspDelete_internal(node)
    node = nil

proc bspLeft*(
  node: Bsp): Bsp {.
    cdecl, importc: "TCOD_bsp_left", dynlib: LIB_NAME.}

proc bspRight*(
  node: Bsp): Bsp {.
    cdecl, importc: "TCOD_bsp_right", dynlib: LIB_NAME.}

proc bspFather*(
  node: Bsp): Bsp {.
    cdecl, importc: "TCOD_bsp_father", dynlib: LIB_NAME.}

proc bspIsLeaf*(
  node: Bsp): bool {.
    cdecl, importc: "TCOD_bsp_is_leaf", dynlib: LIB_NAME.}

proc bspTraversePreOrder*(
  node: Bsp; listener: BspCallback; userData: pointer = nil): bool {.
    cdecl, importc: "TCOD_bsp_traverse_pre_order", dynlib: LIB_NAME.}

proc bspTraverseInOrder*(
  node: Bsp; listener: BspCallback; userData: pointer = nil): bool {.
    cdecl, importc: "TCOD_bsp_traverse_in_order", dynlib: LIB_NAME.}

proc bspTraversePostOrder*(
  node: Bsp; listener: BspCallback; userData: pointer = nil): bool {.
    cdecl, importc: "TCOD_bsp_traverse_post_order", dynlib: LIB_NAME.}

proc bspTraverseLevelOrder*(
  node: Bsp; listener: BspCallback; userData: pointer = nil): bool {.
    cdecl, importc: "TCOD_bsp_traverse_level_order", dynlib: LIB_NAME.}

proc bspTraverseInvertedLevelOrder*(
  node: Bsp; listener: BspCallback; userData: pointer = nil): bool {.
    cdecl, importc: "TCOD_bsp_traverse_inverted_level_order", dynlib: LIB_NAME.}

proc bspContains*(
  node: Bsp; x, y: cint): bool {.
    cdecl, importc: "TCOD_bsp_contains", dynlib: LIB_NAME.}

proc bspFindNode*(
  node: Bsp; x, y: cint): Bsp {.
    cdecl, importc: "TCOD_bsp_find_node", dynlib: LIB_NAME.}

proc bspResize*(
  node: Bsp; x, y, w, h: cint) {.
    cdecl, importc: "TCOD_bsp_resize", dynlib: LIB_NAME.}

proc bspSplitOnce*(
  node: Bsp; horizontal: bool; position: cint) {.
    cdecl, importc: "TCOD_bsp_split_once", dynlib: LIB_NAME.}

proc bspSplitRecursive*(
  node: Bsp; randomizer: Random;
  nb, minHSize, minVSize: cint;
  maxHRatio, maxVRatio: cfloat) {.
    cdecl, importc: "TCOD_bsp_split_recursive", dynlib: LIB_NAME.}

proc bspRemoveSons*(
  node: Bsp) {.
    cdecl, importc: "TCOD_bsp_remove_sons", dynlib: LIB_NAME.}

