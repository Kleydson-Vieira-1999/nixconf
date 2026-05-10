{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {
    packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;

      package = pkgs.git;

      env = rec {
        GIT_AUTHOR_NAME = "Kleydson Vieira";
        GIT_AUTHOR_EMAIL = "kleydson122@gmail.com";
        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
      };
    };
  };

}