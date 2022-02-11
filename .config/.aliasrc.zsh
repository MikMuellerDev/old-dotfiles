alias tmux='tmux -2'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias ip='ip -c'
alias l='exa -lhg --icons --octal-permissions'
alias la='exa -lahg --icons --octal-permissions'
alias ll='exa -lhg --icons --octal-permissions'

updaterc () {
    current_dir="$PWD"
    cd ~/.dotfiles || {
        echo 'The .dotfiles folder should be at ~/.dotfiles to auto update'
        return 2
    }
    git pull
    ./install.sh
    cd "$current_dir" || return 2
    # Reload shell
    exec "$SHELL"
}

editrc () {
    [[ -d "$HOME/.dotfiles" ]] || {
        echo 'No .dotfiles folder at ~/.dotfiles'
        return 2
    }
    code ~/.dotfiles
}

command -v xclip >/dev/null && { alias setclip='xclip -selection c'; alias getclip='xclip -selection c -o'; }
command -v wl-copy >/dev/null && { alias setclip='wl-copy'; alias getclip='wl-paste'; }


alias lelcat='bash -c "$(curl -fsSL https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/meow.sh)"'
cl () {
    if [[ -f "$HOME/.clear_count.txt" ]]; then
        count="$(cat "$HOME/.clear_count.txt")"
    else
        count=0
    fi
    
    count=$(( count + 1 ))
    echo "Stop it. You didn't behave $count times..."
    qdbus org.kde.KWin /KWin org.kde.KWin.nextDesktop
    
    echo "$count" > "$HOME/.clear_count.txt"
}
alias poof='shutdown -P now'
alias rcp='rsync --progress -ravzh'
alias 'cd..'='cd ..'
alias myip='curl ipinfo.io/ip'
alias sus='systemctl suspend'
alias rssdm='sudo systemctl restart sddm'
alias lock='loginctl lock-session'
alias sss='ssh cloud'
alias ss8='ssh s8'
alias con='ssh contabo'
alias ssp='ssh pi-rack'
alias sspr='ssh pi_room'
alias ssr='ssh redripper'
alias ss2='ssh cloud2'
alias ssb='ssh pi_box'
alias wstart='myip && echo "\n" && sudo systemctl start wg-quick@wg0 && myip'
alias wstop='myip && echo "\n" && sudo systemctl stop wg-quick@wg0 && myip'
alias update='sudo apt update && sudo apt upgrade && sudo apt autoclean && sudo apt autoremove'

volume () {
    ssh pi_box pactl set-sink-volume 0 "$1"
    ssh pi_room pactl set-sink-volume 0 "$1"
}

radigo () {
    cd /home/mik/Downloads/radiGo/bin && ./radiGo-1.2.2
}

postclip () {
    getclip | quick-clip set -i
}

fetchclip () {
    quick-clip get -o | setclip
}

postfile () {
    cat "$1" | quick-clip set -i
}

fetchfile () {
    quick-clip get -o >> "$1"
}

fixkeyboard() {
    wget -O- https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/US-DE_Keyboard_Layout/install.sh | sudo bash
}

pubarbeit() {
    bash /home/mik/scripts/login-facharbeit.sh
}

cheat () { curl -s "cheat.sh/$1" | less; }
timeout () { sleep "$1"; shift; bash -c "$*"; }
colors () {
    for i in {0..255}; do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}

alias sr='screen -r'
alias sls='screen -ls'
