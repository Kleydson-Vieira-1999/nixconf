{ self, inputs, config, ... }:
let
  user = config.my.user;
in
{

  perSystem = { pkgs, ... }: {
    packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;

      package = pkgs.git;

      env = rec {
        GIT_AUTHOR_NAME = user.fullName;
        GIT_AUTHOR_EMAIL = user.email;
        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
      };
    };
  };

}