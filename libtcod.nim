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


when defined tcod151:
  include
    src151/libtcod_define,
    src151/color,
    src151/console,
    src151/mouse,
    src151/image,
    src151/sys,
    src151/mersenne,
    src151/noise,
    src151/bresenham,
    src151/tree,
    src151/bsp,
    src151/fov,
    src151/path,
    src151/heightmap,
    src151/lex,
    src151/parser,
    src151/zip,
    src151/namegen,
    src151/txtfield

else: # tcod170
  include
    src170/libtcod_define,
    #
    src170/color,
    src170/console_types,
    src170/fov_types,
    src170/image,
    src170/list,
    src170/lex,
    src170/mersenne_types,
    src170/mouse_types,
    src170/noise_defaults,
    src170/noise,
    src170/tree,
    #
    src170/bresenham,
    src170/bsp,
    src170/console,
    src170/console_rexpaint,
    src170/fov,
    src170/heightmap,
    src170/mersenne,
    src170/mouse,
    src170/namegen,
    src170/parser,
    src170/path,
    src170/sys,
    src170/txtfield,
    #src170/wrappers,
    src170/zip

