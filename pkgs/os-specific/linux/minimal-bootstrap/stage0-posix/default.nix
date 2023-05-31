{ lib
, newScope
}:

lib.makeScope newScope (self: with self; {
  inherit (callPackage ./platforms.nix { }) platforms stage0Arch m2libcArch m2libcOS baseAddress;

  inherit (callPackage ./bootstrap-sources.nix { }) version hex0-seed src;

  m2libc = src + "/M2libc";

  hex0 = callPackage ./hex0.nix { };

  kaem = callPackage ./kaem { };
  kaem-minimal = callPackage ./kaem/minimal.nix { };

  mescc-tools-boot = callPackage ./mescc-tools-boot.nix { };

  inherit (self.mescc-tools-boot) blood-elf-0 hex2 kaem-unwrapped M1 M2;

  mescc-tools = callPackage ./mescc-tools { };

  mescc-tools-extra = callPackage ./mescc-tools-extra { };
})
