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
  TKeycode* {.size: sizeof(cint).} = enum
    K_NONE,
    K_ESCAPE,
    K_BACKSPACE,
    K_TAB,
    K_ENTER,
    K_SHIFT,
    K_CONTROL,
    K_ALT,
    K_PAUSE,
    K_CAPSLOCK,
    K_PAGEUP,
    K_PAGEDOWN,
    K_END,
    K_HOME,
    K_UP,
    K_LEFT,
    K_RIGHT,
    K_DOWN,
    K_PRINTSCREEN,
    K_INSERT,
    K_DELETE,
    K_LWIN,
    K_RWIN,
    K_APPS,
    K_0,
    K_1,
    K_2,
    K_3,
    K_4,
    K_5,
    K_6,
    K_7,
    K_8,
    K_9,
    K_KP0,
    K_KP1,
    K_KP2,
    K_KP3,
    K_KP4,
    K_KP5,
    K_KP6,
    K_KP7,
    K_KP8,
    K_KP9,
    K_KPADD,
    K_KPSUB,
    K_KPDIV,
    K_KPMUL,
    K_KPDEC,
    K_KPENTER,
    K_F1,
    K_F2,
    K_F3,
    K_F4,
    K_F5,
    K_F6,
    K_F7,
    K_F8,
    K_F9,
    K_F10,
    K_F11,
    K_F12,
    K_NUMLOCK,
    K_SCROLLLOCK,
    K_SPACE,
    K_CHAR

  # key data : special code or character
  TKey*{.bycopy.} = object
    vk*: TKeycode
    #empty1, empty2, empty3: uint8
    c*: char
    pressed*: bool
    lalt*: bool
    lctrl*: bool
    ralt*: bool
    rctrl*: bool
    shift*: bool

  TColctrl* {.size: sizeof(cint).} = enum
    COLCTRL_1 = 1,
    COLCTRL_2,
    COLCTRL_3,
    COLCTRL_4,
    COLCTRL_5,
    COLCTRL_FORE_RGB,
    COLCTRL_BACK_RGB,
    COLCTRL_STOP

  TBkgndFlag* = int

  TRenderer* {.size: sizeof(cint).} = enum
    RENDERER_GLSL,
    RENDERER_OPENGL,
    RENDERER_SDL,
    NB_RENDERERS

  TAlignment* {.size: sizeof(cint).} = enum
    LEFT,
    RIGHT,
    CENTER

const
  KEY_PRESSED* = 1
  KEY_RELEASED* = 2

  COLCTRL_NUMBER* = COLCTRL_5

  # custom font flags
  FONT_LAYOUT_ASCII_INCOL* = 1
  FONT_LAYOUT_ASCII_INROW* = 2
  FONT_TYPE_GRAYSCALE* = 4
  FONT_TYPE_GREYSCALE* = 4
  FONT_LAYOUT_TCOD* = 8

  # background flags
  BKGND_NONE* = 0
  BKGND_SET* = 1
  BKGND_MULTIPLY* = 2
  BKGND_LIGHTEN* = 3
  BKGND_DARKEN* = 4
  BKGND_SCREEN* = 5
  BKGND_COLOR_DODGE* = 6
  BKGND_COLOR_BURN* = 7
  BKGND_ADD* = 8
  BKGND_ADDA* = 9
  BKGND_BURN* = 10
  BKGND_OVERLAY* = 11
  BKGND_ALPH* = 12
  BKGND_DEFAULT* = 13

  # chars
  CHAR_SMILIE* = 1
  CHAR_SMILIE_INV* = 2
  CHAR_HEART* = 3
  CHAR_DIAMOND* = 4
  CHAR_CLUB* = 5
  CHAR_SPADE* = 6
  CHAR_BULLET* = 7
  CHAR_BULLET_INV* = 8
  CHAR_RADIO_UNSET* = 9
  CHAR_RADIO_SET* = 10
  CHAR_MALE* = 11
  CHAR_FEMALE* = 12
  CHAR_NOTE* = 13
  CHAR_NOTE_DOUBLE* = 14
  CHAR_LIGHT* = 15
  CHAR_ARROW2_E* = 16
  CHAR_ARROW2_W* = 17
  CHAR_DARROW_V* = 18
  CHAR_EXCLAM_DOUBLE* = 19
  CHAR_PILCROW* = 20
  CHAR_SECTION* = 21
  CHAR_ARROW_N* = 24
  CHAR_ARROW_S* = 25
  CHAR_ARROW_E* = 26
  CHAR_ARROW_W* = 27
  CHAR_DARROW_H* = 29
  CHAR_ARROW2_N* = 30
  CHAR_ARROW2_S* = 31
  CHAR_POUND* = 156
  CHAR_MULTIPLICATION* = 158
  CHAR_FUNCTION* = 159
  CHAR_RESERVED* = 169
  CHAR_HALF* = 171
  CHAR_ONE_QUARTER* = 172
  CHAR_BLOCK1* = 176
  CHAR_BLOCK2* = 177
  CHAR_BLOCK3* = 178
  CHAR_VLINE* = 179
  CHAR_TEEW* = 180
  CHAR_COPYRIGHT* = 184
  CHAR_DTEEW* = 185
  CHAR_DVLINE* = 186
  CHAR_DNE* = 187
  CHAR_DSE* = 188
  CHAR_CENT* = 189
  CHAR_YEN* = 190
  CHAR_NE* = 191
  CHAR_SW* = 192
  CHAR_TEEN* = 193
  CHAR_TEES* = 194
  CHAR_TEEE* = 195
  CHAR_HLINE* = 196
  CHAR_CROSS* = 197
  CHAR_DSW* = 200
  CHAR_DNW* = 201
  CHAR_DTEEN* = 202
  CHAR_DTEES* = 203
  CHAR_DTEEE* = 204
  CHAR_DHLINE* = 205
  CHAR_DCROSS* = 206
  CHAR_CURRENCY* = 207
  CHAR_SE* = 217
  CHAR_NW* = 218
  CHAR_CHECKBOX_UNSET* = 224
  CHAR_CHECKBOX_SET* = 225
  CHAR_SUBP_NW* = 226
  CHAR_SUBP_NE* = 227
  CHAR_SUBP_N* = 228
  CHAR_SUBP_SE* = 229
  CHAR_SUBP_DIAG* = 230
  CHAR_SUBP_E* = 231
  CHAR_SUBP_SW* = 232
  CHAR_THREE_QUARTERS* = 243
  CHAR_DIVISION* = 246
  CHAR_GRADE* = 248
  CHAR_UMLAUT* = 249
  CHAR_POW1* = 251
  CHAR_POW3* = 252
  CHAR_POW2* = 253
  CHAR_BULLET_SQUARE* = 254

