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


# utility proc
proc lerp*[T](a, b, x: T): T =
  return a + x * (b - a)


include
  libtcod_nim/private/libtcod_define,
  libtcod_nim/private/color,
  libtcod_nim/private/console,
  libtcod_nim/private/mouse,
  libtcod_nim/private/image,
  libtcod_nim/private/sys,
  libtcod_nim/private/mersenne,
  libtcod_nim/private/noise,
  libtcod_nim/private/bresenham,
  libtcod_nim/private/tree,
  libtcod_nim/private/bsp,
  libtcod_nim/private/fov,
  libtcod_nim/private/path,
  libtcod_nim/private/heightmap,
  libtcod_nim/private/lex,
  libtcod_nim/private/parser,
  libtcod_nim/private/zip,
  libtcod_nim/private/namegen,
  libtcod_nim/private/txtfield

