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
#
# Mingos' NameGen
# This file was written by Dominik "Mingos" Marczuk.
#


# parse a file with syllable sets
#TCODLIB_API void TCOD_namegen_parse (const char * filename, TCOD_random_t random);
proc namegen_parse*(filename: cstring, random: PRandom = nil) {.cdecl, importc: "TCOD_namegen_parse", dynlib: LIB_NAME.}

# generate a name
#TCODLIB_API char * TCOD_namegen_generate (char * name, bool allocate);
proc namegen_generate*(name: cstring, allocate=false): cstring {.cdecl, importc: "TCOD_namegen_generate", dynlib: LIB_NAME.}


# generate a name using a custom generation rule
#TCODLIB_API char * TCOD_namegen_generate_custom (char * name, char * rule, bool allocate);
proc namegen_generate_custom*(name, rule: cstring, allocate=false): cstring {.cdecl, importc: "TCOD_namegen_generate_custom", dynlib: LIB_NAME.}


# retrieve the list of all available syllable set names
#TCODLIB_API TCOD_list_t TCOD_namegen_get_sets (void);
proc namegen_get_sets_list(): PList {.cdecl, importc: "TCOD_namegen_get_sets", dynlib: LIB_NAME.}
proc namegen_get_sets*(): seq[string] {.inline.} =
  var list = namegen_get_sets_list()
  result = cstringArrayToSeq(cast[cstringArray](list_begin(list)), list_size(list))
  list_delete(list)


# delete a generator
#TCODLIB_API void TCOD_namegen_destroy (void);
proc namegen_destroy*() {.cdecl, importc: "TCOD_namegen_destroy", dynlib: LIB_NAME.}


