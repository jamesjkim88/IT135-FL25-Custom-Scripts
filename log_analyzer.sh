#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <log_file> [customer_id] [region] [error_code]"
    exit 1
fi

LOG_FILE="$1"
CUSTOMER="$2"
REGION="$3"
ERROR="$4"

RESULT=$(cat "$LOG_FILE")

if [ ! -z "$CUSTOMER" ]; then
    RESULT=$(echo "$RESULT" | grep "$CUSTOMER")
fi

if [ ! -z "$REGION" ]; then
    RESULT=$(echo "$RESULT" | grep "$REGION")
fi

if [ ! -z "$ERROR" ]; then
    RESULT=$(echo "$RESULT" | grep "$ERROR")
fi

echo "$RESULT" > filtered_logs.txt

echo "Summary Report for $LOG_FILE" > report.txt
echo "--------------------------------" >> report.txt
echo "Total matching lines: $(echo "$RESULT" | wc -l)" >> report.txt

echo "" >> report.txt
echo "Counts per error code:" >> report.txt
echo "$RESULT" | awk '{print $4}' | sort | uniq -c >> report.txt

echo "" >> report.txt
echo "Unique customers:" >> report.txt
echo "$RESULT" | awk '{print $2}' | sort | uniq -c >> report.txt
echo "Total unique customers: $(echo "$RESULT" | awk '{print $2}' | sort | uniq | wc -l)" >> report.txt

# Optional alert for critical error E001
if echo "$RESULT" | grep -qi "E001"; then
    echo "" >> report.txt
    echo "ALERT: Critical error E001 found!" >> report.txt
fi

echo "Filtering complete. See filtered_logs.txt and report.txt for results."
