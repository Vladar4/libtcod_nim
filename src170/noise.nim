##
##  libtcod
##  Copyright (c) 2008-2018 Jice & Mingos & rmtew
##  All rights reserved.
##
##  Redistribution and use in source and binary forms, with or without
##  modification, are permitted provided that the following conditions are met:
##      * Redistributions of source code must retain the above copyright
##        notice, this list of conditions and the following disclaimer.
##      * Redistributions in binary form must reproduce the above copyright
##        notice, this list of conditions and the following disclaimer in the
##        documentation and/or other materials provided with the distribution.
##      * The name of Jice or Mingos may not be used to endorse or promote
##        products derived from this software without specific prior written
##        permission.
##
##  THIS SOFTWARE IS PROVIDED BY JICE, MINGOS AND RMTEW ``AS IS'' AND ANY
##  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
##  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
##  DISCLAIMED. IN NO EVENT SHALL JICE, MINGOS OR RMTEW BE LIABLE FOR ANY
##  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
##  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
##  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
##  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
##  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
##  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##

import
  mersenne_types


type
  Noise* = pointer
  NoiseKind* {.size: sizeof(cint).} = enum
    NOISE_DEFAULT = 0, NOISE_PERLIN = 1, NOISE_SIMPLEX = 2, NOISE_WAVELET = 4


proc noiseNew*(
  dimensions: cint; hurst, lacunarity: cfloat; random: Random): Noise {.
    cdecl, importc: "TCOD_noise_new", dynlib: LIB_NAME.}
  ##  create a new noise object

#  simplified API

proc noiseSetKind*(
  noise: Noise; kind: NoiseKind) {.
    cdecl, importc: "TCOD_noise_set_type", dynlib: LIB_NAME.}

proc noiseGetEx*(
  noise: Noise; f: ptr cfloat; kind: NoiseKind): cfloat {.
    cdecl, importc: "TCOD_noise_get_ex", dynlib: LIB_NAME.}

proc noiseGetFbmEx*(
  noise: Noise; f: ptr cfloat; octaves: cfloat; Kind: NoiseKind): cfloat {.
    cdecl, importc: "TCOD_noise_get_fbm_ex", dynlib: LIB_NAME.}

proc noiseGetTurbulenceEx*(
  noise: Noise; f: ptr cfloat; octaves: cfloat; kind: NoiseKind): cfloat {.
    cdecl, importc: "TCOD_noise_get_turbulence_ex", dynlib: LIB_NAME.}

proc noiseGet*(
  noise: Noise; f: ptr cfloat): cfloat {.
    cdecl, importc: "TCOD_noise_get", dynlib: LIB_NAME.}

proc noiseGetFbm*(
  noise: Noise; f: ptr cfloat; octaves: cfloat): cfloat {.
    cdecl, importc: "TCOD_noise_get_fbm", dynlib: LIB_NAME.}

proc noiseGetTurbulence*(
  noise: Noise; f: ptr cfloat; octaves: cfloat): cfloat {.
    cdecl, importc: "TCOD_noise_get_turbulence", dynlib: LIB_NAME.}

proc noiseDelete*(
  noise: Noise) {.
    cdecl, importc: "TCOD_noise_delete", dynlib: LIB_NAME.}
  ##  delete the noise object

