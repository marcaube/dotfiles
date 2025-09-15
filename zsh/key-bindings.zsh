# Use emacs key bindings
bindkey -e

# Make ⌥+⌫ developer friendly by treating /, =, and . as *not* part of a word
# https://lgug2z.com/articles/sensible-wordchars-for-most-developers/
WORDCHARS='*?_-[]~&;!#$%^(){}<>'

# kitty: jumping words using option + arrows
# https://github.com/kovidgoyal/kitty/issues/838#issuecomment-770328902
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word  # ⌥→

# [Option-Delete] - delete whole forward-word
# see: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
bindkey "\e[3;3~" kill-word # ⌥⌦
bindkey "\e[3~" delete-char # ⌦

# Start typing + [Up-Arrow] - fuzzy find history forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# [Ctrl-X][Ctrl-E] - Edit the current command line in $EDITOR
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh#L120-L123
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
