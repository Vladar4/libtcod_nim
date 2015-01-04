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
  TValueType* = range[0..32000]

const
  TYPE_NONE*: TValueType = 0
  TYPE_BOOL*: TValueType = 1
  TYPE_CHAR*: TValueType = 2
  TYPE_INT*: TValueType = 3
  TYPE_FLOAT*: TValueType = 4
  TYPE_STRING*: TValueType = 5
  TYPE_COLOR*: TValueType = 6
  TYPE_DICE*: TValueType = 7
  TYPE_VALUELIST00*: TValueType = 8
  TYPE_VALUELIST01*: TValueType = 9
  TYPE_VALUELIST02*: TValueType = 10
  TYPE_VALUELIST03*: TValueType = 11
  TYPE_VALUELIST04*: TValueType = 12
  TYPE_VALUELIST05*: TValueType = 13
  TYPE_VALUELIST06*: TValueType = 14
  TYPE_VALUELIST07*: TValueType = 15
  TYPE_VALUELIST08*: TValueType = 16
  TYPE_VALUELIST09*: TValueType = 17
  TYPE_VALUELIST10*: TValueType = 18
  TYPE_VALUELIST11*: TValueType = 19
  TYPE_VALUELIST12*: TValueType = 20
  TYPE_VALUELIST13*: TValueType = 21
  TYPE_VALUELIST14*: TValueType = 22
  TYPE_VALUELIST15*: TValueType = 23
  TYPE_CUSTOM00*: TValueType = 24
  TYPE_CUSTOM01*: TValueType = 25
  TYPE_CUSTOM02*: TValueType = 26
  TYPE_CUSTOM03*: TValueType = 27
  TYPE_CUSTOM04*: TValueType = 28
  TYPE_CUSTOM05*: TValueType = 29
  TYPE_CUSTOM06*: TValueType = 30
  TYPE_CUSTOM07*: TValueType = 31
  TYPE_CUSTOM08*: TValueType = 32
  TYPE_CUSTOM09*: TValueType = 33
  TYPE_CUSTOM10*: TValueType = 34
  TYPE_CUSTOM11*: TValueType = 35
  TYPE_CUSTOM12*: TValueType = 36
  TYPE_CUSTOM13*: TValueType = 37
  TYPE_CUSTOM14*: TValueType = 38
  TYPE_CUSTOM15*: TValueType = 39
  TYPE_LIST*: TValueType = 1024

  MAX_TYPE: TValueType = TYPE_LIST or TYPE_CUSTOM15

type
  # generic value
  TValue* = object
    case kind*: TValueType
    of TYPE_BOOL: b*: bool
    of TYPE_CHAR: c*: char
    of TYPE_INT: i*: cint
    of TYPE_FLOAT: f*: float32
    of TYPE_STRING, TYPE_VALUELIST00..TYPE_VALUELIST15: s*: string
    of TYPE_COLOR: col*: TColor
    of TYPE_DICE: dice*: TDice
    of TYPE_CUSTOM00..TYPE_CUSTOM15: custom*: pointer
    of TYPE_LIST..MAX_TYPE: list*: seq[TValue]
    else: nil

  # parser listener
  PParserListener* = ref TParserListener
  TParserListener* = object
    new_struct*:   proc(str: PParserStruct, name: string): bool {.closure.}
    new_flag*:     proc(name: string): bool {.closure.}
    new_property*: proc(propname: string, value_type: TValueType, value: TValue): bool {.closure.}
    end_struct*:   proc(str: PParserStruct, name: string): bool {.closure.}
    error*:        proc(msg: string) {.closure.}

  TStructProp = tuple[name: string, value: TValueType, mandat: bool]
  TProp = tuple[name: string, value_type: TValueType, value: TValue]

  # parser structures
  PParserStruct* = ref TParserStruct
  TParserStruct* = object
    name: string # entity type name
    flags: seq[string] # list of flags
    props: seq[TStructProp] # list of properties (name, type, mandatory)
    lists: seq[seq[string]] # list of value lists
    structs: seq[PParserStruct] # list of sub-structures

  # the parser
  PParser* = ref TParser
  TParser* = object
    structs: seq[PParserStruct] # list of structures
    customs: array[0..15, PParserCustom] # list of custom type parsers
    fatal: bool # fatal error occured
    props: seq[TProp] # list of properties if default listener is used

  # a custom type parser
  PParserCustom* = proc(lex: PLex, listener: PParserListener, str: PParserStruct, propname: string): TValue {.closure.}


