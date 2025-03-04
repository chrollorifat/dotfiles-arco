#!/usr/bin/env bash
#   ██████╗██████╗ ██╗███████╗████████╗██╗███╗   ██╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔════╝██╔══██╗██║██╔════╝╚══██╔══╝██║████╗  ██║██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ██║     ██████╔╝██║███████╗   ██║   ██║██╔██╗ ██║███████║    ██████╔╝██║██║     █████╗
#  ██║     ██╔══██╗██║╚════██║   ██║   ██║██║╚██╗██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ╚██████╗██║  ██║██║███████║   ██║   ██║██║ ╚████║██║  ██║    ██║  ██║██║╚██████╗███████╗
#   ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Cristina
set_bspwm_config() {
    bspc config border_width 0
    bspc config top_padding 2
    bspc config bottom_padding 60
    bspc config left_padding 2
    bspc config right_padding 2
    bspc config normal_border_color "#9bced7"
    bspc config active_border_color "#9bced7"
    bspc config focused_border_color "#c3a5e6"
    bspc config presel_feedback_color "#c3a5e6"
}

# Reload terminal colors
set_term_config() {
    cat > "$HOME"/.config/alacritty/rice-colors.toml << EOF
# (Rose-Pine Moon) Color scheme for Cristina Rice

# Default colors
[colors.primary]
background = "#232136"
foreground = "#e0def4"

# Cursor colors
[colors.cursor]
cursor = "#c3a5e6"
text = "#232136"

# Normal colors
[colors.normal]
black = "#393552"
blue = "#34738e"
cyan = "#eabbb9"
green = "#9bced7"
magenta = "#c3a5e6"
red = "#ea6f91"
white = "#faebd7"
yellow = "#f1ca93"

# Bright colors
[colors.bright]
black = "#6e6a86"
blue = "#34738e"
cyan = "#ebbcba"
green = "#9bced7"
magenta = "#c3a5e6"
red = "#ea6f91"
white = "#e0def4"
yellow = "#f1ca93"
EOF
}

# Set compositor configuration
set_picom_config() {
    sed -i "$HOME"/.config/bspwm/picom.conf \
        -e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
        -e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
        -e "s/corner-radius = .*/corner-radius = 6/g" \
        -e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
        -e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
    sed -i "$HOME"/.config/bspwm/dunstrc \
        -e "s/transparency = .*/transparency = 0/g" \
        -e "s/frame_color = .*/frame_color = \"#232136\"/g" \
        -e "s/separator_color = .*/separator_color = \"#ea6f91\"/g" \
        -e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
        -e "s/foreground='.*'/foreground='#9bced7'/g"

    sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
    cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
			[urgency_low]
			timeout = 3
			background = "#232136"
			foreground = "#e0def4"

			[urgency_normal]
			timeout = 6
			background = "#232136"
			foreground = "#e0def4"

			[urgency_critical]
			timeout = 0
			background = "#232136"
			foreground = "#e0def4"
_EOF_
}

# Set eww colors
set_eww_colors() {
    cat > "$HOME"/.config/bspwm/eww/colors.scss << EOF
// Eww colors for Cristina rice
\$bg: #232136;
\$bg-alt: #2a2740
\$fg: #e0def4;
\$black: #6f6e85;
\$lightblack: #262831;
\$red: #ea6f91;
\$blue: #34738e;
\$cyan: #eabbb9;
\$magenta: #c3a5e6;
\$green: #9bced7;
\$yellow: #f1ca93;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Cristina
set_jgmenu_colors() {
    sed -i "$HOME"/.config/bspwm/jgmenurc \
        -e 's/color_menu_bg = .*/color_menu_bg = #232136/' \
        -e 's/color_norm_fg = .*/color_norm_fg = #e0def4/' \
        -e 's/color_sel_bg = .*/color_sel_bg = #2a2740/' \
        -e 's/color_sel_fg = .*/color_sel_fg = #e0def4/' \
        -e 's/color_sep_fg = .*/color_sep_fg = #6f6e85/'
}

# Set Rofi launcher config
set_launcher_config () {
    sed -i "$HOME/.config/bspwm/scripts/Launcher.rasi" \
        -e '22s/\(font: \).*/\1"Terminess Nerd Font Mono Bold 10";/' \
        -e 's/\(background: \).*/\1#232136;/' \
        -e 's/\(background-alt: \).*/\1#232136E0;/' \
        -e 's/\(foreground: \).*/\1#e0def4;/' \
        -e 's/\(selected: \).*/\1#c3a5e6;/' \
        -e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

    # WallSelect menu colors
    sed -i "$HOME/.config/bspwm/scripts/WallSelect.rasi" \
        -e 's/\(main-bg: \).*/\1#232136E6;/' \
        -e 's/\(main-fg: \).*/\1#e0def4;/' \
        -e 's/\(select-bg: \).*/\1#c3a5e6;/' \
        -e 's/\(select-fg: \).*/\1#232136;/'
}

# Launch the bar and or eww widgets
launch_bars() {

    for mon in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$mon polybar -q cristina-bar -c "${rice_dir}"/config.ini &
    done

}



### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
launch_bars
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
