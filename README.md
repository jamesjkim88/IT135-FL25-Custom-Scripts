# Log Analyzer Script

A bash script that can filter through logs by customer ID, region, and error codes and produce a summary report within unique customer counts and alerts for critical errors.

## Overview

This script automates the process of analyzing large log files to quickly identify errors affecting customers across different regions.

Inspired by my experience at Amazon, where I manually filtered logs for errors by customer ID, region, and error code, this script streamlines that workflow by:

- Filtering logs based on criteria
- Counting occurrences of error codes
- Reporting unique customer impacts
- Highlighting critical errors for quick attention

## Features

- Filter logs by customer ID, region, and/or error code
- Generate a filtered log file (`filtered_logs.txt`)
- Produce a summary report (`report.txt`) including:
  - Total matching lines
  - Counts per error code
  - Unique customer counts
  - Alerts for critical errors (E001)
- Works with any plain-text log file in the expected format

## Usage & Sample Logs

Make the script executable and run it with optional filters:

```bash
chmod +x log_analyzer.sh
```

## Filter by all criteria

### All filtered files will be under log_analysis_output directory

```bash
./log_analyzer.sh <log_file> [customerID] [region] [error_code]
```

## Filter by error code only

```bash
./log_analyzer.sh <log_file> "" "" [error_code]
```

## Process entire log without filters

```bash
./log_analyzer.sh sample_logs.txt
```

## View outputs

```bash
cat log_analysis_output/filtered_logs.txt # Lines matching your filters
cat log_analysis_output/report.txt # Summary of matching lines, unique customers, and alerts
```

Sample script to run:

```bash
./log_analyzer.sh sample_logs.txt 1234 us-east-1 E001
```

Sample of the output:

```
Summary Report for sample_logs.txt (see log_analysis_output/filtered_logs.txt for filtered lines)
--------------------------------
Total matching lines:        6

Counts per error code:
   6 E001

Unique customers:
   6 1234
Total unique customers:        1
```

```
2025-12-11T08:00:01 1234 us-east-1 E001 "Failed login attempt"
2025-12-11T08:03:45 1234 us-east-1 E001 "Failed login attempt"
2025-12-11T08:12:42 1234 us-east-1 E001 "Failed login attempt"
2025-12-11T08:25:44 1234 us-east-1 E001 "Failed login attempt"
2025-12-11T08:52:11 1234 us-east-1 E001 "Failed login attempt"
2025-12-11T09:13:45 1234 us-east-1 E001 "Failed login attempt"
```
