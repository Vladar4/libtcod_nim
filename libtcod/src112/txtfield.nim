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

# import color, console_types

type
  Text* = pointer


proc textInit*(
  x, y, w, h, maxChars: cint): Text {.
    cdecl, importc: "TCOD_text_init", dynlib: LIB_NAME.}

proc textInit2*(
  w, h, maxChars: cint): Text {.
    cdecl, importc: "TCOD_text_init2", dynlib: LIB_NAME.}

proc textSetPos*(
  txt: Text; x, y: cint) {.
    cdecl, importc: "TCOD_text_set_pos", dynlib: LIB_NAME.}

proc textSetProperties*(
  txt: Text; cursorChar, blinkInterval: cint; prompt: cstring; tabSize: cint) {.
    cdecl, importc: "TCOD_text_set_properties", dynlib: LIB_NAME.}

proc textSetColors*(
  txt: Text; fore, back: Color; backTransparency: cfloat) {.
    cdecl, importc: "TCOD_text_set_colors", dynlib: LIB_NAME.}

proc textUpdate*(
  txt: Text; key: Key): bool {.
    cdecl, importc: "TCOD_text_update", dynlib: LIB_NAME.}

proc textRender*(
  txt: Text; con: Console) {.
    cdecl, importc: "TCOD_text_render", dynlib: LIB_NAME.}

proc textGet*(
  txt: Text): cstring {.
    cdecl, importc: "TCOD_text_get", dynlib: LIB_NAME.}

proc textReset*(
  txt: Text) {.
    cdecl, importc: "TCOD_text_reset", dynlib: LIB_NAME.}

proc textDelete_internal(
  txt: Text) {.
    cdecl, importc: "TCOD_text_delete", dynlib: LIB_NAME.}

proc textDelete*(txt: var Text) =
  if txt != nil:
    textDelete_internal(txt)
    txt = nil

