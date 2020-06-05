{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  users.users.estysdesu = {
    description = "Tyler Estes";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    initialHashedPassword = "$6$GfeFhsS.R78KZOh$lQ31rLsvjFvnvnnhvlzPbEc9uVOAlY0OTCpTYbtTUxnk5Qy9UAyUVt0IPgNJCGUnqtMzYGq/DyDzyuUU2zqs01";
    shell = pkgs.bash;
#     packages = with pkgs;
#       let
#         vscode-insiders = vscode.overrride { isInsiders = true; }; # merged on master? #71251
#         noxPackages = [ neovim zsh docker ];
#       in
#         if config.services.xserver.enable then
#           noxPackages ++ [ alacritty vscode-insiders brave teamviewer ]
#         else noxPackages;
  };
  
  home-manager = {
    useUserPackages = true;
    users.estysdesu = {
      programs.bash.enable = true;
      home.packages = with pkgs; [
        
        # CLI
        bash # bats (only needed for bash projects)
        bat
        docker
        exercism
        ffmpeg        
        go
        julia
        # kvm
        linode-cli
        lsd
        neovim
        nmap
        # node (npm, etc.; only needed for projects) # jq # elmPackages.elm # not under pkgs (with pkgs ^)
        # nomino
        nushell
        octave
        poetry
        python
        # python38Packages.howdoi # not under pkgs (with pkgs ^)
        # python38Packages.jupyter # not under pkgs (with pkgs ^)
        # pyenv # needs packaged
        pv
        ripgrep
        rustup
        speedtest-cli
        # spicetify-cli
        termtosvg
        tmux
        tokei
        # virtmanager
        wget
        youtube-dl
        
        # GUI
        alacritty
        # autodesk-fusion360 # needs alternative (FreeCAD, OpenSCAD)
        brave # brave-beta PR?
        discord
      ];
    };
  };
}
