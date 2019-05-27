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

else: # tcod112
  include
    src112/libtcod_define,
    #
    src112/color,
    src112/console_types,
    src112/console_console,
    src112/fov_types,
    src112/image,
    src112/list,
    src112/lex,
    src112/mersenne_types,
    src112/mouse_types,
    src112/noise_defaults,
    src112/noise,
    src112/tree,
    #
    src112/bresenham,
    src112/bsp,
    src112/console,
    src112/console_drawing,
    src112/console_printing,
    src112/console_rexpaint,
    src112/tileset,
    src112/engine,
    src112/fov,
    src112/heightmap,
    src112/mersenne,
    src112/mouse,
    src112/namegen,
    src112/parser,
    src112/path,
    src112/sys,
    src112/txtfield,
    src112/version,
    #src112/wrappers,
    src112/zip

