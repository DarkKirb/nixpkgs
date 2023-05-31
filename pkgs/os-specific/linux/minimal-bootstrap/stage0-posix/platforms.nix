# Platform specific constants
{ lib
, targetPlatform
}:
rec {
  # meta.platforms
  platforms = [
    "i686-linux"
    "x86_64-linux"
  ];

  # system arch as used within the stage0 project
  stage0Arch = {
    "i686-linux"   = "x86";
    "x86_64-linux" = "AMD64";
  }.${targetPlatform.system} or (throw "Unsupported system: ${targetPlatform.system}");

  # lower-case form is widely used by m2libc
  m2libcArch = lib.toLower stage0Arch;

  # Passed to M2-Mesoplanet as --operating-system
  m2libcOS = if targetPlatform.isLinux then "linux" else throw "Unsupported system: ${targetPlatform.system}";

  baseAddress = {
    "i686-linux"   = "0x08048000";
    "x86_64-linux" = "0x00600000";
  }.${targetPlatform.system} or (throw "Unsupported system: ${targetPlatform.system}");
}
