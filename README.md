# Bail

[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A high-performance, modular Bash CLI client for the Mail.tm API. This tool allows users to provision temporary email accounts, manage tokens, and read messages directly from the terminal with minimal dependencies.

## Features

- **Account Management**: Provision new accounts with custom or random prefixes.
- **Authentication**: Stateless token generation and management using local cache.
- **Inbox Interaction**: List and read messages with optimized JSON parsing.
- **Domain Discovery**: Quickly identify available Mail.tm domains.
- **Auto-Cleanup**: Automatically wipes previous accounts when provisioning new ones.

## Tech Stack

- **Core**: Pure Bash (optimized for performance).
- **Network**: `curl` for API interactions.
- **JSON Processing**: `jq` for robust data extraction.
- **Design**: POSIX-aligned modular architecture with a flat execution flow.

## Project Structure

- `bail`: Main dispatcher wrapper for all commands.
- `bail-create`: Provisions new Mail.tm accounts.
- `bail-delete`: Deletes accounts and clears local state.
- `bail-domain`: Fetches and displays available domains.
- `bail-me`: Displays current account profile and quota.
- `bail-messages`: Lists messages in the inbox.
- `bail-read`: Displays the content of specific messages.
- `bail-token`: Manages API authentication tokens.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/unamatasanatarai/mail.tm-bash-api-client.git
   cd mail.tm-bash-api-client
   ```

2. Ensure scripts are executable:
   ```bash
   chmod +x bail*
   ```

3. (Optional) Add to your PATH:
   ```bash
   export PATH="$PATH:$(pwd)"
   ```

## Usage

The project uses a sub-command pattern similar to `git` or `docker`.

```bash
./bail <command> [options]
```

### Common Commands

- **Create an account**: `./bail create [prefix] [-p password]`
- **Check inbox**: `./bail messages`
- **Read a message**: `./bail read <index>`
- **Show token**: `./bail token`
- **Delete account**: `./bail delete`

## Configuration

State is stored locally in the XDG state directory:
- Default: `~/.config/state/bail/account`
- Controlled via `XDG_STATE_HOME`.

## License

This project is licensed under the MIT License.
