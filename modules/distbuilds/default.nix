{ config , ... }:


{
  nix =
    let
      sshUser = "builder";
      sshKey = config.sops.secrets."users/builder/key".path;
      system = "x86_64-linux";
      supportedFeatures = [
        "benchmark"
        "big-parallel"
        "kvm"
      ];
    in
    {
      settings.experimental-features = [ "nix-command" "flakes" ];
      distributedBuilds = true;
      #settings.max-jobs = 0;
      buildMachines = [
        {
          inherit sshUser sshKey system supportedFeatures;
          hostName = "wsl-main";
          maxJobs = 2;
          speedFactor = 8;
        }
        {
          inherit sshUser sshKey system supportedFeatures;
          hostName = "lxc-kabu";
          maxJobs = 4;
          speedFactor = 9;
        }
      ];
      extraOptions = ''
        builders-use-substitutes = true
      '';
    };
}
