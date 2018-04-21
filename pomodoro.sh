#!/usr/bin/env bash

function show { 
  echo -ne "$1\033[0K\r"
}
function count { 
  for minutes in `seq $2 1`; do 
    for seconds in `seq -f "%02g" 59 0`; do 
      show "$1 $minutes:$seconds"; sleep 1; 
    done 
  done 
}
function announce { 
  osascript -e "display notification \"$1\" with title \"Pomodoro\"" && say $1
}
pomodoros=0
while true; do 
  announce 'Now work'; count "Work#$pomodoros: " ${1:-25}
  announce 'Now Rest'; count "Rest#$pomodoros: " ${1:-5}
  announce 'Rest finished'
  show 'Hit enter to start new pomodoro'; read
  let pomodoros=pomodoros+1
done
