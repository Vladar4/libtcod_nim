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
# This is a libtcod internal module.
# Use at your own risks...
#


const
  LEX_FLAG_NOCASE* = 1
  LEX_FLAG_NESTING_COMMENT* = 2
  LEX_FLAG_TOKENIZE_COMMENTS* = 4

  LEX_ERROR* = -1
  LEX_UNKNOWN* = 0
  LEX_SYMBOL* = 1
  LEX_KEYWORD* = 2
  LEX_IDEN* = 3
  LEX_STRING* = 4
  LEX_INTEGER* = 5
  LEX_FLOAT* = 6
  LEX_CHAR* = 7
  LEX_EOF* = 8
  LEX_COMMENT* = 9

  LEX_MAX_SYMBOLS* = 100
  LEX_SYMBOL_SIZE* = 5
  LEX_MAX_KEYWORDS* = 100
  LEX_KEYWORD_SIZE* = 20


type
  PLex* = ptr TLex
  TLex*{.bycopy.} = object
    file_line*, token_type*, token_int_val*, token_idx*: cint
    token_float_val*: float32
    tok*: cstring
    toklen*: cint
    lastStringDelim*: char
    pos*: cstring
    buf*: cstring
    filename*: cstring
    last_javadoc_comment*: cstring
    nb_symbols, nb_keywords, flags: cint
    symbols: array[0..LEX_MAX_SYMBOLS-1, array[0..LEX_SYMBOL_SIZE-1, char]]
    keywords: array[0..LEX_MAX_KEYWORDS-1, array[0..LEX_KEYWORD_SIZE-1, char]]
    simpleCmt: cstring
    cmtStart, cmtStop, javadocCmtStart: cstring
    stringDelim: cstring
    javadoc_read: bool
    allocBuf: bool
    savept: bool # is this object a savepoint (no free in destructor)


#TCODLIB_API TCOD_lex_t *TCOD_lex_new_intern();
proc lex_new_intern*(): PLex {.cdecl, importc: "TCOD_lex_new_intern", dynlib: LIB_NAME.}
#TCODLIB_API TCOD_lex_t *TCOD_lex_new(const char **symbols, const char **keywords, const char *simpleComment, const char *commentStart, const char *commentStop, const char *javadocCommentStart, const char *stringDelim, int flags);
proc lex_new*(symbols, keywords: cstringArray, simpleComment, commentStart, commentStop, javadocCommentStart, stringDelim: cstring, flags: cint): PLex {.cdecl, importc: "TCOD_lex_new", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_lex_delete(TCOD_lex_t *lex);
proc lex_delete*(lex: PLex) {.cdecl, importc: "TCOD_lex_delete", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_lex_set_data_buffer(TCOD_lex_t *lex,char *dat);
proc lex_set_data_buffer*(lex: PLex, dat: cstring) {.cdecl, importc: "TCOD_lex_set_data_buffer", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_lex_set_data_file(TCOD_lex_t *lex,const char *filename);
proc lex_set_data_file*(lex: PLex, filename: cstring): bool {.cdecl, importc: "TCOD_lex_set_data_file", dynlib: LIB_NAME.}


#TCODLIB_API int TCOD_lex_parse(TCOD_lex_t *lex);
proc lex_parse*(lex: PLex): cint {.cdecl, importc: "TCOD_lex_parse", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_lex_parse_until_token_type(TCOD_lex_t *lex,int token_type);
proc lex_parse_until_token_type*(lex: PLex, token_type: cint): cint {.cdecl, importc: "TCOD_lex_parse_until_token_type", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_lex_parse_until_token_value(TCOD_lex_t *lex,const char *token_value);
proc lex_parse_until_token_value*(lex: PLex, token_value: cstring): cint {.cdecl, importc: "TCOD_lex_parse_until_token_value", dynlib: LIB_NAME.}


#TCODLIB_API bool TCOD_lex_expect_token_type(TCOD_lex_t *lex,int token_type);
proc lex_expect_token_type*(lex: PLex, token_type: cint): bool {.cdecl, importc: "TCOD_lex_expect_token_type", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_lex_expect_token_value(TCOD_lex_t *lex,int token_type,const char *token_value);
proc lex_expect_token_value*(lex: PLex, token_type: cint, token_value: cstring): bool {.cdecl, importc: "TCOD_lex_expect_token_value", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_lex_savepoint(TCOD_lex_t *lex,TCOD_lex_t *savept);
proc lex_savepoint*(lex, savept: PLex) {.cdecl, importc: "TCOD_lex_savepoint", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_lex_restore(TCOD_lex_t *lex,TCOD_lex_t *savept);
proc lex_restore*(lex, savept: PLex) {.cdecl, importc: "TCOD_lex_restore", dynlib: LIB_NAME.}

#TCODLIB_API char *TCOD_lex_get_last_javadoc(TCOD_lex_t *lex);
proc lex_get_last_javadoc*(lex: PLex): cstring {.cdecl, importc: "TCOD_lex_get_last_javadoc", dynlib: LIB_NAME.}

#TCODLIB_API const char *TCOD_lex_get_token_name(int token_type);
proc lex_get_token_name*(token_type: cint): cstring {.cdecl, importc: "TCOD_lex_get_token_name", dynlib: LIB_NAME.}

#TCODLIB_API char *TCOD_lex_get_last_error();
proc lex_get_last_error*(): cstring {.cdecl, importc: "TCOD_lex_get_last_error", dynlib: LIB_NAME.}


#TCODLIB_API int TCOD_lex_hextoint(char c);
proc lex_hextoint*(c: char): cint {.cdecl, importc: "TCOD_lex_hextoint", dynlib: LIB_NAME.}

