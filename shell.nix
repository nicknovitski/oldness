{ pkgs ? import <nixpkgs> {} }:

import ./. { inherit (pkgs) stdenv ruby bundlerEnv; }
