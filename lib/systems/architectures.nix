{ lib }:

rec {
  # gcc.arch to its features (as in /proc/cpuinfo)
  features = {
    default        = [ ];
    # x86_64 Intel
    westmere       = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes"                                    ];
    sandybridge    = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx"                              ];
    ivybridge      = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx"                              ];
    haswell        = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2"          "fma"        ];
    broadwell      = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2"          "fma"        ];
    skylake        = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2"          "fma"        ];
    skylake-avx512 = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    cannonlake     = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    icelake-client = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    icelake-server = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    cascadelake    = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    cooperlake     = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    tigerlake      = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx" "avx2" "avx512" "fma"        ];
    # x86_64 AMD
    btver1         = [ "sse3" "ssse3" "sse4_1" "sse4_2"                                                  ];
    btver2         = [ "sse3" "ssse3" "sse4_1" "sse4_2"         "aes" "avx"                              ];
    bdver1         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx"                 "fma" "fma4" ];
    bdver2         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx"                 "fma" "fma4" ];
    bdver3         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx"                 "fma" "fma4" ];
    bdver4         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx" "avx2"          "fma" "fma4" ];
    znver1         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx" "avx2"          "fma"        ];
    znver2         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx" "avx2"          "fma"        ];
    znver3         = [ "sse3" "ssse3" "sse4_1" "sse4_2" "sse4a" "aes" "avx" "avx2"          "fma"        ];
    # other
    armv5te        = [ ];
    armv6          = [ ];
    armv7-a        = [ ];
    armv8-a        = [ "fp" "simd" ];
    "armv8.1-a"    = [ "crc" "lse" "rdma" ] ++ features.armv8-a;
    "armv8.2-a"    = features."armv8.1-a";
    "armv8.3-a"    = [ "pauth" ] ++ features."armv8.2-a";
    "armv8.4-a"    = [ "flagm" "fp16fml" "dotprod" ] ++ features."armv8.3-a";
    "armv8.5-a"    = [ "sb" "sbss" "predres" ] ++ features."armv8.4-a";
    "armv8.6-a"    = [ "bf16" "i8mm" ] ++ features."armv8.5-a";
    "armv8.7-a"    = [ "ls64" ] ++ features."armv8.6-a";
    "armv8.8-a"    = [ "mops" ] ++ features."armv8.7-a";
    "armv9-a"      = [ "sve" "sve2" ] ++ features."armv8.5-a";
    "armv9.1-a"    = [ "bf16" "i8mm" ] ++ features."armv9-a";
    "armv9.2-a"    = [ "ls64" ] ++ features."armv9.1-a";
    "armv9.3-a"    = [ "mops" ] ++ features."armv9.2-a";
    mips32         = [ ];
    loongson2f     = [ ];
    riscv64-g      = [ "multiply" "atomic" "float" "double" "csr" "ifencei" ];
    riscv64-gc     = [ "compressed" ] ++ features.riscv64-g;
    riscv64-gcv    = [ "vector" ] ++ features.riscv64-gc;
  };

  # a superior CPU has all the features of an inferior and is able to build and test code for it
  inferiors = {
    # x86_64 Intel
    default        = [ ];
    westmere       = [ ];
    sandybridge    = [ "westmere"    ] ++ inferiors.westmere;
    ivybridge      = [ "sandybridge" ] ++ inferiors.sandybridge;
    haswell        = [ "ivybridge"   ] ++ inferiors.ivybridge;
    broadwell      = [ "haswell"     ] ++ inferiors.haswell;
    skylake        = [ "broadwell"   ] ++ inferiors.broadwell;
    skylake-avx512 = [ "skylake"     ] ++ inferiors.skylake;

    # x86_64 AMD
    # TODO: fill this (need testing)
    btver1         = [ ];
    btver2         = [ ];
    bdver1         = [ ];
    bdver2         = [ ];
    bdver3         = [ ];
    bdver4         = [ ];
    # Regarding `skylake` as inferior of `znver1`, there are reports of
    # successful usage by Gentoo users and Phoronix benchmarking of different
    # `-march` targets.
    #
    # The GCC documentation on extensions used and wikichip documentation
    # regarding supperted extensions on znver1 and skylake was used to create
    # this partial order.
    #
    # Note:
    #
    # - The successors of `skylake` (`cannonlake`, `icelake`, etc) use `avx512`
    #   which no current AMD Zen michroarch support.
    # - `znver1` uses `ABM`, `CLZERO`, `CX16`, `MWAITX`, and `SSE4A` which no
    #   current Intel microarch support.
    #
    # https://www.phoronix.com/scan.php?page=article&item=amd-znver3-gcc11&num=1
    # https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html
    # https://en.wikichip.org/wiki/amd/microarchitectures/zen
    # https://en.wikichip.org/wiki/intel/microarchitectures/skylake
    znver1         = [ "skylake" ] ++ inferiors.skylake;
    znver2         = [ "znver1"  ] ++ inferiors.znver1;
    znver3         = [ "znver2"  ] ++ inferiors.znver2;

    # other
    armv5te        = [ ];
    armv6          = [ ];
    armv7-a        = [ ];
    armv8-a        = [ ];
    "armv8.1-a"    = [ "armv8-a" ] ++ inferiors.armv8-a;
    "armv8.2-a"    = [ "armv8.1-a" ] ++ inferiors."armv8.1-a";
    "armv8.3-a"    = [ "armv8.2-a" ] ++ inferiors."armv8.2-a";
    "armv8.4-a"    = [ "armv8.3-a" ] ++ inferiors."armv8.3-a";
    "armv8.5-a"    = [ "armv8.4-a" ] ++ inferiors."armv8.4-a";
    "armv8.6-a"    = [ "armv8.5-a" ] ++ inferiors."armv8.5-a";
    "armv8.7-a"    = [ "armv8.6-a" ] ++ inferiors."armv8.6-a";
    "armv8.8-a"    = [ "armv8.7-a" ] ++ inferiors."armv8.7-a";
    "armv9-a"      = [ "armv8.5-a" ] ++ inferiors."armv8.5-a";
    "armv9.1-a"    = [ "armv9-a" "armv8.6-a" ] ++ inferiors."armv9-a" ++ inferiors."armv8.6-a";
    "armv9.2-a"    = [ "armv9.1-a" "armv8.7-a" ] ++ inferiors."armv9.1-a" ++ inferiors."armv8.7-a";
    "armv9.3-a"    = [ "armv9.2-a" "armv8.8-a" ] ++ inferiors."armv9.2-a" ++ inferiors."armv8.8-a";
    mips32         = [ ];
    loongson2f     = [ ];
    riscv64-g      = [ ];
    riscv64-gc     = [ "riscv64-g" ] ++ inferiors.riscv64-g;
    riscv64-gcv    = [ "riscv64-gc" ] ++ inferiors.riscv64-gc;
  };

  predicates = let
    featureSupport = feature: x: builtins.elem feature features.${x} or [];
  in {
    sse3Support    = featureSupport "sse3";
    ssse3Support   = featureSupport "ssse3";
    sse4_1Support  = featureSupport "sse4_1";
    sse4_2Support  = featureSupport "sse4_2";
    sse4_aSupport  = featureSupport "sse4a";
    avxSupport     = featureSupport "avx";
    avx2Support    = featureSupport "avx2";
    avx512Support  = featureSupport "avx512";
    aesSupport     = featureSupport "aes";
    fmaSupport     = featureSupport "fma";
    fma4Support    = featureSupport "fma4";
  };
}
