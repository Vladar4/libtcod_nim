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
  # generic type
  TValueType* = enum
    TYPE_NONE,
    TYPE_BOOL,
    TYPE_CHAR,
    TYPE_INT,
    TYPE_FLOAT,
    TYPE_STRING,
    TYPE_COLOR,
    TYPE_DICE,
    TYPE_VALUELIST00,
    TYPE_VALUELIST01,
    TYPE_VALUELIST02,
    TYPE_VALUELIST03,
    TYPE_VALUELIST04,
    TYPE_VALUELIST05,
    TYPE_VALUELIST06,
    TYPE_VALUELIST07,
    TYPE_VALUELIST08,
    TYPE_VALUELIST09,
    TYPE_VALUELIST10,
    TYPE_VALUELIST11,
    TYPE_VALUELIST12,
    TYPE_VALUELIST13,
    TYPE_VALUELIST14,
    TYPE_VALUELIST15,
    TYPE_CUSTOM00,
    TYPE_CUSTOM01,
    TYPE_CUSTOM02,
    TYPE_CUSTOM03,
    TYPE_CUSTOM04,
    TYPE_CUSTOM05,
    TYPE_CUSTOM06,
    TYPE_CUSTOM07,
    TYPE_CUSTOM08,
    TYPE_CUSTOM09,
    TYPE_CUSTOM10,
    TYPE_CUSTOM11,
    TYPE_CUSTOM12,
    TYPE_CUSTOM13,
    TYPE_CUSTOM14,
    TYPE_CUSTOM15,
    TYPE_LIST=1024

  # generic value
  TValue*{.bycopy.} = object
    i1, i2: int32
    f1, f2: float32
  
template BoolValue*(value: TValue): stmt {.immediate.} =
  cast[bool](addr(value))
template CharValue*(value: TValue): stmt {.immediate.} =
  cast[char](addr(value))
template IntValue*(value: TValue): stmt {.immediate.} =
  cast[int32](addr(value))
template FloatValue*(value: TValue): stmt {.immediate.} =
  cast[float32](addr(value))
template StringValue*(value: TValue): stmt {.immediate.} =
  cast[cstring](addr(value))
template ColorValue*(value: TValue): stmt {.immediate.} =
  cast[TColor](addr(value))
proc DiceValue*(value: var TValue): TDice =
  result.nb_rolls = value.i1
  result.nb_faces = value.i2
  result.multiplier = value.f1
  result.addsub = value.f2
  #cast[TDice](addr(value[0]))[]
template ListValue*(value: TValue): stmt {.immediate.} =
  cast[PList](addr(value))
template CustomValue*(value: TValue): stmt {.immediate.} =
  cast[pointer](addr(value))


# parser structures
type
  PParserStruct* = pointer


