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
#     * The name of Jice or Mingos may not be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY JICE, MINGOS AND RMTEW ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL JICE, MINGOS OR RMTEW BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# import mersenne_types, noise

type
  Heightmap* = ptr HeightmapObj
  HeightmapObj* {.bycopy.} = object
    w*, h*: cint
    values*: ptr cfloat


proc heightmapNew*(
  w, h: cint): Heightmap {.
    cdecl, importc: "TCOD_heightmap_new", dynlib: LIB_NAME.}

proc heightmapDelete_internal(
  hm: Heightmap) {.
    cdecl, importc: "TCOD_heightmap_delete", dynlib: LIB_NAME.}

proc heightmapDelete*(hm: var Heightmap) =
  if not (hm == nil):
    heightmapDelete_internal(hm)
    hm = nil

proc heightmapGetValue*(
  hm: Heightmap; x, y: cint): cfloat {.
    cdecl, importc: "TCOD_heightmap_get_value", dynlib: LIB_NAME.}

proc heightmapGetInterpolatedValue*(
  hm: Heightmap; x, y: cfloat): cfloat {.
    cdecl, importc: "TCOD_heightmap_get_interpolated_value", dynlib: LIB_NAME.}

proc heightmapSetValue*(
  hm: Heightmap; x, y: cint; value: cfloat) {.
    cdecl, importc: "TCOD_heightmap_set_value", dynlib: LIB_NAME.}

proc heightmapGetSlope*(
  hm: Heightmap; x, y: cint): cfloat {.
    cdecl, importc: "TCOD_heightmap_get_slope", dynlib: LIB_NAME.}

proc heightmapGetNormal*(
  hm: Heightmap; x, y: cfloat; n: array[3, cfloat]; waterLevel: cfloat = 0.0) {.
    cdecl, importc: "TCOD_heightmap_get_normal", dynlib: LIB_NAME.}

proc heightmapCountCells*(
  hm: Heightmap; `min`, `max`: cfloat): cint {.
    cdecl, importc: "TCOD_heightmap_count_cells", dynlib: LIB_NAME.}

proc heightmapHasLandOnBorder*(
  hm: Heightmap; waterLevel: cfloat): bool {.
    cdecl, importc: "TCOD_heightmap_has_land_on_border", dynlib: LIB_NAME.}

proc heightmapGetMinmax*(
  hm: Heightmap; `min`, `max`: ptr cfloat) {.
    cdecl, importc: "TCOD_heightmap_get_minmax", dynlib: LIB_NAME.}

proc heightmapCopy*(
  hmSource: Heightmap; hmDest: Heightmap) {.
    cdecl, importc: "TCOD_heightmap_copy", dynlib: LIB_NAME.}

proc heightmapAdd*(
  hm: Heightmap; value: cfloat) {.
    cdecl, importc: "TCOD_heightmap_add", dynlib: LIB_NAME.}

proc heightmapScale*(
  hm: Heightmap; value: cfloat) {.
    cdecl, importc: "TCOD_heightmap_scale", dynlib: LIB_NAME.}

proc heightmapClamp*(
  hm: Heightmap; `min`, `max`: cfloat) {.
    cdecl, importc: "TCOD_heightmap_clamp", dynlib: LIB_NAME.}

proc heightmapNormalize*(
  hm: Heightmap; `min`: cfloat = 0.0; `max`: cfloat = 1.0) {.
    cdecl, importc: "TCOD_heightmap_normalize", dynlib: LIB_NAME.}

proc heightmapClear*(
  hm: Heightmap) {.
    cdecl, importc: "TCOD_heightmap_clear", dynlib: LIB_NAME.}

proc heightmapLerpHm*(
  hm1, hm2, hmres: Heightmap; coef: cfloat) {.
    cdecl, importc: "TCOD_heightmap_lerp_hm", dynlib: LIB_NAME.}

proc heightmapAddHm*(
  hm1, hm2, hmres: Heightmap) {.
    cdecl, importc: "TCOD_heightmap_add_hm", dynlib: LIB_NAME.}

proc heightmapMultiplyHm*(
  hm1, hm2, hmres: Heightmap) {.
    cdecl, importc: "TCOD_heightmap_multiply_hm", dynlib: LIB_NAME.}

proc heightmapAddHill*(
  hm: Heightmap; hx, hy, hradius, hheight: cfloat) {.
    cdecl, importc: "TCOD_heightmap_add_hill", dynlib: LIB_NAME.}

proc heightmapDigHill*(
  hm: Heightmap; hx, hy, hradius, hheight: cfloat) {.
    cdecl, importc: "TCOD_heightmap_dig_hill", dynlib: LIB_NAME.}

proc heightmapDigBezier*(
  hm: Heightmap; px, py: array[4, cint];
  startRadius, startDepth, endRadius, endDepth: cfloat) {.
    cdecl, importc: "TCOD_heightmap_dig_bezier", dynlib: LIB_NAME.}

proc heightmapRainErosion*(
  hm: Heightmap; nbDrops: cint;
  erosionCoef, sedimentationCoef: cfloat; rnd: Random = nil) {.
    cdecl, importc: "TCOD_heightmap_rain_erosion", dynlib: LIB_NAME.}

#[
proc heightmapHeatErosion(
  hm: Heightmap; nbPass: cint,
  minSlope, erosionCoef, sedimentationCoef: cfloat; rnd: Random = nil) {.
    cdecl, importc: "TCOD_heightmap_heat_erosion", dynlib: LIB_NAME.}
]#

proc heightmapKernelTransform*(
  hm: Heightmap; kernelsize: cint; dx, dy: ptr cint;
  weight: ptr cfloat; minLevel, maxLevel: cfloat) {.
    cdecl, importc: "TCOD_heightmap_kernel_transform", dynlib: LIB_NAME.}

proc heightmapAddVoronoi*(
  hm: Heightmap; nbPoints, nbCoef: cint; coef: ptr cfloat; rnd: Random = nil) {.
    cdecl, importc: "TCOD_heightmap_add_voronoi", dynlib: LIB_NAME.}

proc heightmapMidPointDisplacement*(
  hm: Heightmap; rnd: Random = nil; roughness: cfloat = 0.45) {.
    cdecl, importc: "TCOD_heightmap_mid_point_displacement", dynlib: LIB_NAME.}

proc heightmapAddFbm*(
  hm: Heightmap; noise: Noise;
  mulx, muly, addx, addy, octaves, delta, scale: cfloat) {.
    cdecl, importc: "TCOD_heightmap_add_fbm", dynlib: LIB_NAME.}

proc heightmapScaleFbm*(
  hm: Heightmap; noise: Noise;
  mulx, muly, addx, addy, octaves, delta, scale: cfloat) {.
    cdecl, importc: "TCOD_heightmap_scale_fbm", dynlib: LIB_NAME.}

proc heightmapIslandify*(
  hm: Heightmap; seaLevel: cfloat; rnd: Random = nil) {.
    cdecl, importc: "TCOD_heightmap_islandify", dynlib: LIB_NAME.}

