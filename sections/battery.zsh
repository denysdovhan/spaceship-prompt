#
# Battery
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# | SPACESHIP_BATTERY_SHOW | below threshold | above threshold | fully charged |
# |------------------------+-----------------+-----------------+---------------|
# | false                  | hidden          | hidden          | hidden        |
# | always                 | shown           | shown           | shown         |
# | true                   | shown           | hidden          | hidden        |
# | charged                | shown           | hidden          | shown         |
# ------------------------------------------------------------------------------

SPACESHIP_BATTERY_SHOW="${SPACESHIP_BATTERY_SHOW=true}"
SPACESHIP_BATTERY_PREFIX="${SPACESHIP_BATTERY_PREFIX=""}"
SPACESHIP_BATTERY_SUFFIX="${SPACESHIP_BATTERY_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_BATTERY_SYMBOL_CHARGING="${SPACESHIP_BATTERY_SYMBOL_CHARGING="⇡"}"
SPACESHIP_BATTERY_SYMBOL_DISCHARGING="${SPACESHIP_BATTERY_SYMBOL_DISCHARGING="⇣"}"
SPACESHIP_BATTERY_SYMBOL_FULL="${SPACESHIP_BATTERY_SYMBOL_FULL="•"}"
SPACESHIP_BATTERY_THRESHOLD="${SPACESHIP_BATTERY_THRESHOLD=10}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show section only if either of follow is true
# - Always show is true
# - battery percentage is below the given limit (default: 10%)
# - Battery is fully charged
# Escape % for display since it's a special character in zsh prompt expansion
spaceship_battery() {
  [[ $SPACESHIP_BATTERY_SHOW == false ]] && return

  local battery_data battery_percent battery_status battery_color

  if spaceship::exists pmset; then
    battery_data=$(pmset -g batt)

    # Return if no internal battery
    [[ -z $(echo $battery_data | grep "InternalBattery") ]] && return

    battery_percent="$( echo $battery_data | grep -oE '[0-9]{1,3}%' )"
    battery_status="$( echo $battery_data | awk -F '; *' 'NR==2 { print $2 }' )"
  elif spaceship::exists upower; then
    local battery=$(command upower -e | grep battery | head -1)

    # Return if no battery
    [[ -z $battery ]] && return

    battery_data=$(upower -i $battery)
    battery_percent="$( echo "$battery_data" | grep percentage | awk '{print $2}' )"
    battery_status="$( echo "$battery_data" | grep state | awk '{print $2}' )"
  elif spaceship::exists acpi; then
    battery_data=$(acpi -ib)

    # Return if no battery
    [[ -z $battery_data ]] && return

    battery_percent="$( echo $battery_data | awk '(NR % 2){ perc=$4/100 } !(NR % 2) { availmAh += perc * $10; totalmAh += $10 } END { printf "%.0f", (availmAh / totalmAh)*100 }' )"
    battery_status="$( echo $battery_data | awk '(NR % 2){ print tolower($3) }' | tr -d '%[,;' | awk '{ s=$1 } (s=="charging") { status=s } (s=="discharging") { status=s } END { print status }' )"
  else
    return
  fi

  # Remove trailing % and symbols for comparison
  battery_percent="$(echo $battery_percent | tr -d '%[,;]')"

  # Change color based on battery percentage
  if [[ $battery_percent == 100 || $battery_status =~ "(charged|full)" ]]; then
    battery_color="green"
  elif [[ $battery_percent -lt $SPACESHIP_BATTERY_THRESHOLD ]]; then
    battery_color="red"
  else
    battery_color="yellow"
  fi

  # Battery indicator based on current status of battery
  if [[ $battery_status == "charging" ]];then
    battery_symbol="${SPACESHIP_BATTERY_SYMBOL_CHARGING}"
  elif [[ $battery_status =~ "^[dD]ischarg.*" ]]; then
    battery_symbol="${SPACESHIP_BATTERY_SYMBOL_DISCHARGING}"
  else
    battery_symbol="${SPACESHIP_BATTERY_SYMBOL_FULL}"
  fi

  # Escape % for display since it's a special character in Zsh prompt expansion
  if [[ $SPACESHIP_BATTERY_SHOW == 'always' ||
        $battery_percent -lt $SPACESHIP_BATTERY_THRESHOLD ||
        $SPACESHIP_BATTERY_SHOW == 'charged' && $battery_status =~ "(charged|full)" ]]; then
    spaceship::section \
      "$battery_color" \
      "$SPACESHIP_BATTERY_PREFIX" \
      "$battery_symbol$battery_percent%%" \
      "$SPACESHIP_BATTERY_SUFFIX"
  fi
}
