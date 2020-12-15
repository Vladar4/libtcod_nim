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

{.deadCodeElim: on.}

# csize is deprecated in Nim v1.1
# See Nim commit 99078d80d7abb1c47612bc70f7affbde8735066a
when not declared(csize_t):
  type csize_t* {.importc: "size_t", nodecl.} = uint

const
  NO_UNICODE* = false  ## Disable Unicode support
  NO_OPENGL* = false   ## Disable OpenGL support

when defined(linux):
  const LIB_NAME* = "libtcod.so(|.0.0.0)"

elif defined(MacOSX):
  const LIB_NAME* = "libtcod.dylib"

else: # windows
  const LIB_NAME* = "libtcod.dll"

const
  HEXVERSION* = 0x00010700
  STRVERSION* = "1.7.0"
  TECHVERSION* = 0x01070000
  STRVERSIONNAME* = "libtcod 1.7.0"
  WRAPPERVERSION* = "0.99"

