alias tmux='tmux -2'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias ip='ip -c'
alias cl='clear'
alias l='exa -lhg --icons --octal-permissions --git'
alias la='l -a'
alias ll=l

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
    nvim ~/.dotfiles
}

command -v xclip >/dev/null && { alias setclip='xclip -selection c'; alias getclip='xclip -selection c -o'; }
command -v wl-copy >/dev/null && { alias setclip='wl-copy'; alias getclip='wl-paste'; }


alias cl='clear'
alias lelcat='bash -c "$(curl -fsSL https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/meow.sh)"'
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

# Go development
alias gotest='richgo test -v -race ./...'
alias gorun='richgo run -v -race .'

# Smarthome development
alias mdev='make vite-dev'
alias mrun='make run'
alias mrel='make release'
alias mtes='make test'
alias shdb='docker exec -it smarthome-mariadb  mysql -u root -p'
alias shtdb='docker exec -it smarthome-mariadb-testing mysql -u root -p'

apoof() {
    # Only run Homescript if the alias function is executed on the Desktop-PC, not the laptop
    if [[ "$(cat /proc/sys/kernel/hostname)" == "mik-pc" ]]; then
        echo "$(cat /proc/sys/kernel/hostname)"
        homescript pipe "
            #Automated shutdown script for Smarthome v0.0.26-beta-rc.2, cli version v2.0.0
            sleep(30)
            switch('s4', off)
        " &
        sleep 5
        shutdown -P now
    else
        shutdown -P now
    fi
}

postclip () {
    getclip | quick-clip set -i
}

fetchclip () {
    quick-clip get -o | setclip
}

fixkeyboard() {
    wget -O- https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/US-DE_Keyboard_Layout/install.sh | sudo bash
}

cheat () { curl -s "cheat.sh/$1" | less; }
timeout () { sleep "$1"; shift; bash -c "$*"; }
colors () {
    for i in {0..255}; do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}
