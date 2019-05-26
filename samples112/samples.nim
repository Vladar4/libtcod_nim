#
# libtcod Nim samples
# This code demonstrates various usages of libtcod modules
# It's in the public domain.
#

import
  libtcod, math, os, parseutils, strutils

const
  DATA_PATH = "../data/"  # change it to your data location
                          # if "samples" directory is not in "libtcod_nim"
  NO_SDL_SAMPLE = false   # change to `true` to disable SDL sample
                          # (might cause compilation issues on some systems)


type
  Sample* = tuple[
    name: string,
    render: proc (first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.}] ##  \
  ##  a sample has a name and a rendering function


##  sample screen size

const
  SAMPLE_SCREEN_WIDTH* = 46
  SAMPLE_SCREEN_HEIGHT* = 20
  SAMPLE_SCREEN_X* = 20 ##  sample screen position
  SAMPLE_SCREEN_Y* = 10


#*****************************
# samples rendering functions
#*****************************

var sampleConsole*: Console ##  \
  ##  the offscreen console in which the samples are rendered


#********************
# true colors sample
#********************

proc renderColors*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  const
    TOPLEFT = 0
    TOPRIGHT = 1
    BOTTOMLEFT = 2
    BOTTOMRIGHT = 3

  var
    cols {.global.}: array[4, Color] = [colorRGB(50, 40, 150),
                                        colorRGB(240, 85, 5),
                                        colorRGB(50, 35, 240),
                                        colorRGB(10, 200, 130) ]  ##  \
                                        ##  random corner colors
    dirr {.global.}: array[4, int] = [1, -1,  1,  1]
    dirg {.global.}: array[4, int] = [1, -1, -1,  1]
    dirb {.global.}: array[4, int] = [1,  1,  1, -1]
    c: cint
    textColor: Color

  # ==== slighty modify the corner colors ====
  if first:
    sysSetFps(0) # unlimited fps
    consoleClear(sampleConsole)

  for c in 0..3:
    # move each corner color
    var component: cint = randomGetInt(nil, 0, 2)
    case component
    of 0:
      inc(cols[c].r, 5 * dirr[c])
      if cols[c].r == 255:
        dirr[c] = -1
      elif cols[c].r == 0:
        dirr[c] = 1
    of 1:
      inc(cols[c].g, 5 * dirg[c])
      if cols[c].g == 255:
        dirg[c] = -1
      elif cols[c].g == 0:
        dirg[c] = 1
    of 2:
      inc(cols[c].b, 5 * dirb[c])
      if cols[c].b == 255:
        dirb[c] = -1
      elif cols[c].b == 0:
        dirb[c] = 1
    else:
      discard

  # ==== scan the whole screen, interpolating corner colors ====
  for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
    var
      xcoef: cfloat = (float)(x) / (SAMPLE_SCREEN_WIDTH - 1)
      #  get the current column top and bottom colors
      top: Color = colorLerp(cols[TOPLEFT], cols[TOPRIGHT], xcoef)
      bottom: Color = colorLerp(cols[BOTTOMLEFT], cols[BOTTOMRIGHT], xcoef)

    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      var
        ycoef: cfloat = (float)(y) / (SAMPLE_SCREEN_HEIGHT - 1)
        # get the current cell color
        curColor: Color = colorLerp(top, bottom, ycoef)
      consoleSetCharBackground(sampleConsole, x, y, curColor, BKGND_SET)

  # ==== print the text ====
  # get the background color at the text position
  textColor = consoleGetCharBackground(
    sampleConsole, SAMPLE_SCREEN_WIDTH div 2, 5)
  # and invert it
  textColor.r = 255'u8 - textColor.r
  textColor.g = 255'u8 - textColor.g
  textColor.b = 255'u8 - textColor.b
  consoleSetDefaultForeground(sampleConsole, textColor)

  #  put random text (for performance tests)
  for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      var
        c: cint
        col: Color = consoleGetCharBackground(sampleConsole, x, y)
      col = colorLerp(col, BLACK, 0.5)
      c = randomGetInt(nil, 'a'.ord, 'z'.ord)
      consoleSetDefaultForeground(sampleConsole, col)
      consolePutChar(sampleConsole, x, y, c, BKGND_NONE)

  # the background behind the text is slightly darkened
  # using the BKGND_MULTIPLY flag
  consoleSetDefaultBackground(sampleConsole, GREY)
  discard consolePrintfRectEx(
    sampleConsole, SAMPLE_SCREEN_WIDTH div 2, 5,
    SAMPLE_SCREEN_WIDTH - 2, SAMPLE_SCREEN_HEIGHT - 1,
    BKGND_MULTIPLY, CENTER, "The Doryen library uses 24 bits colors, for both background and foreground.")


##  ***************************
##  offscreen console sample
##  **************************

