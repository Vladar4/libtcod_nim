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


include
  mersenne_types


type
  PRandom* = pointer


#TCODLIB_API TCOD_random_t TCOD_random_get_instance(void);
proc random_get_instance*(): PRandom {.cdecl, importc: "TCOD_random_get_instance", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_random_t TCOD_random_new(TCOD_random_algo_t algo);
proc random_new*(algo: TRandomAlgo = RNG_CMWC): PRandom {.cdecl, importc: "TCOD_random_new", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_random_t TCOD_random_save(TCOD_random_t mersenne);
proc random_save*(mersenne: PRandom): PRandom {.cdecl, importc: "TCOD_random_save", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_random_restore(TCOD_random_t mersenne, TCOD_random_t backup);
proc random_restore*(mersenne, backup: PRandom) {.cdecl, importc: "TCOD_random_restore", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_random_t TCOD_random_new_from_seed(TCOD_random_algo_t algo, cuint seed);
proc random_new_from_seed*(algo: TRandomAlgo, seed: cuint): PRandom {.cdecl, importc: "TCOD_random_new_from_seed", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_random_delete(TCOD_random_t mersenne);
proc TCOD_random_delete(mersenne: PRandom) {.cdecl, importc: "TCOD_random_delete", dynlib: LIB_NAME.}
proc random_delete*(mersenne: var PRandom) =
  if mersenne != nil:
    TCOD_random_delete(mersenne)
    mersenne = nil


#TCODLIB_API void TCOD_random_set_distribution (TCOD_random_t mersenne, TCOD_distribution_t distribution);
proc random_set_distribution*(mersenne: PRandom, distribution: TDistribution) {.cdecl, importc: "TCOD_random_set_distribution", dynlib: LIB_NAME.}



#TCODLIB_API int TCOD_random_get_int (TCOD_random_t mersenne, int min, int max);
proc random_get_int*(mersenne: PRandom, min, max: int): int {.cdecl, importc: "TCOD_random_get_int", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_random_get_float (TCOD_random_t mersenne, float min, float max);
proc random_get_float*(mersenne: PRandom, min, max: float32): float32 {.cdecl, importc: "TCOD_random_get_float", dynlib: LIB_NAME.}

#TCODLIB_API double TCOD_random_get_double (TCOD_random_t mersenne, double min, double max);
proc random_get_double*(mersenne: PRandom, min, max: float64): float64 {.cdecl, importc: "TCOD_random_get_double", dynlib: LIB_NAME.}



#TCODLIB_API int TCOD_random_get_int_mean (TCOD_random_t mersenne, int min, int max, int mean);
proc random_get_int_mean*(mersenne: PRandom, min, max, mean: int): int {.cdecl, importc: "TCOD_random_get_int_mean", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_random_get_float_mean (TCOD_random_t mersenne, float min, float max, float mean);
proc random_get_float_mean*(mersenne: PRandom, min, max, mean: float32): float32 {.cdecl, importc: "TCOD_random_get_float_mean", dynlib: LIB_NAME.}

#TCODLIB_API double TCOD_random_get_double_mean (TCOD_random_t mersenne, double min, double max, double mean);
proc random_get_double_mean*(mersenne: PRandom, min, max, mean: float64): float64 {.cdecl, importc: "TCOD_random_get_double_mean", dynlib: LIB_NAME.}



#TCODLIB_API TCOD_dice_t TCOD_random_dice_new (const char * s);
proc random_dice_new*(s: cstring): TDice {.cdecl, importc: "TCOD_random_dice_new", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_random_dice_roll (TCOD_random_t mersenne, TCOD_dice_t dice);
proc random_dice_roll*(mersenne: PRandom, dice: TDice): int {.cdecl, importc: "TCOD_random_dice_roll", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_random_dice_roll_s (TCOD_random_t mersenne, const char * s);
proc random_dice_roll_s*(mersenne: PRandom, s: cstring): int {.cdecl, importc: "TCOD_random_dice_roll_s", dynlib: LIB_NAME.}

