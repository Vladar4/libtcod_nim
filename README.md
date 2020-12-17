libtcod_nim v1.112.0
====================

libtcod_nim is a wrapper of the libtcod library for the Nim language.

* libtcod homepage: http://roguecentral.org/doryen/libtcod/
* libtcod repository: https://github.com/libtcod/libtcod/
* Nim homepage: http://nim-lang.org/
* libtcod_nim docs: https://vladar4.github.io/libtcod_nim/

Libtcod, a.k.a. “The Doryen Library”, is a free, fast, portable and uncomplicated API for roguelike developers providing an advanced true color console, input, and lots of other utilities frequently used in roguelikes.

You need to have dynamic library of libtcod installed:
* libtcod 1.5.1:
  * libtcod.so.1.5.1 on Linux
  * libtcod-mingw.dll or libtcod-mingw-debug.dll on Windows.
* libtcod 1.7.0 or 1.12.2:
  * libtcod.so (or libtcod.so.1.0.12 for libtcod 1.12.2) on Linux;
  * libtcod.dll on Windows.

Also you may need SDL, SDL2, OpenGL or GLSL dynamic libraries installed, depending on used renderer.


Compilation
-----------

* The default complilation option is libtcod 1.12.2 (src112 directory).

To use legacy versions use the following keys in your compile command:

  * `--define:tcod15` for libtcod 1.5.1.

  * `--define:tcod17` for libtcod 1.7.0.


----------------------------------------

CHANGELOG:
==========
**v1.112.1**
* changes and fixes for Nim v1.1+
* fixed nimble warnings

**v1.112.0**
* changed versioning system to reflect the latest supported libtcod version
* added libtcod 1.12.2 wrapper
* added optional module libtcod/cp437
* changed compile keys for legacy branches
* various bugfixes

**v0.99**
* added libtcod 1.7.0 wrapper
* bugfixes for both 1.5.1 and 1.7.0 wrappers

**v0.98.1**
* adaptation for Nim v0.18.1 and newer (strings can't be nil anymore)

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

