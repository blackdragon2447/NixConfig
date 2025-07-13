{
  fetchFromGitHub,
  neovimUtils,
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
}
