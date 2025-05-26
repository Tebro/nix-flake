
CLASS=org.tebro.tdropmux
TERM=kitty # Chose yours here, needs to support --class
ACTIVE_WORKSPACE="$(hyprctl activeworkspace -j | jq -r .id)" || echo "hdrop: Error executing dependencies 'hyprctl' or 'jq'" "Check terminal output of 'hdrop $COMMANDLINE'"
VERBOSE=false
FOCUS=false
TERM_STATUS=$(pgrep -a $TERM | grep "$CLASS")
TMUX_SESSION=dropdown

if [[ -n "${TERM_STATUS}" ]]; then
  if [[ -n $(hyprctl clients -j | jq -r ".[] | select(.class==\"$CLASS\" and .workspace.id!=$ACTIVE_WORKSPACE)") ]]; then
    if [[ $FOCUS == false ]]; then
      # shellcheck disable=SC2140 # erroneous warning
      hyprctl dispatch movetoworkspacesilent "$ACTIVE_WORKSPACE","class:^($CLASS)$" || echo "hdrop: Error moving '$0' to current workspace"
      hyprctl dispatch resizewindowpixel exact 90% 90%,"class:^($CLASS)$" || echo "asdf!!"
      hyprctl dispatch focuswindow "class:^($CLASS)$" || echo "asdf!!"
      hyprctl dispatch centerwindow || echo "asdf!!"
      if $VERBOSE; then echo "hdrop: Matched class '$CLASS' on another workspace and moved it to current workspace"; fi
    fi
    hyprctl dispatch -- focuswindow "class:^$CLASS$" || echo "hdrop: Error focusing '$COMMANDLINE' on current workspace"
  elif [[ $(hyprctl clients -j | jq -r ".[] | select(.class==\"$CLASS\" and .workspace.id==$ACTIVE_WORKSPACE)") ]]; then
    if [[ $FOCUS == false ]]; then
      hyprctl dispatch movetoworkspacesilent special:tdropmux,"class:^($CLASS)$" || echo "hdrop: Error moving '$COMMANDLINE' to workspace 'special:tdropmux'"
      if $VERBOSE; then echo "hdrop: Matched class '$CLASS' on current workspace and moved it to workspace 'special:hdrop'"; fi
    else
      hyprctl dispatch -- focuswindow "^($CLASS)$" || echo "hdrop: Error focusing '$COMMANDLINE' on current workspace"
    fi
  else
    if $VERBOSE; then echo "hdrop: No running program matches class '$CLASS'." "Currently active classes are '$(hyprctl clients -j | jq -r '.[] | select(.mapped==true) | .class' | sort | tr '\n' ' ')'. Executed '$COMMANDLINE' in case it was not running already."; fi
  fi
else
  echo "no matching $TERM found, starting..."

	if ! tmux has-session -t $TMUX_SESSION; then
		tmux new-session -s $TMUX_SESSION -n flake -d
		tmux send-keys -t $TMUX_SESSION 'cd ~/flake; nvim' C-m

		tmux new-window -t $TMUX_SESSION -n btop
		tmux send-keys -t $TMUX_SESSION:1 'btop' C-m

		tmux select-window -t $TMUX_SESSION:0
	fi

	$TERM --class="$CLASS" -e tmux attach -t $TMUX_SESSION
fi
