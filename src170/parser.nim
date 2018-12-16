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

# import color, list, lex, mersenne_types

type
  ValueKind* {.size: sizeof(cint).} = enum ##  \
    ##  Generic kind.
    KIND_NONE, KIND_BOOL, KIND_CHAR, KIND_INT, KIND_FLOAT, KIND_STRING,
    KIND_COLOR, KIND_DICE,
    KIND_VALUELIST00, KIND_VALUELIST01, KIND_VALUELIST02, KIND_VALUELIST03,
    KIND_VALUELIST04, KIND_VALUELIST05, KIND_VALUELIST06, KIND_VALUELIST07,
    KIND_VALUELIST08, KIND_VALUELIST09, KIND_VALUELIST10, KIND_VALUELIST11,
    KIND_VALUELIST12, KIND_VALUELIST13, KIND_VALUELIST14, KIND_VALUELIST15,
    KIND_CUSTOM00, KIND_CUSTOM01, KIND_CUSTOM02, KIND_CUSTOM03, KIND_CUSTOM04,
    KIND_CUSTOM05, KIND_CUSTOM06, KIND_CUSTOM07, KIND_CUSTOM08, KIND_CUSTOM09,
    KIND_CUSTOM10, KIND_CUSTOM11, KIND_CUSTOM12, KIND_CUSTOM13, KIND_CUSTOM14,
    KIND_CUSTOM15, KIND_LIST = 1024



type
  Value* {.bycopy.} = object {.union.}
    ##  Generic value.
    b*: bool
    c*: char
    i*: int32
    f*: cfloat
    s*: cstring
    col*: Color
    dice*: Dice
    list*: List
    custom*: pointer


type
  ParserStruct* = pointer ##  Parser structures.


proc structGetName*(
  def: ParserStruct): cstring {.
    cdecl, importc: "TCOD_struct_get_name", dynlib: LIB_NAME.}

proc structAddProperty*(
  def: ParserStruct; name: cstring; kind: ValueKind; mandatory: bool) {.
    cdecl, importc: "TCOD_struct_add_property", dynlib: LIB_NAME.}

proc structAddListProperty*(
  def: ParserStruct; name: cstring; kind: ValueKind; mandatory: bool) {.
    cdecl, importc: "TCOD_struct_add_list_property", dynlib: LIB_NAME.}

proc structAddValueList*(
  def: ParserStruct; name: cstring; valueList: cstringArray; mandatory: bool) {.
    cdecl, importc: "TCOD_struct_add_value_list", dynlib: LIB_NAME.}

proc structAddValueListSized*(
  def: ParserStruct; name: cstring; valueList: cstringArray;
  size: cint; mandatory: bool) {.
    cdecl, importc: "TCOD_struct_add_value_list_sized", dynlib: LIB_NAME.}

proc structAddFlag*(
  def: ParserStruct; propname: cstring) {.
    cdecl, importc: "TCOD_struct_add_flag", dynlib: LIB_NAME.}

proc structAddStructure*(
  def: ParserStruct; subStructure: ParserStruct) {.
    cdecl, importc: "TCOD_struct_add_structure", dynlib: LIB_NAME.}

proc structIsMandatory*(
  def: ParserStruct; propname: cstring): bool {.
    cdecl, importc: "TCOD_struct_is_mandatory", dynlib: LIB_NAME.}

proc structGetKind*(
  def: ParserStruct; propname: cstring): ValueKind {.
    cdecl, importc: "TCOD_struct_get_type", dynlib: LIB_NAME.}


type
  ParserListener* = ptr ParserListenerObj
  ParserListenerObj* {.bycopy.} = object  ##  \
    ##  parser listener
    newStruct*:   proc (str: ParserStruct; name: cstring): bool {.cdecl.}
    newFlag*:     proc (name: cstring): bool {.cdecl.}
    newProperty*: proc (propname: cstring; kind: ValueKind; value: Value): bool {.cdecl.}
    endStruct*:   proc (str: ParserStruct; name: cstring): bool {.cdecl.}
    error*:       proc (msg: cstring) {.cdecl.}



type
  ParserCustom* = proc (
    ##  a custom type parser
    lex: ptr Lex; listener: ParserListener;
    str: ParserStruct; propname: cstring): Value {.cdecl.}

  Parser* = pointer ##  the parser


proc parserNew*(): Parser {.
    cdecl, importc: "TCOD_parser_new", dynlib: LIB_NAME.}

proc parserNewStruct*(
  parser: Parser; name: cstring): ParserStruct {.
    cdecl, importc: "TCOD_parser_new_struct", dynlib: LIB_NAME.}

proc parserNewCustomType*(
  parser: Parser; customTypeParser: ParserCustom): ValueKind {.
    cdecl, importc: "TCOD_parser_new_custom_type", dynlib: LIB_NAME.}

