#!/bin/bash

######### METHOD : using source <implementing select#1<OPS<DOCKER

## ./../general/select.sh  "${choices[@]}"

## we can get it  as argument 
# read -a choicesToShow <<< "${BASH_ARGV[@]}"
# echo "${choicesToShow[@]}"

# choices=$1
##echo "Choices: ${choicesToShow[@]}"
##echo -e "\n"


##choicesToShow=( 'one' 'two' 'three' 'four' 'five' ) # sample choices
select dummy in "${choicesToShow[@]}"; do  # present numbered choices to user
  # Parse ,-separated numbers entered into an array.
  # Variable $REPLY contains whatever the user entered.
  IFS=', ' read -ra selChoiceOptn <<<"$REPLY"
  # Loop over all numbers entered.
  for choice in "${selChoiceOptn[@]}"; do
    # Validate the number entered.
    (( choice >= 1 && choice <= ${#choicesToShow[@]} )) || { echo "Invalid choice: $choice. Try again." >&2; continue 2; }
    # If valid, echo the choice and its number.
    echo "Choice #$(( ++choiceIncrementor )): ${choicesToShow[choice-1]} ($choice)"
    export mychoicefromsel=${choicesToShow[choice-1]}

  done
  # All choices are valid, exit the prompt.
  break
done


unset choicesToShow
unset selChoiceOptn
unset choiceIncrementor
unset dummy

echo "exiting select with mychoicefromsel = $mychoicefromsel"

