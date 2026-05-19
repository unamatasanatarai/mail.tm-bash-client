# Bail — Mail.tm Bash CLI

[![Bash](https://img.shields.io/badge/language-Bash-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![API](https://img.shields.io/badge/API-Mail.tm-0078D4)](https://mail.tm/)
[![deps](https://img.shields.io/badge/deps-curl%20%7C%20jq%20%7C%20peco-orange)](https://github.com/peco/peco)
[![XDG](https://img.shields.io/badge/XDG-compliant-informational)](https://specifications.freedesktop.org/basedir-spec/latest/)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS-blueviolet)]()
[![version](https://img.shields.io/badge/version-0.6-success)]()
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

![Bail](look-at-me.jpg)

A modular, high-performance Bash CLI for the [Mail.tm](https://mail.tm/) API. Bail lets you provision and manage temporary email accounts, read messages, and interact with the Mail.tm REST API entirely from the terminal — no browser required.

---

## Features

- **Smart defaults** — calling `bail` with no arguments initiates an interactive message picker using `peco`; automatically redirects to account creation if no account is configured.
- **Interactive selection** — seamlessly select and open inbox emails using `peco` with your current email address as the prompt.
- **Quick index shortcut** — read a specific message instantly by calling `bail <index>` (e.g. `bail 1`).
- **Account provisioning** — create a temporary account with an optional custom prefix and password.
- **Auto-cleanup** — provisioning a new account silently deletes the existing one from Mail.tm and local state first.
- **Token management** — generates API bearer tokens from cached local credentials.
- **Inbox listing** — lists messages with index, sender, and subject; shows the active address at the top.
- **Message reading** — fetches and displays full message content (text or HTML fallback) by index.
- **Account deletion** — removes the account from Mail.tm and wipes local state; supports `-y` to skip confirmation.
- **Domain query** — prints the first available Mail.tm domain; usable as a sourced library.

---

## Tech Stack & Requirements

- **Shell**: `bash` 4+
- **HTTP Client**: `curl`
- **JSON Processor**: `jq`
- **Interactive Filter**: `peco`

---

## Project Structure

```text
bail            Router — dispatches subcommands, enforces smart defaults, and initiates peco selector
bail-new        Provisions a new Mail.tm account; auto-deletes the previous one
bail-messages   Lists inbox messages; displays active address as header
bail-read       Fetches and renders a message by numeric index
bail-me         Prints current account profile JSON
bail-token      Generates and caches a bearer token from local credentials
bail-delete     Deletes the account from Mail.tm and removes local state
bail-domain     Fetches the first available domain (also usable via source)
install.sh      One-shot installer to $XDG_BIN_HOME / ~/.local/bin
```

---

## Installation

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/unamatasanatarai/mail.tm-bash-client/master/install.sh | bash
```

The installer downloads all scripts to `${XDG_BIN_HOME:-$HOME/.local/bin}` and marks them executable. If that directory is not on your `$PATH`, it prints the export line to add to your shell profile.

### Manual

```bash
git clone https://github.com/unamatasanatarai/mail.tm-bash-client.git
cd mail.tm-bash-client
chmod +x bail bail-*
```

---

## Usage

```
bail [command|index] [options]
```

Calling `bail` with no arguments is equivalent to running `bail read`, which starts the interactive `peco` selector to pick and read messages. If no account exists, it runs `bail new` automatically.

| Command | Description |
|---|---|
| `new [prefix] [-p pw]` | Provision a new account (replaces current) |
| `messages` | List all messages in the mailbox |
| `read [<index>]` | Display content of a specific message (opens interactive `peco` selector if index is omitted) |
| `domain` | Display the first available domain |
| `token` | Print the current API authentication token |
| `me` | Show current account profile and quota |
| `delete [-y]` | Permanently wipe account and local state |
| `<index>` | Direct numeric shortcut to display a message (e.g. `bail 1`) |

### Examples

```bash
# Interactively list and select a message via peco (default action)
bail

# Directly read message #1 using the shortcut
bail 1

# Directly read message #2 using the read command
bail read 2

# Create an account with a custom prefix and password
bail new myalias -p s3cr3tpw

# List all messages (non-interactive)
bail messages

# Delete account without confirmation
bail delete -y

# Get help for a specific command
bail help read
```

---

## Configuration

Account credentials and state are stored in:

```
${XDG_STATE_HOME:-$HOME/.local/state}/bail/account
```

The file is a JSON object containing `address`, `id`, and `password`. It is created on `bail new` and removed on `bail delete`. No manual configuration is required.

---

## API Documentation

This client integrates with the following Mail.tm REST endpoints:

- **Accounts**: `POST /accounts` (create account), `DELETE /accounts/{id}` (delete account), `GET /me` (fetch profile)
- **Authentication**: `POST /token` (retrieve API key)
- **Domains**: `GET /domains` (fetch available domains)
- **Messages**: `GET /messages` (list inbox), `GET /messages/{id}` (read specific email)

---

## License

[MIT](LICENSE)
