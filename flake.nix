{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs = {self,...}@inputs: 
  let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.default = pkgs.buildGoModule {
      buildInputs = with pkgs; [
        pcsclite
        go
        gopls
        go-tools
        pinentry
      ];
      nativeBuildInputs = with pkgs; [
        pkg-config
      ];
      src = pkgs.lib.cleanSource ./.;
      name = "yubikey-agent";
      vendorHash = "sha256-QSuDMi/by6kMBKBM1JJuujWb1jm1jr+zpgg4fHtZpy0=";
    };
    devShells.x86_64-linux.default = pkgs.mkShell {
      inputsFrom = [self.packages.x86_64-linux.default];
    };
  };
}
