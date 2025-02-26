#!/bin/bash

# Configuration
EMAIL="admin@example.com"            # Change this to your email
LOG_FILE="/var/log/service_monitor.log"

# configer ..
read -p "Pleas enter your email :" EMAIL

# 1️⃣ Allow the user to modify services
declare -a SERVICES=("nginx" "mysql" "docker") # List of services to monitor

echo -e "\n${GREEN}➡️  Current Services Being Checked: ${NC}"
for service in "${SERVICES[@]}"; do
    echo "   - $service"
done

read -p "🛠️  Do you want to modify the services? (yes/no): " MODIFY_SERVICES
if [[ "$MODIFY_SERVICES" == "yes" || "$MODIFY_SERVICES" == "y" ]]; then
    read -p "Enter the services you want to check (separated by spaces): " -a SERVICES
fi

# Check services
echo "🔍 Checking critical services..." | tee -a $LOG_FILE
for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $service; then
        echo "✅ $service is running" | tee -a $LOG_FILE
    else
        echo "❌ $service is DOWN! Restarting..." | tee -a $LOG_FILE
        sudo systemctl restart $service
        
        # Send email alert (requires mailutils installed)
        echo "$service was down and has been restarted on $(hostname) at $(date)" | mail -s "$service Restarted!" $EMAIL
    fi
done

echo "✅ Service check completed!" | tee -a $LOG_FILE
