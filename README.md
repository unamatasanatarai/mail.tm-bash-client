# Bail - Mail.tm Bash CLI Client

[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/) [![API](https://img.shields.io/badge/API-Mail.tm-blue.svg)](https://mail.tm/) [![Dependencies](https://img.shields.io/badge/dependencies-curl%20|%20jq-orange.svg)](https://github.com/stedolan/jq) [![OS](https://img.shields.io/badge/OS-Linux%20|%20macOS-blueviolet.svg)]()

![Bail Logo](look-at-me.jpg "Bail: The Bash Command-Line Interface for Mail.tm")

Bail: a high-performance, modular Bash command-line interface for the Mail.tm API. It enables users to quickly provision temporary email accounts, manage authentication tokens, and read messages directly from the terminal.

## Features
- Provision new temporary email accounts with optional custom prefixes and passwords
- Automatically delete the previous account when creating a new one
- Authenticate and manage API tokens via local state caching
- Retrieve and display the first available domain from Mail.tm
- View current account profile data
- List all messages in the inbox
- Read the content of a specific message

## Tech Stack
- Bash
- `curl`
- `jq`

## Project Structure
- `bail`: Main dispatcher script that routes commands to the corresponding components.
- `bail-create`: Provisions a new Mail.tm account and deletes the existing one.
- `bail-delete`: Wipes the current account from the server and local state.
- `bail-domain`: Fetches and displays the first available domain.
- `bail-me`: Shows current account profile data.
- `bail-messages`: Lists all messages in the mailbox.
- `bail-read`: Displays the content of a specific message by index.
- `bail-token`: Generates an API authentication token from local account data.

## Installation Instructions

1. Clone the repository to your local machine.
2. Ensure you have `curl` and `jq` installed on your system.
3. Make all scripts executable:
   ```bash
   chmod +x bail bail-*
   ```

## Usage

Use the `bail` dispatcher to run commands:

```bash
./bail <command> [options]
```

### Examples
- **Create an account:**
  ```bash
  ./bail create myalias -p mypassword
  ```
- **List messages:**
  ```bash
  ./bail messages
  ```
- **Read a message:**
  ```bash
  ./bail read 1
  ```
- **View profile:**
  ```bash
  ./bail me
  ```
- **Delete account:**
  ```bash
  ./bail delete
  ```

## Configuration
The client stores local state (such as account credentials) in the directory specified by `XDG_STATE_HOME`. If this environment variable is not set, it defaults to `$HOME/.config/state/bail`.
