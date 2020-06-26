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
  };
  
  home-manager = {
    useUserPackages = true;
    users.estysdesu = {
      programs.bash.enable = true;
      home.packages = with pkgs; [
        ##### CLI #####
        #ascii
        bash # bats (only needed for bash projects)
        #bat
        #bats
        #cookiecutter
        #dash
        #docker
        #exercism
        #ffmpeg
        #figlet
        #genact
        #go
        #gh # github
        htop
        #httpie
        #julia
        #kvm/qemu
        #linode-cli
        #lsd
        #make
        #mercurial # hg
        #neofetch
        neovim
        #nmap
        #node (npm, etc.; only needed for projects) # jq # elmPackages.elm # not under pkgs (with pkgs ^)
        #nomino
        #nordvpn
        #nushell
        #octave
        #platformio
        #podman
        #poetry
        #pre-commit
        python
        #python38Packages.howdoi # not under pkgs (with pkgs ^)
        #python38Packages.jupyter # not under pkgs (with pkgs ^)
        #pyenv # needs packaged
        #pv
        #ripgrep
        #rustup
        #speedtest-cli
        # spicetify-cli
        #termtosvg
        #tokei
        #trash-cli
        tmux
        #tokei
        #virtmanager
        wget
        #wireguard
        #youtube-dl
        
        ##### GUI #####
        alacritty
        # autodesk-fusion360 # needs alternative (FreeCAD, OpenSCAD)
        brave # brave-beta PR?
        #discord
        #inkscape
        #keeper-password-manager
        #lepton
        #qbittorrent
        #slack
        #spotify
        #steam
        #teamviewer
        #telegram
        #vagrant
        #virutalbox
        vscode #vscode.overrride { isInsiders = true; } # merged on master? #71251
      ];
    };
  };
}
