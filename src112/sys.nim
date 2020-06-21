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

# import console_types, image, list, mouse_types

from os import walkFiles, joinPath


proc sysStartup*() {.
    cdecl, importc: "TCOD_sys_startup", dynlib: LIB_NAME.}

proc sysShutdown*() {.
    cdecl, importc: "TCOD_sys_shutdown", dynlib: LIB_NAME.}

proc sysElapsedMilli*(): uint32 {.
    cdecl, importc: "TCOD_sys_elapsed_milli", dynlib: LIB_NAME.}

proc sysElapsedSeconds*(): cfloat {.
    cdecl, importc: "TCOD_sys_elapsed_seconds", dynlib: LIB_NAME.}

proc sysSleepMilli*(
  val: uint32) {.
    cdecl, importc: "TCOD_sys_sleep_milli", dynlib: LIB_NAME.}

proc sysSetFps*(
  val: cint) {.
    cdecl, importc: "TCOD_sys_set_fps", dynlib: LIB_NAME.}

proc sysGetFps*(): cint {.
    cdecl, importc: "TCOD_sys_get_fps", dynlib: LIB_NAME.}

proc sysGetLastFrameLength*(): cfloat {.
    cdecl, importc: "TCOD_sys_get_last_frame_length", dynlib: LIB_NAME.}

proc sysSaveScreenshot*(
  filename: cstring) {.
    cdecl, importc: "TCOD_sys_save_screenshot", dynlib: LIB_NAME.}

proc sysForceFullscreenResolution*(
  width, height: cint) {.
    cdecl, importc: "TCOD_sys_force_fullscreen_resolution", dynlib: LIB_NAME.}

proc sysSetRenderer*(
  renderer: Renderer) {.
    cdecl, importc: "TCOD_sys_set_renderer", dynlib: LIB_NAME.}

proc sysGetRenderer*(): Renderer {.
    cdecl, importc: "TCOD_sys_get_renderer", dynlib: LIB_NAME.}

proc sysGetCurrentResolution*(
  w, h: ptr cint) {.
    cdecl, importc: "TCOD_sys_get_current_resolution", dynlib: LIB_NAME.}

proc sysGetFullscreenOffsets*(
  offx, offy: ptr cint) {.
    cdecl, importc: "TCOD_sys_get_fullscreen_offsets", dynlib: LIB_NAME.}

proc sysGetCharSize*(
  w, h: ptr cint) {.
    cdecl, importc: "TCOD_sys_get_char_size", dynlib: LIB_NAME.}

proc sysUpdateChar*(
  asciiCode, fontx, fonty: cint; img: Image; x, y: cint) {.
    cdecl, importc: "TCOD_sys_update_char", dynlib: LIB_NAME.}


type
  Event* {.size: sizeof(cint).} = enum
    EVENT_NONE = 0
    EVENT_KEY_PRESS = 1
    EVENT_KEY_RELEASE = 2
    EVENT_KEY = EVENT_KEY_PRESS.ord or EVENT_KEY_RELEASE.ord
    EVENT_MOUSE_MOVE = 4
    EVENT_MOUSE_PRESS = 8
    EVENT_MOUSE_RELEASE = 16
    EVENT_MOUSE = EVENT_MOUSE_MOVE.ord or EVENT_MOUSE_PRESS.ord or
      EVENT_MOUSE_RELEASE.ord
    EVENT_FINGER_MOVE = 32
    EVENT_FINGER_PRESS = 64
    EVENT_FINGER_RELEASE = 128
    EVENT_FINGER = EVENT_FINGER_MOVE.ord or EVENT_FINGER_PRESS.ord or
      EVENT_FINGER_RELEASE.ord
    EVENT_ANY = EVENT_KEY.ord or EVENT_MOUSE.ord or EVENT_FINGER.ord

proc sysWaitForEvent*(
  eventMask: cint; key: ptr Key; mouse: ptr Mouse; flush: bool): Event {.
    cdecl, importc: "TCOD_sys_wait_for_event", dynlib: LIB_NAME.}

proc sysCheckForEvent*(
  eventMask: cint; key: ptr Key; mouse: ptr Mouse): Event {.
    cdecl, importc: "TCOD_sys_check_for_event", dynlib: LIB_NAME.}

#  filesystem stuff

proc sysCreateDirectory*(
  path: cstring): bool {.
    cdecl, importc: "TCOD_sys_create_directory", dynlib: LIB_NAME,
    deprecated.}

proc sysDeleteFile*(
  path: cstring): bool {.
    cdecl, importc: "TCOD_sys_delete_file", dynlib: LIB_NAME,
    deprecated.}

proc sysDeleteDirectory*(
  path: cstring): bool {.
    cdecl, importc: "TCOD_sys_delete_directory", dynlib: LIB_NAME,
    deprecated.}

proc sysIsDirectory*(
  path: cstring): bool {.
    cdecl, importc: "TCOD_sys_is_directory", dynlib: LIB_NAME,
    deprecated.}

proc sysGetDirectoryContent*(
  path: cstring; pattern: cstring): List {.
    cdecl, importc: "TCOD_sys_get_directory_content", dynlib: LIB_NAME,
    deprecated.}

proc sysGetDirectoryContentSeq*(path, pattern: string): seq[string] =
  result = @[]
  for f in walkFiles(joinPath(path, pattern)):
    result.add(f)

proc sysFileExists*(
  filename: cstring): bool {.
    varargs, cdecl, importc: "TCOD_sys_file_exists", dynlib: LIB_NAME,
    deprecated.}

