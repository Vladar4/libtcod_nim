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


from os import walkFiles, joinPath


#TCODLIB_API uint32 TCOD_sys_elapsed_milli();
proc sys_elapsed_milli*(): uint32 {.cdecl, importc: "TCOD_sys_elapsed_milli", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_sys_elapsed_seconds();
proc sys_elapsed_seconds*(): float32 {.cdecl, importc: "TCOD_sys_elapsed_seconds", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_sleep_milli(uint32 val);
proc sys_sleep_milli*(val: uint32) {.cdecl, importc: "TCOD_sys_sleep_milli", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_save_screenshot(const char *filename);
proc sys_save_screenshot*(filename: cstring) {.cdecl, importc: "TCOD_sys_save_screenshot", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_force_fullscreen_resolution(int width, int height);
proc sys_force_fullscreen_resolution*(width, height: int) {.cdecl, importc: "TCOD_sys_force_fullscreen_resolution", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_set_renderer(TCOD_renderer_t renderer);
proc sys_set_renderer*(renderer: TRenderer) {.cdecl, importc: "TCOD_sys_set_renderer", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_renderer_t TCOD_sys_get_renderer();
proc sys_get_renderer*(): TRenderer {.cdecl, importc: "TCOD_sys_get_renderer", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_set_fps(int val);
proc sys_set_fps*(val: int) {.cdecl, importc: "TCOD_sys_set_fps", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_sys_get_fps();
proc sys_get_fps*(): int {.cdecl, importc: "TCOD_sys_get_fps", dynlib: LIB_NAME.}

#TCODLIB_API float TCOD_sys_get_last_frame_length();
proc sys_get_last_frame_length*(): float32 {.cdecl, importc: "TCOD_sys_get_last_frame_length", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_get_current_resolution(int *w, int *h);
proc sys_get_current_resolution*(w, h: ptr int) {.cdecl, importc: "TCOD_sys_get_current_resolution", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_get_fullscreen_offsets(int *offx, int *offy);
proc sys_get_fullscreen_offsets*(offx, offy: ptr int) {.cdecl, importc: "TCOD_sys_get_fullscreen_offsets", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_update_char(int asciiCode, int fontx, int fonty, TCOD_image_t img, int x, int y);
proc sys_update_char*(asciiCode, fontx, fonty: int, img: PImage, x, y: int) {.cdecl, importc: "TCOD_sys_update_char", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_sys_get_char_size(int *w, int *h);
proc sys_get_char_size*(w, h: ptr int) {.cdecl, importc: "TCOD_sys_get_char_size", dynlib: LIB_NAME.}

#TCODLIB_API void *TCOD_sys_get_sdl_window();
proc sys_get_sdl_window*(): pointer {.cdecl, importc: "TCOD_sys_get_sdl_window", dynlib: LIB_NAME.}


type
  TEvent* = int

const
  EVENT_KEY_PRESS* = 1
  EVENT_KEY_RELEASE* = 2
  EVENT_KEY* = EVENT_KEY_PRESS or EVENT_KEY_RELEASE
  EVENT_MOUSE_MOVE* = 4
  EVENT_MOUSE_PRESS* = 8
  EVENT_MOUSE_RELEASE* = 16
  EVENT_MOUSE* = EVENT_MOUSE_MOVE or EVENT_MOUSE_PRESS or EVENT_MOUSE_RELEASE
  EVENT_ANY* = EVENT_KEY or EVENT_MOUSE


#TCODLIB_API TCOD_event_t TCOD_sys_wait_for_event(int eventMask, TCOD_key_t *key, TCOD_mouse_t *mouse, bool flush);
proc sys_wait_for_event*(eventMask: int, key: ptr TKey, mouse: ptr TMouse, flush: bool): TEvent {.cdecl, importc: "TCOD_sys_wait_for_event", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_event_t TCOD_sys_check_for_event(int eventMask, TCOD_key_t *key, TCOD_mouse_t *mouse);
proc sys_check_for_event*(eventMask: int, key: ptr TKey, mouse: ptr TMouse): TEvent {.cdecl, importc: "TCOD_sys_check_for_event", dynlib: LIB_NAME.}


# filesystem stuff
#TCODLIB_API bool TCOD_sys_create_directory(const char *path);
proc sys_create_directory*(path: cstring): bool {.cdecl, importc: "TCOD_sys_create_directory", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_sys_delete_file(const char *path);
proc sys_delete_file*(path: cstring): bool {.cdecl, importc: "TCOD_sys_delete_file", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_sys_delete_directory(const char *path);
proc sys_delete_directory*(path: cstring): bool {.cdecl, importc: "TCOD_sys_delete_directory", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_sys_is_directory(const char *path);
proc sys_is_directory*(path: cstring): bool {.cdecl, importc: "TCOD_sys_is_directory", dynlib: LIB_NAME.}

#TCODLIB_API TCOD_list_t TCOD_sys_get_directory_content(const char *path, const char *pattern);
#proc sys_get_directory_content(path, pattern: cstring): PList {.cdecl, importc: "TCOD_sys_get_directory_content", dynlib: LIB_NAME.}
proc sys_get_directory_content*(path, pattern: string): seq[string] =
  result = @[]
  for f in walkFiles(joinPath(path, pattern)):
    result.add(f)

#TCODLIB_API bool TCOD_sys_file_exists(const char * filename, ...);
proc sys_file_exists*(filename: cstring): bool {.cdecl, importc: "TCOD_sys_file_exists", varargs, dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_sys_read_file(const char *filename, unsigned char **buf, uint32 *size);
proc sys_read_file*(filename: cstring, buf: pointer, size: ptr uint32): bool {.cdecl, importc: "TCOD_sys_read_file", dynlib: LIB_NAME.}

#TCODLIB_API bool TCOD_sys_write_file(const char *filename, unsigned char *buf, uint32 size);
proc sys_write_file*(filename: cstring, buf: pointer, size: uint32): bool {.cdecl, importc: "TCOD_sys_write_file", dynlib: LIB_NAME.}


# clipboard
#TCODLIB_API void TCOD_sys_clipboard_set(const char *value);
proc sys_clipboard_set*(value: cstring) {.cdecl, importc: "TCOD_sys_clipboard_set", dynlib: LIB_NAME.}

#TCODLIB_API char *TCOD_sys_clipboard_get();
proc sys_clipboard_get*(): cstring {.cdecl, importc: "TCOD_sys_clipboard_get", dynlib: LIB_NAME.}


# thread stuff
type
  PThread* = pointer
  PSemaphore* = pointer
  PMutex* = pointer
  PCond* = pointer
  PCallback* = proc(p: pointer): int {.cdecl.}


# threads
#TCODLIB_API TCOD_thread_t TCOD_thread_new(int (*func)(void *), void *data);
proc thread_new*(cb: PCallback, data: pointer): PThread {.cdecl, importc: "TCOD_thread_new", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_thread_delete(TCOD_thread_t th);
proc thread_delete*(th: PThread) {.cdecl, importc: "TCOD_thread_delete", dynlib: LIB_NAME.}

#TCODLIB_API int TCOD_sys_get_num_cores();
proc sys_get_num_cores*(): int {.cdecl, importc: "TCOD_sys_get_num_cores", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_thread_wait(TCOD_thread_t th);
proc thread_wait*(th: PThread) {.cdecl, importc: "TCOD_thread_wait", dynlib: LIB_NAME.}


# mutex
#TCODLIB_API TCOD_mutex_t TCOD_mutex_new();
proc mutex_new*(): PMutex {.cdecl, importc: "TCOD_mutex_new", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_mutex_in(TCOD_mutex_t mut);
proc mutex_in*(mut: PMutex) {.cdecl, importc: "TCOD_mutex_in", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_mutex_out(TCOD_mutex_t mut);
proc mutex_out*(mut: PMutex) {.cdecl, importc: "TCOD_mutex_out", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_mutex_delete(TCOD_mutex_t mut);
proc mutex_delete*(mut: PMutex) {.cdecl, importc: "TCOD_mutex_delete", dynlib: LIB_NAME.}


# semaphore
#TCODLIB_API TCOD_semaphore_t TCOD_semaphore_new(int initVal);
proc semaphore_new*(initVal: int): PSemaphore {.cdecl, importc: "TCOD_semaphore_new", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_semaphore_lock(TCOD_semaphore_t sem);
proc semaphore_lock*(sem: PSemaphore) {.cdecl, importc: "TCOD_semaphore_lock", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_semaphore_unlock(TCOD_semaphore_t sem);
proc semaphore_unlock*(sem: PSemaphore) {.cdecl, importc: "TCOD_semaphore_unlock", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_semaphore_delete( TCOD_semaphore_t sem);
proc semaphore_delete*(sem: PSemaphore) {.cdecl, importc: "TCOD_semaphore_delete", dynlib: LIB_NAME.}


# condition
#TCODLIB_API TCOD_cond_t TCOD_condition_new();
proc condition_new*(): PCond {.cdecl, importc: "TCOD_condition_new", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_condition_signal(TCOD_cond_t sem);
proc condition_signal*(sem: PCond) {.cdecl, importc: "TCOD_condition_signal", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_condition_broadcast(TCOD_cond_t sem);
proc condition_broadcast*(sem: PCond) {.cdecl, importc: "TCOD_condition_broadcast", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_condition_wait(TCOD_cond_t sem, TCOD_mutex_t mut);
proc condition_wait*(sem: PCond, mut: PMutex) {.cdecl, importc: "TCOD_condition_wait", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_condition_delete( TCOD_cond_t sem);
proc condition_delete*(sem: PCond) {.cdecl, importc: "TCOD_condition_delete", dynlib: LIB_NAME.}


# dynamic library
type
  PLibrary* = pointer

#TCODLIB_API TCOD_library_t TCOD_load_library(const char *path);
proc load_library*(path: cstring): PLibrary {.cdecl, importc: "TCOD_load_library", dynlib: LIB_NAME.}

#TCODLIB_API void * TCOD_get_function_address(TCOD_library_t library, const char *function_name);
proc get_function_address*(library: PLibrary, function_name: cstring): pointer {.cdecl, importc: "TCOD_get_function_address", dynlib: LIB_NAME.}

#TCODLIB_API void TCOD_close_library(TCOD_library_t);
proc close_library*(library: PLibrary) {.cdecl, importc: "TCOD_close_library", dynlib: LIB_NAME.}


# SDL renderer callback
#typedef void (*SDL_renderer_t) (void *sdl_surface);
type
  PSDLRenderer* = proc(sdl_surface: pointer) {.cdecl.}

#TCODLIB_API void TCOD_sys_register_SDL_renderer(SDL_renderer_t renderer);
proc sys_register_SDL_renderer*(renderer: PSDLRenderer) {.cdecl, importc: "TCOD_sys_register_SDL_renderer", dynlib: LIB_NAME.}

