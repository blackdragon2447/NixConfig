{...}: {
  environment.etc.aliases = {
    text = '''';
  };

  networking.firewall.allowedTCPPorts = [25 80 443 465 993 4190];

  services.postfix = {
    enable = true;
    postmasterAlias = "avery@hydra1.local";
    rootAlias = "avery@hydra1.local";
    config = {
      home_mailbox = "Maildir/";
    };
  };
}
