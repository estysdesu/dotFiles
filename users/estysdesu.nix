{ config, pkgs, ... }:

{
  imports = [
  #   ../profiles/home-manager.nix
  ];
 
  users.extraUsers.estysdesu = {
    isNormalUser = true;
    description = "Tyler Estes";
    extraGroups = [ "wheel" ];
    # extraGroups = [ "wheel" "networkmanager" "plex" ]; # a way to auto configure this?
    initialHashedPassword = "$6$QjJG1SzDoMGk$0QNVsZWMMPw9szVggw2VNX3pAJhuNBThggVeZ1y.kHT6dgEP.SurKwcVMGlK2BEixYDIQU9ZuFdraTmfZ2kVR.";
    shell = pkgs.zsh;
    packages = with pkgs;
      let
        vscode-insiders = vscode.overrride { isInsiders = true; }; # merged on master? #71251
        noxPackages = [ neovim zsh ];
      in
        if config.services.xserver.enable then
          noxPackages ++ [ alacritty vscode brave teamviewer ]
        else noxPackages;
    };

  # environment.gnome3.excludePackages = with pkgs.gnome3;
  #   if services.xserver.desktopManager.gnome3.enable then
  #     [ epiphany gnome-terminal ]
  #   else null;

  # users.extraGroups.networkmanager.members = 
  #   if networking.networkmanager.enable then [ "estysdesu" ] else null;
  # 
  # users.extraGroups.plex.members = 
  #   if services.plex.enable then [ "estysdesu" ] else null;

  # users.extraGroups.vboxusers.members =
  #   if virtualization.virtualbox.host.enable then [ "estysdesu" ] else null;

  # home-manager.useUserPackages = true;
}
