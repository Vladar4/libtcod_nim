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
  PBSP* = ptr TBSP
  TBSP*{.bycopy.} = object
    tree*: TTree # pseudo oop : bsp inherit tree
    x*, y*, w*, h*: cint # node position & size
    position*: cint # position of splitting
    level*: uint8 # level in the tree
    horizontal*: bool # horizontal splitting ?

  PBSPCallback* = proc(node: PBSP, userData: pointer): bool {.cdecl.}

#TCODLIB_API TCOD_bsp_t *TCOD_bsp_new();
proc bsp_new*(): PBSP {.cdecl, importc: "TCOD_bsp_new", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_bsp_t *TCOD_bsp_new_with_size(int x,int y,int w, int h);
proc bsp_new_with_size*(x, y, w, h: int): PBSP {.cdecl, importc: "TCOD_bsp_new_with_size", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_bsp_delete(TCOD_bsp_t *node);
proc bsp_delete*(node: PBSP) {.cdecl, importc: "TCOD_bsp_delete", dynlib: LIB_NAME.}


#TCODLIB_API TCOD_bsp_t * TCOD_bsp_left(TCOD_bsp_t *node);
proc bsp_left*(node: PBSP): PBSP {.cdecl, importc: "TCOD_bsp_left", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_bsp_t * TCOD_bsp_right(TCOD_bsp_t *node);
proc bsp_right*(node: PBSP): PBSP {.cdecl, importc: "TCOD_bsp_right", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_bsp_t * TCOD_bsp_father(TCOD_bsp_t *node);
proc bsp_father*(node: PBSP): PBSP {.cdecl, importc: "TCOD_bsp_father", dynlib: LIB_NAME.}


#TCODLIB_API bool TCOD_bsp_is_leaf(TCOD_bsp_t *node);
proc bsp_is_leaf*(node: PBSP): bool {.cdecl, importc: "TCOD_bsp_is_leaf", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_bsp_traverse_pre_order(TCOD_bsp_t *node, TCOD_bsp_callback_t listener, void *userData);
proc bsp_traverse_pre_order*(node: PBSP, listener: PBSPCallback, userData: pointer = nil): bool {.cdecl, importc: "TCOD_bsp_traverse_pre_order", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_bsp_traverse_in_order(TCOD_bsp_t *node, TCOD_bsp_callback_t listener, void *userData);
proc bsp_traverse_in_order*(node: PBSP, listener: PBSPCallback, userData: pointer = nil): bool {.cdecl, importc: "TCOD_bsp_traverse_in_order", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_bsp_traverse_post_order(TCOD_bsp_t *node, TCOD_bsp_callback_t listener, void *userData);
proc bsp_traverse_post_order*(node: PBSP, listener: PBSPCallback, userData: pointer = nil): bool {.cdecl, importc: "TCOD_bsp_traverse_post_order", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_bsp_traverse_level_order(TCOD_bsp_t *node, TCOD_bsp_callback_t listener, void *userData);
proc bsp_traverse_level_order*(node: PBSP, listener: PBSPCallback, userData: pointer = nil): bool {.cdecl, importc: "TCOD_bsp_traverse_level_order", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_bsp_traverse_inverted_level_order(TCOD_bsp_t *node, TCOD_bsp_callback_t listener, void *userData);
proc bsp_traverse_inverted_level_order*(node: PBSP, listener: PBSPCallback, userData: pointer = nil): bool {.cdecl, importc: "TCOD_bsp_traverse_inverted_level_order", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_bsp_contains(TCOD_bsp_t *node, int x, int y);
proc bsp_contains*(node: PBSP, x, y: int): bool {.cdecl, importc: "TCOD_bsp_contains", dynlib: LIB_NAME.}


#TCODLIB_API TCOD_bsp_t * TCOD_bsp_find_node(TCOD_bsp_t *node, int x, int y);
proc bsp_find_node*(node: PBSP, x, y: int): PBSP {.cdecl, importc: "TCOD_bsp_find_node", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_bsp_resize(TCOD_bsp_t *node, int x,int y, int w, int h);
proc bsp_resize*(node: PBSP, x, y, w, h: int) {.cdecl, importc: "TCOD_bsp_resize", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_bsp_split_once(TCOD_bsp_t *node, bool horizontal, int position);
proc bsp_split_once*(node: PBSP, horizontal: bool, position: int) {.cdecl, importc: "TCOD_bsp_split_once", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_bsp_split_recursive(TCOD_bsp_t *node, TCOD_random_t randomizer, int nb, int minHSize, int minVSize, float maxHRatio, float maxVRatio);
proc bsp_split_recursive*(node: PBSP, randomizer: PRandom, nb, minHSize, minVSize: int, maxHRatio, maxVRatio: cfloat) {.cdecl, importc: "TCOD_bsp_split_recursive", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_bsp_remove_sons(TCOD_bsp_t *node);
proc bsp_remove_sons*(node: PBSP) {.cdecl, importc: "TCOD_bsp_remove_sons", dynlib: LIB_NAME.}

