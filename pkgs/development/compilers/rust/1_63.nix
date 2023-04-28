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
  rustcVersion = "1.63.0";
  rustcSha256 = "1f9580295642ef5da7e475a8da2397d65153d3f2cb92849dbd08ed0effca99d0";

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
    inherit (buildPackages.rust_1_62.packages.stable) rustc cargo;
  };

  selectRustPackage = pkgs: pkgs.rust_1_63;

  rustcPatches = [
  ];
}

(builtins.removeAttrs args [ "fetchpatch" "pkgsBuildHost" "llvmPackages_11" "llvmPackages_14" "llvm_14"])
