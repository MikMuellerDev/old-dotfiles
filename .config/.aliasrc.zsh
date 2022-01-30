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

<<<<<<< Updated upstream
facharbeit() {
    code /home/mik/Documents/facharbeit/facharbeit
    code /home/mik/Documents/facharbeit/facharbeit/main.pdf
}

=======
>>>>>>> Stashed changes
untis () {
    user="$1"
    [[ -n "$user" ]] || {
        echo "No user specified"
        return 11
    }
    date="$2"
    [[ -n "$date" ]] || {
        echo "No date specified"
        return 1
    }
    
    [[ -f ~/.untisusers.json ]] || {
        echo "No '.untisusers.json' in home directory"
        return 1
    }
    
    username="$(jq -r ".$user.username" ~/.untisusers.json)"
    password="$(jq -r ".$user.password" ~/.untisusers.json)"
    [[ "$username" != "null" ]] && [[ "$password" != "null" ]] || {
        echo "User not found in ~/.untisusers.json"
        return 1
    }
    
    if [[ -n "$3" ]]; then
        filtered="true"
    else
        filtered="false"
    fi
    
    res="$(curl -X POST -H 'Content-Type: application/json' -d "{
        \"username\": \"$username\",
        \"password\": \"$password\",
        \"filtered\": $filtered
    }" "https://untis.rubixdev.de/timetable/$date")"
    if [[ "$(echo "$res" | jq 'has("error")')" == "true" ]]; then
        echo "$res" | jq
        return 1
    fi
    res="$(echo "$res" | jq 'to_entries | sort_by(.key) | from_entries')"
    
    color () {
        case "$1" in
            NORMAL            ) echo "48;5;208" ;;
            SUBSTITUTION      ) echo "48;5;134" ;;
            EXAM              ) echo "48;5;221" ;;
            CANCELLED         ) echo "48;5;246" ;;
            ROOM_SUBSTITUTION ) echo "48;5;33"  ;;
            FREE              ) echo "48;5;250" ;;
            ADDITIONAL        ) echo "48;5;34"  ;;
            *                 ) echo "48;5;169" ;;
        esac
    }
    
    for date in $(echo "$res" | jq -r '.[] | @base64'); do
        echo "\n----------------------------------------------------------\n"
        lessons="$(echo "$date" | base64 -d)"
        
        timetable=()
        for lesson in $(echo "$lessons" | jq -r 'sort_by(.lesson)[] | @base64'); do
            _jq () { echo "$lesson" | base64 -d | jq -r "$1"; }
            timetable+=(
                "$(_jq '.lesson')"
                "$(_jq '.subject.longName')"
                "$(_jq '.room.name')"
                "$(_jq '.state')"
            )
        done
        
        last_lesson=-1
        for (( i = 1; i <= ${#timetable[@]}; i += 4 )); do
            current_lesson="${timetable[i]}"
            for (( j = last_lesson + 1; j < current_lesson; j++ )); do
                echo -e "\t$(printf "%2s" "$j"):"
            done
            printf "\t%2s: \x1b[%sm  \x1b[0m  \x1b[1m%-32s\x1b[0m %-8s \x1b[90m%s\x1b[0m\n" "$current_lesson" "$(color "${timetable[i+3]}")"       "${timetable[i+1]}" "${timetable[i+2]}" "${timetable[i+3]}"
            last_lesson="$current_lesson"
        done
        for (( i = last_lesson + 1; i <= 10; i++ )); do
            echo -e "\t$(printf "%2s" "$i"):"
        done
    done
    echo "\n----------------------------------------------------------"
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
alias ssss='ssh cloud-temp'
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

cheat () { curl -s "cheat.sh/$1" | less; }
timeout () { sleep "$1"; shift; bash -c "$*"; }
colors () {
    for i in {0..255}; do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}

alias sr='screen -r'
alias sls='screen -ls'
