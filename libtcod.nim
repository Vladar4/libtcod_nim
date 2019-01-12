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


when defined tcod15:
  include
    src15/libtcod_define,
    src15/color,
    src15/console,
    src15/mouse,
    src15/image,
    src15/sys,
    src15/mersenne,
    src15/noise,
    src15/bresenham,
    src15/tree,
    src15/bsp,
    src15/fov,
    src15/path,
    src15/heightmap,
    src15/lex,
    src15/parser,
    src15/zip,
    src15/namegen,
    src15/txtfield

elif defined tcod17:
  include
    src17/libtcod_define,
    #
    src17/color,
    src17/console_types,
    src17/fov_types,
    src17/image,
    src17/list,
    src17/lex,
    src17/mersenne_types,
    src17/mouse_types,
    src17/noise_defaults,
    src17/noise,
    src17/tree,
    #
    src17/bresenham,
    src17/bsp,
    src17/console,
    src17/console_rexpaint,
    src17/fov,
    src17/heightmap,
    src17/mersenne,
    src17/mouse,
    src17/namegen,
    src17/parser,
    src17/path,
    src17/sys,
    src17/txtfield,
    #src17/wrappers,
    src17/zip

else: # tcod110
  include
    src110/libtcod_define,
    #
    src110/color,
    src110/console_types,
    src110/fov_types,
    src110/image,
    src110/list,
    src110/lex,
    src110/mersenne_types,
    src110/mouse_types,
    src110/noise_defaults,
    src110/noise,
    src110/tree,
    #
    src110/bresenham,
    src110/bsp,
    src110/console,
    src110/console_drawing,
    src110/console_printing,
    src110/console_rexpaint,
    src110/engine,
    src110/fov,
    src110/heightmap,
    src110/mersenne,
    src110/mouse,
    src110/namegen,
    src110/parser,
    src110/path,
    src110/sys,
    src110/txtfield,
    src110/version,
    #src110/wrappers,
    src110/zip

