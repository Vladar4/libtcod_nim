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

#
# This is a libtcod internal module.
# Use at your own risks...
#

const
  LEX_FLAG_NOCASE*: cint = 1
  LEX_FLAG_NESTING_COMMENT*: cint = 2
  LEX_FLAG_TOKENIZE_COMMENTS*: cint = 4

  LEX_ERROR*: cint = -1
  LEX_UNKNOWN*: cint = 0
  LEX_SYMBOL*: cint = 1
  LEX_KEYWORD*: cint = 2
  LEX_IDEN*: cint = 3
  LEX_STRING*: cint = 4
  LEX_INTEGER*: cint = 5
  LEX_FLOAT*: cint = 6
  LEX_CHAR*: cint = 7
  LEX_EOF*: cint = 8
  LEX_COMMENT*: cint = 9

  LEX_MAX_SYMBOLS*: cint = 100
  LEX_SYMBOL_SIZE*: cint = 5
  LEX_MAX_KEYWORDS*: cint = 100
  LEX_KEYWORD_SIZE*: cint = 20

type
  Lex* = ptr LexObj
  LexObj* {.bycopy.} = object ##  \
    ##
    fileLine*: cint
    tokenType*: cint
    tokenIntVal*: cint
    tokenIdx*: cint
    tokenFloatVal*: cfloat
    tok*: cstring
    toklen*: cint
    lastStringDelim*: char
    pos*: cstring
    buf*: cstring
    filename*: cstring
    lastJavadocComment*: cstring

    nbSymbols*: cint  ##  private stuff from here
    nbKeywords*: cint
    flags*: cint
    symbols*: array[LEX_MAX_SYMBOLS, array[LEX_SYMBOL_SIZE, char]]
    keywords*: array[LEX_MAX_KEYWORDS, array[LEX_KEYWORD_SIZE, char]]
    simpleCmt*: cstring
    cmtStart*: cstring
    cmtStop*: cstring
    javadocCmtStart*: cstring
    stringDelim*: cstring
    javadocRead*: bool
    allocBuf*: bool
    savept*: bool ##  is this object a savepoint (no free in destructor)


proc lexNewIntern*(): Lex {.
    cdecl, importc: "TCOD_lex_new_intern", dynlib: LIB_NAME.}

proc lexNew*(
  symbols, keywords: cstringArray;
  simpleComment, commentStart, commentStop: cstring;
  javadocCommentStart, stringDelim: cstring; flags: cint): Lex {.
    cdecl, importc: "TCOD_lex_new", dynlib: LIB_NAME.}

proc lexDelete_internal(
  lex: Lex) {.
    cdecl, importc: "TCOD_lex_delete", dynlib: LIB_NAME.}

proc lexDelete*(lex: var Lex) =
  if not (lex == nil):
    lexDelete_internal(lex)
    lex = nil

proc lexSetDataBuffer*(
  lex: Lex; dat: cstring) {.
    cdecl, importc: "TCOD_lex_set_data_buffer", dynlib: LIB_NAME.}

proc lexSetDataFile*(
  lex: Lex; filename: cstring): bool {.
    cdecl, importc: "TCOD_lex_set_data_file", dynlib: LIB_NAME.}

proc lexParse*(
  lex: Lex): cint {.
    cdecl, importc: "TCOD_lex_parse", dynlib: LIB_NAME.}

proc lexParseUntilTokenType*(
  lex: Lex; tokenType: cint): cint {.
    cdecl, importc: "TCOD_lex_parse_until_token_type", dynlib: LIB_NAME.}

proc lexParseUntilTokenValue*(
  lex: Lex; tokenValue: cstring): cint {.
  cdecl, importc: "TCOD_lex_parse_until_token_value", dynlib: LIB_NAME.}

proc lexExpectTokenType*(
  lex: Lex; tokenType: cint): bool {.
    cdecl, importc: "TCOD_lex_expect_token_type", dynlib: LIB_NAME.}

proc lexExpectTokenValue*(
  lex: Lex; tokenType: cint; tokenValue: cstring): bool {.
    cdecl, importc: "TCOD_lex_expect_token_value", dynlib: LIB_NAME.}

proc lexSavepoint*(
  lex, savept: Lex) {.
    cdecl, importc: "TCOD_lex_savepoint", dynlib: LIB_NAME.}

proc lexRestore*(
  lex: Lex; savept: Lex) {.
    cdecl, importc: "TCOD_lex_restore", dynlib: LIB_NAME.}

proc lexGetLastJavadoc*(
  lex: Lex): cstring {.
    cdecl, importc: "TCOD_lex_get_last_javadoc", dynlib: LIB_NAME.}

proc lexGetTokenName*(
  tokenType: cint): cstring {.
    cdecl, importc: "TCOD_lex_get_token_name", dynlib: LIB_NAME.}

proc lexGetLastError*(): cstring {.
    cdecl, importc: "TCOD_lex_get_last_error", dynlib: LIB_NAME.}

proc lexHextoint*(
  c: char): cint {.
    cdecl, importc: "TCOD_lex_hextoint", dynlib: LIB_NAME.}

