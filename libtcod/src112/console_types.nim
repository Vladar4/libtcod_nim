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

type
  Keycode* {.size: sizeof(cint).} = enum
    K_NONE, K_ESCAPE, K_BACKSPACE, K_TAB, K_ENTER, K_SHIFT, K_CONTROL, K_ALT,
    K_PAUSE, K_CAPSLOCK, K_PAGEUP, K_PAGEDOWN, K_END, K_HOME, K_UP, K_LEFT,
    K_RIGHT, K_DOWN, K_PRINTSCREEN, K_INSERT, K_DELETE, K_LWIN, K_RWIN, K_APPS,
    K_0, K_1, K_2, K_3, K_4, K_5, K_6, K_7, K_8, K_9,
    K_KP0, K_KP1, K_KP2, K_KP3, K_KP4, K_KP5, K_KP6, K_KP7, K_KP8, K_KP9,
    K_KPADD, K_KPSUB, K_KPDIV, K_KPMUL, K_KPDEC, K_KPENTER,
    K_F1, K_F2, K_F3, K_F4, K_F5, K_F6, K_F7, K_F8, K_F9, K_F10, K_F11, K_F12,
    K_NUMLOCK, K_SCROLLLOCK, K_SPACE, K_CHAR, K_TEXT

const
  KEY_TEXT_SIZE*: cint = 32


type
  Key* {.bycopy.} = object  ##  \
    ##  Key data : special code or character or text.
    vk*: Keycode  ##   key code
    c*: char      ##  character if vk == K_CHAR else 0
    text*: array[KEY_TEXT_SIZE, char] ##  \
      ##  text if vk == K_TEXT else text[0] == '\0'
    pressed*: bool ## does this correspond to a key press or key release event ?
    lalt*, lctrl*, lmeta*, ralt*, rctrl*, rmeta*, shift*: bool


const
  # single walls
  CHAR_HLINE*: cint = 196
  CHAR_VLINE*: cint = 179
  CHAR_NE*: cint = 191
  CHAR_NW*: cint = 218
  CHAR_SE*: cint = 217
  CHAR_SW*: cint = 192
  CHAR_TEEW*: cint = 180
  CHAR_TEEE*: cint = 195
  CHAR_TEEN*: cint = 193
  CHAR_TEES*: cint = 194
  CHAR_CROSS*: cint = 197

  # double walls
  CHAR_DHLINE*: cint = 205
  CHAR_DVLINE*: cint = 186
  CHAR_DNE*: cint = 187
  CHAR_DNW*: cint = 201
  CHAR_DSE*: cint = 188
  CHAR_DSW*: cint = 200
  CHAR_DTEEW*: cint = 185
  CHAR_DTEEE*: cint = 204
  CHAR_DTEEN*: cint = 202
  CHAR_DTEES*: cint = 203
  CHAR_DCROSS*: cint = 206

  # blocks
  CHAR_BLOCK1*: cint = 176
  CHAR_BLOCK2*: cint = 177
  CHAR_BLOCK3*: cint = 178

  # arrows
  CHAR_ARROW_N*: cint = 24
  CHAR_ARROW_S*: cint = 25
  CHAR_ARROW_E*: cint = 26
  CHAR_ARROW_W*: cint = 27

  # arrows without tail
  CHAR_ARROW2_N*: cint = 30
  CHAR_ARROW2_S*: cint = 31
  CHAR_ARROW2_E*: cint = 16
  CHAR_ARROW2_W*: cint = 17

  # double arrows
  CHAR_DARROW_H*: cint = 29
  CHAR_DARROW_V*: cint = 18

  # GUI stuff
  CHAR_CHECKBOX_UNSET*: cint = 224
  CHAR_CHECKBOX_SET*: cint = 225
  CHAR_RADIO_UNSET*: cint = 9
  CHAR_RADIO_SET*: cint = 10

  # sub-pixel resolution kit
  CHAR_SUBP_NW*: cint = 226
  CHAR_SUBP_NE*: cint = 227
  CHAR_SUBP_N*: cint = 228
  CHAR_SUBP_SE*: cint = 229
  CHAR_SUBP_DIAG*: cint = 230
  CHAR_SUBP_E*: cint = 231
  CHAR_SUBP_SW*: cint = 232

  # miscellaneous
  CHAR_SMILIE*: cint = 1
  CHAR_SMILIE_INV*: cint = 2
  CHAR_HEART*: cint = 3
  CHAR_DIAMOND*: cint = 4
  CHAR_CLUB*: cint = 5
  CHAR_SPADE*: cint = 6
  CHAR_BULLET*: cint = 7
  CHAR_BULLET_INV*: cint = 8
  CHAR_MALE*: cint = 11
  CHAR_FEMALE*: cint = 12
  CHAR_NOTE*: cint = 13
  CHAR_NOTE_DOUBLE*: cint = 14
  CHAR_LIGHT*: cint = 15
  CHAR_EXCLAM_DOUBLE*: cint = 19
  CHAR_PILCROW*: cint = 20
  CHAR_SECTION*: cint = 21
  CHAR_POUND*: cint = 156
  CHAR_MULTIPLICATION*: cint = 158
  CHAR_FUNCTION*: cint = 159
  CHAR_RESERVED*: cint = 169
  CHAR_HALF*: cint = 171
  CHAR_ONE_QUARTER*: cint = 172
  CHAR_COPYRIGHT*: cint = 184
  CHAR_CENT*: cint = 189
  CHAR_YEN*: cint = 190
  CHAR_CURRENCY*: cint = 207
  CHAR_THREE_QUARTERS*: cint = 243
  CHAR_DIVISION*: cint = 246
  CHAR_GRADE*: cint = 248
  CHAR_UMLAUT*: cint = 249
  CHAR_POW1*: cint = 251
  CHAR_POW3*: cint = 252
  CHAR_POW2*: cint = 253
  CHAR_BULLET_SQUARE*: cint = 254

  # diacritics


