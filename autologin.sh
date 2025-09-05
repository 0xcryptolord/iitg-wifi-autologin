#!/bin/bash

LOGIN_URL="https://agnigarh.iitg.ac.in:1442/login?"

# Define your credentials - Use single quotes to preserve special characters
# Replace these with your actual credentials
USERNAME='your_username'
PASSWORD='your_password'

# URL encode function to handle special characters in password
urlencode() {
    local string="${1}"
    local strlen=${#string}
    local encoded=""
    local pos c o

    for (( pos=0 ; pos<strlen ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'$c" ;;
        esac
        encoded+="${o}"
    done
    echo "${encoded}"
}

while true; do
    # Step 1: Fetch the login page and extract the magic value
    MAGIC=$(curl -s "$LOGIN_URL" | grep 'name="magic"' | sed -E 's/.*name="magic" value="([^"]+)".*/\1/')

    if [[ -z "$MAGIC" ]]; then
        echo "❌ Error: Could not find magic value. Retrying in 10 seconds..."
        sleep 10
        continue
    fi

    # URL encode the password to handle special characters
    ENCODED_PASSWORD=$(urlencode "$PASSWORD")
    
    # Step 2: Submit login credentials with extracted magic value
    RESPONSE=$(curl -s \
        --data-urlencode "4Tredir=$LOGIN_URL" \
        --data-urlencode "magic=$MAGIC" \
        --data-urlencode "username=$USERNAME" \
        --data-raw "password=$ENCODED_PASSWORD" \
        -X POST "$LOGIN_URL")

    # Step 3: Detect Successful Login or Password Failure
    if echo "$RESPONSE" | grep -q "window.location"; then
        echo "✅ Login successful at $(date)"
        echo "🔄 Waiting 19 minutes before next login attempt..."
        sleep 1140
    elif echo "$RESPONSE" | grep -qi "Authentication Failed"; then
        echo "❌ Login failed: Incorrect username or password at $(date)"
        sleep 10
    else
        echo "❌ Login failed for unknown reasons at $(date)"
        sleep 10
    fi
done