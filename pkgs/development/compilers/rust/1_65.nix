{ stdenv, lib
, buildPackages
, newScope, callPackage
, CoreFoundation, Security, SystemConfiguration
, pkgsBuildTarget, pkgsBuildBuild, pkgsBuildHost
, makeRustPlatform
, llvmPackages_11
, llvmPackages_15, llvm_15
, fetchpatch
} @ args:

import ./default.nix {
  rustcVersion = "1.65.0";
  rustcSha256 = "5828bb67f677eabf8c384020582b0ce7af884e1c84389484f7f8d00dd82c0038";

  llvmSharedForBuild = pkgsBuildBuild.llvmPackages_15.libllvm.override { enableSharedLibraries = true; };
  llvmSharedForHost = pkgsBuildHost.llvmPackages_15.libllvm.override { enableSharedLibraries = true; };
  llvmSharedForTarget = pkgsBuildTarget.llvmPackages_15.libllvm.override { enableSharedLibraries = true; };

  llvmBootstrapForDarwin = llvmPackages_11;

  # For use at runtime
  llvmShared = llvm_15.override { enableSharedLibraries = true; };

  # Expose llvmPackages used for rustc from rustc via passthru for LTO in Firefox
  llvmPackages = llvmPackages_15;


  # Note: the version MUST be one version prior to the version we're
  # building
  bootstrapRustPackages = {
    inherit (buildPackages.rust_1_64.packages.stable) rustc cargo;
  };

  selectRustPackage = pkgs: pkgs.rust_1_65;

  rustcPatches = [
  ];
}

(builtins.removeAttrs args [ "fetchpatch" "pkgsBuildHost" "llvmPackages_11" "llvmPackages_15" "llvm_15"])
