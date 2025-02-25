#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

LOG_FILE="server_health.log" # Default log file name


echo -e "${YELLOW}🔹 Server Health Check Started...${NC}"

# 1️⃣ Allow the user to modify services
declare -a SERVICES=("nginx" "mysql" "docker")

echo -e "\n${GREEN}➡️  Current Services Being Checked: ${NC}"
for service in "${SERVICES[@]}"; do
    echo "   - $service"
done

read -p "🛠️  Do you want to modify the services? (yes/no): " MODIFY_SERVICES
if [[ "$MODIFY_SERVICES" == "yes" || "$MODIFY_SERVICES" == "y" ]]; then
    read -p "Enter the services you want to check (separated by spaces): " -a SERVICES
fi

echo -e "\n${GREEN}➡️  Checking CPU Usage...${NC}"
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo -e "🔹 CPU Usage: ${CPU_LOAD}%"

echo -e "\n${GREEN}➡️  Checking Memory Usage...${NC}"
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
echo -e "🔹 Memory Usage: $MEMORY_USAGE"

echo -e "\n${GREEN}➡️  Checking Disk Space...${NC}"
DISK_USAGE=$(df -h / | awk 'NR==2{print "Used: "$3" / Total: "$2", Available: "$4", Usage: "$5}')
echo -e "🔹 Disk Space: $DISK_USAGE"

echo -e "\n${GREEN}➡️  Checking Running Services...${NC}"
for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $service; then
        echo -e "✅ $service is ${GREEN}running${NC}"
    else
        echo -e "❌ $service is ${RED}not running${NC} - Restarting..."
        sudo systemctl restart $service
    fi
done

echo -e "\n${GREEN}➡️  Checking Network Connectivity...${NC}"
ping -c 2 google.com &> /dev/null
if [ $? -eq 0 ]; then
    echo -e "✅ Internet Connection: ${GREEN}Active${NC}"
else
    echo -e "❌ Internet Connection: ${RED}Not Available${NC}"
fi

echo -e "\n${YELLOW}✅ Server Health Check Completed.${NC}"

# Ask if user wants to save output to a log file
read -p "💾 Do you want to save this output to a log file? (yes/no): " SAVE_LOG
if [[ "$SAVE_LOG" == "yes" || "$SAVE_LOG" == "y" ]]; then
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    if [[ -f "$LOG_FILE" ]]; then
        echo -e "${YELLOW}Appending data to existing log file: $LOG_FILE...${NC}"
    else
        echo -e "${GREEN}Creating new log file: $LOG_FILE...${NC}"
    fi

    # Save results to log file
    {
        echo "------------------------"
        echo "📅 Date: $TIMESTAMP"
        echo "------------------------"
        echo "🔹 CPU Usage: ${CPU_LOAD}%"
        echo "🔹 Memory Usage: $MEMORY_USAGE"
        echo "🔹 Disk Space: $DISK_USAGE"
        echo "🔹 Services Checked: ${SERVICES[*]}"
        echo "🔹 Internet Status: $(if ping -c 1 google.com &> /dev/null; then echo "Active"; else echo "Not Available"; fi)"
        echo "✅ Health Check Completed."
        echo "------------------------"
    } >> "$LOG_FILE"
    
    echo -e "${GREEN}✅ Data saved to $LOG_FILE${NC}"
fi
