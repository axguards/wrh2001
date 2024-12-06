                                             # Installation Guide

Follow these steps to install and run the WRH Repository script:

## Requirements
- **Operating System**: Linux or macOS (tested on Kali Linux).  
- **Bash**: Ensure `bash` is installed (default in most Linux distros).  
- **Python3**: Required for browser automation.
- **Firefox**: Needed for headless browser tasks.
- **Dependencies**: Install required Python libraries:
  ```bash
  pip3 install selenium

3. INSTALLATION.md

Details on how to install and use the script.

# Installation Guide

Follow these steps to install and run the WRH Repository script:

## Requirements
- **Operating System**: Linux or macOS (tested on Kali Linux).  
- **Bash**: Ensure `bash` is installed (default in most Linux distros).  
- **Python3**: Required for browser automation.
- **Firefox**: Needed for headless browser tasks.
- **Dependencies**: Install required Python libraries:
  ```bash
  pip3 install selenium

    JQ: For processing JSON output:

    sudo apt install jq

Installation Steps

    Clone this repository:

git clone https://github.com/your-username/wrh-repository.git

Navigate to the project directory:

         cd wrh-repository

Make the script executable:

       chmod +x wrh_script.sh

Run the script:

    ./wrh_script.sh

Notes

  To use the browser automation, ensure Geckodriver is installed and in your PATH.
  If running on a virtual machine, allocate at least 2GB of RAM for browser automation tasks.
    
     sudo apt install firefox-geckodriver

    
