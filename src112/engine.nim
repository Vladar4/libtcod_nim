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
  SDL_Rect* = object
    x*, y*, w*, h*: cint
  SDL_Window* = pointer
  SDL_Renderer* = pointer

#
# engine/display
#

proc consoleInitRoot*(
  w, h: cint; title: cstring;
  fullscreen: bool = false;
  renderer: Renderer = RENDERER_SDL) {.
    cdecl, importc: "TCOD_console_init_root", dynlib: LIB_NAME.}
  ##  Initialize the libtcod graphical engine.
  ##
  ##  ``w`` The width in tiles.
  ##
  ##  ``h`` The height in tiles.
  ##
  ##  ``title`` The title for the window.
  ##
  ##  ``fullscreen`` Fullscreen option.
  ##
  ##  ``renderer`` Which renderer to use when rendering the console.
  ##
  ##  You may want to call ``consoleSetCustomFont()`` BEFORE calling this
  ##  function.  By default this function loads libtcod's `terminal.png` image
  ##  from the working directory.
  ##
  ##  Afterwards ``quit()`` must be called before the program exits.
  ##
  ##  ``Returns`` `0`` on success, or `-1` on an error,
  ##  you can check the error with  ``sysGetError()``

proc consoleInitRoot*(
  w, h: cint; title: cstring;
  fullscreen: bool = false;
  renderer: Renderer = RENDERER_SDL;
  vsync: bool) {.
    cdecl, importc: "TCOD_console_init_root_", dynlib: LIB_NAME.}

proc quit*() {.cdecl, importc: "TCOD_quit", dynlib: LIB_NAME.}
  ##  Shutdown libtcod.  This must be called before your program exits.

proc consoleSetWindowTitle*(
  title: cstring) {.
    cdecl, importc: "TCOD_console_set_window_title", dynlib: LIB_NAME.}
  ##  Change the title string of the active window.
  ##
  ##  ``title`` A utf8 string.

proc consoleSetFullscreen*(
  fullscreen: bool) {.
    cdecl, importc: "TCOD_console_set_fullscreen", dynlib: LIB_NAME.}
  ##  Set the display to be full-screen or windowed.
  ##
  ##  ``fullscreen`` If `true` the display will go full-screen.

proc consoleIsFullscreen*(): bool {.
    cdecl, importc: "TCOD_console_is_fullscreen", dynlib: LIB_NAME.}
  ##  Return `true` if the display is full-screen.

proc consoleHasMouseFocus*(): bool {.
    cdecl, importc: "TCOD_console_has_mouse_focus", dynlib: LIB_NAME.}
  ##  Return true if the window has mouse focus.

proc consoleIsActive*(): bool {.
    cdecl, importc: "TCOD_console_is_active", dynlib: LIB_NAME.}
  ##  Return `true` if the window has keyboard focus.
  ##
  ##  ``Note:`` This function was previously broken.
  ##  It now keeps track of keyboard focus.

proc consoleIsWindowClosed*(): bool {.
    cdecl, importc: "TCOD_console_is_window_closed", dynlib: LIB_NAME.}
  ##  Return `true` if the window is closing.

proc sysGetSDLWindow*(): SDL_Window {.
    cdecl, importc: "TCOD_sys_get_sdl_window", dynlib: LIB_NAME.}
  ##  Return an ``SDL_Window`` pointer if one is in use,
  ##  returns ``nil`` otherwise.

proc sysGetSDLRenderer*(): SDL_Renderer {.cdecl,
    importc: "TCOD_sys_get_sdl_renderer", dynlib: LIB_NAME.}
  ##   Return an ``SDL_Renderer`` pointer if one is in use,
  ##   returns ``nil`` otherwise.

proc sysAccumulateConsole*(console: Console): cint {.
    cdecl, importc: "TCOD_sys_accumulate_console", dynlib: LIB_NAME.}
  ##  Render a console over the display.
  ##
  ##  ``console`` can be any size,
  ##  the active render will try to scale it to fit the screen.
  ##
  ##  The function will only work for the SDL2/OPENGL2 renderers.
  ##
  ##  Unlike ``consoleFlush()`` this will not present the display.
  ##  You will need to do that manually, likely with the SDL API.
  ##
  ##  Returns `0` on success, or a negative number on a failure
  ##  such as the incorrect renderer being active.
  ##
  ##  See also:
  ##
  ##  ``sysGetSDLWindow()``
  ##
  ##  ``sysGetSDLRenderer()``

proc sysAccumulateConsole*(console: Console, viewport: ptr SDL_Rect): cint {.
    cdecl, importc: "TCOD_sys_accumulate_console_", dynlib: LIB_NAME.}

#
# engine/globals
#

proc getDefaultTileset*(): Tileset {.
    cdecl, importc: "TCOD_get_default_tileset", dynlib: LIB_NAME.}
  ##  ``Return`` the default tileset, may be `nil`.
  ##
  ##  ``Note:`` This function is provisional, the API may change in the future.

proc setDefaultTileset*(tileset: Tileset) {.
    cdecl, importc: "TCOD_set_default_tileset", dynlib: LIB_NAME.}
  ##  Set the default tileset and update the default display to use it.
  ##
  ##  ``Note:`` This function is provisional, the API may change in the future.

#
# engine/error
#

proc getError*(): cstring {.
    cdecl, importc: "TCOD_get_error", dynlib: LIB_NAME.}
  ##  ``Return`` the last error message.
  ##  If there is no error then the string will have a length of zero.
  ##
  ##  The error state is thread specific.

proc setError*(error: cstring): int {.
    cdecl, importc: "TCOD_set_error", dynlib: LIB_NAME.}
  ##  Set an error message and return `-1`.

