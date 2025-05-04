#!/bin/bash

# Script to get location information from an IP address
# Output format: city, state, country

# Function to display usage information
function display_usage {
  echo "Usage: $0 [IP_ADDRESS]"
  echo "If no IP address is provided, the script will use your current public IP."
}

# Check if help was requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  display_usage
  exit 0
fi

# Determine which IP to use
if [ -z "$1" ]; then
  echo "No IP provided. Getting your current public IP..."
  IP=$(curl -s https://api.ipify.org)
  if [ -z "$IP" ]; then
    echo "Error: Could not determine your public IP address."
    exit 1
  fi
  echo "Your public IP: $IP"
else
  IP="$1"
fi

# Validate IP format (basic validation)
if ! [[ $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Invalid IP address format."
  display_usage
  exit 1
fi

# Use ipapi.co API to get location data
echo "Fetching location data for IP: $IP..."
LOCATION_DATA=$(curl -s "https://ipapi.co/$IP/json/")

# Check if the API request was successful
if [ -z "$LOCATION_DATA" ]; then
  echo "Error: Could not fetch location data."
  exit 1
fi

# Extract the needed fields from the JSON response
CITY=$(echo "$LOCATION_DATA" | grep -o '"city": *"[^"]*"' | cut -d'"' -f4)
REGION=$(echo "$LOCATION_DATA" | grep -o '"region": *"[^"]*"' | cut -d'"' -f4)
COUNTRY=$(echo "$LOCATION_DATA" | grep -o '"country_name": *"[^"]*"' | cut -d'"' -f4)

# Check if we got the location data
if [ -z "$CITY" ] || [ -z "$REGION" ] || [ -z "$COUNTRY" ]; then
  echo "Warning: Could not retrieve complete location information."
  echo "Available data:"
  [ -n "$CITY" ] && echo "City: $CITY"
  [ -n "$REGION" ] && echo "State/Region: $REGION"
  [ -n "$COUNTRY" ] && echo "Country: $COUNTRY"
  exit 1
fi

# Output in the requested format
echo "$CITY, $REGION, $COUNTRY"