#======= PRIVATE =======#

const
  BIG_NAME_LEN = 128

var
  lex: PLex = nil
  listener, default_listener: PParserListener

# default listener
proc default_new_struct(str: PParserStruct, name: string): bool {.closure.}
proc default_new_flag(name: string): bool {.closure.}
proc default_new_property(propname: string, value_type: TValueType, value: TValue): bool {.closure.}
proc default_end_struct(str: PParserStruct, name: string): bool {.closure.}
proc default_error(msg: string) {.closure.}

new(default_listener)
default_listener.new_struct = default_new_struct
default_listener.new_flag = default_new_flag
default_listener.new_property = default_new_property
default_listener.end_struct = default_end_struct
default_listener.error = default_error


#======= PROCEDURES =======#

proc parser_error*(msg: string, args: varargs[string, `$`]) =
  var err = "error in $# line $# : " % [$lex.filename, $lex.file_line]
  addf(err, msg, args)
  listener.error(err)
  lex.token_type = LEX_ERROR


proc struct_get_name*(def: PParserStruct): string {.inline.} =
  return def.name


proc struct_add_property*(def: PParserStruct, name: string, value_type: TValueType, mandatory: bool) {.inline.} =
  ## add a property to an entity definition
  def.props.add((name, value_type, mandatory))


proc struct_add_list_property*(def: PParserStruct, name: string, value_type: TValueType, mandatory: bool) {.inline.} =
  ## add a list property to an entity definition
  struct_add_property(def, name, TValueType(int(value_type) or int(TYPE_LIST)), mandatory)


proc struct_add_value_list*(def: PParserStruct, name: string, value_list: seq[string], mandatory: bool) =
  ## add a value-list property to an entity definition
  let value_type = TValueType(int(TYPE_VALUELIST00) + len(def.lists))
  struct_add_property(def, name, value_type, mandatory)
  def.lists.add(value_list)


proc struct_add_value_list_sized*(def: PParserStruct, name: string, value_list: seq[string], size: int, mandatory: bool) {.inline.} =
  ## do not use, use struct_add_value_list instead
  struct_add_value_list(def, name, value_list, mandatory)


proc struct_add_flag*(def: PParserStruct, propname: string) {.inline.} =
  ## add a flag (simplified bool value) to an entity definition
  ##
  ## a flag cannot be mandatory. if present => true, if omitted => false
  def.flags.add(propname)


proc struct_add_structure*(def: PParserStruct, sub_structure: PParserStruct) {.inline.} =
  ## add a sub-entity to an entity definition
  def.structs.add(sub_structure)


proc struct_is_mandatory*(def: PParserStruct, propname: string): bool =
  for prop in def.props:
    if cmp(prop.name, propname) == 0:
      return prop.mandat
  return false


proc struct_get_type*(def: PParserStruct, propname: string): TValueType =
  ## returns the type of given property
  ##
  ## TYPE_NONE if the property does not exist
  for prop in def.props.items():
    if cmp(prop.name, propname) == 0:
      return prop.value
  for flag in def.flags:
    if cmp(flag, propname) == 0:
      return TYPE_BOOL
  return TYPE_NONE




proc parse_bool_value*(): TValue =
  result.kind = TYPE_BOOL
  if cmp($lex.tok, "true") == 0:
    result.b = true
  elif cmp($lex.tok, "false") == 0:
    result.b = false
  else:
    parser_error("parseBoolValue : unknown value $# for bool. 'true' of 'false' expected", $lex.tok)


