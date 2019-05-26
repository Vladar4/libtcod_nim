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
  MapCell* {.bycopy.} = object  ##  \
    ##  Private map cell object.
    transparent*: bool
    walkable*: bool
    fov*: bool

  Map* = ptr MapObj
  MapObj* {.bycopy.} = object ##  \
    ##  Private map object.
    width*: cint
    height*: cint
    nbCells*: cint
    cells*: ptr MapCell

  FovAlgorithm* {.size: sizeof(cint).} = enum ##  Field-of-view options.
    FOV_BASIC,  ##  \
    ##  FOV_BASIC : http://roguebasin.roguelikedevelopment.org/index.php?title=Ray_casting
    FOV_DIAMOND,  ##  \
    ##  FOV_DIAMOND : http://www.geocities.com/temerra/los_rays.html
    FOV_SHADOW, ##  \
    ##  FOV_SHADOW : http://roguebasin.roguelikedevelopment.org/index.php?title=FOV_using_recursive_shadowcasting
    FOV_PERMISSIVE_0, ##  \
    ##  FOV_PERMISSIVE : http://roguebasin.roguelikedevelopment.org/index.php?title=Precise_Permissive_Field_of_View
    FOV_PERMISSIVE_1, FOV_PERMISSIVE_2, FOV_PERMISSIVE_3, FOV_PERMISSIVE_4,
    FOV_PERMISSIVE_5, FOV_PERMISSIVE_6, FOV_PERMISSIVE_7, FOV_PERMISSIVE_8,
    FOV_RESTRICTIVE,  ##  \
    ##  FOV_RESTRICTIVE : Mingos' Restrictive Precise Angle Shadowcasting (contribution by Mingos)
    NB_FOV_ALGORITHMS


template fov_Permissive*(x: untyped): untyped =
  ((FovAlgorithm)(FOV_PERMISSIVE_0 + (x)))

