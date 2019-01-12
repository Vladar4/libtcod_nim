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
  PHeightmap* = ptr THeightmap
  THeightmap*{.bycopy.} = object
    w, h: cint
    values: ptr cfloat


#TCODLIB_API TCOD_heightmap_t *TCOD_heightmap_new(int w,int h);
proc heightmap_new*(w, h: int): PHeightmap {.cdecl, importc: "TCOD_heightmap_new", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_delete(TCOD_heightmap_t *hm);
proc heightmap_delete*(hm: PHeightmap) {.cdecl, importc: "TCOD_heightmap_delete", dynlib: LIB_NAME.}


#TCODLIB_API float TCOD_heightmap_get_value(const TCOD_heightmap_t *hm, int x, int y);
proc heightmap_get_value*(hm: PHeightmap, x, y: int): cfloat {.cdecl, importc: "TCOD_heightmap_get_value", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_heightmap_get_interpolated_value(const TCOD_heightmap_t *hm, float x, float y);
proc heightmap_get_interpolated_value*(hm: PHeightmap, x, y: cfloat): cfloat {.cdecl, importc: "TCOD_heightmap_get_interpolated_value", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_set_value(TCOD_heightmap_t *hm, int x, int y, float value);
proc heightmap_set_value*(hm: PHeightmap, x, y: int, value: cfloat) {.cdecl, importc: "TCOD_heightmap_set_value", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_heightmap_get_slope(const TCOD_heightmap_t *hm, int x, int y);
proc heightmap_get_slope*(hm: PHeightmap, x, y: int): cfloat {.cdecl, importc: "TCOD_heightmap_get_slope", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_get_normal(const TCOD_heightmap_t *hm, float x, float y, float n[3], float waterLevel);
proc heightmap_get_normal*(hm: PHeightmap, x, y: cfloat, n: ptr array[0..2, cfloat], waterLevel: cfloat) {.cdecl, importc: "TCOD_heightmap_get_normal", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_heightmap_count_cells(const TCOD_heightmap_t *hm, float min, float max);
proc heightmap_count_cells*(hm: PHeightmap, min, max: cfloat): cint {.cdecl, importc: "TCOD_heightmap_count_cells", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_heightmap_has_land_on_border(const TCOD_heightmap_t *hm, float waterLevel);
proc heightmap_has_land_on_border*(hm: PHeightmap, waterLevel: cfloat): bool {.cdecl, importc: "TCOD_heightmap_has_land_on_border", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_get_minmax(const TCOD_heightmap_t *hm, float *min, float *max);
proc heightmap_get_minmax*(hm: PHeightmap, min, max: ptr cfloat) {.cdecl, importc: "TCOD_heightmap_get_minmax", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_heightmap_copy(const TCOD_heightmap_t *hm_source,TCOD_heightmap_t *hm_dest);
proc heightmap_copy*(hm_source, hm_dest: PHeightmap) {.cdecl, importc: "TCOD_heightmap_copy", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_add(TCOD_heightmap_t *hm, float value);
proc heightmap_add*(hm: PHeightmap, value: cfloat) {.cdecl, importc: "TCOD_heightmap_add", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_scale(TCOD_heightmap_t *hm, float value);
proc heightmap_scale*(hm: PHeightmap, value: cfloat) {.cdecl, importc: "TCOD_heightmap_scale", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_clamp(TCOD_heightmap_t *hm, float min, float max);
proc heightmap_clamp*(hm: PHeightmap, min, max: cfloat) {.cdecl, importc: "TCOD_heightmap_clamp", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_normalize(TCOD_heightmap_t *hm, float min, float max);
proc heightmap_normalize*(hm: PHeightmap, min=0.0'f32, max=1.0'f32) {.cdecl, importc: "TCOD_heightmap_normalize", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_clear(TCOD_heightmap_t *hm);
proc heightmap_clear*(hm: PHeightmap) {.cdecl, importc: "TCOD_heightmap_clear", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_lerp_hm(const TCOD_heightmap_t *hm1, const TCOD_heightmap_t *hm2, TCOD_heightmap_t *hmres, float coef);
proc heightmap_lerp_hm*(hm1, hm2, hmres: PHeightmap, coef: cfloat) {.cdecl, importc: "TCOD_heightmap_lerp_hm", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_add_hm(const TCOD_heightmap_t *hm1, const TCOD_heightmap_t *hm2, TCOD_heightmap_t *hmres);
proc heightmap_add_hm*(hm1, hm2, hmres: PHeightmap) {.cdecl, importc: "TCOD_heightmap_add_hm", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_multiply_hm(const TCOD_heightmap_t *hm1, const TCOD_heightmap_t *hm2, TCOD_heightmap_t *hmres);
proc heightmap_multiply_hm*(hm1, hm2, hmres: PHeightmap) {.cdecl, importc: "TCOD_heightmap_multiply_hm", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_heightmap_add_hill(TCOD_heightmap_t *hm, float hx, float hy, float hradius, float hheight);
proc heightmap_add_hill*(hm: PHeightmap, hx, hy, hradius, hheight: cfloat) {.cdecl, importc: "TCOD_heightmap_add_hill", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_dig_hill(TCOD_heightmap_t *hm, float hx, float hy, float hradius, float hheight);
proc heightmap_dig_hill*(hm: PHeightmap, hx, hy, hradius, hheight: cfloat) {.cdecl, importc: "TCOD_heightmap_dig_hill", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_dig_bezier(TCOD_heightmap_t *hm, int px[4], int py[4], float startRadius, float startDepth, float endRadius, float endDepth);
proc heightmap_dig_bezier*(hm: PHeightmap, px, py: array[0..3, int], startRadius, startDepth, endRadius, endDepth: cfloat) {.cdecl, importc: "TCOD_heightmap_dig_bezier", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_rain_erosion(TCOD_heightmap_t *hm, int nbDrops,float erosionCoef,float sedimentationCoef,TCOD_random_t rnd);
proc heightmap_rain_erosion*(hm: PHeightmap, nbDrops: int, erosionCoef, sedimentationCoef: cfloat, rnd: PRandom = nil) {.cdecl, importc: "TCOD_heightmap_rain_erosion", dynlib: LIB_NAME.}


#/* TCODLIB_API void TCOD_heightmap_heat_erosion(TCOD_heightmap_t *hm, int nbPass,float minSlope,float erosionCoef,float sedimentationCoef,TCOD_random_t rnd); */
#proc heightmap_heat_erosion*(hm: PHeightmap, nbPass: int, minSlope, erosionCoef, sedimentationCoef: cfloat, rnd: PRandom = nil) {.cdecl, importc: "TCOD_heightmap_heat_erosion", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_heightmap_kernel_transform(TCOD_heightmap_t *hm, int kernelsize, const int *dx, const int *dy, const float *weight, float minLevel,float maxLevel);
proc heightmap_kernel_transform*(hm: PHeightmap, kernelsize: int, dx, dy: ptr int, weight: ptr cfloat, minLevel, maxLevel: cfloat) {.cdecl, importc: "TCOD_heightmap_kernel_transform", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_add_voronoi(TCOD_heightmap_t *hm, int nbPoints, int nbCoef, const float *coef,TCOD_random_t rnd);
proc heightmap_add_voronoi*(hm: PHeightmap, nbPoints, nbCoef: int, coef: ptr cfloat, rnd: PRandom = nil) {.cdecl, importc: "TCOD_heightmap_add_voronoi", dynlib: LIB_NAME.}


#/* TCODLIB_API void TCOD_heightmap_mid_point_deplacement(TCOD_heightmap_t *hm, TCOD_random_t rnd); */
#proc heightmap_mid_point_deplacement*(hm: PHeightmap, rnd: PRandom = nil) {.cdecl, importc: "TCOD_heightmap_mid_point_deplacement", dynlib: LIB_NAME.}


#TCODLIB_API void TCOD_heightmap_add_fbm(TCOD_heightmap_t *hm, TCOD_noise_t noise,float mulx, float muly, float addx, float addy, float octaves, float delta, float scale); 
proc heightmap_add_fbm*(hm: PHeightmap, noise: PNoise, mulx, muly, addx, addy, octaves, delta, scale: cfloat) {.cdecl, importc: "TCOD_heightmap_add_fbm", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_scale_fbm(TCOD_heightmap_t *hm, TCOD_noise_t noise,float mulx, float muly, float addx, float addy, float octaves, float delta, float scale); 
proc heightmap_scale_fbm*(hm: PHeightmap, noise: PNoise, mulx, muly, addx, addy, octaves, delta, scale: cfloat) {.cdecl, importc: "TCOD_heightmap_scale_fbm", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_heightmap_islandify(TCOD_heightmap_t *hm, float seaLevel,TCOD_random_t rnd);
proc heightmap_islandify*(hm: PHeightmap, seaLevel: cfloat, rnd: PRandom = nil) {.cdecl, importc: "TCOD_heightmap_islandify", dynlib: LIB_NAME.}