proc parserRun*(
  parser: Parser; filename: cstring; listener: ParserListener) {.
    cdecl, importc: "TCOD_parser_run", dynlib: LIB_NAME.}

proc parserDelete*(
  parser: Parser) {.
    cdecl, importc: "TCOD_parser_delete", dynlib: LIB_NAME.}

proc parserError*(
  msg: cstring) {.
    varargs, cdecl, importc: "TCOD_parser_error", dynlib: LIB_NAME.}
  ##  error during parsing. can be called by the parser listener


#  default parser listener

proc parserHasProperty*(
  parser: Parser; name: cstring): bool {.
    cdecl, importc: "TCOD_parser_has_property", dynlib: LIB_NAME.}

proc parserGetBoolProperty*(
  parser: Parser; name: cstring): bool {.
    cdecl, importc: "TCOD_parser_get_bool_property", dynlib: LIB_NAME.}

proc parserGetCharProperty*(
  parser: Parser; name: cstring): cint {.
    cdecl, importc: "TCOD_parser_get_char_property", dynlib: LIB_NAME.}

proc parserGetIntProperty*(
  parser: Parser; name: cstring): cint {.
    cdecl, importc: "TCOD_parser_get_int_property", dynlib: LIB_NAME.}

proc parserGetFloatProperty*(
  parser: Parser; name: cstring): cfloat {.
    cdecl, importc: "TCOD_parser_get_float_property", dynlib: LIB_NAME.}

proc parserGetStringProperty*(
  parser: Parser; name: cstring): cstring {.
    cdecl, importc: "TCOD_parser_get_string_property", dynlib: LIB_NAME.}

proc parserGetColorProperty*(
  parser: Parser; name: cstring): Color {.
    cdecl, importc: "TCOD_parser_get_color_property", dynlib: LIB_NAME.}

proc parserGetDiceProperty*(
  parser: Parser; name: cstring): Dice {.
    cdecl, importc: "TCOD_parser_get_dice_property", dynlib: LIB_NAME.}

proc parserGetDicePropertyPy*(
  parser: Parser; name: cstring; dice: ptr Dice) {.
    cdecl, importc: "TCOD_parser_get_dice_property_py", dynlib: LIB_NAME.}

proc parserGetCustomProperty*(
  parser: Parser; name: cstring): pointer {.
    cdecl, importc: "TCOD_parser_get_custom_property", dynlib: LIB_NAME.}

proc parserGetListProperty*(
  parser: Parser; name: cstring; kind: ValueKind): List {.
    cdecl, importc: "TCOD_parser_get_list_property", dynlib: LIB_NAME.}

#  parser internals (may be used by custom type parsers)

type
  StructInt* {.bycopy.} = object ##  \
    ##  parser structures
    ##
    name*: cstring  ##  entity type name
    flags*: List    ##  list of flags
    props*: List    ##  list of properties (name, type, mandatory)
    lists*: List    ##  list of value lists
    structs*: List  ##  list of sub-structures

  ParserInt* {.bycopy.} = object ##  \
    ##  the parser
    ##
    structs*: List                    ##  list of structures
    customs*: array[16, ParserCustom] ##  list of custom type parsers
    fatal*: bool                      ##  fatal error occurred
    props*: List  ##  list of properties if default listener is used


proc parseBoolValue*(): Value {.
    cdecl, importc: "TCOD_parse_bool_value", dynlib: LIB_NAME.}

proc parseCharValue*(): Value {.
    cdecl, importc: "TCOD_parse_char_value", dynlib: LIB_NAME.}

proc parseIntegerValue*(): Value {.
    cdecl, importc: "TCOD_parse_integer_value", dynlib: LIB_NAME.}

proc parseFloatValue*(): Value {.
    cdecl, importc: "TCOD_parse_float_value", dynlib: LIB_NAME.}

proc parseStringValue*(): Value {.
    cdecl, importc: "TCOD_parse_string_value", dynlib: LIB_NAME.}

proc parseColorValue*(): Value {.
    cdecl, importc: "TCOD_parse_color_value", dynlib: LIB_NAME.}

proc parseDiceValue*(): Value {.
    cdecl, importc: "TCOD_parse_dice_value", dynlib: LIB_NAME.}

proc parseValueListValue*(
  def: ptr StructInt; listnum: cint): Value {.
    cdecl, importc: "TCOD_parse_value_list_value", dynlib: LIB_NAME.}

proc parsePropertyValue*(
  parser: ptr ParserInt; def: ParserStruct;
  propname: cstring; list: bool): Value {.
    cdecl, importc: "TCOD_parse_property_value", dynlib: LIB_NAME.}

