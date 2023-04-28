{ stdenv, lib
, buildPackages
, newScope, callPackage
, CoreFoundation, Security, SystemConfiguration
, pkgsBuildTarget, pkgsBuildBuild, pkgsBuildHost
, makeRustPlatform
, llvmPackages_11
, llvmPackages_12, llvm_12
, fetchpatch
} @ args:

import ./default.nix {
  rustcVersion = "1.55.0";
  rustcSha256 = "b2379ac710f5f876ee3c3e03122fe33098d6765d371cac6c31b1b6fc8e43821e";

  llvmSharedForBuild = pkgsBuildBuild.llvmPackages_12.libllvm.override { enableSharedLibraries = true; };
  llvmSharedForHost = pkgsBuildHost.llvmPackages_12.libllvm.override { enableSharedLibraries = true; };
  llvmSharedForTarget = pkgsBuildTarget.llvmPackages_12.libllvm.override { enableSharedLibraries = true; };

  llvmBootstrapForDarwin = llvmPackages_11;

  # For use at runtime
  llvmShared = llvm_12.override { enableSharedLibraries = true; };

  # Expose llvmPackages used for rustc from rustc via passthru for LTO in Firefox
  llvmPackages = llvmPackages_12;


# Note: the version MUST be one version prior to the version we're
  # building
  bootstrapRustPackages = {
    rustc = buildPackages.mrustc-bootstrap;
    cargo = buildPackages.mrustc-bootstrap;
  };

  selectRustPackage = pkgs: pkgs.rust_1_55;

  rustcPatches = [
  ];
}


(builtins.removeAttrs args [ "fetchpatch" "pkgsBuildHost" "llvmPackages_11" "llvmPackages_12" "llvm_12"])
