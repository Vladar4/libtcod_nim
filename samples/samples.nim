#
# libtcod Nimrod samples
# This code demonstrates various usages of libtcod modules
# It's in the public domain.
#

import libtcod, unsigned, os, parseutils, math


# a sample has a name and a rendering function
type
  PSampleRender = proc(first: bool, key: ptr TKey, mouse: ptr TMouse){.closure.}
  TSample = tuple[name: string, render: PSampleRender]

const
  # sample screen size
  SAMPLE_SCREEN_WIDTH = 46
  SAMPLE_SCREEN_WIDTH_2 = int(SAMPLE_SCREEN_WIDTH / 2)
  SAMPLE_SCREEN_WIDTH_4 = int(SAMPLE_SCREEN_WIDTH_2 / 2)
  SAMPLE_SCREEN_HEIGHT = 20
  SAMPLE_SCREEN_HEIGHT_2 = int(SAMPLE_SCREEN_HEIGHT / 2)
  # sample screen position
  SAMPLE_SCREEN_X = 20
  SAMPLE_SCREEN_Y = 10


proc strtoint(s: string): int =
  var i: int
  discard parseInt(s, i)
  return i


# ***************************
# samples rendering functions
# ***************************

# the offscreen console in which the samples are rendered
var sample_console: PConsole


