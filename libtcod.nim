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


# utility proc
proc lerp*[T](a, b, x: T): T =
  return a + x * (b - a)


when defined tcod15:
  include
    libtcod/src15/libtcod_define,
    libtcod/src15/color,
    libtcod/src15/console,
    libtcod/src15/mouse,
    libtcod/src15/image,
    libtcod/src15/sys,
    libtcod/src15/mersenne,
    libtcod/src15/noise,
    libtcod/src15/bresenham,
    libtcod/src15/tree,
    libtcod/src15/bsp,
    libtcod/src15/fov,
    libtcod/src15/path,
    libtcod/src15/heightmap,
    libtcod/src15/lex,
    libtcod/src15/parser,
    libtcod/src15/zip,
    libtcod/src15/namegen,
    libtcod/src15/txtfield

elif defined tcod17:
  include
    libtcod/src17/libtcod_define,
    #
    libtcod/src17/color,
    libtcod/src17/console_types,
    libtcod/src17/fov_types,
    libtcod/src17/image,
    libtcod/src17/list,
    libtcod/src17/lex,
    libtcod/src17/mersenne_types,
    libtcod/src17/mouse_types,
    libtcod/src17/noise_defaults,
    libtcod/src17/noise,
    libtcod/src17/tree,
    #
    libtcod/src17/bresenham,
    libtcod/src17/bsp,
    libtcod/src17/console,
    libtcod/src17/console_rexpaint,
    libtcod/src17/fov,
    libtcod/src17/heightmap,
    libtcod/src17/mersenne,
    libtcod/src17/mouse,
    libtcod/src17/namegen,
    libtcod/src17/parser,
    libtcod/src17/path,
    libtcod/src17/sys,
    libtcod/src17/txtfield,
    #libtcod/src17/wrappers,
    libtcod/src17/zip

else: # tcod112
  include
    libtcod/src112/libtcod_define,
    #
    libtcod/src112/color,
    libtcod/src112/console_types,
    libtcod/src112/console_console,
    libtcod/src112/fov_types,
    libtcod/src112/image,
    libtcod/src112/list,
    libtcod/src112/lex,
    libtcod/src112/mersenne_types,
    libtcod/src112/mouse_types,
    libtcod/src112/noise_defaults,
    libtcod/src112/noise,
    libtcod/src112/tree,
    #
    libtcod/src112/bresenham,
    libtcod/src112/bsp,
    libtcod/src112/console,
    libtcod/src112/console_drawing,
    libtcod/src112/console_printing,
    libtcod/src112/console_rexpaint,
    libtcod/src112/tileset,
    libtcod/src112/engine,
    libtcod/src112/fov,
    libtcod/src112/heightmap,
    libtcod/src112/mersenne,
    libtcod/src112/mouse,
    libtcod/src112/namegen,
    libtcod/src112/parser,
    libtcod/src112/path,
    libtcod/src112/sys,
    libtcod/src112/txtfield,
    libtcod/src112/version,
    #libtcod/src112/wrappers,
    libtcod/src112/zip

