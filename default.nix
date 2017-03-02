{ stdenv, bundlerEnv, ruby }:

let env = bundlerEnv {
  name = "oldness";
  inherit ruby;
  gemdir = ./.;
};
in
stdenv.mkDerivation {
  name = "oldness";
  buildInputs = [env ruby];
}