# ***************************
# true colors sample
# ***************************
proc render_colors(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  const
    TOPLEFT = 0
    TOPRIGHT = 1
    BOTTOMLEFT = 2
    BOTTOMRIGHT = 3

  var
    # random corner colors
    cols {.global.}: array[0..3, TColor] = [(50'u8,40'u8,150'u8),
                                            (240'u8,85'u8,5'u8),
                                            (50'u8,35'u8,240'u8),
                                            (10'u8,200'u8,130'u8)]
    dirr {.global.}: array[0..3, int] = [1,-1,1,1]
    dirg {.global.}: array[0..3, int] = [1,-1,-1,1]
    dirb {.global.}: array[0..3, int] = [1,1,1,-1]
    textColor, col, top, bottom: TColor
    xcoef, ycoef: float32
    c: int

  # ==== slighty modify the corner colors ====
  if first:
    sys_set_fps(0) # unlimited fps
    console_clear(sample_console)

  # ==== slighty modify the corner colors ====
  for c in 0..3:
    # move each corner color
    var component: int = random_get_int(nil, 0, 2)
    case component
    of 0:
      cols[c].r += uint8(5 * dirr[c])
      if cols[c].r == 255'u8: dirr[c] = -1
      elif cols[c].r == 0'u8: dirr[c] = 1
    of 1:
      cols[c].g += uint8(5 * dirg[c])
      if cols[c].g == 255'u8: dirg[c] = -1
      elif cols[c].g == 0'u8: dirg[c] = 1
    of 2:
      cols[c].b += uint8(5 * dirb[c])
      if cols[c].b == 255'u8: dirb[c] = -1
      elif cols[c].b == 0'u8: dirb[c] = 1
    else:
      discard

  # ==== scan the whole screen, interpolating corner colors ====
  for x in 0..SAMPLE_SCREEN_WIDTH-1:
    xcoef = x / (SAMPLE_SCREEN_WIDTH - 1)
    # get the current column top and bottom colors
    top = color_lerp(cols[TOPLEFT], cols[TOPRIGHT], xcoef)
    bottom = color_lerp(cols[BOTTOMLEFT], cols[BOTTOMRIGHT], xcoef)
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      ycoef = y / (SAMPLE_SCREEN_HEIGHT - 1)
      # get the current cell color
      col = color_lerp(top, bottom, ycoef)
      console_set_char_background(sample_console, x, y, col, BKGND_SET)

  # ==== print the text ====
  # get the background color at the text position
  textColor = console_get_char_background(sample_console, SAMPLE_SCREEN_WIDTH_2, 5)
  # and invert it
  textColor.r = 255'u8 - textColor.r
  textColor.g = 255'u8 - textColor.g
  textColor.b = 255'u8 - textColor.b
  console_set_default_foreground(sample_console, textColor)

  # put random text (for performance tests)
  for x in 0..SAMPLE_SCREEN_WIDTH-1:
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      # ==== This block causes error on Windows ====
      #col = console_get_char_background(sample_console, x, y)
      #col = color_lerp(col, BLACK, 0.5)
      c = random_get_int(nil, ord('a'), ord('z'))
      console_set_default_foreground(sample_console, col)
      console_put_char(sample_console, x, y, c, BKGND_NONE)

  # the background behind the text is slightly darkened using the BKGND_MULTIPLY flag
  console_set_default_background(sample_console, GREY)
  discard console_print_rect_ex(sample_console, SAMPLE_SCREEN_WIDTH_2, 5,
    SAMPLE_SCREEN_WIDTH-2, SAMPLE_SCREEN_HEIGHT-1, BKGND_MULTIPLY, CENTER,
    "The Doryen library uses 24 bits colors, for both background and foreground.")


# ***************************
# offscreen console sample
# ***************************
proc render_offscreen(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    secondary {.global.}: PConsole # second screen
    screenshot {.global.}: PConsole # second screen
    init {.global.} = false # draw the secondary screen only the first time
    counter {.global.} = 0
    x {.global.} = 0 # secondary screen position x
    y {.global.} = 0 # secondary screen position y
    xdir {.global.} = 1 # movement direction x
    ydir {.global.} = 1 # movement direction y

  if not init:
    init = true
    secondary = console_new(SAMPLE_SCREEN_WIDTH_2, SAMPLE_SCREEN_HEIGHT_2)
    screenshot = console_new(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    console_print_frame(secondary, 0, 0, SAMPLE_SCREEN_WIDTH_2, SAMPLE_SCREEN_HEIGHT_2, false, BKGND_SET, "Offscreen console")
    discard console_print_rect_ex(secondary, SAMPLE_SCREEN_WIDTH_4, 2, SAMPLE_SCREEN_WIDTH_2-2, SAMPLE_SCREEN_HEIGHT_2, BKGND_NONE, CENTER, "You can render to an offscreen console and blit in on another one, simulating alpha transparency.")

  if first:
    sys_set_fps(30) # limited to 30 fps
    # get a "screenshot" of the current sample screen
    console_blit(sample_console, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT, screenshot, 0, 0, 1.0, 1.0)
  inc(counter)

  if counter mod 20 == 0:
    # move the secondary screen every 2 seconds
    x += xdir
    y += ydir
    if x == SAMPLE_SCREEN_WIDTH_2+5: xdir = -1
    elif x == -5: xdir=1
    if y == SAMPLE_SCREEN_HEIGHT_2+5: ydir = -1
    elif y == -5: ydir=1

  # restore the initial screen
  console_blit(screenshot, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT, sample_console, 0, 0, 1.0, 1.0)
  # blit the overlapping screen
  console_blit(secondary, 0, 0, SAMPLE_SCREEN_WIDTH_2, SAMPLE_SCREEN_HEIGHT_2, sample_console, x, y, 1.0, 0.75)


# ***************************
# line drawing sample
# ***************************
var bk_flag = BKGND_SET # current blending mode

proc line_listener(x, y: int): bool {.cdecl.} =
  if x >= 0 and y >= 0 and x < SAMPLE_SCREEN_WIDTH and y < SAMPLE_SCREEN_HEIGHT:
    console_set_char_background(sample_console, x, y, LIGHT_BLUE, bk_flag)
  return true


proc render_lines(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    bk {.global.}: PConsole # colored background
    init {.global.} = false
    flag_names {.global.} = @[
      "BKGND_NONE",
      "BKGND_SET",
      "BKGND_MULTIPLY",
      "BKGND_LIGHTEN",
      "BKGND_DARKEN",
      "BKGND_SCREEN",
      "BKGND_COLOR_DODGE",
      "BKGND_COLOR_BURN",
      "BKGND_ADD",
      "BKGND_ADDALPHA",
      "BKGND_BURN",
      "BKGND_OVERLAY",
      "BKGND_ALPHA"]
    xo, yo, xd, yd: int # segment starting, ending, current position
    alpha: float32 # alpha value when blending mode = TCOD_BKGND_ALPHA
    angle, cos_angle, sin_angle: float32 # segment angle data
    recty: int # gradient vertical position

  if key.vk == K_ENTER or key.vk == K_KPENTER:
    # switch to the next blending mode
    inc(bk_flag)
    if (bk_flag and 0xff) > BKGND_ALPH: bk_flag = BKGND_NONE

  if (bk_flag and 0xff) == BKGND_ALPH:
    # for the alpha mode, update alpha every frame
    alpha = (1.0 + cos(sys_elapsed_seconds() * 2)) / 2.0
    bk_flag = bkgnd_alpha(alpha)
  elif (bk_flag and 0xff) == BKGND_ADDA:
    # for the add alpha mode, update alpha every frame
    alpha = (1.0 + cos(sys_elapsed_seconds() * 2)) / 2.0
    bk_flag = bkgnd_addalpha(alpha)

  if not init:
    bk = console_new(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    # initialize the colored background
    for x in 0..SAMPLE_SCREEN_WIDTH-1:
      for y in 0..SAMPLE_SCREEN_HEIGHT-1:
        var col: TColor
        col.r = uint8(x * 255 / (SAMPLE_SCREEN_WIDTH - 1))
        col.g = uint8((x + y) * 255 / (SAMPLE_SCREEN_WIDTH - 1 + SAMPLE_SCREEN_HEIGHT - 1))
        col.b = uint8(y * 255 / (SAMPLE_SCREEN_HEIGHT - 1))
        console_set_char_background(bk, x, y, col, BKGND_SET)
    init = true

  if first:
    sys_set_fps(30) # limited to 30 fps
    console_set_default_foreground(sample_console, WHITE)

  # blit the background
  console_blit(bk, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT, sample_console, 0, 0, 1.0, 1.0)
  # render the gradient
  recty = int((SAMPLE_SCREEN_HEIGHT - 2) * ((1.0 + cos(sys_elapsed_seconds())) / 2.0))
  for x in 0..SAMPLE_SCREEN_WIDTH-1:
    var col: TColor
    col.r = uint8(x * 255 / SAMPLE_SCREEN_WIDTH)
    col.g = uint8(x * 255 / SAMPLE_SCREEN_WIDTH)
    col.b = uint8(x * 255 / SAMPLE_SCREEN_WIDTH)
    console_set_char_background(sample_console, x, recty, col, bk_flag)
    console_set_char_background(sample_console, x, recty+1, col, bk_flag)
    console_set_char_background(sample_console, x, recty+2, col, bk_flag)

  # calculate the segment ends
  angle = sys_elapsed_seconds() * 2.0
  cos_angle = cos(angle)
  sin_angle = sin(angle)
  let
    SCRW2 = float32(SAMPLE_SCREEN_WIDTH_2)
    SCRH2 = float32(SAMPLE_SCREEN_HEIGHT_2)
  xo = int(SCRW2 * (1 + cos_angle))
  yo = int(SCRH2 + sin_angle * SCRW2)
  xd = int(SCRW2 * (1 - cos_angle))
  yd = int(SCRH2 - sin_angle * SCRW2)
  # render the line
  discard line(xo, yo, xd, yd, line_listener)
  # print the current flag
  console_print(sample_console, 2, 2, "%s (ENTER to change)", flag_names[bk_flag and 0xff])


# ***************************
# noise sample
# ***************************
proc render_noise(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
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

  var
    functName {.global.} = @["1 : perlin noise       ",
                            "2 : simplex noise      ",
                            "3 : wavelet noise      ",
                            "4 : perlin fbm         ",
                            "5 : perlin turbulence  ",
                            "6 : simplex fbm        ",
                            "7 : simplex turbulence ",
                            "8 : wavelet fbm        ",
                            "9 : wavelet turbulence "]
    funct {.global.} = PERLIN
    noise {.global.}: PNoise = nil
    dx {.global.} = 0.0
    dy {.global.} = 0.0
    octaves {.global.} = 4.0
    hurst {.global.} = NOISE_DEFAULT_HURST
    lacunarity {.global.} = NOISE_DEFAULT_LACUNARITY
    img {.global.}: PImage = nil
    zoom {.global.} = 3.0

  if noise == nil:
    noise = noise_new(2, hurst, lacunarity, nil)
    img = image_new(SAMPLE_SCREEN_WIDTH*2, SAMPLE_SCREEN_HEIGHT*2)

  if first:
    sys_set_fps(30) # limited to 30 fps

  console_clear(sample_console)
  # texture animation
  dx += 0.01
  dy += 0.01
  # render the 2d noise function
  for y in 0..2*SAMPLE_SCREEN_HEIGHT-1:
    for x in 0..2*SAMPLE_SCREEN_WIDTH-1:
      var
        f: array[0..1, float32]
        value: float
        c: uint8
        col: TColor
      f[0] = zoom * float32(x / (2 * SAMPLE_SCREEN_WIDTH) + dx)
      f[1] = zoom * float32(y / (2 * SAMPLE_SCREEN_HEIGHT) + dy)
      value = 0.0
      var pf = floatArrayToPtr(f)
      case funct
      of PERLIN: value = noise_get_ex(noise, pf, NOISE_PERLIN)
      of SIMPLEX: value = noise_get_ex(noise, pf, NOISE_SIMPLEX)
      of WAVELET: value = noise_get_ex(noise, pf, NOISE_WAVELET)
      of FBM_PERLIN: value = noise_get_fbm_ex(noise, pf, octaves, NOISE_PERLIN)
      of TURBULENCE_PERLIN: value = noise_get_turbulence_ex(noise, pf, octaves, NOISE_PERLIN)
      of FBM_SIMPLEX: value = noise_get_fbm_ex(noise, pf, octaves, NOISE_SIMPLEX)
      of TURBULENCE_SIMPLEX: value = noise_get_turbulence_ex(noise, pf, octaves, NOISE_SIMPLEX)
      of FBM_WAVELET: value = noise_get_fbm_ex(noise, pf, octaves, NOISE_WAVELET)
      of TURBULENCE_WAVELET: value = noise_get_turbulence_ex(noise, pf, octaves, NOISE_WAVELET)
      else: discard
      c= uint8((value + 1.0) / 2.0 * 255)
      # use a bluish color
      col.g = uint8(c.int / 2)
      col.r = col.g
      col.b = c
      image_put_pixel(img, x, y, col)

  # blit the noise image with subcell resolution
  image_blit_2x(img, sample_console, 0, 0, 0, 0, -1, -1)

  # draw a transparent rectangle
  console_set_default_background(sample_console, GREY)
  var n: int
  if funct <= WAVELET: n = 10
  else: n = 13
  console_rect(sample_console, 2, 2, 23, n, false, BKGND_MULTIPLY)
  # ==== This block causes error on Windows ====
  #for y in 2..1+n:
  #  for x in 2..1+23:
  #    var col: TColor = console_get_char_foreground(sample_console, x, y)
  #    col = color_multiply(col, GREY)
  #    console_set_char_foreground(sample_console, x, y, col)

  # draw the text
  for curfunct in PERLIN..TURBULENCE_WAVELET:
    if curfunct == funct:
        console_set_default_foreground(sample_console, WHITE)
        console_set_default_background(sample_console, LIGHT_BLUE)
        console_print_ex(sample_console, 2, 2+curfunct, BKGND_SET, LEFT, functName[curfunct])
    else:
        console_set_default_foreground(sample_console, GREY)
        console_print(sample_console, 2, 2+curfunct, functName[curfunct])

  # draw parameters
  console_set_default_foreground(sample_console, WHITE)
  console_print(sample_console, 2, 11, "Y/H : zoom (%2.1f)       ", zoom)
  if funct > WAVELET:
    console_print(sample_console, 2, 12, "E/D : hurst (%2.1f)      ", hurst)
    console_print(sample_console, 2, 13, "R/F : lacunarity (%2.1f) ", lacunarity)
    console_print(sample_console, 2, 14, "T/G : octaves (%2.1f)    ", octaves)

  # handle keypress
  if key.vk == K_NONE: return
  if key.c >= '1' and key.c <= '9':
    # change the noise function
    funct = ord(key.c) - ord('1')
  elif key.c == 'E' or key.c == 'e':
    # increase hurst
    hurst += 0.1
    noise_delete(noise)
    noise = noise_new(2, hurst, lacunarity, nil)
  elif key.c == 'D' or key.c == 'd':
    # decrease hurst
    hurst -= 0.1
    noise_delete(noise)
    noise = noise_new(2, hurst, lacunarity, nil)
  elif key.c == 'R' or key.c == 'r':
    # increase lacunarity
    lacunarity += 0.5
    noise_delete(noise)
    noise = noise_new(2, hurst, lacunarity, nil)
  elif key.c == 'F' or key.c == 'f':
    # decrease lacunarity
    lacunarity -= 0.5
    noise_delete(noise)
    noise = noise_new(2, hurst, lacunarity, nil)
  elif key.c == 'T' or key.c == 't':
    # increase octaves
    octaves += 0.5
  elif key.c == 'G' or key.c == 'g':
    # decrease octaves
    octaves -= 0.5
  elif key.c == 'Y' or key.c == 'y':
    # increase zoom
    zoom += 0.2
  elif key.c == 'H' or key.c == 'h':
    # decrease zoom
    zoom -= 0.2


# ***************************
# fov sample
# ***************************
proc mode_str(mode: bool): string =
  if mode: return "on "
  return "off"

proc render_fov(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  const
    TORCH_RADIUS = 10.0
    SQUARED_TORCH_RADIUS = TORCH_RADIUS * TORCH_RADIUS

  var
    smap {.global.} = @["##############################################",
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
    px {.global.} = 20 # player position x
    py {.global.} = 10 # player position y
    recompute_fov {.global.} = true
    torch {.global.} = false
    light_walls {.global.} = true
    map {.global.}: PMap = nil
    dark_wall {.global.}: TColor = (0'u8, 0'u8, 100'u8)
    light_wall {.global.}: TColor = (130'u8, 110'u8, 50'u8)
    dark_ground {.global.}: TColor = (50'u8, 50'u8, 150'u8)
    light_ground {.global.}: TColor = (200'u8, 180'u8, 50'u8)
    noise {.global.}: PNoise
    algonum {.global.} = 0
    algo_names {.global.} = [
      "BASIC      ", "DIAMOND    ", "SHADOW     ",
      "PERMISSIVE0", "PERMISSIVE1", "PERMISSIVE2","PERMISSIVE3","PERMISSIVE4",
      "PERMISSIVE5", "PERMISSIVE6", "PERMISSIVE7","PERMISSIVE8", "RESTRICTIVE"]
    torchx {.global.} =0.0'f32 # torch light position in the perlin noise
    # torch position & intensity variation
    dx = 0.0
    dy = 0.0
    di = 0.0

  if map == nil:
    map = map_new(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      for x in 0..SAMPLE_SCREEN_WIDTH-1:
        if smap[y][x] == ' ': map_set_properties(map, x, y, true, true) # ground
        elif smap[y][x] == '=': map_set_properties(map, x, y, true, false) # window
    noise = noise_new(1, 1.0, 1.0, nil) # 1d noise for the torch flickering

  if first:
    sys_set_fps(30) # limited to 30 fps
    # we draw the foreground only the first time.
    # during the player movement, only the @ is redrawn.
    # the rest impacts only the background color

    # draw the help text & player @ 
    console_clear(sample_console)
    console_set_default_foreground(sample_console, WHITE)
    console_print(sample_console, 1, 0, "IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s", mode_str(torch), mode_str(light_walls), algo_names[algonum])
    console_set_default_foreground(sample_console, BLACK)
    console_put_char(sample_console, px, py, '@', BKGND_NONE)
    # draw windows
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      for x in 0..SAMPLE_SCREEN_WIDTH-1:
        if smap[y][x] == '=':
          console_put_char(sample_console, x, y, CHAR_DHLINE, BKGND_NONE)

  if recompute_fov:
    recompute_fov = false
    var radius: int
    if torch: radius = int(TORCH_RADIUS)
    else: radius = 0
    map_compute_fov(map, px, py, radius, light_walls, TFOVAlgorithm(algonum))

  if torch:
    var tdx: float32
    # slightly change the perlin noise parameter */
    torchx += 0.2
    # randomize the light position between -1.5 and 1.5
    tdx = torchx + 20.0
    dx = noise_get(noise, addr(tdx)) * 1.5
    tdx += 30.0
    dy = noise_get(noise, addr(tdx)) * 1.5
    di = 0.2 * noise_get(noise, addr(torchx))

  for y in 0..SAMPLE_SCREEN_HEIGHT-1:
    for x in 0..SAMPLE_SCREEN_WIDTH-1:
      var
        visible: bool = map_is_in_fov(map, x, y)
        wall: bool = smap[y][x] == '#'
      if not visible:
        var cl: TColor
        if wall: cl = dark_wall
        else: cl = dark_ground
        console_set_char_background(sample_console, x, y, cl, BKGND_SET)
      else:
        if not torch:
          var cl: TColor
          if wall: cl = light_wall
          else: cl = light_ground
          console_set_char_background(sample_console, x, y, cl, BKGND_SET)
        else:
          var
            base, light: TColor
          if wall:
            base = dark_wall
            light = light_wall
          else:
            base = dark_ground
            light = light_ground
          var
            r: float32 = (float32(x-px)+dx) * (float32(x-px)+dx) + (float32(y-py)+dy) * (float32(y-py)+dy) # cell distance to torch (squared)
          if r < SQUARED_TORCH_RADIUS:
            var vl: float32 = (SQUARED_TORCH_RADIUS - r) / SQUARED_TORCH_RADIUS + di
            vl = clamp(vl, 0.0, 1.0)
            base = color_lerp(base, light, vl)
          console_set_char_background(sample_console, x, y, base, BKGND_SET)

  if key.c == 'I' or key.c == 'i':
    if smap[py-1][px] == ' ':
      console_put_char(sample_console, px, py, ' ', BKGND_NONE)
      dec(py)
      console_put_char(sample_console, px, py, '@', BKGND_NONE)
      recompute_fov = true
  elif key.c == 'K' or key.c == 'k':
    if smap[py+1][px] == ' ':
      console_put_char(sample_console, px, py, ' ', BKGND_NONE)
      inc(py)
      console_put_char(sample_console, px, py, '@', BKGND_NONE)
      recompute_fov = true
  elif key.c == 'J' or key.c == 'j':
    if smap[py][px-1] == ' ':
      console_put_char(sample_console, px, py, ' ', BKGND_NONE)
      dec(px)
      console_put_char(sample_console, px, py, '@', BKGND_NONE)
      recompute_fov = true
  elif key.c == 'L' or key.c == 'l':
    if smap[py][px+1] == ' ':
      console_put_char(sample_console, px, py, ' ', BKGND_NONE)
      inc(px)
      console_put_char(sample_console, px, py, '@', BKGND_NONE)
      recompute_fov = true
  elif key.c == 'T' or key.c == 't':
    torch = not torch
    console_set_default_foreground(sample_console, WHITE)
    console_print(sample_console, 1, 0, "IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s", mode_str(torch), mode_str(light_walls), algo_names[algonum])
    console_set_default_foreground(sample_console, BLACK)
  elif key.c == 'W' or key.c == 'w':
    light_walls = not light_walls
    console_set_default_foreground(sample_console, WHITE)
    console_print(sample_console,1,0,"IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s", mode_str(torch), mode_str(light_walls), algo_names[algonum])
    console_set_default_foreground(sample_console, BLACK)
    recompute_fov = true
  elif key.c == '+' or key.c == '-':
    if key.c == '+': inc(algonum)
    else: dec(algonum)
    algonum = clamp(algonum, 0, NB_FOV_ALGORITHMS.int-1)
    console_set_default_foreground(sample_console, WHITE)
    console_print(sample_console,1,0,"IJKL : move around\nT : torch fx %s\nW : light walls %s\n+-: algo %s", mode_str(torch), mode_str(light_walls), algo_names[algonum])
    console_set_default_foreground(sample_console, BLACK)
    recompute_fov = true


# ***************************
# path sample
# ***************************
var usingAstar = true
proc render_path(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    smap {.global.} = @["##############################################",
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
    px {.global.} = 20 # player position x
    py {.global.} = 10 # player position y
    dx {.global.} = 24 # destination x
    dy {.global.} = 1 # destination y
    map {.global.}: PMap = nil
    dark_wall {.global.}: TColor = (0'u8, 0'u8, 100'u8)
    dark_ground {.global.}: TColor = (50'u8, 50'u8, 150'u8)
    light_ground {.global.}: TColor = (200'u8, 180'u8, 50'u8)
    path {.global.}: PPath = nil
    dijkstraDist {.global.} = 0.0'f32
    dijkstra {.global.}: PDijkstra = nil
    recalculatePath {.global.} = false
    busy {.global.}: float32
    oldChar {.global.}: int = ord(' ')
    mx, my: int

  if map == nil:
    # initialize the map
    map = map_new(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      for x in 0..SAMPLE_SCREEN_WIDTH-1:
        if smap[y][x] == ' ': map_set_properties(map, x, y, true, true) # ground
        elif smap[y][x] == '=': map_set_properties(map, x, y, true, false) # window
    path = path_new_using_map(map)
    dijkstra = dijkstra_new(map)

  if first:
    sys_set_fps(30) # limited to 30 fps
    # we draw the foreground only the first time.
    # during the player movement, only the @ is redrawn.
    # the rest impacts only the background color

    # draw the help text & player @
    console_clear(sample_console)
    console_set_default_foreground(sample_console, WHITE)
    console_put_char(sample_console, dx, dy, '+', BKGND_NONE)
    console_put_char(sample_console, px, py, '@', BKGND_NONE)
    console_print(sample_console, 1, 1, "IJKL / mouse :\nmove destination\nTAB : A*/dijkstra")
    console_print(sample_console, 1, 4, "Using : A*")

    # draw windows
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      for x in 0..SAMPLE_SCREEN_WIDTH-1:
        if smap[y][x] == '=':
          console_put_char(sample_console, x, y, CHAR_DHLINE, BKGND_NONE)

    recalculatePath=true

  if recalculatePath == true:
    if usingAstar:
      discard path_compute(path, px, py, dx, dy)
    else:
      # compute the distance grid
      dijkstra_compute(dijkstra, px, py)
      # get the maximum distance (needed for ground shading only)
      for y in 0..SAMPLE_SCREEN_HEIGHT-1:
        for x in 0..SAMPLE_SCREEN_WIDTH-1:
          var d = dijkstra_get_distance(dijkstra, x, y)
          if d > dijkstraDist: dijkstraDist = d
      # compute the path
      discard dijkstra_path_set(dijkstra, dx, dy)
    recalculatePath = false
    busy = 0.2

  # draw the dungeon
  for y in 0..SAMPLE_SCREEN_HEIGHT-1:
    for x in 0..SAMPLE_SCREEN_WIDTH-1:
      var
        wall: bool = smap[y][x] == '#'
        cl: TColor
      if wall: cl = dark_wall
      else: cl = dark_ground
      console_set_char_background(sample_console, x, y, cl, BKGND_SET)

  # draw the path
  if usingAstar:
    for i in 0..path_size(path)-1:
      var x, y: int
      path_get(path, i, addr(x), addr(y))
      console_set_char_background(sample_console, x, y, light_ground, BKGND_SET)
  else:
    for y in 0..SAMPLE_SCREEN_HEIGHT-1:
      for x in 0..SAMPLE_SCREEN_WIDTH-1:
        var wall: bool = smap[y][x] == '#'
        if not wall:
          var d = dijkstra_get_distance(dijkstra, x, y)
          console_set_char_background(sample_console, x, y, color_lerp(light_ground, dark_ground, 0.9 * d / dijkstraDist), BKGND_SET)
    for i in 0..dijkstra_size(dijkstra)-1:
      var x, y: int
      dijkstra_get(dijkstra, i, addr(x), addr(y))
      console_set_char_background(sample_console, x, y, light_ground, BKGND_SET)

  # move the creature
  busy -= sys_get_last_frame_length()
  if busy <= 0.0:
    busy = 0.2
    if usingAstar:
      if not path_is_empty(path):
        console_put_char(sample_console, px, py, ' ', BKGND_NONE)
        discard path_walk(path, addr(px), addr(py), true)
        console_put_char(sample_console, px, py, '@', BKGND_NONE)
    else:
      if not dijkstra_is_empty(dijkstra):
        console_put_char(sample_console, px, py, ' ', BKGND_NONE)
        discard dijkstra_path_walk(dijkstra, addr(px), addr(py))
        console_put_char(sample_console, px, py, '@', BKGND_NONE)
        recalculatePath = true

  if (key.c == 'I' or key.c == 'i') and dy > 0:
    # destination move north
    console_put_char(sample_console, dx, dy, oldChar, BKGND_NONE)
    dec(dy)
    oldChar = console_get_char(sample_console, dx, dy)
    console_put_char(sample_console, dx, dy, '+', BKGND_NONE)
    if smap[dy][dx] == ' ':
      recalculatePath = true
  elif (key.c == 'K' or key.c == 'k') and dy < SAMPLE_SCREEN_HEIGHT-1:
    # destination move south
    console_put_char(sample_console, dx, dy, oldChar, BKGND_NONE)
    inc(dy)
    oldChar = console_get_char(sample_console, dx, dy)
    console_put_char(sample_console, dx, dy, '+', BKGND_NONE)
    if smap[dy][dx] == ' ':
      recalculatePath = true
  elif (key.c == 'J' or key.c == 'j') and dx > 0:
    # destination move west
    console_put_char(sample_console, dx, dy, oldChar, BKGND_NONE)
    dec(dx)
    oldChar = console_get_char(sample_console, dx, dy)
    console_put_char(sample_console, dx, dy, '+', BKGND_NONE)
    if smap[dy][dx] == ' ':
      recalculatePath = true
  elif (key.c == 'L' or key.c == 'l') and dx < SAMPLE_SCREEN_WIDTH - 1:
    # destination move east
    console_put_char(sample_console, dx, dy, oldChar, BKGND_NONE)
    inc(dx)
    oldChar = console_get_char(sample_console, dx, dy)
    console_put_char(sample_console, dx, dy, '+', BKGND_NONE)
    if smap[dy][dx] == ' ':
      recalculatePath = true
  elif key.vk == K_TAB:
    usingAstar = not usingAstar
    if usingAstar:
      console_print(sample_console, 1, 4, "Using : A*      ")
    else:
      console_print(sample_console, 1, 4, "Using : Dijkstra")
    recalculatePath = true

  mx = mouse.cx - SAMPLE_SCREEN_X
  my = mouse.cy - SAMPLE_SCREEN_Y
  if mx >= 0 and mx < SAMPLE_SCREEN_WIDTH and my >= 0 and my < SAMPLE_SCREEN_HEIGHT  and (dx != mx or dy != my):
    console_put_char(sample_console, dx, dy, oldChar, BKGND_NONE)
    dx = mx
    dy = my
    oldChar = console_get_char(sample_console, dx, dy)
    console_put_char(sample_console, dx, dy, '+', BKGND_NONE)
    if smap[dy][dx] == ' ':
      recalculatePath = true


# ***************************
# bsp sample
# ***************************
var
  bspDepth = 8
  minRoomSize = 4
  randomRoom = false # a room fills a random part of the node or the maximum available space ?
  roomWalls = true # if true, there is always a wall on north & west side of a room

type
  TMap = array [0..SAMPLE_SCREEN_WIDTH-1, array[0..SAMPLE_SCREEN_HEIGHT-1, char]]

# draw a vertical line
proc vline(map: ptr TMap, x, y1, y2: int) =
  var
    y = y1
    dy: int
  if y1 > y2: dy = -1
  else: dy = 1
  map[x][y] = ' '
  if y1 == y2: return
  while y != y2:
    y += dy
    map[x][y] = ' '

# draw a vertical line up until we reach an empty space
proc vline_up(map: ptr TMap, x, y: int) =
  var y = y
  while y >= 0 and map[x][y] != ' ':
    map[x][y] = ' '
    dec(y)

# draw a vertical line down until we reach an empty space
proc vline_down(map: ptr TMap, x, y: int) =
  var y = y
  while y < SAMPLE_SCREEN_HEIGHT and map[x][y] != ' ':
    map[x][y] = ' '
    inc(y)

# draw a horizontal line
proc hline(map: ptr TMap, x1, y, x2: int) =
  var
    x = x1
    dx: int
  if x1 > x2: dx = -1
  else: dx = 1
  map[x][y] = ' '
  if x1 == x2: return
  while x != x2:
    x += dx
    map[x][y] = ' '

# draw a horizontal line left until we reach an empty space
proc hline_left(map: ptr TMap, x, y: int) =
  var x = x
  while x >= 0 and map[x][y] != ' ':
    map[x][y] = ' '
    dec(x)

# draw a horizontal line right until we reach an empty space
proc hline_right(map: ptr TMap, x, y: int) =
  var x = x
  while x < SAMPLE_SCREEN_WIDTH and map[x][y] != ' ':
    map[x][y] = ' '
    inc(x)

# the class building the dungeon from the bsp nodes
proc traverse_node(node: PBSP, userData: pointer): bool {.cdecl.} =
  var
    map: ptr TMap = cast[ptr TMap](userData)
  if bsp_is_leaf(node):
    # calculate the room size
    var
      minx = node.x + 1
      maxx = node.x + node.w - 1
      miny = node.y + 1
      maxy = node.y + node.h - 1

    if not roomWalls:
      if minx > 1: dec(minx)
      if miny > 1: dec(miny)

    if maxx == SAMPLE_SCREEN_WIDTH-1: dec(maxx)
    if maxy == SAMPLE_SCREEN_HEIGHT-1: dec(maxy)
    if randomRoom:
      minx = random_get_int(nil, minx, maxx-minRoomSize+1).int32
      miny = random_get_int(nil, miny, maxy-minRoomSize+1).int32
      maxx = random_get_int(nil, minx+minRoomSize-1, maxx).int32
      maxy = random_get_int(nil, miny+minRoomSize-1, maxy).int32

    # resize the node to fit the room
    node.x = minx
    node.y = miny
    node.w = maxx - minx + 1
    node.h = maxy - miny + 1
    # dig the room
    for x in minx..maxx:
      for y in miny..maxy:
        map[x][y] = ' '
  else:
    # resize the node to fit its sons
    var
      left: PBSP = bsp_left(node)
      right: PBSP = bsp_right(node)
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
          x1 = random_get_int(nil, left.x, left.x + left.w - 1)
          x2 = random_get_int(nil, right.x, right.x + right.w - 1)
          y = random_get_int(nil, left.y + left.h, right.y)
        vline_up(map, x1, y-1)
        hline(map, x1, y, x2)
        vline_down(map, x2, y+1)
      else:
        # straight vertical corridor
        var
          minx = max(left.x, right.x)
          maxx = min(left.x + left.w - 1, right.x + right.w - 1)
          x = random_get_int(nil, minx, maxx)
        vline_down(map, x, right.y)
        vline_up(map, x, right.y-1)
    else:
      # horizontal corridor
      if left.y + left.h - 1 < right.y or right.y + right.h - 1 < left.y:
        # no overlapping zone. we need a Z shaped corridor
        var
          y1 = random_get_int(nil, left.y, left.y + left.h - 1)
          y2 = random_get_int(nil, right.y, right.y + right.h - 1)
          x = random_get_int(nil, left.x + left.w, right.x)
        hline_left(map, x-1, y1)
        vline(map, x, y1, y2)
        hline_right(map, x+1, y2)
      else:
        # straight horizontal corridor
        var
          miny = max(left.y, right.y)
          maxy = max(left.y + left.h - 1, right.y + right.h - 1)
          y = random_get_int(nil, miny, maxy)
        hline_left(map, right.x-1, y)
        hline_right(map, right.x, y)
  return true

proc render_bsp(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    bsp {.global.}: PBSP = nil
    generate {.global.} = true
    refresh {.global.} = false
    map {.global.}: array[0..SAMPLE_SCREEN_WIDTH-1, array[0..SAMPLE_SCREEN_HEIGHT-1, char]]
    darkWall {.global.}: TColor = (0'u8, 0'u8, 100'u8)
    darkGround {.global.}: TColor = (50'u8, 50'u8, 150'u8)

  if generate or refresh:
    # dungeon generation
    if bsp == nil:
      # create the bsp
      bsp = bsp_new_with_size(0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    else:
      # restore the nodes size
      bsp_resize(bsp, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
    for col in 0..SAMPLE_SCREEN_WIDTH-1:
      for row in 0..SAMPLE_SCREEN_HEIGHT-1:
        map[col][row] = '#'

    if generate:
      # build a new random bsp tree
      bsp_remove_sons(bsp)
      var optWalls: int
      if roomWalls: optWalls = 1
      else: optWalls = 0
      bsp_split_recursive(bsp, nil, bspDepth, minRoomSize + optWalls, minRoomSize + optWalls, 1.5, 1.5)

    # create the dungeon from the bsp
    discard bsp_traverse_inverted_level_order(bsp, traverse_node, addr(map))
    generate = false
    refresh = false

  console_clear(sample_console)
  console_set_default_foreground(sample_console, WHITE)
  var roomMode: string
  if randomRoom: roomMode = "ON"
  else: roomMode = "OFF"
  console_print(sample_console, 1, 1, "ENTER : rebuild bsp\nSPACE : rebuild dungeon\n+-: bsp depth %d\n*/: room size %d\n1 : random room size %s", bspDepth, minRoomSize, roomMode)
  if randomRoom:
    console_print(sample_console, 1, 6, "2 : room walls %s", roomMode)
  # render the level
  for y in 0..SAMPLE_SCREEN_HEIGHT-1:
    for x in 0..SAMPLE_SCREEN_WIDTH-1:
      var
        wall: bool = map[x][y] == '#'
        cl: TColor
      if wall: cl = darkWall
      else: cl = darkGround
      console_set_char_background(sample_console, x, y, cl, BKGND_SET)

  if key.vk == K_ENTER or key.vk == K_KPENTER:
    generate = true
  elif key.c == ' ':
    refresh = true
  elif key.c == '+':
    inc(bspDepth)
    generate = true
  elif key.c == '-' and bspDepth > 1:
    dec(bspDepth)
    generate = true
  elif key.c == '*':
    inc(minRoomSize)
    generate = true
  elif key.c == '/' and minRoomSize > 2:
    dec(minRoomSize)
    generate = true
  elif key.c == '1' or key.vk == K_1 or key.vk == K_KP1:
    randomRoom = not randomRoom
    if not randomRoom: roomWalls = true
    refresh = true
  elif key.c == '2' or key.vk == K_2 or key.vk == K_KP2:
    roomWalls = not roomWalls
    refresh = true



# ***************************
# image sample
# ***************************
proc render_image(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    img {.global.}: PImage = nil
    circle {.global.}: PImage = nil
    blue {.global.}: TColor = (0'u8, 0'u8, 255'u8)
    green {.global.}: TColor = (0'u8, 255'u8, 0'u8)
    x, y, scalex, scaley, angle: float32
    elapsed: int64

  if img == nil:
    img = image_load("../data/img/skull.png")
    image_set_key_color(img, BLACK)
    circle = image_load("../data/img/circle.png")

  if first:
    sys_set_fps(30) # limited to 30 fps

  console_set_default_background(sample_console, BLACK)
  console_clear(sample_console)
  x = SAMPLE_SCREEN_WIDTH / 2 + cos(sys_elapsed_seconds()) * 10.0
  y = SAMPLE_SCREEN_HEIGHT / 2
  scalex = 0.2 + 1.8 * (1.0 + cos(sys_elapsed_seconds() / 2)) / 2.0
  scaley = scalex
  angle = sys_elapsed_seconds()
  elapsed = int64(sys_elapsed_milli().int / 2000)
  if (elapsed and 1) == 1:
    # split the color channels of circle.png
    # the red channel
    console_set_default_background(sample_console, RED)
    console_rect(sample_console, 0, 3, 15, 15, false, BKGND_SET)
    image_blit_rect(circle,sample_console, 0, 3, -1, -1, BKGND_MULTIPLY)
    # the green channel
    console_set_default_background(sample_console, green)
    console_rect(sample_console, 15, 3, 15, 15, false, BKGND_SET)
    image_blit_rect(circle, sample_console, 15, 3, -1, -1, BKGND_MULTIPLY)
    # the blue channel
    console_set_default_background(sample_console, blue)
    console_rect(sample_console, 30, 3, 15, 15, false, BKGND_SET)
    image_blit_rect(circle, sample_console, 30, 3, -1, -1, BKGND_MULTIPLY)
  else:
    # render circle.png with normal blitting
    image_blit_rect(circle, sample_console, 0, 3, -1, -1, BKGND_SET)
    image_blit_rect(circle, sample_console, 15, 3, -1, -1, BKGND_SET)
    image_blit_rect(circle, sample_console, 30, 3, -1, -1, BKGND_SET)
  image_blit(img, sample_console, x, y, BKGND_SET, scalex, scaley, angle)


# ***************************
# mouse sample
# ***************************
proc mb_mode_str(mb: bool): string {.inline.} =
  if mb: return " ON"
  return "OFF"

proc mw_mode_str(mwup, mwdn: bool): string {.inline.} =
  if mwup: return "UP"
  elif mwdn: return "DOWN"
  return ""

proc render_mouse(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    lbut {.global.} = false
    rbut {.global.} = false
    mbut {.global.} = false

  if first:
    console_set_default_background(sample_console, GREY)
    console_set_default_foreground(sample_console, LIGHT_YELLOW)
    mouse_move(320, 200)
    mouse_show_cursor(true)
    sys_set_fps(30) # limited to 30 fps

  console_clear(sample_console)
  if mouse.lbutton_pressed: lbut = not lbut
  if mouse.rbutton_pressed: rbut = not rbut
  if mouse.mbutton_pressed: mbut = not mbut
  console_print(sample_console, 1, 1,
    """Mouse position : %4dx%4d
    Mouse cell     : %4dx%4d
    Mouse movement : %4dx%4d
    Left button    : %s (toggle %s)
    Right button   : %s (toggle %s)
    Middle button  : %s (toggle %s)
    Wheel          : %s""",
    mouse.x, mouse.y,
    mouse.cx, mouse.cy,
    mouse.dx, mouse.dy,
    mb_mode_str(mouse.lbutton), mb_mode_str(lbut),
    mb_mode_str(mouse.rbutton), mb_mode_str(rbut),
    mb_mode_str(mouse.mbutton), mb_mode_str(mbut),
    mw_mode_str(mouse.wheel_up, mouse.wheel_down))

  console_print(sample_console, 1, 10, "1 : Hide cursor\n2 : Show cursor")
  if key.c == '1': mouse_show_cursor(false)
  elif key.c == '2': mouse_show_cursor(true)


# ***************************
# name generator sample
# ***************************
proc render_name(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  var
    curSet {.global.} = 0
    delay {.global.} = 0.0
    sets {.global.}: seq[string] = @[]
    names {.global.}: seq[string] = @[]
  if len(names) == 0:
    var files: seq[string]
    files = sys_get_directory_content("../data/namegen", "*.cfg")
    # parse all the files
    for f in files.items():
      namegen_parse(f, nil)

    # get the sets list
    sets = namegen_get_sets()

  if first:
    sys_set_fps(30) # limited to 30 fps

  while len(names) >= 15:
    # remove the first element.
    names.delete(0)

  console_clear(sample_console)
  console_set_default_foreground(sample_console, WHITE)
  console_print(sample_console, 1, 1, "%s\n\n+ : next generator\n- : prev generator", sets[curSet])
  for i in 0..names.high:
    var name = names[i]
    if len(name) < SAMPLE_SCREEN_WIDTH:
      console_print_ex(sample_console, SAMPLE_SCREEN_WIDTH - 2, 2 + i, BKGND_NONE, RIGHT, name)

  delay += sys_get_last_frame_length()
  if delay >= 0.5:
    delay -= 0.5
    # add a new name to the list
    names.add($namegen_generate(sets[curSet]))

  if key.c == '+':
    inc(curSet)
    if curSet == len(sets): curSet = 0
    names.add("======")
  elif key.c == '-':
    dec(curSet)
    if curSet < 0: curSet = len(sets)-1
    names.add("======")


# ***************************
# SDL callback sample
# ***************************
from sdl import PSurface, PUInt8Array

var
  noise: PNoise = nil
  sdl_callback_enabled = false
  effectNum = 0
  delay = 3.0


proc burn(screen: PSurface, samplex, sampley, samplew, sampleh: int) =
  var
    ridx = int(screen.format.rshift.int / 8)
    gidx = int(screen.format.gshift.int / 8)
    bidx = int(screen.format.bshift.int / 8)
  for x in samplex..samplex+samplew-1:
    var p: PUInt8Array = cast[PUInt8Array](cast[int](screen.pixels) + x * screen.format.bytesPerPixel.int + sampley * screen.pitch.int)
    for y in sampley..sampley+sampleh-1:
      var
        ir: uint8 = 0
        ig: uint8 = 0
        ib: uint8 = 0
        p2: PUInt8Array = cast[PUInt8Array](cast[int](p) + screen.format.bytesPerPixel.int) # get pixel at x+1,y
      ir += p2[ridx]
      ig += p2[gidx]
      ib += p2[bidx]
      p2 = cast[PUInt8Array](cast[int](p2) - 2 * screen.format.bytesPerPixel.int) # get pixel at x-1,y
      ir += p2[ridx]
      ig += p2[gidx]
      ib += p2[bidx]
      p2 = cast[PUInt8Array](cast[int](p2) + screen.format.bytesPerPixel.int + screen.pitch.int) # get pixel at x,y+1
      ir += p2[ridx]
      ig += p2[gidx]
      ib += p2[bidx]
      p2 = cast[PUInt8Array](cast[int](p2) - 2 * screen.pitch.int) # get pixel at x,y-1
      ir += p2[ridx]
      ig += p2[gidx]
      ib += p2[bidx]
      ir = uint8(ir.int / 4)
      ig = uint8(ig.int / 4)
      ib = uint8(ib.int / 4)
      p[ridx] = ir
      p[gidx] = ig
      p[bidx] = ib
      p = cast[PUInt8Array](cast[int](p) + screen.pitch.int)


proc explode(screen: PSurface, samplex, sampley, samplew, sampleh: int) =
  var
    ridx = int(screen.format.rshift.int / 8)
    gidx = int(screen.format.gshift.int / 8)
    bidx = int(screen.format.bshift.int / 8)
    dist = int(10 * (3.0 - delay))

  for x in samplex..samplex+samplew-1:
    var p: PUInt8Array = cast[PUInt8Array](cast[int](screen.pixels) + x * screen.format.bytesPerPixel.int + sampley * screen.pitch.int)
    for y in sampley..sampley+sampleh-1:
      var
        ir: uint8 = 0
        ig: uint8 = 0
        ib: uint8 = 0
      for i in 0..2:
        var
          dx = random_get_int(nil, -dist, dist)
          dy = random_get_int(nil, -dist, dist)
          p2: PUInt8Array
        p2 = cast[PUInt8Array](cast[int](p) + dx * screen.format.bytesPerPixel.int)
        p2 = cast[PUInt8Array](cast[int](p2) + dy * screen.pitch.int)
        ir += p2[ridx]
        ig += p2[gidx]
        ib += p2[bidx]
      ir = uint8(ir.int / 3)
      ig = uint8(ig.int / 3)
      ib = uint8(ib.int / 3)
      p[ridx] = ir
      p[gidx] = ig
      p[bidx] = ib
      p = cast[PUInt8Array](cast[int](p) + screen.pitch.int)


proc blur(screen: PSurface, samplex, sampley, samplew, sampleh: int) =
  # let's blur that sample console
  var
    f: array[0..2, float32]
    n: float32 = 0.0
    ridx = uint8(screen.format.rshift.int / 8)
    gidx = uint8(screen.format.gshift.int / 8)
    bidx = uint8(screen.format.bshift.int / 8)

  f[2] = sys_elapsed_seconds()
  if noise == nil:
    noise = noise_new(3, NOISE_DEFAULT_HURST, NOISE_DEFAULT_LACUNARITY, nil)
  for x in samplex..samplex+samplew-1:
    var p: PUInt8Array = cast[PUInt8Array](cast[int](screen.pixels) + x * screen.format.bytesPerPixel.int + sampley * screen.pitch.int)
    f[0] = x / samplew
    for y in sampley..sampley+sampleh-1:
      var
        ir: int = 0
        ig: int = 0
        ib: int = 0
        dec, count: int
      if (y - sampley) mod 8 == 0:
        f[1] = y / sampleh
        n = noise_get_fbm(noise, floatArrayToPtr(f), 3.0)

      dec = int(3 * (n + 1.0))
      count = 0
      if dec == 4:
        count += 4
        # get pixel at x,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - 2 * screen.format.bytesPerPixel.int) # get pixel at x+2,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - 2 * screen.pitch.int) # get pixel at x+2,y+2
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + 2 * screen.format.bytesPerPixel.int) # get pixel at x,y+2
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + 2 * screen.pitch.int)
      if dec >= 3:
        count += 4
        # get pixel at x,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + 2 * screen.format.bytesPerPixel.int) # get pixel at x+2,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + 2 * screen.pitch.int) # get pixel at x+2,y+2
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - 2 * screen.format.bytesPerPixel.int) # get pixel at x,y+2
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - 2 * screen.pitch.int)
      if dec >= 2:
        count += 4
        # get pixel at x,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - screen.format.bytesPerPixel.int) # get pixel at x-1,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - screen.pitch.int) # get pixel at x-1,y-1
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + screen.format.bytesPerPixel.int) # get pixel at x,y-1
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + screen.pitch.int)
      if dec >= 1:
        count += 4
        # get pixel at x,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + screen.format.bytesPerPixel.int) # get pixel at x+1,y
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) + screen.pitch.int) # get pixel at x+1,y+1
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - screen.format.bytesPerPixel.int) # get pixel at x,y+1
        ir += p[ridx].int
        ig += p[gidx].int
        ib += p[bidx].int
        p = cast[PUInt8Array](cast[int](p) - screen.pitch.int)
        ir = int(ir.int / count)
        ig = int(ig.int / count)
        ib = int(ib. int / count)
        p[ridx] = ir.byte
        p[gidx] = ig.byte
        p[bidx] = ib.byte
      p = cast[PUInt8Array](cast[int](p) + screen.pitch.int)


proc SDL_render(sdlSurface: pointer) {.cdecl.} =
  var
    screen: PSurface = cast[PSurface](sdlSurface)
    # now we have almighty access to the screen's precious pixels !!
    # get the font character size
    charw, charh, samplex, sampley: int
  sys_get_char_size(addr(charw), addr(charh))
  # compute the sample console position in pixels
  samplex = SAMPLE_SCREEN_X * charw
  sampley = SAMPLE_SCREEN_Y * charh
  delay -= sys_get_last_frame_length()
  if delay < 0.0:
    delay = 3.0
    effectNum = (effectNum + 1) mod 3
    if effectNum == 2:
      sdl_callback_enabled=false # no forced redraw for burn effect
    else:
      sdl_callback_enabled = true

  case effectNum
  of 0 : blur(screen, samplex, sampley, SAMPLE_SCREEN_WIDTH * charw, SAMPLE_SCREEN_HEIGHT * charh)
  of 1 : explode(screen, samplex, sampley, SAMPLE_SCREEN_WIDTH * charw, SAMPLE_SCREEN_HEIGHT * charh)
  of 2 : burn(screen, samplex, sampley, SAMPLE_SCREEN_WIDTH * charw, SAMPLE_SCREEN_HEIGHT * charh)
  else: discard


proc render_sdl(first: bool, key: ptr TKey, mouse: ptr TMouse) {.closure.} =
  if first:
    sys_set_fps(30) # limited to 30 fps
    # use noise sample as background. rendering is done in SampleRenderer
    console_set_default_background(sample_console, LIGHT_BLUE)
    console_set_default_foreground(sample_console, WHITE)
    console_clear(sample_console)
    discard console_print_rect_ex(sample_console, SAMPLE_SCREEN_WIDTH_2, 3, SAMPLE_SCREEN_WIDTH, 0, BKGND_NONE, CENTER, "The SDL callback gives you access to the screen surface so that you can alter the pixels one by one using SDL API or any API on top of SDL. SDL is used here to blur the sample console.\n\nHit TAB to enable/disable the callback. While enabled, it will be active on other samples too.\n\nNote that the SDL callback only works with SDL renderer.")

  if key.vk == K_TAB:
    sdl_callback_enabled = not sdl_callback_enabled
    if sdl_callback_enabled:
      sys_register_SDL_renderer(SDL_render)
    else:
      sys_register_SDL_renderer(nil)
      # we want libtcod to redraw the sample console even if nothing has changed in it
      console_set_dirty(SAMPLE_SCREEN_X, SAMPLE_SCREEN_Y, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)


# ***************************
# the list of samples
# ***************************


var
  sample1: TSample = ("  True colors        ", render_colors)
  sample2: TSample = ("  Offscreen console  ", render_offscreen)
  sample3: TSample = ("  Line drawing       ", render_lines)
  sample4: TSample = ("  Noise              ", render_noise)
  sample5: TSample = ("  Field of view      ", render_fov)
  sample6: TSample = ("  Path finding       ", render_path)
  sample7: TSample = ("  Bsp toolkit        ", render_bsp)
  sample8: TSample = ("  Image toolkit      ", render_image)
  sample9: TSample = ("  Mouse support      ", render_mouse)
  sample10: TSample = ("  Name generator     ", render_name)
  sample11: TSample = ("  SDL callback       ", render_sdl)

var samples = @[sample1,  sample2, sample3, sample4,
                sample5, sample6, sample7,
                sample8, sample9, sample10, sample11]


var
  nb_samples: int = len(samples) # total number of samples
  cur_sample = 0 # index of the current sample
  first = true # first time we render a sample
  key: TKey
  mouse: TMouse
  font: string = "../data/fonts/consolas10x10_gs_tc.png"
  nb_char_horiz=0
  nb_char_vertic=0
  argn: int
  fullscreen_width = 0
  fullscreen_height = 0
  font_flags: int = FONT_TYPE_GREYSCALE or FONT_LAYOUT_TCOD
  font_new_flags = 0
  renderer = RENDERER_SDL
  fullscreen = false
  credits_end = false
  cur_renderer = 0
  renderer_name = @["F1 GLSL   ","F2 OPENGL ","F3 SDL    "]


# initialize the root console (open the game window)
var argc = paramCount()+1
argn = 1
while argn < argc:
  if cmp(paramStr(argn), "-font") == 0 and argn+1 < argc:
    inc(argn)
    font = paramStr(argn)
    font_flags = 0
  elif cmp(paramStr(argn), "-font-nb-char") == 0 and argn+2 < argc:
    inc(argn)
    nb_char_horiz = strtoint(paramStr(argn))
    inc(argn)
    nb_char_vertic = strtoint(paramStr(argn))
    font_flags = 0
  elif cmp(paramStr(argn), "-fullscreen-resolution") == 0 and argn+2 < argc:
    inc(argn)
    fullscreen_width = strtoint(paramStr(argn))
    inc(argn)
    fullscreen_height = strtoint(paramStr(argn))
  elif cmp(paramStr(argn), "-renderer") == 0 and argn+1 < argc:
    inc(argn)
    renderer = TRenderer(strtoint(paramStr(argn)))
  elif cmp(paramStr(argn), "-fullscreen") == 0:
    fullscreen = true
  elif cmp(paramStr(argn), "-font-in-row") == 0:
    font_flags = 0
    font_new_flags = font_new_flags or FONT_LAYOUT_ASCII_INROW
  elif cmp(paramStr(argn), "-font-greyscale") == 0:
    font_flags = 0
    font_new_flags = font_new_flags or FONT_TYPE_GREYSCALE
  elif cmp(paramStr(argn), "-font-tcod") == 0:
    font_flags = 0
    font_new_flags = font_new_flags or FONT_LAYOUT_TCOD
  elif cmp(paramStr(argn), "-help") == 0 or cmp(paramStr(argn), "-?") == 0:
    echo("options :")
    echo("-font <filename> : use a custom font")
    echo("-font-nb-char <nb_char_horiz> <nb_char_vertic> : number of characters in the font")
    echo("-font-in-row : the font layout is in row instead of columns")
    echo("-font-tcod : the font uses TCOD layout instead of ASCII")
    echo("-font-greyscale : antialiased font using greyscale bitmap")
    echo("-fullscreen : start in fullscreen")
    echo("-fullscreen-resolution <screen_width> <screen_height> : force fullscreen resolution")
    echo("-renderer <num> : set renderer. 0 : GLSL 1 : OPENGL 2 : SDL")
    quit(0)
  else:
    # ignore parameter
    discard
  argn += 1

if font_flags == 0:
  font_flags = font_new_flags
console_set_custom_font(font, font_flags, nb_char_horiz, nb_char_vertic)

if fullscreen_width > 0:
  sys_force_fullscreen_resolution(fullscreen_width, fullscreen_height)

console_init_root(80, 50, "libtcod Nimrod sample", fullscreen, renderer)

# initialize the offscreen console for the samples
sample_console = console_new(SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)
while not console_is_window_closed():
  if not credits_end:
    credits_end = console_credits_render(60, 43, false)

  # print the list of samples
  for i in 0..nb_samples-1:
    if i == cur_sample:
      # set colors for currently selected sample
      console_set_default_foreground(nil, WHITE)
      console_set_default_background(nil, LIGHT_BLUE)
    else:
      # set colors for other samples
      console_set_default_foreground(nil, GREY)
      console_set_default_background(nil, BLACK)

    # print the sample name
    console_print_ex(nil, 2, 46-(nb_samples-i), BKGND_SET, LEFT, samples[i].name)

  # print the help message
  console_set_default_foreground(nil, GREY)
  console_print_ex(nil, 79, 46, BKGND_NONE, RIGHT, "last frame : %3d ms (%3d fps)", int(sys_get_last_frame_length()*1000), sys_get_fps())
  console_print_ex(nil, 79, 47, BKGND_NONE, RIGHT, "elapsed : %8dms %4.2fs", sys_elapsed_milli(), sys_elapsed_seconds())
  console_print(nil, 2, 47, "%c%c : select a sample", CHAR_ARROW_N, CHAR_ARROW_S)
  var mode: string
  if console_is_fullscreen():
    mode = "windowed mode  "
  else:
    mode = "fullscreen mode"
  console_print(nil, 2, 48, "ALT-ENTER : switch to %s", mode)
  # render current sample
  samples[cur_sample].render(first, addr(key), addr(mouse))
  first = false

  # blit the sample console on the root console
  console_blit(sample_console, 0, 0, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT,
               nil, SAMPLE_SCREEN_X, SAMPLE_SCREEN_Y,
               1.0, 1.0)
  if sdl_callback_enabled:
    # we want libtcod to redraw the sample console even if nothing has changed in it
    console_set_dirty(SAMPLE_SCREEN_X, SAMPLE_SCREEN_Y, SAMPLE_SCREEN_WIDTH, SAMPLE_SCREEN_HEIGHT)

  # display renderer list and current renderer
  cur_renderer = int(sys_get_renderer())
  console_set_default_foreground(nil, GREY)
  console_set_default_background(nil, BLACK)
  console_print_ex(nil, 42, 46-(NB_RENDERERS.int+1), BKGND_SET, LEFT, "Renderer :")
  for i in 0..NB_RENDERERS.int-1:
    if i == cur_renderer:
      # set colors for current renderer
      console_set_default_foreground(nil, WHITE)
      console_set_default_background(nil, LIGHT_BLUE)
    else:
      # set colors for other renderers
      console_set_default_foreground(nil, GREY)
      console_set_default_background(nil, BLACK)

    console_print_ex(nil, 42, 46-(NB_RENDERERS.int-i), BKGND_SET, LEFT, renderer_name[i])

  # update the game screen
  console_flush()

  # did the user hit a key ?
  discard sys_check_for_event(EVENT_KEY_PRESS or EVENT_MOUSE, addr(key), addr(mouse))
  if key.vk == K_DOWN:
    # down arrow : next sample
    cur_sample = cur_sample+1
    if cur_sample >= nb_samples:
      cur_sample = 0
    first = true
  elif key.vk == K_UP:
    # up arrow : previous sample
    dec(cur_sample)
    if cur_sample < 0:
      cur_sample = nb_samples - 1
    first = true
  elif key.vk == K_ENTER and key.lalt:
    # ALT-ENTER : switch fullscreen
    console_set_fullscreen(not console_is_fullscreen())
  elif key.vk == K_PRINTSCREEN:
    if key.lalt:
      # Alt-PrintScreen : save to samples.asc
      discard console_save_asc(nil, "samples.asc")
    else:
      # save screenshot
      sys_save_screenshot(nil)
  elif key.vk == K_F1:
    # switch renderers with F1,F2,F3
    sys_set_renderer(RENDERER_GLSL)
  elif key.vk == K_F2:
    sys_set_renderer(RENDERER_OPENGL)
  elif key.vk == K_F3:
    sys_set_renderer(RENDERER_SDL)


