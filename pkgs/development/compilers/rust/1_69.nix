# New rust versions should first go to staging.
# Things to check after updating:
# 1. Rustc should produce rust binaries on x86_64-linux, aarch64-linux and x86_64-darwin:
#    i.e. nix-shell -p fd or @GrahamcOfBorg build fd on github
#    This testing can be also done by other volunteers as part of the pull
#    request review, in case platforms cannot be covered.
# 2. The LLVM version used for building should match with rust upstream.
#    Check the version number in the src/llvm-project git submodule in:
#    https://github.com/rust-lang/rust/blob/<version-tag>/.gitmodules
# 3. Firefox and Thunderbird should still build on x86_64-linux.
{
  stdenv,
  lib,
  buildPackages,
  newScope,
  callPackage,
  CoreFoundation,
  Security,
  SystemConfiguration,
  pkgsBuildTarget,
  pkgsBuildBuild,
  pkgsBuildHost,
  makeRustPlatform,
  llvmPackages_11,
  llvmPackages_15,
  llvm_15,
} @ args:
import ./default.nix {
  rustcVersion = "1.69.0";
  rustcSha256 = "sha256-+wWXGGetbMq703ICefWpS5n2ECSSMYe1a7XEVfo89g8=";

  llvmSharedForBuild = pkgsBuildBuild.llvmPackages_15.libllvm.override {enableSharedLibraries = true;};
  llvmSharedForHost = pkgsBuildHost.llvmPackages_15.libllvm.override {enableSharedLibraries = true;};
  llvmSharedForTarget = pkgsBuildTarget.llvmPackages_15.libllvm.override {enableSharedLibraries = true;};

  llvmBootstrapForDarwin = llvmPackages_11;

  # For use at runtime
  llvmShared = llvm_15.override {enableSharedLibraries = true;};

  # Expose llvmPackages used for rustc from rustc via passthru for LTO in Firefox
  llvmPackages = llvmPackages_15;

  # Note: the version MUST be one version prior to the version we're
  # building
  bootstrapRustPackages = {
    inherit (buildPackages.rust_1_68.packages.stable) rustc cargo;
  };

  selectRustPackage = pkgs: pkgs.rust_1_69;

  rustcPatches = [];
}
(builtins.removeAttrs args ["pkgsBuildHost" "llvmPackages_11" "llvmPackages_15" "llvm_15"])
