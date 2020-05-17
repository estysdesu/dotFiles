{ config, pkgs, ... }:
{
  imports = [
    ../profiles/sound.nix
    ../profiles/awesome.nix
    ../profiles/virtualization.nix
    ../services/networkManager.nix
    ../services/plex.nix
    ../services/printing.nix
    ../services/qbittorrent.nix
    ../users/estysdesu.nix
    <home-manager/nixos>
  ];

  users.extraUsers.estysdesu.extraGroups = [ "networkmanager" "plex" "vboxusers" "docker"];
  home-manager = {
    useUserPackages = true;
    extraUsers.estysdesu = {
      shell = pkgs.zsh;
      programs.zsh.enable = true;
      home.packages = with pkgs; [
        
        # CLI
        bash
        bat
        bats
        docker
        # elmPackages.elm # not under pkgs (with pkgs ^)
        exercism
        ffmpeg        
        go
        julia
        jq
        # kvm
        linode-cli
        lsd
        neovim
        nmap
        # node (npm, etc.)
        nomino
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
        spicetify-cli
        termtosvg
        tmux
        tokei
        # virtmanager
        wget
        youtube-dl
        zsh
        
        # GUI
        alacritty
        # autodesk-fusion360 # needs alternative (FreeCAD, OpenSCAD)
        brave # brave-beta PR?
        discord
        firefox-devedition-bin
        inkscape
        # keeper-security # needs packaged
        # lepton # needs packaged
        # nordvpn # needs packaged
        obs-studio
        prusa-slicer
        slack
        spotify
        teamviewer
        telegram
        # tunnelblick # needs alternative (for use with wireguard?)
        vscode.override { isInsiders = true; }
        virtualboxWithExtpack
        
         
      ];
    };
  };
}