proc parse_char_value*(): TValue =
  result.kind = TYPE_CHAR
  if (lex.token_type != LEX_CHAR) and (lex.token_type != LEX_INTEGER):
    parser_error("parseCharValue : char constant expected instead of '$#'", $lex.tok)
  result.c = chr(lex.token_int_val)


proc parse_integer_value*(): TValue =
  result.kind = TYPE_INT
  if lex.token_type != LEX_INTEGER:
    parser_error("parseIntegerValue : integer constant expected instead of '$#'", $lex.tok)
  result.i = lex.token_int_val


proc parse_float_value*(): TValue =
  result.kind = TYPE_FLOAT
  if (lex.token_type != LEX_FLOAT) and (lex.token_type != LEX_INTEGER):
    parser_error("parseFloatValue : float constant expected insead of '$#'", $lex.tok)
  if lex.token_type == LEX_FLOAT:
    result.f = lex.token_float_val
  else:
    result.f = float32(lex.token_int_val)


proc parse_string_value*(): TValue =
  result.kind = TYPE_STRING
  result.s = ""
  if lex.token_type != LEX_STRING:
    parser_error("parseStringValue : string constant expected instead of '$#'", $lex.tok)
  while true:
    var save: TLex
    result.s.add($lex.tok)
    lex_savepoint(lex, addr(save))
    if lex_parse(lex) != LEX_STRING:
      lex_restore(lex, addr(save))
      break


proc parse_color_value*(): TValue =
  result.kind = TYPE_COLOR
  if (lex.token_type == LEX_SYMBOL) and (lex.tok[0] == '#'):
    var
      tmp: string
      tok: int = lex_parse(lex)
    # format : col = #FFFFFF
    tmp.add('#')
    if (tok == LEX_IDEN) or (tok == LEX_INTEGER):
      tmp.add($lex.tok)
      lex.tok = substr(tmp)
      if (len(lex.tok) < 7) and (tok == LEX_INTEGER):
        # special case of #12AABB => symbol # + integer 12 + iden AABB
        tok = lex_parse(lex)
        if tok == LEX_IDEN:
          tmp.add($lex.tok)
          lex.tok = substr(tmp)
      lex.token_type = LEX_STRING
  if lex.token_type != LEX_STRING:
    parser_error("parseColorValue : string constant expected instead of '$#'", $lex.tok)
  if lex.tok[0] == '#':
    var r, g, b: int
    if len(lex.tok) != 7:
      parser_error("parseColorValue : bad color format. '#rrggbb' expected instead of '$#'", $lex.tok)
    # web format : #rrggbb
    r = parseHexInt(substr($lex.tok, 1, 2))
    g = parseHexInt(substr($lex.tok, 3, 4))
    b = parseHexInt(substr($lex.tok, 5, 6))
    result.col = (uint8(r), uint8(g), uint8(b))
  else:
    # standart format : rrr,ggg,bbb
    var rgb: seq[string] = split($lex.tok, ',')
    if len(rgb) != 3:
      parser_error("parseColorValue : bad color format 'rrr,ggg,bbb' expected instead of '$#'", $lex.tok)
    else:
      result.col = (uint8(parseInt(rgb[0])), uint8(parseInt(rgb[1])), uint8(parseInt(rgb[2])))


