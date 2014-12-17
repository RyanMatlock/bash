#!/bin/bash

# uptime_til_shutdown.sh

# This script writes the output of the program uptime to a file, ~/uptime.log,
# every minute It's useful for when you want to know how long a computer runs
# until it's shutdown.

# By the way, you may want to call it with a trailing ampersand (like
# ./uptime_til_shutdown.sh &) so that you get your shell back.

while true; do
    echo $(uptime) > ~/uptime.log
    sleep 1m # uptime only records to the minute anyway
done