type
  Colctrl* {.size: sizeof(cint).} = enum
    COLCTRL_1 = 1, COLCTRL_2, COLCTRL_3, COLCTRL_4, COLCTRL_5, # COLCTRL_NUMBER
    COLCTRL_FORE_RGB, COLCTRL_BACK_RGB, COLCTRL_STOP

const COLCTRL_NUMBER* = COLCTRL_5


const
  KEY_PRESSED*: cint = 1
  KEY_RELEASED*: cint = 2

  FONT_LAYOUT_ASCII_INCOL*: cint = 1  ##  \
    ##  These font flags can be OR'd together into a bit-field and passed to
    ##  ``console_set_custom_font``
    ##
    ##  Tiles are arranged in column-major order.
    ##  ::
    ##    0 3 6
    ##    1 4 7
    ##    2 5 8
    ##
  FONT_LAYOUT_ASCII_INROW*: cint = 2  ##  \
    ##  Tiles are arranged in row-major order.
    ##  ::
    ##    0 1 2
    ##    3 4 5
    ##    6 7 8
    ##
  FONT_TYPE_GREYSCALE*: cint = 4  ##  \
    ##  Converts all tiles into a monochrome gradient.
  FONT_TYPE_GRAYSCALE*: cint = FONT_TYPE_GREYSCALE
  FONT_LAYOUT_TCOD*: cint = 8     ##  \
    ##  A unique layout used by some of libtcod's fonts.
  FONT_LAYOUT_CP437*: cint = 16   ##  \
    ##  Decode a code page 437 tileset
    ##  into Unicode code-points.



type
  Renderer* {.size: sizeof(cint).} = enum ##  \
    ##   The available renderers.
    ##
    RENDERER_GLSL   ##  An OpenGL implementation using a shader.
    RENDERER_OPENGL ##  \
      ##  An OpenGL implementation without a shader.
      ##
      ##  Performs worse than `RENDERER_GLSL` without many benefits.
    RENDERER_SDL    ##  \
      ##  A software based renderer.
      ##
      ##  The font file is loaded into RAM
      ##  instead of VRAM in this implementation.
    RENDERER_SDL2   ##  \
      ##  A new SDL2 renderer. Allows the window to be resized.
    RENDERER_OPENGL2  ##  \
      ##  A new OpenGL 2.0 core renderer. Allows the window to be resized.
    NB_RENDERERS