proc parse_dice_value*(): TValue =
  ## dice format : [<m>(x|*)]<n>(D|d)<f>[(+|-)<a>]
  result.kind = TYPE_DICE
  result.dice.multiplier = 1.0
  result.dice.addsub = 0.0
  var
    minus = false
    begin = 0
    p = 0
  # multiplier
  p = find($lex.tok, 'x')
  if p < 0:
    p = find($lex.tok, '*')
  if p > 0:
    # parse multiplier
    result.dice.multiplier = float32(parseFloat(substr($lex.tok, begin, p-1)))
    begin = p + 1
  # nb_rolls
  p = find($lex.tok, 'D')
  if p < 0:
    p = find($lex.tok, 'd')
  if p < 0:
    parser_error("parseDiceValue : bad dice format. [<m>(x|*)]<n>(D|d)<f>[(+|-)<a>] expected instead of '$#'", $lex.tok)
  # parse nb_rolls
  result.dice.nb_rolls = cint(parseInt(substr($lex.tok, begin, p-1)))
  begin = p + 1
  # faces
  p = find($lex.tok, '+')
  if p < 0:
    p = find($lex.tok, '-')
    if p > 0:
      minus = true
  # parse faces
  if p < 0:
    result.dice.nb_faces = cint(parseInt(substr($lex.tok, begin)))
  else:
    result.dice.nb_faces = cint(parseInt(substr($lex.tok, begin, p-1)))
  if p > 0:
    # parse addsub
    begin = p + 1
    result.dice.addsub = float32(parseFloat(substr($lex.tok, begin)))
    if minus:
      result.dice.addsub = -result.dice.addsub


proc parse_value_list_value*(def: PParserStruct, listnum: int): TValue =
  var
    value_list = def.lists[listnum]
    value_idx = -1
  if lex.token_type != LEX_STRING:
    parser_error("parseValueListValue : string constant expected instead of '$#'", $lex.tok)
  for i in 0..value_list.high:
    if cmp($lex.tok, value_list[i]) == 0:
      value_idx = i
      break
  if value_idx < 0:
    parser_error("parseValueListValue : incorrect value '$#'", $lex.tok)
  result.kind = TValueType(int(TYPE_VALUELIST00) + value_idx)
  result.s = value_list[value_idx]


proc parse_property_value*(parser: PParser, def: PParserStruct, propname: string, list: bool): TValue =
  var
    value_type: TValueType = struct_get_type(def, propname)
  result.kind = value_type
  if not list:
    value_type = TValueType(int(value_type) and not int(TYPE_LIST))
  if (int(value_type) and int(TYPE_LIST)) != 0:
    value_type = TValueType(int(value_type) and not int(TYPE_LIST))
    if cmp($lex.tok, "[") != 0:
      parser_error("'[' expected for list value instead of '$#'", $lex.tok)
    result.list = @[]
    while true:
      var
        val: TValue
        tok = lex_parse(lex)
      if (tok == LEX_EOF) or (tok == LEX_ERROR):
        parser_error("Missing ']' in list value")
      val = parse_property_value(parser, def, propname, false)
      result.list.add(val)
      # TODO DELETE
      #if (value_type == TYPE_STRING or ((value_type >= TYPE_VALUELIST00) and (value_type <= TYPE_VALUELIST15))):
      #  result.list.add(val)
      #else:
      #  result.list.add(val)
      discard lex_parse(lex)
      if (cmp($lex.tok, ",") != 0) and (cmp($lex.tok, "]") != 0):
        parser_error("',' or ']' expected in list value instead of '$#'", $lex.tok)
      if cmp($lex.tok, "]") == 0:
        break
  else:
    case value_type
    of TYPE_BOOL: return parse_bool_value()
    of TYPE_CHAR: return parse_char_value()
    of TYPE_INT: return parse_integer_value()
    of TYPE_FLOAT: return parse_float_value()
    of TYPE_STRING: return parse_string_value()
    of TYPE_COLOR: return parse_color_value()
    of TYPE_DICE: return parse_dice_value()
    of TYPE_VALUELIST00..TYPE_VALUELIST_15:
      var listnum = int(value_type) - int(TYPE_VALUELIST00)
      return parse_value_list_value(def, listnum)
    of TYPE_CUSTOM00..TYPE_CUSTOM15:
      var customnum = (int(value_type) - int(TYPE_CUSTOM00))
      if len(parser.customs) > customnum:
        return parser.customs[customnum](lex, listener, def, propname)
      else:
        parser_error("parser_property_value : no custom parser for property type $# for entity $# prop $#", value_type, def.name, propname)
    else:
      parser_error("parse_property_value : unknown property type $# for entity $# prop $#", value_type, def.name, propname)


