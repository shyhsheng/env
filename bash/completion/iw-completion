# 自定義補全函數
_iw_dev_completions() {
    _init_completion || return
    # local cur prev words cword
    local devs=$(iw dev | awk '/Interface/ {print $2}')
    local mains="dev phy reg help --version"

    _is_mac() {
        [[ "$1" =~ ^([[:xdigit:]]{2}:){0,5}[[:xdigit:]]{0,2}$ ]]
    }

    _get_station_macs() {
        iw dev "$1" station dump 2>/dev/null | awk '/Station/ {print $2}'
    }

    _join_mac_words() {
        local mac=""
        for i in {5..15}; do
            [[ -n "${words[$i]}" ]] && mac+="${words[$i]}"
        done
        echo "$mac"
    }

    _get_channel_bandwidth_options() {
        iw dev "$1" set channel 2>&1 |
            grep -o '\[[^]]*\]' |         # 抓出所有中括號段
            grep -E 'MHz|HT|NOHT' |       # 只留下頻寬相關的
            head -n1 |                    # 取第一個
            sed 's/[][]//g' |             # 去掉中括號
            tr '|' '\n'                   # 分行
    }

    _gen_mac_hint() {
        local macs=""
        for i in {0..9}; do
            macs="$macs 02:00:00:00:00:0$i"
        done
        echo "$macs"
    }

    if [[ ${COMP_CWORD} -eq 1 ]]; then
       COMPREPLY=( $(compgen -W "${mains}" -- "$cur") )
       return
    fi

    if [[ ${words[1]} == "dev" ]]; then
        if [[ ${COMP_CWORD} -eq 2 ]]; then
            COMPREPLY=( $(compgen -W "${devs}" -- "$cur") )
            return
        fi

        local iface=${words[2]}
        local cmd=${words[3]}
        local devcmds="station set get mesh mpath info interface ibss scan link connect disconnect"
        if [[ ${COMP_CWORD} -eq 3 ]]; then
            COMPREPLY=( $(compgen -W "${devcmds}" -- "$cur") )
            return
        fi

        case "$cmd" in
            station)
                local station_cmd="dump set get del"
                if [[ ${COMP_CWORD} -eq 4 ]]; then
                    COMPREPLY=( $(compgen -W "${station_cmd}" -- "$cur") )
                    return
                fi
                if [[ ${words[4]} =~ ^(get|del|set)$ && ${COMP_CWORD} -eq 5 ]]; then
                    local macs=$(_get_station_macs "$iface")
                    COMPREPLY=( $(compgen -W "${macs}" -- "$cur") )
                    return
                fi
                if [[ ${words[4]} == "set" && ${COMP_CWORD} -gt 15 ]]; then
                    local full_mac="$(_join_mac_words)"
                    if _is_mac "${full_mac}"; then
                        local station_set_cmd="plink_action mesh_power_mode vlan airtime_weigh txpwr"
                        if [[ ${COMP_CWORD} -eq 16 ]]; then
                            COMPREPLY=( $(compgen -W "$station_set_cmd" -- "$cur") )
                            return
                        fi
                        if [[ ${words[16]} == "plink_action" && ${COMP_CWORD} -eq 17 ]]; then
                            COMPREPLY=( $(compgen -W "block open" -- "$cur") )
                            return
                        elif [[ ${words[16]} == "mesh_power_mode" && ${COMP_CWORD} -eq 17 ]]; then
                            COMPREPLY=( $(compgen -W "active light deep" -- "$cur") )
                            return
                        elif [[ ${words[16]} == "txpwr" && ${COMP_CWORD} -eq 17 ]]; then
                            COMPREPLY=( $(compgen -W "auto limit" -- "$cur") )
                            return
                        fi
                    fi
                fi
            ;;
            mpath)
                local mpathcmds="dump get set del new probe"
                if [[ ${COMP_CWORD} -eq 4 ]]; then
                    COMPREPLY=( $(compgen -W "${mpathcmds}" -- "$cur") )
                    return
                fi
                if [[ ${words[4]} =~ ^(set|new)$ ]]; then
                    if [[ ${COMP_CWORD} -eq 5 ]]; then
                        local macs=$(_get_station_macs "$iface")
                        COMPREPLY=( $(compgen -W "${macs}" -- "$cur") )
                        return
                    elif [[ ${COMP_CWORD} -eq 16 && ${cur} != "next_hop" ]]; then
                        COMPREPLY=( $(compgen -W "next_hop" -- "$cur") )
                        return
                    elif [[ ${COMP_CWORD} -eq 17 && ${cur} != "next_hop" ]]; then
                        # next_hop MAC address
                        local macs=$(_get_station_macs "$iface")
                        COMPREPLY=( $(compgen -W "${macs}" -- "$cur") )
                        return
                    fi
                elif [[ ${words[4]} =~ ^(get|del)$ ]]; then
                    if [[ ${COMP_CWORD} -eq 5 ]]; then
                        local macs=$(_get_station_macs "$iface")
                        COMPREPLY=( $(compgen -W "${macs}" -- "$cur") )
                        return
                    fi
                fi
            ;;
            mesh)
                local meshcmds="join leave"
                if [[ ${COMP_CWORD} -eq 4 ]]; then
                    COMPREPLY=( $(compgen -W "${meshcmds}" -- "$cur") )
                    return
                fi
                if [[ ${words[4]} == "join" && ${COMP_CWORD} -eq 6 ]]; then
                    COMPREPLY=( $(compgen -W "freq" -- "$cur") )
                    return
                fi
            ;;
            set)
                local setcmds="4addr type mesh_param channel freq"

                if [[ ${COMP_CWORD} -eq 4 ]]; then
                    COMPREPLY=( $(compgen -W "${setcmds}" -- "$cur") )
                    return
                fi

                if [[ ${words[4]} == "4addr" && ${COMP_CWORD} -eq 5 ]]; then
                    COMPREPLY=( $(compgen -W "on off" -- "$cur") )
                    return
                elif [[ ${words[4]} == "type" && ${COMP_CWORD} -eq 5 ]]; then
                    COMPREPLY=( $(compgen -W "managed ibss monitor mesh wds __ap" -- "$cur") )
                    return
                elif [[ ${words[4]} == "mesh_param" && ${COMP_CWORD} -eq 5 ]]; then
                    local meshparam="$(iw dev $iface get mesh_param | awk '/- mesh_/{print $2}')"
                    local with_equal=""
                    for item in $meshparam; do
                        meshparam_with_equal="$meshparam_with_equal ${item}="
                    done
                    COMPREPLY=( $(compgen -W "${meshparam_with_equal}" -- "$cur") )
                    compopt -o nospace
                    return
                elif [[ ${words[4]} == "channel" && ${COMP_CWORD} -eq 6 ]]; then
                   local bw_opts="$(_get_channel_bandwidth_options "$iface")"
                   COMPREPLY=( $(compgen -W "$bw_opts" -- "$cur") )
                   return
                fi
            ;;
            get)
                local getcmds="mesh_param txq power_save"
                if [[ ${COMP_CWORD} -eq 4 ]]; then
                    COMPREPLY=( $(compgen -W "${getcmds}" -- "$cur") )
                    return
                fi
                if [[ ${words[4]} == "mesh_param" && ${COMP_CWORD} -eq 5 ]]; then
                    local meshparam="$(iw dev $iface get mesh_param | awk '/- mesh_/ {print $2}')"
                    COMPREPLY=( $(compgen -W "${meshparam}" -- "$cur") )
                    return
                fi
            ;;
        esac

    elif [[ ${words[1]} == "phy" ]]; then
        if [[ ${COMP_CWORD} -eq 2 ]]; then
            COMPREPLY=( $(iw phy | grep -o 'phy[0-9]*' | sort -u) )
            return
        fi
    # elif [[ ${words[1]} == "reg" ]]; then
    fi
}

# 為 iw 命令設置補$全函數
complete -F _iw_dev_completions iw
