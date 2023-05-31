{ lib
, derivationWithMeta
, hex0-seed
, src
, version
, platforms
, stage0Arch
}:
derivationWithMeta {
  inherit version;
  pname = "hex0";
  builder = hex0-seed;
  args = [
    "${src}/bootstrap-seeds/POSIX/${stage0Arch}/hex0_${stage0Arch}.hex0"
    (placeholder "out")
  ];

  meta = with lib; {
    description = "Minimal assembler for bootstrapping";
    homepage = "https://github.com/oriansj/stage0-posix";
    license = licenses.gpl3Plus;
    maintainers = teams.minimal-bootstrap.members;
    inherit platforms;
  };

  # Ensure the untrusted hex0-seed binary produces a known-good hex0
  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = {
    "x86"   = "sha256-QU3RPGy51W7M2xnfFY1IqruKzusrSLU+L190ztN6JW8=";
    "AMD64" = "sha256-RCgK9oZRDQUiWLVkcIBSR2HeoB+Bh0czthrpjFEkCaY=";
  }.${stage0Arch};
}