proc parser_new_struct*(parser: PParser, name: string): PParserStruct

proc parser_parse_entity*(parser: PParser, def: PParserStruct): bool =
  var name: string = ""
  if lex_parse(lex) == LEX_STRING:
    # entity type name
    name = $lex.tok
    discard lex_parse(lex)
  if cmp($lex.tok, "{") != 0:
    parser_error("Parser::parseEntity : '{' expected")
    return false
  discard lex_parse(lex)
  while(cmp($lex.tok, "}") != 0):
    var
      found = false
      dynStruct = false
      dynType: TValueType = TYPE_NONE
    if lex.token_type == LEX_KEYWORD:
      # dynamic property declaration
      if cmp($lex.tok, "bool") == 0: dynType = TYPE_BOOL
      elif cmp($lex.tok, "char") == 0: dynType = TYPE_CHAR
      elif cmp($lex.tok, "int") == 0: dynType = TYPE_INT
      elif cmp($lex.tok, "float") == 0: dynType = TYPE_FLOAT
      elif cmp($lex.tok, "string") == 0: dynType = TYPE_STRING
      elif cmp($lex.tok, "color") == 0: dynType = TYPE_COLOR
      elif cmp($lex.tok, "dice") == 0: dynType = TYPE_DICE
      elif cmp($lex.tok, "struct") == 0: dynStruct = true
      else:
        parser_error("Parser::parseEntity : dynamic declaration of '$#' not supported", $lex.tok)
        return false
      # TODO : dynamically decalred sub-structures
      discard lex_parse(lex)
      if cmp($lex.tok, "[") == 0:
        if dynType == TYPE_NONE:
          parser_error("Parser::parseEntity : unexpected symbol '['")
          return false
        discard lex_parse(lex)
        if cmp($lex.tok, "]") != 0:
          parser_error("Parser::parseEntity : syntax error. ']' expected instead of '$#'", $lex.tok)
          return false
        dynType = TValueType(int(dynType) or int(TYPE_LIST))
        discard lex_parse(lex)
    # parse entity type content
    if lex.token_type != LEX_IDEN:
      parser_error("Parser::parseEntity : identifier expected")
      return false
    # is it a flag ?
    if not dynStruct and (dynType == TYPE_NONE):
      for iflag in def.flags.items():
        if cmp(iflag, $lex.tok) == 0:
          found = true
          if not listener.new_flag($lex.tok):
            return false
          break
    if not found and not dynStruct:
      while true:
        # is it a property ?
        for iprop in def.props.items():
          if cmp(iprop.name, $lex.tok) == 0:
            var propname: string = $lex.tok
            discard lex_parse(lex)
            if cmp($lex.tok, "=") != 0:
              parser_error("Parser::parseEntity : '=' expected")
              return false
            discard lex_parse(lex)
            if not listener.new_property(propname, struct_get_type(def, propname), parse_property_value(parser, def, propname, true)):
              return false
            if lex.token_type == LEX_ERROR:
              return false
            found = true
            break
        if not found and (dynType != TYPE_NONE):
          # dynamically add a property to the current structure
          struct_add_property(def, $lex.tok, dynType, false)
        if not (not found and (dynType != TYPE_NONE)):
          break
    if not found:
      # is it a sub-entity type
      var
        id: string
        blockFound = false
      while true:
        var
          save: TLex
          kind: string
          subname: string = ""
          named = false
        lex_savepoint(lex, addr(save))
        kind = $lex.tok
        id = kind
        if lex_parse(lex) == LEX_STRING:
          # <type>#<name>
          id.add("#")
          id.add($lex.tok)
          named = true
          subname = $lex.tok
          lex_restore(lex, addr(save))
          for sub in def.structs.items():
            if cmp(sub.name, id) == 0:
              if not listener.new_struct(sub, $lex.tok):
                return false
              if not parser_parse_entity(parser, sub):
                return false
              blockFound = true
              found = true
              break
        else:
          lex_restore(lex, addr(save))
        if not blockFound:
          # <type> alone
          for sub in def.structs.items():
            if cmp(sub.name, kind) == 0:
              if not listener.new_struct(sub, subname):
                return false
              if not parser_parse_entity(parser, sub):
                return false
              blockFound = true
              found = true
              break
        if not blockFound and dynStruct:
          # unknown structure. auto-declaration
          var
            s: PParserStruct = nil
          for idef in parser.structs.items():
            if cmp(idef.name, id) == 0:
              s = idef
              break
          if s == nil and named:
            # look for general definition <type> for entity <type>#<name>
            for idef in parser.structs.items():
              if cmp(idef.name, kind) == 0:
                s = idef
                break
          if s == nil:
            # dyn struct not found. create it
            s = parser_new_struct(parser, kind)
          struct_add_structure(def, s)
        if not (not blockFound and dynStruct):
          break
      if not blockFound:
        parser_error("Parser::parseEntity : entity type $# does not contain $#", def.name, id)
        return false
    discard lex_parse(lex)
  if not listener.end_struct(def, name):
    return false
  return true


