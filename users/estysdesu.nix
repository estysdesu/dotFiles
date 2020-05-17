{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  users.extraUsers.estysdesu = {
    isNormalUser = true;
    description = "Tyler Estes";
    extraGroups = [ "wheel" ]; 
    initialHashedPassword = "$6$QjJG1SzDoMGk$0QNVsZWMMPw9szVggw2VNX3pAJhuNBThggVeZ1y.kHT6dgEP.SurKwcVMGlK2BEixYDIQU9ZuFdraTmfZ2kVR.";
    shell = pkgs.zsh;
    packages = with pkgs;
      let
        vscode-insiders = vscode.overrride { isInsiders = true; }; # merged on master? #71251
        noxPackages = [ neovim zsh docker ];
      in
        if config.services.xserver.enable then
          noxPackages ++ [ alacritty vscode-insiders brave teamviewer ]
        else noxPackages;
    };
  home-manager.users.estysdesu = {pkgs, ... }: {
    home.packages = [ pkgs.nushell ];
    programs.zsh.enable = true;
  };

  # environment.gnome3.excludePackages = with pkgs.gnome3;
  #   if services.xserver.desktopManager.gnome3.enable then
  #     [ epiphany gnome-terminal ]
  #   else null;

  # home-manager.useUserPackages = true;
}
