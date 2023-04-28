{ stdenv, lib
, buildPackages
, newScope, callPackage
, CoreFoundation, Security, SystemConfiguration
, pkgsBuildTarget, pkgsBuildBuild, pkgsBuildHost
, makeRustPlatform
, llvmPackages_11
, llvmPackages_14, llvm_14
, fetchpatch
} @ args:

import ./default.nix {
  rustcVersion = "1.61.0";
  rustcSha256 = "ad0b4351675aa9abdf4c7e066613bd274c4391c5506db152983426376101daed";

  llvmSharedForBuild = pkgsBuildBuild.llvmPackages_14.libllvm.override { enableSharedLibraries = true; };
  llvmSharedForHost = pkgsBuildHost.llvmPackages_14.libllvm.override { enableSharedLibraries = true; };
  llvmSharedForTarget = pkgsBuildTarget.llvmPackages_14.libllvm.override { enableSharedLibraries = true; };

  llvmBootstrapForDarwin = llvmPackages_11;

  # For use at runtime
  llvmShared = llvm_14.override { enableSharedLibraries = true; };

  # Expose llvmPackages used for rustc from rustc via passthru for LTO in Firefox
  llvmPackages = llvmPackages_14;


  # Note: the version MUST be one version prior to the version we're
  # building
  bootstrapRustPackages = {
    inherit (buildPackages.rust_1_60.packages.stable) rustc cargo;
  };

  selectRustPackage = pkgs: pkgs.rust_1_61;

  rustcPatches = [
  ];
}

(builtins.removeAttrs args [ "fetchpatch" "pkgsBuildHost" "llvmPackages_11" "llvmPackages_14" "llvm_14"])