#
# generic parser
#

var
  symbols, keywords: cstringArray
  cur_parser: PParser = nil


proc parser_new*(): PParser =
  new(result)
  result.structs = @[]
  result.props = @[]


proc parser_new_custom_type*(parser: PParser, custom_type_parser: PParserCustom): TValueType =
  var kind = TYPE_CUSTOM00
  while parser.customs[int(kind) - int(TYPE_CUSTOM00)] != nil and kind < TYPE_CUSTOM15:
    kind = TValueType(int(kind) + 1)
  if parser.customs[int(kind) - int(TYPE_CUSTOM00)] != nil:
    # no more custom types slots available
    return TYPE_NONE
  parser.customs[int(kind) - int(TYPE_CUSTOM00)] = custom_type_parser
  return kind


proc parser_new_struct*(parser: PParser, name: string): PParserStruct =
  new(result)
  result.name = name
  result.flags = @[]
  result.props = @[]
  result.lists = @[]
  result.structs = @[]
  parser.structs.add(result)
  return result


proc parser_delete*(parser: PParser) {.inline.} =
  deallocCstringArray(symbols)
  deallocCstringArray(keywords)


# parse a file

proc parser_run*(parser: PParser, filename: string, plistener: PParserListener = nil) =
  ## triggers callbacks in the listener for each event during parsing
  if plistener == nil:
    listener = default_listener
  else:
    listener = plistener
  cur_parser = parser
  symbols = allocCstringArray(["{","}","=","/","+","-","[","]",",","#"])
  keywords = allocCstringArray(["struct","bool","char","int","float","string","color","dice"])
  lex = lex_new(symbols, keywords, "//", "/*", "*/", nil, "\"", LEX_FLAG_NESTING_COMMENT)
  if not lex_set_data_file(lex, filename):
    listener.error("Fatal error : $#\n" % $lex_get_last_error())
    return

  while true:
    var
      named = false
      id, kind: string
      save: TLex
      def: PParserStruct = nil
      dynStruct = false
    discard lex_parse(lex)
    if (lex.token_type == LEX_EOF) or (lex.token_type == LEX_ERROR):
      break
    if lex.token_type == LEX_KEYWORD:
      if cmp($lex.tok, "struct") == 0:
        # level 0 dynamic structure declaration
        dynStruct = true
        discard lex_parse(lex)
      else:
        parser_error("Parser::parse : unexpected keyword '$#'", $lex.tok)
        return
    # get entity type
    if lex.token_type != LEX_IDEN:
      parser_error("Parser::parse : identifier token expected")
      return
    kind = $lex.tok
    id = kind
    lex_savepoint(lex, addr(save))
    if lex_parse(lex) == LEX_STRING:
      # named entity. id = <type>#<name>
      id.add("#")
      if len(lex.tok) >= BIG_NAME_LEN:
        parser_error("Parser::parse : name $# too long. Max $# characters", $lex.tok, BIG_NAME_LEN-1)
        return
      id.add($lex.tok)
      named = true
    lex_restore(lex, addr(save))
    while true:
      # look for a definition for id
      for idef in parser.structs.items():
        if cmp(idef.name, id) == 0:
          def = idef
          break
      if def == nil and named:
        # look for general definition <type> for entity <type>#<name>
        for idef in parser.structs.items():
          if cmp(idef.name, kind) == 0:
            def = idef
            break
      if def == nil and dynStruct:
         # dyn struct not found. create it
         discard parser_new_struct(parser, kind)
      if not (def == nil and dynStruct):
        break
    # end while
    
    if def == nil:
      parser_error("Parser::parse : unknown entity type $#", kind)
      return
    else:
      var name: string
      if named:
        name = substr(id, find(id, '#')+1)
      else:
        name = ""
      if not listener.new_struct(def, name):
        return
      if not parser_parse_entity(parser, def):
        return
  # end while

  if lex.token_type == LEX_ERROR:
    parser_error("Parser::parse : error while parsing")
    return
  lex_delete(lex)


