{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      PROMPT='%F{blue}%1~ %(?.%F{green}.%F{red})%#%f '
      PATH="$HOME/bin:$PATH"
    '';
  };
}
