#!/bin/bash

echo "Welcome to the first WRH Repository!"
echo "Strictly for educational purposes only."
echo
echo "Choose an option:"
echo "1. IP Reconnaissance"
echo "2. Username Reconnaissance (with Subdomain, Browser, and Automation Integration)"
echo "3. Subdomain Enumeration (Standalone)"
echo "4. Detect Installed Browsers (Standalone)"
echo "5. Automate Browser Task (Standalone)"
read -p "Enter your choice: " choice

read -p "Specify output directory (default: ./results): " output_dir
output_dir=${output_dir:-./results}
mkdir -p "$output_dir"

if [ "$choice" -eq 1 ]; then
    # IP Reconnaissance
    read -p "Enter target IP: " ip
    echo "Performing IP reconnaissance for $ip..."
    curl -s "https://ipinfo.io/$ip" > "$output_dir/ip_recon_output.txt"
    echo "Results saved in $output_dir/ip_recon_output.txt"
    cat "$output_dir/ip_recon_output.txt"

elif [ "$choice" -eq 2 ]; then
    # Username Reconnaissance + Subdomain + Browser Detection + Automation
    read -p "Enter username: " username
    echo "Searching for username '$username' on social media platforms..."
    social_output="$output_dir/social_recon_output.txt"
    echo -e "Facebook: https://www.facebook.com/$username\nInstagram: https://www.instagram.com/$username\nTwitter: https://twitter.com/$username" > "$social_output"
    echo "Social media results saved to $social_output."

    # Subdomain Enumeration
    read -p "Do you have a domain associated with this username? (e.g., example.com) [y/n]: " has_domain
    if [ "$has_domain" == "y" ]; then
        read -p "Enter domain: " domain
        echo "Finding subdomains for $domain..."
        curl -s "https://crt.sh/?q=%25.$domain&output=json" | jq -r '.[].name_value' | sort -u > "$output_dir/subdomain_output.txt"
        echo "Subdomains found (saved in $output_dir/subdomain_output.txt):"
        cat "$output_dir/subdomain_output.txt"
    else
        echo "Skipping subdomain enumeration as no domain was provided."
    fi

    # Browser Detection
    echo "Detecting installed browsers..."
    browsers=("firefox" "google-chrome" "microsoft-edge" "opera")
    detected=()
    for browser in "${browsers[@]}"; do
        if command -v $browser > /dev/null; then
            detected+=("$browser")
        fi
    done
    if [ ${#detected[@]} -eq 0 ]; then
        echo "No compatible browsers detected."
    else
        echo "Detected Browsers: ${detected[*]}"
    fi

    # Browser Automation
    echo "Automating browser to visit one of the username's social media profiles..."
    read -p "Which URL should be automated (e.g., Facebook, Instagram, Twitter)? Enter URL: " url
    echo "Launching Firefox to visit $url..."
    python3 - <<END
from selenium import webdriver
import time
try:
    options = webdriver.FirefoxOptions()
    options.add_argument('--headless')  # Headless mode for stealth
    driver = webdriver.Firefox(options=options)  # Ensure Geckodriver is installed and in PATH
    driver.get("$url")
    time.sleep(5)
    print(f"Page Title: {driver.title}")
    screenshot_path = "$output_dir/browser_task_screenshot.png"
    driver.save_screenshot(screenshot_path)
    print(f"Screenshot saved at: {screenshot_path}")
    driver.quit()
except Exception as e:
    print(f"Error occurred: {e}")
END
    echo "Browser automation completed. Screenshot saved."

elif [ "$choice" -eq 3 ]; then
    # Subdomain Enumeration (Standalone)
    read -p "Enter domain: " domain
    echo "Finding subdomains for $domain..."
    curl -s "https://crt.sh/?q=%25.$domain&output=json" | jq -r '.[].name_value' | sort -u > "$output_dir/subdomain_output.txt"
    echo "Subdomains found (saved in $output_dir/subdomain_output.txt):"
    cat "$output_dir/subdomain_output.txt"

elif [ "$choice" -eq 4 ]; then
    # Browser Detection (Standalone)
    echo "Detecting installed browsers..."
    browsers=("firefox" "google-chrome" "microsoft-edge" "opera")
    detected=()
    for browser in "${browsers[@]}"; do
        if command -v $browser > /dev/null; then
            detected+=("$browser")
        fi
    done
    if [ ${#detected[@]} -eq 0 ]; then
        echo "No compatible browsers detected."
    else
        echo "Detected Browsers: ${detected[*]}"
    fi

elif [ "$choice" -eq 5 ]; then
    # Browser Automation (Standalone)
    read -p "Enter the URL to visit: " url
    echo "Launching browser to visit $url..."
    python3 - <<END
from selenium import webdriver
import time
try:
    options = webdriver.FirefoxOptions()
    options.add_argument('--headless')
    driver = webdriver.Firefox(options=options)
    driver.get("$url")
    time.sleep(5)
    print(f"Page Title: {driver.title}")
    screenshot_path = "$output_dir/browser_task_screenshot.png"
    driver.save_screenshot(screenshot_path)
    print(f"Screenshot saved at: {screenshot_path}")
    driver.quit()
except Exception as e:
    print(f"Error occurred: {e}")
END

else
    echo "Invalid choice. Exiting..."
fi