# default parser listener

var
  cur_prop_name: string = ""


proc default_new_struct(str: PParserStruct, name: string): bool =
  if len(cur_prop_name) > 0:
    cur_prop_name.add(".")
  cur_prop_name.add(str.name)
  return true


proc default_new_flag(name: string): bool =
  var prop: TProp
  prop.name = "$#.$#" % [cur_prop_name, name]
  prop.value_type = TYPE_BOOL
  prop.value.kind = TYPE_BOOL
  prop.value.b = true
  cur_parser.props.add(prop)
  return true


proc default_new_property(propname: string, value_type: TValueType, value: TValue): bool =
  var prop: TProp
  prop.name = "$#.$#" % [cur_prop_name, propname]
  prop.value_type = value_type
  prop.value = value
  cur_parser.props.add(prop)
  return true


proc default_end_struct(str: PParserStruct, name: string): bool =
  var idx = rfind(cur_prop_name, ".")
  if idx >= 0:
    cur_prop_name = substr(cur_prop_name, 0, idx-1)
  else:
    cur_prop_name = ""
  return true


proc TCOD_parser_error(msg: cstring) {.cdecl, importc: "TCOD_parser_error", dynlib: LIB_NAME.}
proc default_error(msg: string) =
  TCOD_parser_error(msg)


proc get_property(parser: PParser, expectedType: TValueType, name: string): TValue =
  var
    str: PParserStruct = nil
    kind: TValueType
  if len(cur_parser.props) < 1:
    result.kind = TYPE_NONE
    return
  for prop in cur_parser.props.items():
    if cmp(prop.name, name) == 0:
      # property found. check type
      if (expectedType == TYPE_STRING) and
         (prop.value_type >= TYPE_VALUELIST00) and
         (prop.value_type <= TYPE_VALUELIST15):
        return prop.value
      if (expectedType == TYPE_CUSTOM00) and
         (prop.value_type >= TYPE_CUSTOM00) and
         (prop.value_type <= TYPE_CUSTOM15):
        return prop.value
      if prop.value_type != expectedType:
        default_listener.error("Fatal error ! Try to read property '$#' with bad type\n" % name)
      return prop.value
  # property not found. Check if it exists
  var
    tmp = name
    p = find(tmp, '.')
    curname = tmp
    err = "Fatal error ! Try to read unknown property '$#'\n" % name
  while p != -1:
    var found = false
    p = -1
    for s in cur_parser.structs.items():
      str = s
      if cmp(str.name, curname) == 0:
        found = true
    if not found:
      # one of the structures is unknown
      default_listener.error(err)
    curname = substr(curname, p+1)
    p = find(curname, '.')
  if str == nil:
    # no structure in name
    default_listener.error(err)
  kind = struct_get_type(str, curname)
  if kind == TYPE_NONE:
    # property does not exist in structure
    default_listener.error(err)
  # optional property not defined in the file => ok
  result.kind = TYPE_NONE


