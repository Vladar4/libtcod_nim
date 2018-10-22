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

# import color, console_types, image


type
  Zip* = pointer


proc zipNew*(): Zip {.
    cdecl, importc: "TCOD_zip_new", dynlib: LIB_NAME.}

proc zipDelete_internal(
  zip: Zip) {.
    cdecl, importc: "TCOD_zip_delete", dynlib: LIB_NAME.}

proc zipDelete*(zip: var Zip) =
  if zip != nil:
    zipDelete_internal(zip)
    zip = nil

proc zipPutChar*(
  zip: Zip; val: char) {.
    cdecl, importc: "TCOD_zip_put_char", dynlib: LIB_NAME.}
  ##  output interface

proc zipPutInt*(
  zip: Zip; val: cint) {.
    cdecl, importc: "TCOD_zip_put_int", dynlib: LIB_NAME.}

proc zipPutFloat*(
  zip: Zip; val: cfloat) {.
    cdecl, importc: "TCOD_zip_put_float", dynlib: LIB_NAME.}

proc zipPutString*(
  zip: Zip; val: cstring) {.
    cdecl, importc: "TCOD_zip_put_string", dynlib: LIB_NAME.}

proc zipPutColor*(
  zip: Zip; val: Color) {.
    cdecl, importc: "TCOD_zip_put_color", dynlib: LIB_NAME.}

proc zipPutImage*(
  zip: Zip; val: Image) {.
    cdecl, importc: "TCOD_zip_put_image", dynlib: LIB_NAME.}

proc zipPutConsole*(
  zip: Zip; val: Console) {.
    cdecl, importc: "TCOD_zip_put_console", dynlib: LIB_NAME.}

proc zipPutData*(
  zip: Zip; nbBytes: cint; data: pointer) {.
    cdecl, importc: "TCOD_zip_put_data", dynlib: LIB_NAME.}

proc zipGetCurrentBytes*(
  zip: Zip): uint32 {.
    cdecl, importc: "TCOD_zip_get_current_bytes", dynlib: LIB_NAME.}

proc zipSaveToFile*(
  zip: Zip; filename: cstring): cint {.
    cdecl, importc: "TCOD_zip_save_to_file", dynlib: LIB_NAME.}


proc zipLoadFromFile*(
  zip: Zip; filename: cstring): cint {.
    cdecl, importc: "TCOD_zip_load_from_file", dynlib: LIB_NAME.}
  ##  input interface

proc zipGetChar*(
  zip: Zip): char {.
    cdecl, importc: "TCOD_zip_get_char", dynlib: LIB_NAME.}

proc zipGetInt*(
  zip: Zip): cint {.
    cdecl, importc: "TCOD_zip_get_int", dynlib: LIB_NAME.}

proc zipGetFloat*(
  zip: Zip): cfloat {.
    cdecl, importc: "TCOD_zip_get_float", dynlib: LIB_NAME.}

proc zipGetString*(
  zip: Zip): cstring {.
    cdecl, importc: "TCOD_zip_get_string", dynlib: LIB_NAME.}

proc zipGetColor*(
  zip: Zip): Color {.
    cdecl, importc: "TCOD_zip_get_color", dynlib: LIB_NAME.}

proc zipGetImage*(
  zip: Zip): Image {.
    cdecl, importc: "TCOD_zip_get_image", dynlib: LIB_NAME.}

proc zipGetConsole*(
  zip: Zip): Console {.
    cdecl, importc: "TCOD_zip_get_console", dynlib: LIB_NAME.}

proc zipGetData*(
  zip: Zip; nbBytes: cint; data: pointer): cint {.
    cdecl, importc: "TCOD_zip_get_data", dynlib: LIB_NAME.}

proc zipGetRemainingBytes*(
  zip: Zip): uint32 {.
    cdecl, importc: "TCOD_zip_get_remaining_bytes", dynlib: LIB_NAME.}

proc zipSkipBytes*(zip: Zip; nbBytes: uint32) {.
    cdecl, importc: "TCOD_zip_skip_bytes", dynlib: LIB_NAME.}

