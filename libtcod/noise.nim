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
  PNoise* = pointer

  TNoiseType* = enum
    NOISE_DEFAULT = 0,
    NOISE_PERLIN = 1,
    NOISE_SIMPLEX = 2,
    NOISE_WAVELET = 4


const
  NOISE_MAX_OCTAVES* = 128
  NOISE_MAX_DIMENSIONS* = 4
  NOISE_DEFAULT_HURST* = 0.5
  NOISE_DEFAULT_LACUNARITY* = 2.0


# create a new noise object
#TCODLIB_API TCOD_noise_t TCOD_noise_new(int dimensions, float hurst, float lacunarity, TCOD_random_t random); 
proc noise_new*(dimensions: int, hurst=NOISE_DEFAULT_HURST, lacunarity=NOISE_DEFAULT_LACUNARITY, random: PRandom = nil): PNoise {.cdecl, importc: "TCOD_noise_new", dynlib: LIB_NAME.}


# simplified API
#TCODLIB_API void TCOD_noise_set_type (TCOD_noise_t noise, TCOD_noise_type_t type);
proc noise_set_type*(noise: PNoise, noise_type=NOISE_DEFAULT) {.cdecl, importc: "TCOD_noise_set_type", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_noise_get_ex (TCOD_noise_t noise, float *f, TCOD_noise_type_t type);
proc noise_get_ex*(noise: PNoise, f: ptr float, noise_type=NOISE_DEFAULT): float {.cdecl, importc: "TCOD_noise_get_ex", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_noise_get_fbm_ex (TCOD_noise_t noise, float *f, float octaves, TCOD_noise_type_t type);
proc noise_get_fbm_ex*(noise: PNoise, f: ptr float, octaves: float, noise_type=NOISE_DEFAULT): float {.cdecl, importc: "TCOD_noise_get_fbm_ex", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_noise_get_turbulence_ex (TCOD_noise_t noise, float *f, float octaves, TCOD_noise_type_t type);
proc noise_get_turbulence_ex*(noise: PNoise, f: ptr float, octaves: float, noise_type=NOISE_DEFAULT): float {.cdecl, importc: "TCOD_noise_get_turbulence_ex", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_noise_get (TCOD_noise_t noise, float *f);
proc noise_get*(noise: PNoise, f: ptr float): float {.cdecl, importc: "TCOD_noise_get", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_noise_get_fbm (TCOD_noise_t noise, float *f, float octaves);
proc noise_get_fbm*(noise: PNoise, f: ptr float, octaves: float): float {.cdecl, importc: "TCOD_noise_get_fbm", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_noise_get_turbulence (TCOD_noise_t noise, float *f, float octaves);
proc noise_get_turbulence*(noise: PNoise, f: ptr float, octaves: float): float {.cdecl, importc: "TCOD_noise_get_turbulence", dynlib: LIB_NAME.}


# delete the noise object
#TCODLIB_API void TCOD_noise_delete(TCOD_noise_t noise);
proc noise_delete*(noise: PNoise) {.cdecl, importc: "TCOD_noise_delete", dynlib: LIB_NAME.}

