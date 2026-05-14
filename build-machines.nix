{
  config,
  pkgs,
  ...
}: {
  nix.buildMachines = [
    {
      hostName = "archie";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      # if the builder supports building for multiple architectures,
      # replace the previous line by, e.g.
      # systems = ["x86_64-linux" "aarch64-linux"];
      maxJobs = 12;
      speedFactor = 2;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      mandatoryFeatures = [];
    }
  ];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
