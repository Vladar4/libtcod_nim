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

# import color, console_types

type
  Image* = pointer


proc imageNew*(
  width, height: cint): Image {.
    cdecl, importc: "TCOD_image_new", dynlib: LIB_NAME.}

proc imageFromConsole*(
  console: Console): Image {.
    cdecl, importc: "TCOD_image_from_console", dynlib: LIB_NAME.}

proc imageRefreshConsole*(
  image: Image; console: Console) {.
    cdecl, importc: "TCOD_image_refresh_console", dynlib: LIB_NAME.}

proc imageLoad*(
  filename: cstring): Image {.
    cdecl, importc: "TCOD_image_load", dynlib: LIB_NAME.}

proc imageClear*(
  image: Image; color: Color) {.
    cdecl, importc: "TCOD_image_clear", dynlib: LIB_NAME.}

proc imageInvert*(
  image: Image) {.
    cdecl, importc: "TCOD_image_invert", dynlib: LIB_NAME.}

proc imageHflip*(
  image: Image) {.
    cdecl, importc: "TCOD_image_hflip", dynlib: LIB_NAME.}

proc imageRotate90*(
  image: Image; numRotations: cint = 1) {.
    cdecl, importc: "TCOD_image_rotate90", dynlib: LIB_NAME.}

proc imageVflip*(
  image: Image) {.
    cdecl, importc: "TCOD_image_vflip", dynlib: LIB_NAME.}

proc imageScale*(
  image: Image; neww, newh: cint) {.
    cdecl, importc: "TCOD_image_scale", dynlib: LIB_NAME.}

proc imageSave*(
  image: Image; filename: cstring) {.
    cdecl, importc: "TCOD_image_save", dynlib: LIB_NAME.}

proc imageGetSize*(
  image: Image; w, h: ptr cint) {.
    cdecl, importc: "TCOD_image_get_size", dynlib: LIB_NAME.}

proc imageGetPixel*(
  image: Image; x, y: cint): Color {.
    cdecl, importc: "TCOD_image_get_pixel", dynlib: LIB_NAME.}

proc imageGetAlpha*(
  image: Image; x, y: cint): cint {.
    cdecl, importc: "TCOD_image_get_alpha", dynlib: LIB_NAME.}

proc imageGetMipmapPixel*(
  image: Image; x0, y0, x1, y1: cfloat): Color {.
    cdecl, importc: "TCOD_image_get_mipmap_pixel", dynlib: LIB_NAME.}

proc imagePutPixel*(
  image: Image; x, y: cint; col: Color) {.
    cdecl, importc: "TCOD_image_put_pixel", dynlib: LIB_NAME.}

proc imageBlit*(
  image: Image; console: Console; x, y: cfloat;
  bkgndFlag: BkgndFlag = BKGND_SET;
  scalex: cfloat = 1.0;
  scaley: cfloat = 1.0;
  angle: cfloat = 0.0) {.
    cdecl, importc: "TCOD_image_blit", dynlib: LIB_NAME.}

proc imageBlitRect*(
  image: Image; console: Console; x, y: cint;
  w: cint = -1;
  h: cint = -1;
  bkgndFlag: BkgndFlag = BKGND_SET) {.
    cdecl, importc: "TCOD_image_blit_rect", dynlib: LIB_NAME.}

proc imageBlit2x*(
  image: Image; dest: Console; dx, dy: cint;
  sx: cint = 0;
  sy: cint = 0;
  w: cint = -1;
  h: cint = -1) {.
    cdecl, importc: "TCOD_image_blit_2x", dynlib: LIB_NAME.}

proc imageDelete_internal(
  image: Image) {.
    cdecl, importc: "TCOD_image_delete", dynlib: LIB_NAME.}

proc imageDelete*(image: var Image) =
  if not (image == nil):
    imageDelete_internal(image)
    image = nil

proc imageSetKeyColor*(
  image: Image; keyColor: Color) {.
    cdecl, importc: "TCOD_image_set_key_color", dynlib: LIB_NAME.}

proc imageIsPixelTransparent*(
  image: Image; x, y: cint): bool {.
    cdecl, importc: "TCOD_image_is_pixel_transparent", dynlib: LIB_NAME.}

