##  CP437 special characters

const
  # 0 - 127
  CHAR_CIRCLE*: cint = 9
  CHAR_CIRCLE_INV*: cint = 10
  CHAR_RECT*: cint = 22
  CHAR_DARROW_VU*: cint = 23
  CHAR_RIGHT_ANGLE*: cint = 28
  CHAR_SPACE*: cint = 32
  CHAR_DELETE*: cint = 127

  # 155 - 175
  CHAR_CENTS*: cint = 155
  CHAR_YENS*: cint = 157
  CHAR_PESETA*: cint = 158
  CHAR_SUPERA*: cint = 166
  CHAR_SUPERO*: cint = 167
  CHAR_QUESTION_INV*: cint = 168
  CHAR_RNOT*: cint = 169
  CHAR_NOT*: cint = 170
  CHAR_EXCLAM_INV*: cint = 173
  CHAR_LAQUOTE*: cint = 174
  CHAR_RAQUOTE*: cint = 175

  # single/double walls (181-216)
  # double horisontal
  CHAR_DH_TEEW*: cint = 181
  CHAR_DH_NE*: cint = 184
  CHAR_DH_SE*: cint = 190
  CHAR_DH_TEEE*: cint = 198
  CHAR_DH_TEEN*: cint = 207
  CHAR_DH_TEES*: cint = 209
  CHAR_DH_SW*: cint = 212
  CHAR_DH_NW*: cint = 213
  CHAR_DH_CROSS*: cint = 216
  # double vertical
  CHAR_DV_TEEW*: cint = 182
  CHAR_DV_NE*: cint = 183
  CHAR_DV_SE*: cint = 189
  CHAR_DV_TEEE*: cint = 199
  CHAR_DV_TEEN*: cint = 208
  CHAR_DV_TEES*: cint = 210
  CHAR_DV_SW*: cint = 211
  CHAR_DV_NW*: cint = 214
  CHAR_DV_CROSS*: cint = 215


  # blocks
  CHAR_BLOCK_F*: cint = 219
  CHAR_BLOCK_S*: cint = 220
  CHAR_BLOCK_W*: cint = 221
  CHAR_BLOCK_E*: cint = 222
  CHAR_BLOCK_N*: cint = 223

  # 224 - 225
  CHAR_ALPHA*: cint = 224
  CHAR_SHARPS*: cint = 225

  CHAR_GAMMA*: cint = 226   ## shadowed by TCOD's sub-pixel resolution kit
  CHAR_PI*: cint = 227      ## shadowed by TCOD's sub-pixel resolution kit
  CHAR_SIGMA_UP*: cint = 228## shadowed by TCOD's sub-pixel resolution kit
  CHAR_SIGMA*: cint = 229   ## shadowed by TCOD's sub-pixel resolution kit
  CHAR_MICRO*: cint = 230   ## shadowed by TCOD's sub-pixel resolution kit
  CHAR_TAU*: cint = 231     ## shadowed by TCOD's sub-pixel resolution kit
  CHAR_PHI_UP*: cint = 232  ## shadowed by TCOD's sub-pixel resolution kit

  # misc
  CHAR_THETA*: cint = 233
  CHAR_OMEGA*: cint = 234
  CHAR_DELTA*: cint = 235
  CHAR_INF*: cint = 236
  CHAR_PHI*: cint = 237
  CHAR_EPSILON*: cint = 238
  CHAR_INTERSECTION*: cint = 239
  CHAR_IDENTICAL*: cint = 240
  CHAR_PLUSMINUS*: cint = 241
  CHAR_GEQUAL*: cint = 242
  CHAR_LEQUAL*: cint = 243
  CHAR_TOPINT*: cint = 244
  CHAR_LOWINT*: cint = 245
  CHAR_ALMOSTEQUAL*: cint = 247
  CHAR_DEGREE*: cint = 248
  CHAR_BULLET2*: cint = 249
  CHAR_MDOT*: cint = 250
  CHAR_SQRT*: cint = 251
  CHAR_SUPERN*: cint = 252

