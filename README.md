libtcod_nim 1.5.1 v0.98
=======================

libtcod_nim is a wrapper of the libtcod library for the Nim language.

* libtcod homepage: http://doryen.eptalys.net/libtcod/
* Nim homepage: http://nim-lang.org/

Libtcod, a.k.a. “The Doryen Library”, is a free, fast, portable and uncomplicated API for roguelike developers providing an advanced true color console, input, and lots of other utilities frequently used in roguelikes.

You need to have dynamic library of libtcod installed:
* libtcod.so or libtcod-debug.so on Linux;
* libtcod-mingw.dll or libtcod-mingw-debug.dll on Windows.

Also you may need SDL, OpenGL or GLSL dynamic libraries installed, depending on used renderer.

**NOTE**: project in beta-phase and requires heavy testing.

----------------------------------------

CHANGELOG:
==========
**v0.98**
* adaptation for new versions of Nim
* more type-related fixes

**v0.97**
* adaptation for Nim 0.10.2
* fixed data types for correct work on 64-bit systems
* WideCString fix

**v0.96**
* fixed unicode output procedures
* fixed some errata
* adaptation for Nimrod 0.9.2

**v0.95**
* total rewrite of parser module
* added `parser_get_list_<type>_property(parser, name): seq[<type>]` functions
* completed `PList` removal
* tons of fixes

**v0.90**
* most features implemented
* ported samples
* started `PList` removal
* added `floatArrayToPtr` template for noise procedures

