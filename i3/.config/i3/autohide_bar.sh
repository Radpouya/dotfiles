#!/bin/bash

# Check if i3bar is running
if pgrep -x "i3bar" > /dev/null
then
    # If i3bar is running, hide it
    i3bar --exit
else
    # If i3bar isn't running, start it
    i3bar
fi

