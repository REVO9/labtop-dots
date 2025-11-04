{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [sshfs];

  fileSystems."/run/media/revo/archie" = {
    device = "revo@192.168.0.177:/home/revo";
    fsType = "sshfs";
    options = [
      # Filesystem options
      "allow_other" # for non-root access
      "_netdev" # this is a network fs
      "x-systemd.automount" # mount on demand

      # SSH options
      "reconnect" # handle connection drops
      "ServerAliveInterval=15" # keep connections alive
      "IdentityFile=/home/revo/.ssh/archie"
    ];
  };
}
