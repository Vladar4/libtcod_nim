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

type
  List* = pointer


proc listNew*(): List {.
    cdecl, importc: "TCOD_list_new", dynlib: LIB_NAME.}

proc listAllocate*(
  nbElements: cint): List {.
    cdecl, importc: "TCOD_list_allocate", dynlib: LIB_NAME.}

proc listDuplicate*(
  l: List): List {.
    cdecl, importc: "TCOD_list_duplicate", dynlib: LIB_NAME.}

proc listDelete*(
  l: List) {.
    cdecl, importc: "TCOD_list_delete", dynlib: LIB_NAME.}

proc listPush*(
  l: List; elt: pointer) {.
    cdecl, importc: "TCOD_list_push", dynlib: LIB_NAME.}

proc listPop*(
  l: List): pointer {.
    cdecl, importc: "TCOD_list_pop", dynlib: LIB_NAME.}

proc listPeek*(
  l: List): pointer {.
    cdecl, importc: "TCOD_list_peek", dynlib: LIB_NAME.}

proc listAddAll*(
  l, l2: List) {.
    cdecl, importc: "TCOD_list_add_all", dynlib: LIB_NAME.}

proc listGet*(
  l: List; idx: cint): pointer {.
    cdecl, importc: "TCOD_list_get", dynlib: LIB_NAME.}

proc listSet*(
  l: List; elt: pointer; idx: cint) {.
    cdecl, importc: "TCOD_list_set", dynlib: LIB_NAME.}

proc listBegin*(
  l: List): ptr pointer {.
    cdecl, importc: "TCOD_list_begin", dynlib: LIB_NAME.}

proc listEnd*(
  l: List): ptr pointer {.
    cdecl, importc: "TCOD_list_end", dynlib: LIB_NAME.}

proc listReverse*(
  l: List) {.
    cdecl, importc: "TCOD_list_reverse", dynlib: LIB_NAME.}

proc listRemoveIterator*(
  l: List; elt: ptr pointer): ptr pointer {.
    cdecl, importc: "TCOD_list_remove_iterator", dynlib: LIB_NAME.}

proc listRemove*(
  l: List; elt: pointer) {.
    cdecl, importc: "TCOD_list_remove", dynlib: LIB_NAME.}

proc listRemoveIteratorFast*(
  l: List; elt: ptr pointer): ptr pointer {.
    cdecl, importc: "TCOD_list_remove_iterator_fast", dynlib: LIB_NAME.}

proc listRemoveFast*(
  l: List; elt: pointer) {.
    cdecl, importc: "TCOD_list_remove_fast", dynlib: LIB_NAME.}

proc listContains*(
  l: List; elt: pointer): bool {.
    cdecl, importc: "TCOD_list_contains", dynlib: LIB_NAME.}

proc listClear*(
  l: List) {.
    cdecl, importc: "TCOD_list_clear", dynlib: LIB_NAME.}

proc listClearAndDelete*(
  l: List) {.
    cdecl, importc: "TCOD_list_clear_and_delete", dynlib: LIB_NAME.}

proc listSize*(
  l: List): cint {.
    cdecl, importc: "TCOD_list_size", dynlib: LIB_NAME.}

proc listInsertBefore*(
  l: List; elt: pointer; before: cint): ptr pointer {.
    cdecl, importc: "TCOD_list_insert_before", dynlib: LIB_NAME.}

proc listIsEmpty*(
  l: List): bool {.
    cdecl, importc: "TCOD_list_is_empty", dynlib: LIB_NAME.}