proc renderOffscreen*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var
    secondary {.global.}: Console   ##  second screen
    screenshot {.global.}: Console  ##  second screen
    init {.global.}: bool = false   ##  \
      ##  draw the secondary screen only the first time
    counter {.global.}: cint = 0
    x {.global.}: cint = 0  ##  secondary screen position
    y {.global.}: cint = 0
    xdir {.global.}: cint = 1
    ydir {.global.}: cint = 1

  # movement direction
  if not init:
    init = true
    secondary = consoleNew(SAMPLE_SCREEN_WIDTH div 2, SAMPLE_SCREEN_HEIGHT div 2)
    screenshot = consoleNew(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    consolePrintfFrame(
      secondary, 0, 0, SAMPLE_SCREEN_WIDTH div 2, SAMPLE_SCREEN_HEIGHT div 2,
      false, BKGND_SET, "Offscreen console")
    discard consolePrintfRectEx(
      secondary, SAMPLE_SCREEN_WIDTH div 4, 2,
      SAMPLE_SCREEN_WIDTH div 2 - 2, SAMPLE_SCREEN_HEIGHT div 2,
      BKGND_NONE, CENTER, "You can render to an offscreen console and blit in on another one, simulating alpha transparency.")

  if first:
    sysSetFps(30) # limited to 30 fps
    #  get a "screenshot" of the current sample screen
    consoleBlit(
      sampleConsole, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT,
      screenshot, 0, 0, 1.0, 1.0)

  inc(counter)

  if counter mod 20 == 0:
    #  move the secondary screen every 2 seconds
    inc(x, xdir)
    inc(y, ydir)
    if x == SAMPLE_SCREEN_WIDTH div 2 + 5:
      xdir = -1
    elif x == -5:
      xdir = 1
    if y == SAMPLE_SCREEN_HEIGHT div 2 + 5:
      ydir = -1
    elif y == -5:
      ydir = 1
  consoleBlit(
    screenshot, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT,
    sampleConsole, 0, 0, 1.0, 1.0)
  # blit the overlapping screen
  consoleBlit(
    secondary, 0, 0, SAMPLE_SCREEN_WIDTH div 2, SAMPLE_SCREEN_HEIGHT div 2,
    sampleConsole, x, y, 1.0, 0.75)

#*********************
# line drawing sample
#*********************

var bkFlag*: BkgndFlag = BKGND_SET  #  current blending mode

proc lineListener*(x: cint; y: cint): bool {.cdecl.} =
  if x >= 0 and y >= 0 and x < SAMPLE_SCREEN_WIDTH and y < SAMPLE_SCREEN_HEIGHT:
    consoleSetCharBackground(
      sampleConsole, x, y, LIGHT_BLUE, cast[BkgndFlag](bkFlag))
  return true

proc renderLines*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var
    bk {.global.}: Console ##  colored background
    init {.global.}: bool = false
    flagNames: seq[string] = @["TCOD_BKGND_NONE", "TCOD_BKGND_SET",
                              "TCOD_BKGND_MULTIPLY", "TCOD_BKGND_LIGHTEN",
                              "TCOD_BKGND_DARKEN", "TCOD_BKGND_SCREEN",
                              "TCOD_BKGND_COLOR_DODGE", "TCOD_BKGND_COLOR_BURN",
                              "TCOD_BKGND_ADD", "TCOD_BKGND_ADDALPHA",
                              "TCOD_BKGND_BURN", "TCOD_BKGND_OVERLAY",
                              "TCOD_BKGND_ALPHA"]
  var
    xo, yo, xd, yd: cint  ##  segment starting, ending, current position
    alpha: cfloat ##  alpha value when blending mode = TCOD_BKGND_ALPHA
    angle, cosAngle, sinAngle: cfloat ##  segment angle data
    recty: cint ##  gradient vertical position

  if key.vk == K_Enter or key.vk == K_Kpenter:
    #  switch to the next blending mode
    inc(bkFlag)
    if (bkFlag.ord and 0x000000FF) > BKGND_ALPH.ord:
      bkFlag = BKGND_NONE

  if (bkFlag.ord and 0x000000FF) == BKGND_ALPH.ord:
    # for the alpha mode, update alpha every frame
    alpha = (1.0 + cos(sysElapsedSeconds() * 2)) / 2.0
    bkFlag = bkgnd_Alpha(alpha)
  elif (bkFlag.ord and 0x000000FF) == BKGND_ADDA.ord:
    # for the add alpha mode, update alpha every frame
    alpha = (1.0 + cos(sysElapsedSeconds() * 2)) / 2.0
    bkFlag = bkgnd_Addalpha(alpha)

  if not init:
    bk = consoleNew(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    # initialize the colored background
    for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
      for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
        var col: Color
        col.r = (uint8)(x * 255 div (SAMPLE_SCREEN_WIDTH - 1))
        col.g = (uint8)((x + y) * 255 div
            (SAMPLE_SCREEN_WIDTH - 1 + SAMPLE_SCREEN_HEIGHT - 1))
        col.b = (uint8)(y * 255 div (SAMPLE_SCREEN_HEIGHT - 1))
        consoleSetCharBackground(bk, x, y, col, BKGND_SET)
    init = true

  if first:
    sysSetFps(30) # limited to 30 fps
    consoleSetDefaultForeground(sampleConsole, WHITE)
  consoleBlit(
    bk, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT,
    sampleConsole, 0, 0, 1.0, 1.0)
  # render the gradient
  recty = int32((SAMPLE_SCREEN_HEIGHT - 2) *
      ((1.0 + cos(sysElapsedSeconds())) / 2.0))

  for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
    var col: Color
    col.r = (uint8)(x * 255 div SAMPLE_SCREEN_WIDTH)
    col.g = (uint8)(x * 255 div SAMPLE_SCREEN_WIDTH)
    col.b = (uint8)(x * 255 div SAMPLE_SCREEN_WIDTH)
    consoleSetCharBackground(
      sampleConsole, x, recty, col, cast[BkgndFlag](bkFlag))
    consoleSetCharBackground(
      sampleConsole, x, recty + 1, col, cast[BkgndFlag](bkFlag))
    consoleSetCharBackground(
      sampleConsole, x, recty + 2, col, cast[BkgndFlag](bkFlag))

  # calculate the segment ends
  angle = sysElapsedSeconds() * 2.0
  cosAngle = cos(angle)
  sinAngle = sin(angle)
  xo = int32(SAMPLE_SCREEN_WIDTH div 2 * (1 + cosAngle))
  yo = int32(SAMPLE_SCREEN_HEIGHT div 2 + sinAngle * SAMPLE_SCREEN_WIDTH / 2)
  xd = int32(SAMPLE_SCREEN_WIDTH div 2 * (1 - cosAngle))
  yd = int32(SAMPLE_SCREEN_HEIGHT div 2 - sinAngle * SAMPLE_SCREEN_WIDTH / 2)
  # render the line
  discard line(xo, yo, xd, yd, lineListener)
  # print the current flag
  consolePrintf(
    sampleConsole, 2, 2, "%s (ENTER to change)",
    flagNames[bkFlag.ord and 0x000000FF])

#**************
# noise sample
#**************

proc renderNoise*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  const
    PERLIN = 0
    SIMPLEX = 1
    WAVELET = 2
    FBM_PERLIN = 3
    TURBULENCE_PERLIN = 4
    FBM_SIMPLEX = 5
    TURBULENCE_SIMPLEX = 6
    FBM_WAVELET = 7
    TURBULENCE_WAVELET = 8
  # which function we render
  var
    funcName: seq[string] = @["1 : perlin noise       ",
                              "2 : simplex noise      ",
                              "3 : wavelet noise      ",
                              "4 : perlin fbm         ",
                              "5 : perlin turbulence  ",
                              "6 : simplex fbm        ",
                              "7 : simplex turbulence ",
                              "8 : wavelet fbm        ",
                              "9 : wavelet turbulence "]
    funct {.global.}: cint = PERLIN
    noise {.global.}: Noise = nil
    dx {.global.}: cfloat = 0.0
    dy {.global.}: cfloat = 0.0
    octaves {.global.}: cfloat = 4.0
    hurst {.global.}: cfloat = NOISE_DEFAULT_HURST
    lacunarity {.global.}: cfloat = NOISE_DEFAULT_LACUNARITY
    img {.global.}: Image = nil
    zoom {.global.}: cfloat = 3.0

  if noise == nil:
    noise = noiseNew(2, hurst, lacunarity, nil)
    img = imageNew(SAMPLE_SCREEN_WIDTH * 2, SAMPLE_SCREEN_HEIGHT * 2)
  if first:
    sysSetFps(30) # limited to 30 fps
  consoleClear(sampleConsole)
  # texture animation
  dx += 0.01
  dy += 0.01
  # render the 2d noise function
  for y in 0.cint..<2 * SAMPLE_SCREEN_HEIGHT:
    for x in 0.cint..<2 * SAMPLE_SCREEN_WIDTH:
      var
        f: array[2, cfloat]
        value: cfloat
        c: uint8
        col: Color
      f[0] = zoom * cfloat(x / (2 * SAMPLE_SCREEN_WIDTH) + dx)
      f[1] = zoom * cfloat(y / (2 * SAMPLE_SCREEN_HEIGHT) + dy)
      value = 0.0
      var pf = f.toPtr
      case funct
      of PERLIN:
        value = noiseGetEx(noise, pf, NOISE_PERLIN)
      of SIMPLEX:
        value = noiseGetEx(noise, pf, NOISE_SIMPLEX)
      of WAVELET:
        value = noiseGetEx(noise, pf, NOISE_WAVELET)
      of FBM_PERLIN:
        value = noiseGetFbmEx(noise, pf, octaves, NOISE_PERLIN)
      of TURBULENCE_PERLIN:
        value = noiseGetTurbulenceEx(noise, pf, octaves, NOISE_PERLIN)
      of FBM_SIMPLEX:
        value = noiseGetFbmEx(noise, pf, octaves, NOISE_SIMPLEX)
      of TURBULENCE_SIMPLEX:
        value = noiseGetTurbulenceEx(noise, pf, octaves, NOISE_SIMPLEX)
      of FBM_WAVELET:
        value = noiseGetFbmEx(noise, pf, octaves, NOISE_WAVELET)
      of TURBULENCE_WAVELET:
        value = noiseGetTurbulenceEx(noise, pf, octaves, NOISE_WAVELET)
      else:
        discard

      c = (uint8)((value + 1.0) / 2.0 * 255)
      # use a bluish color
      col.r = c div 2
      col.g = col.r
      col.b = c
      imagePutPixel(img, x, y, col)

  # blit the noise image with subcell resolution
  imageBlit2x(img, sampleConsole, 0, 0, 0, 0, -1, -1)
  # draw a transparent rectangle
  consoleSetDefaultBackground(sampleConsole, GREY)
  var n: cint = if funct <= WAVELET: 10 else: 13
  console_rect(sample_console, 2, 2, 23, n, false, BKGND_MULTIPLY)
  for y in 2.cint..1+n:
    for x in 2.cint..1+23:
      var col: Color = consoleGetCharForeground(sampleConsole, x, y)
      col = colorMultiply(col, GREY)
      consoleSetCharForeground(sampleConsole, x, y, col)

  # draw the text
  for curfunc in PERLIN.cint..TURBULENCE_WAVELET:
    if curfunc == funct:
      consoleSetDefaultForeground(sampleConsole, WHITE)
      consoleSetDefaultBackground(sampleConsole, LIGHT_BLUE)
      consolePrintfEx(
        sampleConsole, 2, 2 + curfunc, BKGND_SET, LEFT, funcName[curfunc])
    else:
      consoleSetDefaultForeground(sampleConsole, GREY)
      consolePrintf(sampleConsole, 2, 2 + curfunc, funcName[curfunc])

  # draw parameters
  consoleSetDefaultForeground(sampleConsole, WHITE)
  consolePrintf(sampleConsole, 2, 11, "Y/H : zoom (%2.1f)", zoom)
  if funct > WAVELET:
    consolePrintf(sampleConsole, 2, 12, "E/D : hurst (%2.1f)", hurst)
    consolePrintf(sampleConsole, 2, 13, "R/F : lacunarity (%2.1f)", lacunarity)
    consolePrintf(sampleConsole, 2, 14, "T/G : octaves (%2.1f)", octaves)

  if key.vk == K_None:
    return
  if key.vk == K_Text and key.text[0] != '\x00':
    if key.text[0] >= '1' and key.text[0] <= '9':
      ##  change the noise function
      funct = cint(key.text[0].ord - '1'.ord)
    elif key.text[0] == 'E' or key.text[0] == 'e':
      ##  increase hurst
      hurst += 0.1
      noiseDelete(noise)
      noise = noiseNew(2, hurst, lacunarity, nil)
    elif key.text[0] == 'D' or key.text[0] == 'd':
      ##  decrease hurst
      hurst -= 0.1
      noiseDelete(noise)
      noise = noiseNew(2, hurst, lacunarity, nil)
    elif key.text[0] == 'R' or key.text[0] == 'r':
      ##  increase lacunarity
      lacunarity += 0.5
      noiseDelete(noise)
      noise = noiseNew(2, hurst, lacunarity, nil)
    elif key.text[0] == 'F' or key.text[0] == 'f':
      ##  decrease lacunarity
      lacunarity -= 0.5
      noiseDelete(noise)
      noise = noiseNew(2, hurst, lacunarity, nil)
    elif key.text[0] == 'T' or key.text[0] == 't':
      ##  increase octaves
      octaves += 0.5
    elif key.text[0] == 'G' or key.text[0] == 'g':
      ##  decrease octaves
      octaves -= 0.5
    elif key.text[0] == 'Y' or key.text[0] == 'y':
      ##  increase zoom
      zoom += 0.2
    elif key.text[0] == 'H' or key.text[0] == 'h':
      ##  decrease zoom
      zoom -= 0.2

#************
# fov sample
#************

proc renderFov*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var smap: seq[string] = @["##############################################",
                            "#######################      #################",
                            "#####################    #     ###############",
                            "######################  ###        ###########",
                            "##################      #####             ####",
                            "################       ########    ###### ####",
                            "###############      #################### ####",
                            "################    ######                  ##",
                            "########   #######  ######   #     #     #  ##",
                            "########   ######      ###                  ##",
                            "########                                    ##",
                            "####       ######      ###   #     #     #  ##",
                            "#### ###   ########## ####                  ##",
                            "#### ###   ##########   ###########=##########",
                            "#### ##################   #####          #####",
                            "#### ###             #### #####          #####",
                            "####           #     ####                #####",
                            "########       #     #### #####          #####",
                            "########       #####      ####################",
                            "##############################################"]
  const
    TORCH_RADIUS = 10.0
    SQUARED_TORCH_RADIUS = (TORCH_RADIUS * TORCH_RADIUS)
  var
    px {.global.}: cint = 20  # player position
    py {.global.}: cint = 10
    recomputeFov {.global.}: bool = true
    torch {.global.}: bool = false
    lightWalls {.global.}: bool = true
    map {.global.}: Map = nil
    darkWall: Color = colorRGB(0, 0, 100)
    lightWall: Color = colorRGB(130, 110, 50)
    darkGround: Color = colorRGB(50, 50, 150)
    lightGround: Color = colorRGB(200, 180, 50)
    noise {.global.}: Noise
    algonum {.global.}: cint = 0
    algoNames: seq[string] = @[ "BASIC      ", "DIAMOND    ", "SHADOW     ",
                                "PERMISSIVE0", "PERMISSIVE1", "PERMISSIVE2",
                                "PERMISSIVE3", "PERMISSIVE4", "PERMISSIVE5",
                                "PERMISSIVE6", "PERMISSIVE7", "PERMISSIVE8",
                                "RESTRICTIVE" ]
    torchx {.global.}: cfloat = 0.0  ##  torch light position in the perlin noise
    # torch position & intensity variation
    dx: cfloat = 0.0
    dy: cfloat = 0.0
    di: cfloat = 0.0

  if map == nil:
    map = mapNew(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
        if smap[y][x] == ' ':
          mapSetProperties(map, x, y, true, true)
        elif smap[y][x] == '=':  ##  window
          mapSetProperties(map, x, y, true, false)
    noise = noiseNew(1, 1.0, 1.0, nil)
    ##  1d noise for the torch flickering
  if first:
    sysSetFps(30) # limited to 30 fps
    # we draw the foreground only the first time.
    # during the player movement, only the @ is redrawn.
    # the rest impacts only the background color
    # draw the help text & player @
    consoleClear(sampleConsole)
    consoleSetDefaultForeground(sampleConsole, WHITE)
    consolePrintf(
      sampleConsole, 1, 0,
      "IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s",
      if torch: "on " else: "off", if lightWalls: "on " else: "off",
      algoNames[algonum])
    consoleSetDefaultForeground(sampleConsole, BLACK)
    consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
    # draw windows
    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
        if smap[y][x] == '=':
          consolePutChar(sampleConsole, x, y, CHAR_DHLINE, BKGND_NONE)

  if recomputeFov:
    recomputeFov = false
    mapComputeFov(
      map, px, py, if torch: TORCH_RADIUS.cint else: 0,
      lightWalls, cast[FovAlgorithm](algonum))

  if torch:
    var tdx: cfloat
    # slightly change the perlin noise parameter
    torchx += 0.2
    # randomize the light position between -1.5 and 1.5
    tdx = torchx + 20.0
    dx = noiseGet(noise, addr(tdx)) * 1.5
    tdx += 30.0
    dy = noiseGet(noise, addr(tdx)) * 1.5
    di = 0.2 * noiseGet(noise, addr(torchx))

  for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
    for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
      var
        visible: bool = mapIsInFov(map, x, y)
        wall: bool = smap[y][x] == '#'
      if not visible:
        consoleSetCharBackground(
          sampleConsole, x, y, if wall: darkWall else: darkGround, BKGND_SET)
      else:
        if not torch:
          consoleSetCharBackground(
            sampleConsole, x, y, if wall: lightWall else: lightGround, BKGND_SET)
        else:
          var
            base: Color = (if wall: darkWall else: darkGround)
            light: Color = (if wall: lightWall else: lightGround)
            r: cfloat = (x.float - px.float + dx) *
                        (x.float - px.float + dx) +
                        (y.float - py.float + dy) *
                        (y.float - py.float + dy)
          # cell distance to torch (squared)
          if r < SQUARED_TORCH_RADIUS:
            var
              l: cfloat = (SQUARED_TORCH_RADIUS - r) / SQUARED_TORCH_RADIUS + di
            l = clamp(l, 0.0, 1.0)
            base = colorLerp(base, light, l)
          consoleSetCharBackground(sampleConsole, x, y, base, BKGND_SET)

  if key.vk == K_Text and key.text[0] != '\x00':
    if key.text[0] == 'I' or key.text[0] == 'i':
      if smap[py - 1][px] == ' ':
        consolePutChar(sampleConsole, px, py, ' ', BKGND_NONE)
        dec(py)
        consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
        recomputeFov = true
    elif key.text[0] == 'K' or key.text[0] == 'k':
      if smap[py + 1][px] == ' ':
        consolePutChar(sampleConsole, px, py, ' ', BKGND_NONE)
        inc(py)
        consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
        recomputeFov = true
    elif key.text[0] == 'J' or key.text[0] == 'j':
      if smap[py][px - 1] == ' ':
        consolePutChar(sampleConsole, px, py, ' ', BKGND_NONE)
        dec(px)
        consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
        recomputeFov = true
    elif key.text[0] == 'L' or key.text[0] == 'l':
      if smap[py][px + 1] == ' ':
        consolePutChar(sampleConsole, px, py, ' ', BKGND_NONE)
        inc(px)
        consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
        recomputeFov = true
    elif key.text[0] == 'T' or key.text[0] == 't':
      torch = not torch
      consoleSetDefaultForeground(sampleConsole, WHITE)
      consolePrintf(
        sampleConsole, 1, 0,
        "IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s",
        if torch: "on " else: "off", if lightWalls: "on " else: "off",
        algoNames[algonum])
      consoleSetDefaultForeground(sampleConsole, BLACK)
    elif key.text[0] == 'W' or key.text[0] == 'w':
      lightWalls = not lightWalls
      consoleSetDefaultForeground(sampleConsole, WHITE)
      consolePrintf(
        sampleConsole, 1, 0,
        "IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s",
        if torch: "on " else: "off", if lightWalls: "on " else: "off",
        algoNames[algonum])
      consoleSetDefaultForeground(sampleConsole, BLACK)
      recomputeFov = true
    elif key.text[0] in ['=', '+', '-']:
      inc(algonum, if key.text[0] != '-': 1 else: -1)
      algonum = clamp(algonum, 0, NB_FOV_ALGORITHMS.ord - 1).cint
      consoleSetDefaultForeground(sampleConsole, WHITE)
      consolePrintf(
        sampleConsole, 1, 0,
        "IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s",
        if torch: "on " else: "off", if lightWalls: "on " else: "off",
        algoNames[algonum])
      consoleSetDefaultForeground(sampleConsole, BLACK)
      recomputeFov = true

#**************
# image sample
#**************

proc renderImage*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var
    img {.global.}: Image = nil
    circle {.global.}: Image = nil
    blue: Color = colorRGB(0, 0, 255)
    green: Color = colorRGB(0, 255, 0)
    scalex, scaley, angle: cfloat
    elapsed: clong

  if img == nil:
    img = imageLoad(DATA_PATH & "img/skull.png")
    imageSetKeyColor(img, BLACK)
    circle = imageLoad(DATA_PATH & "img/circle.png")

  if first:
    sysSetFps(30) # limited to 30 fps
  consoleSetDefaultBackground(sampleConsole, BLACK)
  consoleClear(sampleConsole)
  let x = SAMPLE_SCREEN_WIDTH div 2 + cos(sysElapsedSeconds()) * 10.0
  let y = (float)(SAMPLE_SCREEN_HEIGHT div 2)
  scalex = 0.2 + 1.8 * (1.0 + cos(sysElapsedSeconds() / 2)) / 2.0
  scaley = scalex
  angle = sysElapsedSeconds()
  elapsed = clong(sysElapsedMilli() div 2000)

  if (elapsed and 1) != 0:
    # split the color channels of circle.png
    # the red channel
    consoleSetDefaultBackground(sampleConsole, RED)
    consoleRect(sampleConsole, 0, 3, 15, 15, false, BKGND_SET)
    imageBlitRect(circle, sampleConsole, 0, 3, -1, -1, BKGND_MULTIPLY)
    # the green channel
    consoleSetDefaultBackground(sampleConsole, green)
    consoleRect(sampleConsole, 15, 3, 15, 15, false, BKGND_SET)
    imageBlitRect(circle, sampleConsole, 15, 3, -1, -1, BKGND_MULTIPLY)
    # the blue channel
    consoleSetDefaultBackground(sampleConsole, blue)
    consoleRect(sampleConsole, 30, 3, 15, 15, false, BKGND_SET)
    imageBlitRect(circle, sampleConsole, 30, 3, -1, -1, BKGND_MULTIPLY)
  else:
    # render circle.png with normal blitting
    imageBlitRect(circle, sampleConsole, 0, 3, -1, -1, BKGND_SET)
    imageBlitRect(circle, sampleConsole, 15, 3, -1, -1, BKGND_SET)
    imageBlitRect(circle, sampleConsole, 30, 3, -1, -1, BKGND_SET)
  imageBlit(img, sampleConsole, x, y, BKGND_SET, scalex, scaley, angle)

#**************
# mouse sample
#**************

proc renderMouse*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var
    lbut: bool = false
    rbut: bool = false
    mbut: bool = false

  if first:
    consoleSetDefaultBackground(sampleConsole, GREY)
    consoleSetDefaultForeground(sampleConsole, LIGHT_YELLOW)
    mouseMove(320, 200)
    mouseShowCursor(true)
    sysSetFps(30) # limited to 30 fps
  consoleClear(sampleConsole)
  if mouse.lbuttonPressed:
    lbut = not lbut
  if mouse.rbuttonPressed:
    rbut = not rbut
  if mouse.mbuttonPressed:
    mbut = not mbut

  consolePrintf(
    sampleConsole, 1, 1,
    "%s\nMouse position : %4dx%4d %s\nMouse cell     : %4dx%4d\nMouse movement : %4dx%4d\nLeft button    : %s (toggle %s)\nRight button   : %s (toggle %s)\nMiddle button  : %s (toggle %s)\nWheel          : %s\n",
    if consoleIsActive(): "" else: "APPLICATION INACTIVE", mouse.x,
    mouse.y, if consoleHasMouseFocus(): "" else: "OUT OF FOCUS", mouse.cx,
    mouse.cy, mouse.dx, mouse.dy, if mouse.lbutton: " ON" else: "OFF",
    if lbut: " ON" else: "OFF", if mouse.rbutton: " ON" else: "OFF",
    if rbut: " ON" else: "OFF", if mouse.mbutton: " ON" else: "OFF",
    if mbut: " ON" else: "OFF", if mouse.wheelUp: "UP" else: (
    if mouse.wheelDown: "DOWN" else: ""))

  consolePrintf(sampleConsole, 1, 10, "1 : Hide cursor\n2 : Show cursor")
  if key.vk == K_Text and key.text[0] != '\x00':
    if key.text[0] == '1':
      mouseShowCursor(false)
    elif key.text[0] == '2':
      mouseShowCursor(true)

#*************
# path sample
#*************

proc renderPath*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var smap: seq[string] = @["##############################################",
                            "#######################      #################",
                            "#####################    #     ###############",
                            "######################  ###        ###########",
                            "##################      #####             ####",
                            "################       ########    ###### ####",
                            "###############      #################### ####",
                            "################    ######                  ##",
                            "########   #######  ######   #     #     #  ##",
                            "########   ######      ###                  ##",
                            "########                                    ##",
                            "####       ######      ###   #     #     #  ##",
                            "#### ###   ########## ####                  ##",
                            "#### ###   ##########   ###########=##########",
                            "#### ##################   #####          #####",
                            "#### ###             #### #####          #####",
                            "####           #     ####                #####",
                            "########       #     #### #####          #####",
                            "########       #####      ####################",
                            "##############################################"]
  const
    TORCH_RADIUS = 10.0
    SQUARED_TORCH_RADIUS = (TORCH_RADIUS * TORCH_RADIUS)
  var
    px {.global.}: cint = 20  # player position
    py {.global.}: cint = 10
    dx {.global.}: cint = 24  # destination
    dy {.global.}: cint = 1
    map {.global.}: Map = nil
    darkWall: Color = colorRGB(0, 0, 100)
    darkGround: Color = colorRGB(50, 50, 150)
    lightGround: Color = colorRGB(200, 180, 50)
    path {.global.}: Path = nil
    usingAstar {.global.}: bool = true
    dijkstraDist {.global.}: cfloat = 0
    dijkstra {.global.}: Dijkstra = nil
    recalculatePath {.global.}: bool = false
    busy {.global.}: cfloat
    oldChar: cint = ' '.ord
    mx, my: cint

  if map == nil:
    # initialize the map
    map = mapNew(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
        if smap[y][x] == ' ':
          mapSetProperties(map, x, y, true, true)
        elif smap[y][x] == '=': # window
          mapSetProperties(map, x, y, true, false)

    path = pathNewUsingMap(map, 1.41)
    dijkstra = dijkstraNew(map, 1.41)
  if first:
    sysSetFps(30) # limited to 30 fps
    # we draw the foreground only the first time.
    # during the player movement, only the @ is redrawn.
    # the rest impacts only the background color
    # draw the help text & player @
    consoleClear(sampleConsole)
    consoleSetDefaultForeground(sampleConsole, WHITE)
    consolePutChar(sampleConsole, dx, dy, '+', BKGND_NONE)
    consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
    consolePrintf(
      sampleConsole, 1, 1, "IJKL / mouse :\nmove destination\nTAB : A*/dijkstra")
    consolePrintf(sampleConsole, 1, 4, "Using : A*")
    # draw windows
    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
        if smap[y][x] == '=':
          consolePutChar(sampleConsole, x, y, CHAR_DHLINE, BKGND_NONE)

    recalculatePath = true
  if recalculatePath:
    if usingAstar:
      discard pathCompute(path, px, py, dx, dy)
    else:
      var
        x: cint
        y: cint
      dijkstraDist = 0.0
      # compute the distance grid
      dijkstraCompute(dijkstra, px, py)
      # get the maximum distance (needed for ground shading only)
      for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
        for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
          var d: cfloat = dijkstraGetDistance(dijkstra, x, y)
          if d > dijkstraDist:
            dijkstraDist = d

      # compute the path
      discard dijkstraPathSet(dijkstra, dx, dy)
    recalculatePath = false
    busy = 0.2
  for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
    for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
      var wall: bool = smap[y][x] == '#'
      consoleSetCharBackground(
        sampleConsole, x, y, if wall: darkWall else: darkGround, BKGND_SET)

  # draw the path
  if usingAstar:
    for i in 0.cint..<pathSize(path):
      var
        x: cint
        y: cint
      pathGet(path, i, addr(x), addr(y))
      consoleSetCharBackground(sampleConsole, x, y, lightGround, BKGND_SET)
  else:
    for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
      for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
        var wall: bool = smap[y][x] == '#'
        if not wall:
          var d: cfloat = dijkstraGetDistance(dijkstra, x, y)
          consoleSetCharBackground(sampleConsole, x, y, colorLerp(lightGround,
              darkGround, 0.9 * d / dijkstraDist), BKGND_SET)

    for i in 0.cint..<dijkstraSize(dijkstra):
      var x, y: cint
      dijkstraGet(dijkstra, i, addr(x), addr(y))
      consoleSetCharBackground(sampleConsole, x, y, lightGround, BKGND_SET)

  # move the creature
  busy -= sysGetLastFrameLength()
  if busy <= 0.0:
    busy = 0.2
    if usingAstar:
      if not pathIsEmpty(path):
        consolePutChar(sampleConsole, px, py, ' ', BKGND_NONE)
        discard pathWalk(path, addr(px), addr(py), true)
        consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
    else:
      if not dijkstraIsEmpty(dijkstra):
        consolePutChar(sampleConsole, px, py, ' ', BKGND_NONE)
        discard dijkstraPathWalk(dijkstra, addr(px), addr(py))
        consolePutChar(sampleConsole, px, py, '@', BKGND_NONE)
        recalculatePath = true
  if key.vk == K_Tab:
    usingAstar = not usingAstar
    if usingAstar:
      consolePrintf(sampleConsole, 1, 4, "Using : A*      ")
    else:
      consolePrintf(sampleConsole, 1, 4, "Using : Dijkstra")
    recalculatePath = true
  elif key.vk == K_Text and key.text[0] != '\x00':
    if (key.text[0] == 'I' or key.text[0] == 'i') and dy > 0:
      # destination move north
      consolePutChar(sampleConsole, dx, dy, oldChar, BKGND_NONE)
      dec(dy)
      oldChar = consoleGetChar(sampleConsole, dx, dy)
      consolePutChar(sampleConsole, dx, dy, '+', BKGND_NONE)
      if smap[dy][dx] == ' ':
        recalculatePath = true
    elif (key.text[0] == 'K' or key.text[0] == 'k') and dy < SAMPLE_SCREEN_HEIGHT - 1:
      # destination move south
      consolePutChar(sampleConsole, dx, dy, oldChar, BKGND_NONE)
      inc(dy)
      oldChar = consoleGetChar(sampleConsole, dx, dy)
      consolePutChar(sampleConsole, dx, dy, '+', BKGND_NONE)
      if smap[dy][dx] == ' ':
        recalculatePath = true
    elif (key.text[0] == 'J' or key.text[0] == 'j') and dx > 0:
      # destination move west
      consolePutChar(sampleConsole, dx, dy, oldChar, BKGND_NONE)
      dec(dx)
      oldChar = consoleGetChar(sampleConsole, dx, dy)
      consolePutChar(sampleConsole, dx, dy, '+', BKGND_NONE)
      if smap[dy][dx] == ' ':
        recalculatePath = true
    elif (key.text[0] == 'L' or key.text[0] == 'l') and dx < SAMPLE_SCREEN_WIDTH - 1:
      # destination move east
      consolePutChar(sampleConsole, dx, dy, oldChar, BKGND_NONE)
      inc(dx)
      oldChar = consoleGetChar(sampleConsole, dx, dy)
      consolePutChar(sampleConsole, dx, dy, '+', BKGND_NONE)
      if smap[dy][dx] == ' ':
        recalculatePath = true
  mx = mouse.cx - SAMPLE_SCREEN_X
  my = mouse.cy - SAMPLE_SCREEN_Y
  if mx >= 0 and mx < SAMPLE_SCREEN_WIDTH and my >= 0 and my < SAMPLE_SCREEN_HEIGHT and
      (dx != mx or dy != my):
    consolePutChar(sampleConsole, dx, dy, oldChar, BKGND_NONE)
    dx = mx
    dy = my
    oldChar = consoleGetChar(sampleConsole, dx, dy)
    consolePutChar(sampleConsole, dx, dy, '+', BKGND_NONE)
    if smap[dy][dx] == ' ':
      recalculatePath = true

#************
# bsp sample
#************

var
  bspDepth*: cint = 8
  minRoomSize*: cint = 4
  randomRoom*: bool = false ##  \
    ##  a room fills a random part of the node or the maximum available space ?
  roomWalls*: bool = true ##  \
    ##  if true, there is always a wall on north & west side of a room

type
  Map* = array[SAMPLE_SCREEN_WIDTH, array[SAMPLE_SCREEN_HEIGHT, char]]

# draw a vertical line
proc vline*(map: ptr Map; x: cint; y1: cint; y2: cint) =
  var
    y: cint = y1
    dy: cint = (if y1 > y2: -1 else: 1)
  (map[])[x][y] = ' '
  if y1 == y2:
    return
  while true:
    inc(y, dy)
    (map[])[x][y] = ' '
    if not (y != y2):
      break

# draw a vertical line up until we reach an empty space
proc vlineUp*(map: ptr Map; x: cint; y: cint) =
  var y = y
  while y >= 0 and (map[])[x][y] != ' ':
    (map[])[x][y] = ' '
    dec(y)

# draw a vertical line down until we reach an empty space
proc vlineDown*(map: ptr Map; x: cint; y: cint) =
  var y = y
  while y < SAMPLE_SCREEN_HEIGHT and (map[])[x][y] != ' ':
    (map[])[x][y] = ' '
    inc(y)

# draw a horizontal line
proc hline*(map: ptr Map; x1: cint; y: cint; x2: cint) =
  var
    x: cint = x1
    dx: cint = (if x1 > x2: -1 else: 1)
  (map[])[x][y] = ' '
  if x1 == x2:
    return
  while true:
    inc(x, dx)
    (map[])[x][y] = ' '
    if not (x != x2):
      break

# draw a horizontal line left until we reach an empty space
proc hlineLeft*(map: ptr Map; x: cint; y: cint) =
  var x = x
  while x >= 0 and (map[])[x][y] != ' ':
    (map[])[x][y] = ' '
    dec(x)

# draw a horizontal line right until we reach an empty space
proc hlineRight*(map: ptr Map; x: cint; y: cint) =
  var x = x
  while x < SAMPLE_SCREEN_WIDTH and (map[])[x][y] != ' ':
    (map[])[x][y] = ' '
    inc(x)

# the class building the dungeon from the bsp nodes
proc traverseNode*(node: Bsp; userData: pointer): bool {.cdecl.} =
  var map: ptr Map = cast[ptr Map](userData)
  if bspIsLeaf(node):
    ##  calculate the room size
    var
      minx: cint = node.x + 1
      maxx: cint = node.x + node.w - 1
      miny: cint = node.y + 1
      maxy: cint = node.y + node.h - 1

    if not roomWalls:
      if minx > 1:
        dec(minx)
      if miny > 1:
        dec(miny)
    if maxx == SAMPLE_SCREEN_WIDTH - 1:
      dec(maxx)
    if maxy == SAMPLE_SCREEN_HEIGHT - 1:
      dec(maxy)
    if randomRoom:
      minx = randomGetInt(nil, minx, maxx - minRoomSize + 1)
      miny = randomGetInt(nil, miny, maxy - minRoomSize + 1)
      maxx = randomGetInt(nil, minx + minRoomSize - 1, maxx)
      maxy = randomGetInt(nil, miny + minRoomSize - 1, maxy)
    node.x = minx
    node.y = miny
    node.w = maxx - minx + 1
    node.h = maxy - miny + 1
    ##  dig the room
    for x in minx..maxx:
      for y in miny..maxy:
        (map[])[x][y] = ' '
  else:
    ## 	printf("lvl %d %dx%d %dx%d\n",node->level, node->x,node->y,node->w,node->h);
    # resize the node to fit its sons
    var
      left: Bsp = bspLeft(node)
      right: Bsp = bspRight(node)
    node.x = min(left.x, right.x)
    node.y = min(left.y, right.y)
    node.w = max(left.x + left.w, right.x + right.w) - node.x
    node.h = max(left.y + left.h, right.y + right.h) - node.y
    # create a corridor between the two lower nodes
    if node.horizontal:
      # vertical corridor
      if left.x + left.w - 1 < right.x or right.x + right.w - 1 < left.x:
        # no overlapping zone. we need a Z shaped corridor
        var
          x1: cint = randomGetInt(nil, left.x, left.x + left.w - 1)
          x2: cint = randomGetInt(nil, right.x, right.x + right.w - 1)
          y: cint = randomGetInt(nil, left.y + left.h, right.y)
        vlineUp(map, x1, y - 1)
        hline(map, x1, y, x2)
        vlineDown(map, x2, y + 1)
      else:
        # straight vertical corridor
        var
          minx: cint = max(left.x, right.x)
          maxx: cint = min(left.x + left.w - 1, right.x + right.w - 1)
          x: cint = randomGetInt(nil, minx, maxx)
        vlineDown(map, x, right.y)
        vlineUp(map, x, right.y - 1)
    else:
      # horizontal corridor
      if left.y + left.h - 1 < right.y or right.y + right.h - 1 < left.y:
        # no overlapping zone. we need a Z shaped corridor
        var
          y1: cint = randomGetInt(nil, left.y, left.y + left.h - 1)
          y2: cint = randomGetInt(nil, right.y, right.y + right.h - 1)
          x: cint = randomGetInt(nil, left.x + left.w, right.x)
        hlineLeft(map, x - 1, y1)
        vline(map, x, y1, y2)
        hlineRight(map, x + 1, y2)
      else:
        ##  straight horizontal corridor
        var
          miny: cint = max(left.y, right.y)
          maxy: cint = min(left.y + left.h - 1, right.y + right.h - 1)
          y: cint = randomGetInt(nil, miny, maxy)
        hlineLeft(map, right.x - 1, y)
        hlineRight(map, right.x, y)
  return true

proc renderBsp*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var
    bsp {.global.}: Bsp = nil
    generate {.global.}: bool = true
    refresh {.global.}: bool = false
    map {.global.}: array[SAMPLE_SCREEN_WIDTH, array[SAMPLE_SCREEN_HEIGHT, char]]
    darkWall: Color = colorRGB(0, 0, 100)
    darkGround: Color = colorRGB(50, 50, 150)

  if generate or refresh:
    # dungeon generation
    if bsp == nil:
      # create the bsp
      bsp = bspNewWithSize(0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    else:
      # restore the nodes size
      bspResize(bsp, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    #memset(map, '#', sizeof((char) * SAMPLE_SCREEN_WIDTH * SAMPLE_SCREEN_HEIGHT))
    for y in 0..map.high:
      for x in 0..map[0].high:
        map[y][x] = '#'

    if generate:
      # build a new random bsp tree
      bspRemoveSons(bsp)
      let optWalls: cint = if roomWalls: 1 else: 0
      bspSplitRecursive(
        bsp, nil, bspDepth, minRoomSize + optWalls, minRoomSize + optWalls,
        1.5, 1.5)

    discard bspTraverseInvertedLevelOrder(bsp, traverseNode, addr(map))
    generate = false
    refresh = false

  consoleClear(sampleConsole)
  consoleSetDefaultForeground(sampleConsole, WHITE)
  consolePrintf(
    sampleConsole, 1, 1,
    "ENTER : rebuild bsp\nSPACE : rebuild dungeon\n+-: bsp depth %d\n*/: room size %d\n1 : random room size %s",
    bspDepth, minRoomSize, if randomRoom: "ON" else: "OFF")

  if randomRoom:
    consolePrintf(sampleConsole, 1, 6, "2 : room walls %s",
                 if roomWalls: "ON" else: "OFF")
  for y in 0.cint..<SAMPLE_SCREEN_HEIGHT:
    for x in 0.cint..<SAMPLE_SCREEN_WIDTH:
      var wall: bool = (map[x][y] == '#')
      consoleSetCharBackground(sampleConsole, x, y,
                               if wall: darkWall else: darkGround, BKGND_SET)

  if key.vk == K_Enter or key.vk == K_Kpenter:
    generate = true
  elif key.vk == K_Text and key.text[0] != '\x00':
    if key.text[0] == ' ':
      refresh = true
    elif key.text[0] in ['=', '+']:
      inc(bspDepth)
      generate = true
    elif key.text[0] == '-' and bspDepth > 1:
      dec(bspDepth)
      generate = true
    elif key.text[0] == '*':
      inc(minRoomSize)
      generate = true
    elif key.text[0] == '/' and minRoomSize > 2:
      dec(minRoomSize)
      generate = true
    elif key.text[0] == '1' or key.vk == K_1 or key.vk == K_Kp1:
      randomRoom = not randomRoom
      if not randomRoom:
        roomWalls = true
      refresh = true
    elif key.text[0] == '2' or key.vk == K_2 or key.vk == K_Kp2:
      roomWalls = not roomWalls
      refresh = true

#***********************
# name generator sample
#***********************

proc renderName*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
  var
    curSet {.global.}: cint
    delay {.global.}: cfloat = 0.0
    sets {.global.}, names {.global.}: seq[string]

  if  names.len == 0:
    var files: seq[string] = sysGetDirectoryContentSeq(
      DATA_PATH & "namegen", "*.cfg")
    ##  parse all the files
    for f in files.items():
      namegenParse(f, nil)
    ##  get the sets list
    sets = namegenGetSetsSeq()

  if first:
    sysSetFps(30) ##  limited to 30 fps

  while names.len >= 15:
    ##  remove the first element.
    names.delete(0)

  consoleClear(sampleConsole)
  consoleSetDefaultForeground(sampleConsole, WHITE)
  consolePrintf(
    sampleConsole, 1, 1, "%s\n\n+ : next generator\n- : prev generator",
    sets[curSet])

  for i in 0..names.high:
    let name = names[i]
    if name.len < SAMPLE_SCREEN_WIDTH:
      consolePrintfEx(sampleConsole, SAMPLE_SCREEN_WIDTH - 2, cint 2 + i, BKGND_NONE, RIGHT, name)

  delay += sysGetLastFrameLength()
  if delay >= 0.5:
    delay -= 0.5
    ##  add a new name to the list
    names.add($namegenGenerate(sets[curSet]))

  if key.vk == K_Text and key.text[0] != '\x00':
    if key.text[0] in ['=', '+']:
      inc(curSet)
      if curSet == sets.len:
        curSet = 0
      names.add("======")
    elif key.text[0] == '-':
      dec(curSet)
      if curSet < 0:
        curSet = sets.high.cint
      names.add("======")


#*********************
# SDL callback sample
#*********************

from sdl2/sdl import Surface, ptrMath

when not NO_SDL_SAMPLE:
  var
    noise*: Noise = nil
    sdlCallbackEnabled*: bool = false
    effectNum*: cint = 0
    delay*: cfloat = 3.0

  proc burn*(screen: sdl.Surface, samplex, sampley, samplew, sampleh: cint) =
    var
      ridx = cint(screen.format.Rshift.int / 8)
      gidx = cint(screen.format.Gshift.int / 8)
      bidx = cint(screen.format.Bshift.int / 8)

    for x in samplex..<(samplex + samplew):
      var p: ptr uint8 = cast[ptr uint8](cast[int](screen.pixels) +
          x * screen.format.BytesPerPixel.cint + sampley * screen.pitch)
      for y in sampley..<(sampley + sampleh):
        var
          ir: cint = 0
          ig: cint = 0
          ib: cint = 0
        ptrMath:
          var p2: ptr uint8 = cast[ptr uint8](cast[int](p) + screen.format.BytesPerPixel.int)
          # get pixel at x+1,y
          inc(ir, p2[ridx].cint)
          inc(ig, p2[gidx].cint)
          inc(ib, p2[bidx].cint)
          p2 -= 2 * screen.format.BytesPerPixel.int
          # get pixel at x-1,y
          inc(ir, p2[ridx].cint)
          inc(ig, p2[gidx].cint)
          inc(ib, p2[bidx].cint)
          p2 += screen.format.BytesPerPixel.int + screen.pitch
          # get pixel at x,y+1
          inc(ir, p2[ridx].cint)
          inc(ig, p2[gidx].cint)
          inc(ib, p2[bidx].cint)
          p2 -= 2 * screen.pitch
          # get pixel at x,y-1
          inc(ir, p2[ridx].cint)
          inc(ig, p2[gidx].cint)
          inc(ib, p2[bidx].cint)
          ir = ir div 4
          ig = ig div 4
          ib = ib div 4
          p[ridx] = ir.uint8
          p[gidx] = ig.uint8
          p[bidx] = ib.uint8
          p += screen.pitch

  proc explode*(screen: sdl.Surface, samplex, sampley, samplew, sampleh: cint) =
    var
      ridx = cint(screen.format.Rshift.int / 8)
      gidx = cint(screen.format.Gshift.int / 8)
      bidx = cint(screen.format.Bshift.int / 8)
      dist = cint((int)(10 * (3.0 - delay)))

    for x in samplex..<(samplex + samplew):
      var p: ptr uint8 = cast[ptr uint8](cast[int](screen.pixels) +
          x * screen.format.BytesPerPixel.cint + sampley * screen.pitch)
      for y in sampley..<(sampley + sampleh):
        var
          ir: cint = 0
          ig: cint = 0
          ib: cint = 0
          i: cint

        for i in 0..<3:
          var
            dx: cint = randomGetInt(nil, -dist, dist)
            dy: cint = randomGetInt(nil, -dist, dist)
            p2: ptr uint8
          ptrMath:
            p2 = p + dx * screen.format.BytesPerPixel.int
            p2 += dy * screen.pitch
            inc(ir, p2[ridx].cint)
            inc(ig, p2[gidx].cint)
            inc(ib, p2[bidx].cint)

        ptrMath:
          ir = ir div 3
          ig = ig div 3
          ib = ib div 3
          p[ridx] = ir.uint8
          p[gidx] = ig.uint8
          p[bidx] = ib.uint8
          p += screen.pitch

  proc blur*(screen: sdl.Surface, samplex, sampley, samplew, sampleh: cint) =
    # let's blur that sample console
    var
      f: array[3, cfloat]
      n: cfloat = 0.0
      ridx = cint(screen.format.Rshift.int / 8)
      gidx = cint(screen.format.Gshift.int / 8)
      bidx = cint(screen.format.Bshift.int / 8)

    f[2] = sysElapsedSeconds()
    if noise == nil:
      noise = noiseNew(3, NOISE_DEFAULT_HURST, NOISE_DEFAULT_LACUNARITY, nil)

    for x in samplex..<(samplex + samplew):
      var p: ptr uint8 = cast[ptr uint8](cast[int](screen.pixels) +
          x * screen.format.BytesPerPixel.cint + sampley * screen.pitch)
      f[0] = x.cfloat / samplew.cfloat

      for y in sampley..<(sampley + sampleh):
        var
          ir: cint = 0
          ig: cint = 0
          ib: cint = 0
          dc, count: cint

        if (y - sampley) mod 8 == 0:
          f[1] = y.float / sampleh.float
          n = noiseGetFbm(noise, f.toPtr, 3.0)
        dc = cint(3 * (n + 1.0))
        count = 0

        ptrMath:
          case dc
          of 4:
            inc(count, 4)
            # get pixel at x,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= 2 * screen.format.BytesPerPixel.cint
            # get pixel at x+2,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= 2 * screen.pitch
            # get pixel at x+2,y+2
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += 2 * screen.format.BytesPerPixel.cint
            # get pixel at x,y+2
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += 2 * screen.pitch
          of 3:
            inc(count, 4)
            # get pixel at x,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += 2 * screen.format.BytesPerPixel.cint
            # get pixel at x+2,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += 2 * screen.pitch
            # get pixel at x+2,y+2
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= 2 * screen.format.BytesPerPixel.cint
            # get pixel at x,y+2
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= 2 * screen.pitch
          of 2:
            inc(count, 4)
            # get pixel at x,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= screen.format.BytesPerPixel.cint
            # get pixel at x-1,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= screen.pitch
            # get pixel at x-1,y-1
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += screen.format.BytesPerPixel.cint
            # get pixel at x,y-1
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += screen.pitch
          of 1:
            inc(count, 4)
            # get pixel at x,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += screen.format.BytesPerPixel.cint
            # get pixel at x+1,y
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p += screen.pitch
            # get pixel at x+1,y+1
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= screen.format.BytesPerPixel.cint
            # get pixel at x,y+1
            inc(ir, p[ridx].cint)
            inc(ig, p[gidx].cint)
            inc(ib, p[bidx].cint)
            p -= screen.pitch
            ir = ir div count
            ig = ig div count
            ib = ib div count
            p[ridx] = ir.uint8
            p[gidx] = ig.uint8
            p[bidx] = ib.uint8
          else:
            discard
          p += screen.pitch

  proc sdl_render*(sdlSurface: pointer) {.cdecl.} =
    var
      screen: sdl.Surface = cast[sdl.Surface](sdlSurface)
      # now we have almighty access to the screen's precious pixels !!
      # get the font character size
      charw, charh, samplex, sampley: cint

    sysGetCharSize(addr(charw), addr(charh))
    # compute the sample console position in pixels
    samplex = SAMPLE_SCREEN_X * charw
    sampley = SAMPLE_SCREEN_Y * charh
    delay -= sysGetLastFrameLength()
    if delay < 0.0:
      delay = 3.0
      effectNum = (effectNum + 1) mod 3
      if effectNum == 2:
        sdlCallbackEnabled = false
      else:
        sdlCallbackEnabled = true
    case effectNum
    of 0:
      blur(screen, samplex, sampley, SAMPLE_SCREEN_WIDTH * charw,
           SAMPLE_SCREEN_HEIGHT * charh)
    of 1:
      explode(screen, samplex, sampley, SAMPLE_SCREEN_WIDTH * charw,
              SAMPLE_SCREEN_HEIGHT * charh)
    of 2:
      burn(screen, samplex, sampley, SAMPLE_SCREEN_WIDTH * charw,
           SAMPLE_SCREEN_HEIGHT * charh)
    else:
      discard

  proc renderSdl*(first: bool; key: ptr Key; mouse: ptr Mouse) {.cdecl.} =
    if first:
      sysSetFps(30) # limited to 30 fps
      # use noise sample as background. rendering is done in SampleRenderer
      consoleSetDefaultBackground(sampleConsole, LIGHT_BLUE)
      consoleSetDefaultForeground(sampleConsole, WHITE)
      consoleClear(sampleConsole)
      discard consolePrintfRectEx(
        sampleConsole, SAMPLE_SCREEN_WIDTH div 2, 3,
        SAMPLE_SCREEN_WIDTH, 0, BKGND_NONE, CENTER,
        "The SDL callback gives you access to the screen surface so that you can alter the pixels one by one using SDL API or any API on top of SDL. SDL is used here to blur the sample console.\n\nHit TAB to enable/disable the callback. While enabled, it will be active on other samples too.\n\nNote that the SDL callback only works with SDL renderer.")
    if key.vk == K_Tab:
      sdlCallbackEnabled = not sdlCallbackEnabled
      if sdlCallbackEnabled:
        sysRegisterSDL_renderer(sdlRender)
      else:
        sysRegisterSDL_renderer(nil)
        # we want libtcod to redraw the sample console
        # even if nothing has changed in it
        consoleSetDirty(
          SAMPLE_SCREEN_X, SAMPLE_SCREEN_Y,
          SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)

##*********************
## the list of samples
##*********************

var samples*: seq[Sample] = @[("  True colors        ", renderColors),
                              ("  Offscreen console  ", renderOffscreen),
                              ("  Line drawing       ", renderLines),
                              ("  Noise              ", renderNoise),
                              ("  Field of view      ", renderFov),
                              ("  Path finding       ", renderPath),
                              ("  Bsp toolkit        ", renderBsp),
                              ("  Image toolkit      ", renderImage),
                              ("  Mouse support      ", renderMouse),
                              ("  Name generator     ", renderName),
                              ("  SDL callback       ", renderSdl)]

var nbSamples* = samples.len  ##  total number of samples

proc atoi(s: string): cint =
  var r: int
  let n = s.parseInt(r)
  if n == 0: return 0
  return r.cint

var
  curSample: int = 0  ##  index of the current sample
  first: bool = true  ##  first time we render a sample
  i: cint
  key: Key
  mouse: Mouse
  font: cstring = DATA_PATH & "fonts/consolas10x10_gs_tc.png"
  nbCharHoriz: cint = 0
  nbCharVertic: cint = 0
  argn: cint
  argc = paramCount()
  fullscreenWidth: cint = 0
  fullscreenHeight: cint = 0
  fontFlags: cint = FONT_TYPE_GREYSCALE or FONT_LAYOUT_TCOD
  fontNewFlags: cint = 0
  renderer: Renderer = RENDERER_SDL
  fullscreen: bool = false
  creditsEnd: bool = false
  curRenderer: Renderer = 0.Renderer
  rendererName = @["F1 GLSL   ", "F2 OPENGL ", "F3 SDL    ",
                   "F4 SDL2   ", "F5 OPENGL2"]

# initialize the root console (open the game window)
argn = 1
while argn < argc:
  if cmpIgnoreCase(paramStr(argn), "-font") == 0 and argn + 1 < argc:
    inc(argn)
    font = paramStr(argn)
    fontFlags = 0
  elif cmpIgnoreCase(paramStr(argn), "-font-nb-char") == 0 and argn + 2 < argc:
    inc(argn)
    nbCharHoriz = atoi(paramStr(argn))
    inc(argn)
    nbCharVertic = atoi(paramStr(argn))
    fontFlags = 0
  elif cmpIgnoreCase(paramStr(argn), "-fullscreen-resolution") == 0 and argn + 2 < argc:
    inc(argn)
    fullscreenWidth = atoi(paramStr(argn))
    inc(argn)
    fullscreenHeight = atoi(paramStr(argn))
  elif cmpIgnoreCase(paramStr(argn), "-renderer") == 0 and argn + 1 < argc:
    inc(argn)
    renderer = cast[Renderer](atoi(paramStr(argn)))
  elif cmpIgnoreCase(paramStr(argn), "-fullscreen") == 0:
    fullscreen = true
  elif cmpIgnoreCase(paramStr(argn), "-font-in-row") == 0:
    fontFlags = 0
    fontNewFlags = fontNewFlags or FONT_LAYOUT_ASCII_INROW
  elif cmpIgnoreCase(paramStr(argn), "-font-greyscale") == 0:
    fontFlags = 0
    fontNewFlags = fontNewFlags or FONT_TYPE_GREYSCALE
  elif cmpIgnoreCase(paramStr(argn), "-font-tcod") == 0:
    fontFlags = 0
    fontNewFlags = fontNewFlags or FONT_LAYOUT_TCOD
  elif cmpIgnoreCase(paramStr(argn), "-help") == 0 or cmpIgnoreCase(paramStr(argn), "-?") == 0:
    echo("options :")
    echo("-font <filename> : use a custom font")
    echo("-font-nb-char <nb_char_horiz> <nb_char_vertic> : number of characters in the font")
    echo("-font-in-row : the font layout is in row instead of columns")
    echo("-font-tcod : the font uses TCOD layout instead of ASCII")
    echo("-font-greyscale : antialiased font using greyscale bitmap")
    echo("-fullscreen : start in fullscreen")
    echo("-fullscreen-resolution <screen_width> <screen_height> : force fullscreen resolution")
    echo("-renderer <num> : set renderer. 0 : GLSL 1 : OPENGL 2 : SDL")
    system.quit()
  else:
    ##  ignore parameter
  inc(argn)
if fontFlags == 0:
  fontFlags = fontNewFlags
consoleSetCustomFont(font, fontFlags, nbCharHoriz, nbCharVertic)
if fullscreenWidth > 0:
  sysForceFullscreenResolution(fullscreenWidth, fullscreenHeight)
consoleInitRoot(80, 50, "libtcod C sample", fullscreen, renderer)
# initialize the offscreen console for the samples
sampleConsole = consoleNew(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)

while true:
  if not creditsEnd:
    creditsEnd = consoleCreditsRender(60, 43, false)

  for i in 0..<nbSamples:
    if i == curSample:
      # set colors for currently selected sample
      consoleSetDefaultForeground(nil, WHITE)
      consoleSetDefaultBackground(nil, LIGHT_BLUE)
    else:
      # set colors for other samples
      consoleSetDefaultForeground(nil, GREY)
      consoleSetDefaultBackground(nil, BLACK)
    # print the sample name
    consolePrintfEx(
      nil, 2, cint 46 - (nbSamples - i), BKGND_SET, LEFT, samples[i].name)

  # print the help message
  consoleSetDefaultForeground(nil, GREY)
  consolePrintfEx(
    nil, 79, 46, BKGND_NONE, RIGHT, "last frame : %3d ms (%3d fps)",
    (int)(sysGetLastFrameLength() * 1000), sysGetFps())
  consolePrintfEx(
    nil, 79, 47, BKGND_NONE, RIGHT, "elapsed : %8dms %4.2fs",
    sysElapsedMilli(), sysElapsedSeconds())
  consolePrintf(
    nil, 2, 47, "%c%c : select a sample", CHAR_ARROW_N, CHAR_ARROW_S)
  consolePrintf(
    nil, 2, 48, "ALT-ENTER : switch to %s",
    if consoleIsFullscreen(): "windowed mode  " else: "fullscreen mode")
  # render current sample
  samples[curSample].render(first, addr(key), addr(mouse))
  first = false
  # blit the sample console on the root console
  consoleBlit(
    sampleConsole, 0, 0,
    SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT, # the source console & zone to blit
    nil, SAMPLE_SCREEN_X, SAMPLE_SCREEN_Y, # the destination console & position
    1.0, 1.0) # alpha coefs

  when not NO_SDL_SAMPLE:
    if sdlCallbackEnabled:
      # we want libtcod to redraw the sample console
      # even if nothing has changed in it
      consoleSetDirty(
        SAMPLE_SCREEN_X, SAMPLE_SCREEN_Y,
        SAMPLE_SCREEN_WIDTH,SAMPLE_SCREEN_HEIGHT)
  # display renderer list and current renderer
  curRenderer = sysGetRenderer()
  consoleSetDefaultForeground(nil, GREY)
  consoleSetDefaultBackground(nil, BLACK)
  consolePrintfEx(
    nil, 42, cint 46 - (NB_RENDERERS.ord + 1), BKGND_SET, LEFT, "Renderer :")

  for i in 0..<NB_RENDERERS.ord:
    if i == curRenderer.ord:
      # set colors for current renderer
      consoleSetDefaultForeground(nil, WHITE)
      consoleSetDefaultBackground(nil, LIGHT_BLUE)
    else:
      # set colors for other renderer
      consoleSetDefaultForeground(nil, GREY)
      consoleSetDefaultBackground(nil, BLACK)
    consolePrintfEx(nil, 42, cint 46 - (NB_RENDERERS.ord - i), BKGND_SET, LEFT, rendererName[i])

  # update the game screen
  consoleFlush()
  # did the user hit a key ?
  discard sysCheckForEvent((EVENT_KEY_PRESS.ord or EVENT_MOUSE.ord), addr(key), addr(mouse))
  if key.vk == K_Down:
    # down arrow : next sample
    curSample = (curSample + 1) mod nbSamples
    first = true
  elif key.vk == K_Up:
    # up arrow : previous sample
    dec(curSample)
    if curSample < 0:
      curSample = nbSamples - 1
    first = true
  elif key.vk == K_Enter and (key.lalt or key.ralt):
    # ALT-ENTER : switch fullscreen
    consoleSetFullscreen(not consoleIsFullscreen())
  elif key.vk == K_Printscreen:
    if key.lalt:
      # Alt-PrintScreen : save to samples.asc
      discard consoleSaveAsc(nil, "samples.asc")
    else:
      # save screenshot
      sysSaveScreenshot(nil)
  elif key.vk == K_F1:
    # switch renderers with F1,F2,F3
    sysSetRenderer(RENDERER_GLSL)
  elif key.vk == K_F2:
    sysSetRenderer(RENDERER_OPENGL)
  elif key.vk == K_F3:
    sysSetRenderer(RENDERER_SDL)
  elif key.vk == K_F4:
    sysSetRenderer(RENDERER_SDL2)
  elif key.vk == K_F5:
    sysSetRenderer(RENDERER_OPENGL2)
  if consoleIsWindowClosed():
    break
libtcod.quit()
quit(QUIT_SUCCESS)

