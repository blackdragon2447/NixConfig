{
  fetchFromGitHub,
  neovimUtils,
  vimUtils,
}: {
  nvim-ghost-nvim = neovimUtils.buildNeovimPlugin {
    pname = "nvim-ghost.nvim";
    version = "v0.5.4";
    src = fetchFromGitHub {
      owner = "subnut";
      repo = "nvim-ghost.nvim";
      rev = "67cc8f38c69d271af1c2430ff5099766f3550eb8";
      hash = "sha256-XldDgPqVeIfUjaRLVUMp88eHBHLzoVgOmT3gupPs+ao=";
    };
  };

  Coqtail = vimUtils.buildVimPlugin {
    pname = "Coqtail";
    version = "2025-03-29";
    src = fetchFromGitHub {
      owner = "whonore";
      repo = "Coqtail";
      rev = "192e4059d6df00dc76c98b9b451833ba76a70d09";
      hash = "sha256-CwegagIEYRzmNNYmGTqj/pIuwB1QFe1ZAXaX5wwT9Fk=";
    };
    meta.homepage = "https://github.com/whonore/Coqtail/";
    meta.hydraPlatforms = [];
  };
}
