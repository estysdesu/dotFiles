{ config, pkgs, ... }:
  
# let 
#   home-manager = builtins.fetchGit {
#     name = "home-manager-20.03";
#     url = "https://github.com/rycee/home-manager.git";
#     ref = "release-20.03";    
#     rev = "2102b4e7b329c0f41205c79d75b534d0db161775";
#   };
# in 
# {
#   imports = [ 
#     (import "${home-manager}/nixos")
#   ];
# }
{
  imports = [
    <home-manager/nixos>
  ];
} 