#TCODLIB_API const char *TCOD_struct_get_name(TCOD_parser_struct_t def);
proc struct_get_name*(def: PParserStruct): cstring {.cdecl, importc: "TCOD_struct_get_name", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_struct_add_property(TCOD_parser_struct_t def, const char *name,TCOD_value_type_t type, bool mandatory);
proc struct_add_property*(def: PParserStruct, name: cstring, value_type: TValueType, mandatory: bool) {.cdecl, importc: "TCOD_struct_add_property", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_struct_add_list_property(TCOD_parser_struct_t def, const char *name,TCOD_value_type_t type, bool mandatory);
proc struct_add_list_property*(def: PParserStruct, name: cstring, value_type: TValueType, mandatory: bool) {.cdecl, importc: "TCOD_struct_add_list_property", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_struct_add_value_list(TCOD_parser_struct_t def,const char *name, const char **value_list, bool mandatory);
proc struct_add_value_list*(def: PParserStruct, name: cstring, value_list: cstringArray, mandatory: bool) {.cdecl, importc: "TCOD_struct_add_value_list", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_struct_add_value_list_sized(TCOD_parser_struct_t def,const char *name, const char **value_list, int size, bool mandatory);
proc struct_add_value_list_sized*(def: PParserStruct, name: cstring, value_list: cstringArray, size: int, mandatory: bool) {.cdecl, importc: "TCOD_struct_add_value_list_sized", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_struct_add_flag(TCOD_parser_struct_t def,const char *propname);
proc struct_add_flag*(def: PParserStruct, propname: cstring) {.cdecl, importc: "TCOD_struct_add_flag", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_struct_add_structure(TCOD_parser_struct_t def,TCOD_parser_struct_t sub_structure);
proc struct_add_structure*(def, sub_structure: PParserStruct) {.cdecl, importc: "TCOD_struct_add_structure", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_struct_is_mandatory(TCOD_parser_struct_t def,const char *propname);
proc struct_is_mandatory*(def: PParserStruct, propname: cstring): bool {.cdecl, importc: "TCOD_struct_is_mandatory", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_type_t TCOD_struct_get_type(TCOD_parser_struct_t def, const char *propname);
proc struct_get_type*(def: PParserStruct, propname: cstring): TValueType {.cdecl, importc: "TCOD_struct_get_type", dynlib: LIB_NAME.}



# parser listener
type
  PParserListener* = ptr TParserListener
  TParserListener*{.bycopy.} = object
    new_struct*: proc(str: PParserStruct, name: cstring): bool {.cdecl.}
    new_flag*: proc(name: cstring): bool {.cdecl.}
    new_property*: proc(propname: cstring, value_type: TValueType, value: TValue): bool {.cdecl.}
    end_struct*: proc(str: PParserStruct, name: cstring): bool {.cdecl.}
    error*: proc(msg: cstring) {.cdecl.}

  # a custom type parser
  #typedef TCOD_value_t (*TCOD_parser_custom_t)(TCOD_lex_t *lex, TCOD_parser_listener_t *listener, TCOD_parser_struct_t str, char *propname);
  PParserCustom* = proc(lex: PLex, listener: PParserListener, str: PParserStruct, propname: cstring): TValue {.cdecl.}

  # the parser
  PParser = pointer

#TCODLIB_API TCOD_parser_t TCOD_parser_new();
proc parser_new*(): PParser {.cdecl, importc: "TCOD_parser_new", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_parser_struct_t TCOD_parser_new_struct(TCOD_parser_t parser, char *name);
proc parser_new_struct*(parser: PParser, name: cstring): PParserStruct {.cdecl, importc: "TCOD_parser_new_struct", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_type_t TCOD_parser_new_custom_type(TCOD_parser_t parser,TCOD_parser_custom_t custom_type_parser);
proc parser_new_custom_type*(parser: PParser, custom_type_parser: PParserCustom): TValueType {.cdecl, importc: "TCOD_parser_new_custom_type", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_parser_run(TCOD_parser_t parser, const char *filename, TCOD_parser_listener_t *listener);
proc parser_run*(parser: PParser, filename: cstring, listener: PParserListener = nil) {.cdecl, importc: "TCOD_parser_run", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_parser_delete(TCOD_parser_t parser);
proc parser_delete*(parser: PParser) {.cdecl, importc: "TCOD_parser_delete", dynlib: LIB_NAME.}


# error during parsing. can be called by the parser listener
#TCODLIB_API void TCOD_parser_error(const char *msg, ...);
proc parser_error*(msg: cstring) {.cdecl, importc: "TCOD_parser_error", varargs, dynlib: LIB_NAME.}


# default parser listener
#TCODLIB_API bool TCOD_parser_get_bool_property(TCOD_parser_t parser, const char *name);
proc parser_get_bool_property*(parser: PParser, name: cstring): bool {.cdecl, importc: "TCOD_parser_get_bool_property", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_parser_get_char_property(TCOD_parser_t parser, const char *name);
proc parser_get_char_property*(parser: PParser, name: cstring): char {.cdecl, importc: "TCOD_parser_get_char_property", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_parser_get_int_property(TCOD_parser_t parser, const char *name);
proc parser_get_int_property*(parser: PParser, name: cstring): int {.cdecl, importc: "TCOD_parser_get_int_property", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_parser_get_float_property(TCOD_parser_t parser, const char *name);
proc parser_get_float_property*(parser: PParser, name: cstring): float32 {.cdecl, importc: "TCOD_parser_get_float_property", dynlib: LIB_NAME.}

#TCODLIB_API const char * TCOD_parser_get_string_property(TCOD_parser_t parser, const char *name);
proc parser_get_string_property*(parser: PParser, name: cstring): cstring {.cdecl, importc: "TCOD_parser_get_string_property", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_color_t TCOD_parser_get_color_property(TCOD_parser_t parser, const char *name);
proc parser_get_color_property*(parser: PParser, name: cstring): TColor {.cdecl, importc: "TCOD_parser_get_color_property", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_dice_t TCOD_parser_get_dice_property(TCOD_parser_t parser, const char *name);
proc parser_get_dice_property*(parser: PParser, name: cstring): TDice {.cdecl, importc: "TCOD_parser_get_dice_property", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_parser_get_dice_property_py(TCOD_parser_t parser, const char *name, TCOD_dice_t *dice);
proc parser_get_dice_property_py*(parser: PParser, name: cstring, dice: ptr TDice) {.cdecl, importc: "TCOD_parser_get_dice_property_py", dynlib: LIB_NAME.}

#TCODLIB_API void * TCOD_parser_get_custom_property(TCOD_parser_t parser, const char *name);
proc parser_get_custom_property*(parser: PParser, name: cstring): pointer {.cdecl, importc: "TCOD_parser_get_custom_property", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_list_t TCOD_parser_get_list_property(TCOD_parser_t parser, const char *name, TCOD_value_type_t type);
proc parser_get_list_property*(parser: PParser, name: cstring, value_type: TValueType): PList {.cdecl, importc: "TCOD_parser_get_list_property", dynlib: LIB_NAME.}

proc parser_get_list_bool_property*(parser: PParser, name: cstring): seq[bool] =
  var
    list = parser_get_list_property(parser, name, TYPE_BOOL)
  result = @[]
  for i in 0..list_size(list)-1:
    result.add(cast[bool](list_get(list, i)))
  list_delete(list)

proc parser_get_list_char_property*(parser: PParser, name: cstring): seq[char] =
  var
    list = parser_get_list_property(parser, name, TYPE_CHAR)
  result = @[]
  for i in 0..list_size(list)-1:
    result.add(cast[char](list_get(list, i)))
  list_delete(list)

proc parser_get_list_int_property*(parser: PParser, name: cstring): seq[int32] =
  var
    list = parser_get_list_property(parser, name, TYPE_INT)
  result = @[]
  for i in 0..list_size(list)-1:
    result.add(cast[int32](list_get(list, i)))
  list_delete(list)

# TODO
#proc parser_get_list_float_property*(parser: PParser, name: cstring): seq[float32] =
#  var
#    list = parser_get_list_property(parser, name, TYPE_FLOAT)
#  result = @[]
#  for i in 0..list_size(list)-1:
#    #result.add(cast[float32](list_get(list, i))) # linker error
#  list_delete(list)

proc parser_get_list_string_property*(parser: PParser, name: cstring): seq[string] {.inline.} =
  var
    list = parser_get_list_property(parser, name, TYPE_STRING)
  result = cstringArrayToSeq(cast[cstringArray](list_begin(list)), list_size(list))
  list_delete(list)

proc parser_get_list_color_property*(parser: PParser, name: cstring): seq[TColor] =
  var
    list = parser_get_list_property(parser, name, TYPE_COLOR)
  result = @[]
  for i in 0..list_size(list)-1:
    var v = cast[array[0..3, uint8]](list_get(list, i))
    result.add(color_RGB(v[0], v[1], v[2]))
  list_delete(list)

# TODO
#proc parser_get_list_dice_property*(parser: PParser, name: cstring): seq[TDice] =
#  var
#    list = parser_get_list_property(parser, name, TYPE_DICE)
#  result = @[]
#  for i in 0..list_size(list)-1:
#    result.add(cast[TDice](list_get(list, i)))
#  list_delete(list)


# parser internals (may be used by custom type parsers)
type
  # parser structures
  PStructInt* = ptr TStructInt
  TStructInt*{.bycopy.} = object
    name*: cstring # entity type name
    flags*: PList # list of flags
    props*: PList # list of properties (name, type, mandatory)
    lists*: PList # list of value lists
    structs*: PList # list of sub-structures


  # the parser
  PParserInt* = ptr TParserInt
  TParserInt*{.bycopy.} = object
    structs*: PList # list of structures
    customs*: array[0..15, PParserCustom] # list of custom type parsers
    fatal*: bool # fatal error occured
    props*: PList # list of properties if default listener is used


#TCODLIB_API TCOD_value_t TCOD_parse_bool_value();
proc parse_bool_value*(): TValue {.cdecl, importc: "TCOD_parse_bool_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_char_value();
proc parse_char_value*(): TValue {.cdecl, importc: "TCOD_parse_char_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_integer_value();
proc parse_integer_value*(): TValue {.cdecl, importc: "TCOD_parse_integer_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_float_value();
proc parse_float_value*(): TValue {.cdecl, importc: "TCOD_parse_float_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_string_value();
proc parse_string_value*(): TValue {.cdecl, importc: "TCOD_parse_string_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_color_value();
proc parse_color_value*(): TValue {.cdecl, importc: "TCOD_parse_color_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_dice_value();
proc parse_dice_value*(): TValue {.cdecl, importc: "TCOD_parse_dice_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_value_list_value(TCOD_struct_int_t *def,int listnum);
proc parse_value_list_value*(def: PstructInt, listnum: int): TValue {.cdecl, importc: "TCOD_parse_value_list_value", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_value_t TCOD_parse_property_value(TCOD_parser_int_t *parser, TCOD_parser_struct_t def, char *propname, bool list);
proc parse_property_value*(parser: PParserInt, def: PParserStruct, propname: cstring, list: bool): TValue {.cdecl, importc: "TCOD_parse_property_value", dynlib: LIB_NAME.}

