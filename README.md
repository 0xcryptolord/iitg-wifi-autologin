# IITG WiFi Auto-Login Script

A bash script to automatically login to IITG campus WiFi (Agnigarh portal) and maintain the connection.

## Why This Exists

Born out of pure frustration of:
- Keeping Chrome open 24/7 just for a WiFi login extension 
- Getting kicked out every 20 minutes during important work
- Missing that 100x crypto pump because you were busy logging back into WiFi instead of buying the dip                                                                                                                            
- Your blockchain node losing sync and having to re-download 500GB because WiFi said "nope"
- Losing that sweet entry point because you were typing your password AGAIN
- Typing the same credentials 50 times a day like a robot
- Missing important messages because WiFi decided to take a coffee break

Finally, a script that logs in for you while you can actually close Chrome and reclaim your RAM! 

## Features

- Automatic login to IITG WiFi portal
- Handles special characters in passwords
- Maintains connection with 19-minute refresh interval
- URL encoding for secure credential transmission
- Error handling and retry logic
- Freedom from Chrome extensions! 

## Setup

1. Clone this repository:
```bash
git clone https://github.com/yourusername/iitg-wifi-autologin.git
cd iitg-wifi-autologin
```

2. Edit the script with your credentials:
```bash
nano autologin.sh
```

Replace `your_username` and `your_password` with your actual credentials.

3. Make the script executable:
```bash
chmod +x autologin.sh
```

## Usage

### Run in background:
```bash
./autologin.sh &
```

### Stop the script:
```bash
pkill -f autologin.sh
```

### Check if script is running:
```bash
ps aux | grep autologin.sh
```

## How it works

1. Fetches the login page and extracts the "magic" token
2. Submits credentials with the magic token
3. Checks for successful login response
4. Waits 19 minutes before attempting next login (beating the 20-min timeout like a boss)
5. Automatically retries on failure

## Notes

- The script uses single quotes for credentials to preserve special characters
- Passwords are URL-encoded to handle special characters like `$`, `#`, `@`, etc.
- The script runs continuously in a loop to maintain the connection
- No more browser extensions eating your RAM!

## Requirements

- bash
- curl
- sed
- grep
- A burning desire to not login manually ever again

## License

MIT - Use it, share it, spread the freedom from manual logins!
