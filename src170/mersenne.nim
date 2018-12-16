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

# import mersenne_types

proc randomGetInstance*(): Random {.
    cdecl, importc: "TCOD_random_get_instance", dynlib: LIB_NAME.}

proc randomNew*(
  algo: RandomAlgo = RNG_CMWC): Random {.
    cdecl, importc: "TCOD_random_new", dynlib: LIB_NAME.}

proc randomSave*(
  mersenne: Random): Random {.
    cdecl, importc: "TCOD_random_save", dynlib: LIB_NAME.}

proc randomRestore*(
  mersenne: Random; backup: Random) {.
    cdecl, importc: "TCOD_random_restore", dynlib: LIB_NAME.}

proc randomNewFromSeed*(
  algo: RandomAlgo = RNG_CMWC; seed: uint32 = 0): Random {.
    cdecl, importc: "TCOD_random_new_from_seed", dynlib: LIB_NAME.}

proc randomDelete_internal(
  mersenne: Random) {.
    cdecl, importc: "TCOD_random_delete", dynlib: LIB_NAME.}

proc randomDelete*(mersenne: var Random) =
  if not (mersenne == nil):
    randomDelete_internal(mersenne)
    mersenne = nil

proc randomSetDistribution*(
  mersenne: Random; distribution: Distribution) {.
    cdecl, importc: "TCOD_random_set_distribution", dynlib: LIB_NAME.}

proc randomGetInt*(
  mersenne: Random; `min`, `max`: cint): cint {.
    cdecl, importc: "TCOD_random_get_int", dynlib: LIB_NAME.}

template randomGetChar*(mersenne: Random; `min`, `max`: char): char =
  (char(randomGetInt(mersenne, `min`.ord, `max`.ord)))

proc randomGetFloat*(
  mersenne: Random; `min`, `max`: cfloat): cfloat {.
    cdecl, importc: "TCOD_random_get_float", dynlib: LIB_NAME.}

proc randomGetDouble*(
  mersenne: Random; `min`, `max`: cdouble): cdouble {.
  cdecl, importc: "TCOD_random_get_double", dynlib: LIB_NAME.}

proc randomGetIntMean*(
  mersenne: Random; `min`, `max`, mean: cint = 0): cint {.
    cdecl, importc: "TCOD_random_get_int_mean", dynlib: LIB_NAME.}

proc randomGetFloatMean*(
  mersenne: Random; `min`, `max`, mean: cfloat = 0.0): cfloat {.
    cdecl, importc: "TCOD_random_get_float_mean", dynlib: LIB_NAME.}

proc randomGetDoubleMean*(
  mersenne: Random; `min`, `max`, mean: cdouble = 0.0): cdouble {.
    cdecl, importc: "TCOD_random_get_double_mean", dynlib: LIB_NAME.}

proc randomDiceNew*(
  s: cstring): Dice {.
    cdecl, importc: "TCOD_random_dice_new", dynlib: LIB_NAME.}

proc randomDiceRoll*(
  mersenne: Random; dice: Dice): cint {.
    cdecl, importc: "TCOD_random_dice_roll", dynlib: LIB_NAME.}

proc randomDiceRollS*(
  mersenne: Random; s: cstring): cint {.
    cdecl, importc: "TCOD_random_dice_roll_s", dynlib: LIB_NAME.}

