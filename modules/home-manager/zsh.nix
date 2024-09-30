{pkgs, config, ...}: 

{
      programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting={
      enable = true;
    };
   oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    }; 
    history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  };

}
