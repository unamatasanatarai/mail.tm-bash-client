# Bail — Mail.tm Bash CLI

[![Bash](https://img.shields.io/badge/language-Bash-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![API](https://img.shields.io/badge/API-Mail.tm-0078D4)](https://mail.tm/)
[![deps](https://img.shields.io/badge/deps-curl%20%7C%20jq-orange)](https://stedolan.github.io/jq/)
[![XDG](https://img.shields.io/badge/XDG-compliant-informational)](https://specifications.freedesktop.org/basedir-spec/latest/)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS-blueviolet)]()
[![version](https://img.shields.io/badge/version-0.6-success)]()
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

![Bail](look-at-me.jpg)

A modular Bash CLI for the [Mail.tm](https://mail.tm/) API. Bail lets you provision and manage temporary email accounts, read messages, and interact with the Mail.tm REST API entirely from the terminal — no browser required.

---

## Features

- **Smart defaults** — `bail` with no arguments opens the inbox; redirects to account creation if none exists
- **Account provisioning** — create a temporary account with optional custom prefix and password
- **Auto-cleanup** — creating a new account silently deletes the existing one first
- **Token management** — generates API bearer tokens from cached local credentials
- **Inbox listing** — lists messages with index, sender, and subject; shows the active address at the top
- **Message reading** — fetches and displays full message content (text or HTML fallback) by index
- **Account deletion** — removes the account from Mail.tm and wipes local state; supports `-y` to skip confirmation
- **Domain query** — prints the first available Mail.tm domain; usable as a sourced library

---

## Requirements

- `bash` 4+
- `curl`
- `jq`

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
bail [command] [options]
```

Calling `bail` with no arguments is equivalent to `bail messages`. If no account exists, it runs `bail new` automatically.

| Command | Description |
|---|---|
| `new [prefix] [-p pw]` | Provision a new account (replaces current) |
| `messages` | List all messages in the mailbox |
| `read <index>` | Display content of a specific message |
| `me` | Show current account profile and quota |
| `token` | Print the current API authentication token |
| `domain` | Display the first available Mail.tm domain |
| `delete [-y]` | Permanently wipe account and local state |

### Examples

```bash
# Create an account with a custom prefix and password
bail new myalias -p s3cr3tpw

# Open inbox (default action)
bail

# Read message #2
bail read 2

# Delete account without confirmation
bail delete -y

# Get help for a specific command
bail help read
```

---

## Project Structure

```
bail            Router — dispatches subcommands, enforces smart defaults
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

## Configuration

Account credentials and state are stored in:

```
${XDG_STATE_HOME:-$HOME/.local/state}/bail/account
```

The file is a JSON object containing `address`, `id`, and `password`. It is created on `bail new` and removed on `bail delete`.

No manual configuration is required.

---

## License

[MIT](LICENSE)
