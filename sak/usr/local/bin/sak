#!/bin/bash
# Main file 

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

LOG_FILE="server_health.log" # Default log file name
LOGO_FILE="logo.text"        # ASCII logo file

# Display ASCII logo if file exists
if [[ -f "$LOGO_FILE" ]]; then
    echo -e "${GREEN}$(cat "$LOGO_FILE")${NC}"
else
    echo -e "${GREEN}🔪 Swiss Army Knife Tool${NC}"
fi

# Ask the user which script to run
echo -e "${YELLOW}\nWhich tool would you like to run?${NC}"
echo -e "1️⃣  Backup Script (This script performs Backups for important directories , db and compress them)"
echo -e "2️⃣  Server Health Check (This script performs Checks in disk , memory , cpu and services )"
read -p "Enter your choice (1 or 2): " CHOICE

# Run the selected script
case $CHOICE in
    1)
        echo -e "${GREEN}🔹 Running Automated Backup Script...${NC}"
        ./AutomatedBackupScript.sh
        ;;
    2)
        echo -e "${GREEN}🔹 Running Server Health Check...${NC}"
        ./ServerHealthCheck.sh
        ;;
    *)
        echo -e "${RED}❌ Invalid choice! Exiting.${NC}"
        exit 1
        ;;
esac
