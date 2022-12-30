#!/bin/bash

# Create the output folder if it doesn't exist
if [ ! -d "outputs" ]; then
    mkdir outputs
fi

# Parse the command-line arguments
while getopts ":o:" opt; do
    case "$opt" in
        o) output_file=$OPTARG;;
    esac
done
shift $((OPTIND - 1))

# Read the list of URLs from the specified file
while read -r url; do
    # Send an HTTP GET request to the URL and capture the status code
    status=$(curl -L -m 5 -s -o /dev/null -w '%{http_code}' "$url")
    # Print the status code and URL with different colors according to the status code
    if [ "$status" -eq 200 ] || [ "$status" -eq 201 ] || [ "$status" -eq 204 ]; then
        printf '\e[32m%s \e[0m%s\n' "$status" "$url"
    elif [ "$status" -ge 400 ] && [ "$status" -lt 500 ]; then
        printf '\e[33m%s \e[0m%s\n' "$status" "$url"
    elif [ "$status" -ge 500 ]; then
        printf '\e[31m%s \e[0m%s\n' "$status" "$url"
    else
        printf '\e[36m%s \e[0m%s\n' "$status" "$url"
    fi
    # Write the status code and URL to a file in the output folder
    if [ -d "outputs" ]; then
        # Create a file for the status code if it doesn't exist
        if [ ! -f "outputs/$status" ]; then
            touch "outputs/$status"
        fi
        # Append the status code and URL to the file
        echo "$status $url" >> "outputs/$status"
    fi
done < "$1"

# Write the status codes and URLs to the specified output file
if [ -n "$output_file" ]; then
    # Create the file if it doesn't exist
    if [ ! -f "$output_file" ]; then
        touch "$output_file"
    fi
    # Append the status codes and URLs to the file
    cat outputs/* >> "$output_file"
fi