proc parser_get_bool_property*(parser: PParser, name: string): bool =
  let value = get_property(parser, TYPE_BOOL, name)
  if value.kind == TYPE_NONE: return false
  else: return value.b


proc parser_get_char_property*(parser: PParser, name: string): char =
  let value = get_property(parser, TYPE_CHAR, name)
  if value.kind == TYPE_NONE: return chr(0)
  else: return value.c


proc parser_get_int_property*(parser: PParser, name: string): cint =
  let value = get_property(parser, TYPE_INT, name)
  if value.kind == TYPE_NONE: return 0
  else: return value.i


proc parser_get_float_property*(parser: PParser, name: string): float32 =
  let value = get_property(parser, TYPE_FLOAT, name)
  if value.kind == TYPE_NONE: return 0.0
  else: return value.f


proc parser_get_string_property*(parser: PParser, name: string): string =
  let value = get_property(parser, TYPE_STRING, name)
  if value.kind == TYPE_NONE: return ""
  else: return value.s


proc parser_get_color_property*(parser: PParser, name: string): TColor =
  let value = get_property(parser, TYPE_COLOR, name)
  if value.kind == TYPE_NONE: return BLACK
  else: return value.col


proc parser_get_dice_property*(parser: PParser, name: string): TDice =
  var default_dice: TDice = (cint(0), cint(0), float32(0.0), float32(0.0))
  let value = get_property(parser, TYPE_DICE, name)
  if value.kind == TYPE_NONE: return default_dice
  else: return value.dice


proc parser_get_dice_property_py*(parser: PParser, name: string, dice: var TDice) {.inline.} =
  dice = parser_get_dice_property(parser, name)


proc parser_get_custom_property*(parser: PParser, name: string): pointer =
  let value = get_property(parser, TYPE_CUSTOM00, name)
  if value.kind == TYPE_NONE: return nil
  else: return value.custom


proc parser_get_list_property*(parser: PParser, name: string, value_type: TValueType): seq[TValue] =
  let value = get_property(parser, TValueType(int(TYPE_LIST) or int(value_type)), name)
  if value.kind == TYPE_NONE: return @[]
  else: return value.list


# THIS IS NOT NATIVE LIBTCOD PROCEDURES DOWN HERE


proc parser_get_list_bool_property*(parser: PParser, name: string): seq[bool] =
  let list = parser_get_list_property(parser, name, TYPE_BOOL)
  result = @[]
  for i in list.items():
    result.add(i.b)


proc parser_get_list_char_property*(parser: PParser, name: string): seq[char] =
  let list = parser_get_list_property(parser, name, TYPE_CHAR)
  result = @[]
  for i in list.items():
    result.add(i.c)


proc parser_get_list_int_property*(parser: PParser, name: string): seq[int] =
  let list = parser_get_list_property(parser, name, TYPE_INT)
  result = @[]
  for i in list.items():
    result.add(i.i)


proc parser_get_list_float_property*(parser: PParser, name: string): seq[float] =
  let list = parser_get_list_property(parser, name, TYPE_FLOAT)
  result = @[]
  for i in list.items():
    result.add(i.f)


proc parser_get_list_string_property*(parser: PParser, name: string): seq[string] =
  let list = parser_get_list_property(parser, name, TYPE_STRING)
  result = @[]
  for i in list.items():
    result.add(i.s)


proc parser_get_list_color_property*(parser: PParser, name: string): seq[TColor] =
  let list = parser_get_list_property(parser, name, TYPE_COLOR)
  result = @[]
  for i in list.items():
    result.add(i.col)


proc parser_get_list_dice_property*(parser: PParser, name: string): seq[TDice] =
  let list = parser_get_list_property(parser, name, TYPE_DICE)
  result = @[]
  for i in list.items():
    result.add(i.dice)