proc sysReadFile*(
  filename: cstring; buf: ptr ptr cuchar; size: ptr csize_t): bool {.
    cdecl, importc: "TCOD_sys_read_file", dynlib: LIB_NAME,
    deprecated.}

proc sysWriteFile*(
  filename: cstring; buf: ptr cuchar; size: uint32): bool {.
    cdecl, importc: "TCOD_sys_write_file", dynlib: LIB_NAME,
    deprecated.}

#  clipboard

proc sysClipboardSet*(
  value: cstring): bool {.
    cdecl, importc: "TCOD_sys_clipboard_set", dynlib: LIB_NAME,
    deprecated: "Use the SDL2 API to handle the clipboard".}

proc sysClipboardGet*(): cstring {.
    cdecl, importc: "TCOD_sys_clipboard_get", dynlib: LIB_NAME,
    deprecated: "Use the SDL2 API to handle the clipboard".}

#  thread stuff

type
  Thread* = pointer
  Semaphore* = pointer
  Mutex* = pointer
  Cond* = pointer

#  threads

proc threadNew*(
  procedure: proc (a1: pointer): cint {.cdecl.}; data: pointer): Thread {.
    cdecl, importc: "TCOD_thread_new", dynlib: LIB_NAME,
    deprecated.}

proc threadDelete_internal(
  th: Thread) {.
    cdecl, importc: "TCOD_thread_delete", dynlib: LIB_NAME.}

proc threadDelete*(th: var Thread) {.deprecated.} =
  if th != nil:
    threadDelete_internal(th)
    th = nil

proc sysGetNumCores*(): cint {.
    cdecl, importc: "TCOD_sys_get_num_cores", dynlib: LIB_NAME,
    deprecated.}

proc threadWait*(
  th: Thread) {.
    cdecl, importc: "TCOD_thread_wait", dynlib: LIB_NAME,
    deprecated.}

#  mutex

proc mutexNew*(): Mutex {.
    cdecl, importc: "TCOD_mutex_new", dynlib: LIB_NAME,
    deprecated.}

proc mutexIn*(
  mut: Mutex) {.
    cdecl, importc: "TCOD_mutex_in", dynlib: LIB_NAME,
    deprecated.}

proc mutexOut*(
  mut: Mutex) {.
    cdecl, importc: "TCOD_mutex_out", dynlib: LIB_NAME,
    deprecated.}

proc mutexDelete_internal(
  mut: Mutex) {.
    cdecl, importc: "TCOD_mutex_delete", dynlib: LIB_NAME.}

proc mutexDelete*(mut: var Mutex) {.deprecated.} =
  if mut != nil:
    mutexDelete_internal(mut)
    mut = nil

#  semaphore

proc semaphoreNew*(
  initVal: cint): Semaphore {.
    cdecl, importc: "TCOD_semaphore_new", dynlib: LIB_NAME,
    deprecated.}

proc semaphoreLock*(
  sem: Semaphore) {.
    cdecl, importc: "TCOD_semaphore_lock", dynlib: LIB_NAME,
    deprecated.}

proc semaphoreUnlock*(
  sem: Semaphore) {.
    cdecl, importc: "TCOD_semaphore_unlock", dynlib: LIB_NAME,
    deprecated.}

proc semaphoreDelete_internal(
  sem: Semaphore) {.
    cdecl, importc: "TCOD_semaphore_delete", dynlib: LIB_NAME.}

proc semaphoreDelete*(sem: var Semaphore) {.deprecated.} =
  if sem != nil:
    semaphoreDelete_internal(sem)
    sem = nil

#  condition

proc conditionNew*(): Cond {.
    cdecl, importc: "TCOD_condition_new", dynlib: LIB_NAME,
    deprecated.}

proc conditionSignal*(
  sem: Cond) {.
    cdecl, importc: "TCOD_condition_signal", dynlib: LIB_NAME,
    deprecated.}

proc conditionBroadcast*(
  sem: Cond) {.
    cdecl, importc: "TCOD_condition_broadcast", dynlib: LIB_NAME,
    deprecated.}

proc conditionWait*(
  sem: Cond; mut: Mutex) {.
    cdecl, importc: "TCOD_condition_wait", dynlib: LIB_NAME,
    deprecated.}

proc conditionDelete_internal(
  sem: Cond) {.
    cdecl, importc: "TCOD_condition_delete", dynlib: LIB_NAME.}

proc conditionDelete*(sem: var Cond) {.deprecated.} =
  if sem != nil:
    conditionDelete_internal(sem)
    sem = nil


type
  Library* = pointer  ##  dynamic library

proc loadLibrary*(
  path: cstring): Library {.
    cdecl, importc: "TCOD_load_library", dynlib: LIB_NAME,
    deprecated.}

proc getProcedureAddress*(
  library: Library; procedureName: cstring): pointer {.
    cdecl, importc: "TCOD_get_function_address", dynlib: LIB_NAME,
    deprecated.}

proc closeLibrary_internal(
  a1: Library) {.
    cdecl, importc: "TCOD_close_library", dynlib: LIB_NAME.}

proc closeLibrary*(a1: var Library) {.deprecated.} =
  if a1 != nil:
    closeLibrary_internal(a1)
    a1 = nil


type
  SDL_RendererCallback* = proc (sdlRenderer: pointer) {.cdecl.} ##  \
  ##  SDL renderer callback

proc sysRegister_SDL_Renderer*(renderer: SDL_RendererCallback) {.
    cdecl, importc: "TCOD_sys_register_SDL_renderer", dynlib: LIB_NAME.}

