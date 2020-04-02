# Package

version       = "0.1.0"
author        = "Yuriy Glukhov"
description   = "Collection of bindings to MacOS and iOS APIs"
license       = "MIT"

# Dependencies

requires "nim >= 0.17.0"


task c2nim, "Run c2nim":  
  exec "nim c --hints:off -r do_c2nim"