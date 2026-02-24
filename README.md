<!-- Zphisher (Fork) -->

<p align="center">
  <img src=".github/misc/logo.png">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-3.0.0-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Fork-Yes-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Education%20Only-Yes-red?style=for-the-badge">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Author-Muhammad%20Taezeem-blue?style=flat-square">
  <img src="https://img.shields.io/badge/Forked%20From-htr--tech%2Fzphisher-purple?style=flat-square">
  <img src="https://img.shields.io/badge/Open%20Source-Yes-darkgreen?style=flat-square">
  <img src="https://img.shields.io/badge/Maintained%3F-Yes-lightblue?style=flat-square">
  <img src="https://img.shields.io/badge/Written%20In-Bash-darkcyan?style=flat-square">
</p>

<p align="center"><b>A beginners friendly, Automated phishing tool with 45+ templates.</b></p>
<p align="center"><i>Forked from <a href="https://github.com/htr-tech/zphisher">htr-tech/zphisher</a> — For educational purposes only.</i></p>

##

<h3><p align="center">Disclaimer</p></h3>

<i>Any actions and or activities related to <b>Zphisher</b> is solely your responsibility. The misuse of this toolkit can result in <b>criminal charges</b> brought against the persons in question. <b>The contributors will not be held responsible</b> in the event any criminal charges be brought against any individuals misusing this toolkit to break the law.

<b>This toolkit contains materials that can be potentially damaging or dangerous for social media</b>. Refer to the laws in your province/country before accessing, using, or in any other way utilizing this in a wrong way.

<b>This Tool is made for EDUCATIONAL PURPOSES ONLY</b>. Do not attempt to violate the law with anything contained here. <b>If this is your intention, then Get the hell out of here</b>!

It only demonstrates "how phishing works". <b>You shall not misuse the information to gain unauthorized access to someones social media</b>. However you may try out this at your own risk.

<b>This is a fork maintained by Muhammad Taezeem strictly for educational and research purposes.</b></i>

##

### Features

- Latest and updated login pages
- **45+ phishing templates** across categorized platforms
- Beginners friendly with improved UI/UX
- **5 tunneling options:**
  - Localhost
  - Cloudflared (Recommended)
  - LocalXpose
  - **Ngrok** *(NEW)*
  - **Serveo** *(NEW - SSH-based, no setup)*
- Mask URL support with multiple URL shorteners
- **CLI argument support** (`--help`, `--version`, `--log`, `--creds`, `--ips`, `--clean`)
- **Session logging** to `zphisher.log`
- **Categorized menu** (Social Media, Entertainment, Gaming, Dev, Communication, Cloud/Finance)
- Expanded port range support (1024-65535)
- Progress indicators and spinner animations
- Better error handling and colored status messages
- Docker support with health checks

### What's New in v3.0.0

| Feature | Description |
|---------|-------------|
| Ngrok Tunnel | Full ngrok v3 integration with auth token support |
| Serveo Tunnel | SSH-based tunneling - no binary download needed |
| 13 New Templates | Disney+, Telegram, WhatsApp, Signal, Coinbase, Shopify, etc. |
| CLI Arguments | `--help`, `--version`, `--log`, `--creds`, `--ips`, `--clean` |
| Session Logging | All events logged to `zphisher.log` |
| Categorized Menu | Platforms grouped by category for easier navigation |
| Modern UI | Box-drawing banners, spinners, progress bars, ✓/✗ indicators |
| Better Bash | Local variables, proper quoting, `command -v`, helper functions |

##

### Installation

- Just, Clone this repository -
  ```
  git clone --depth=1 https://github.com/taezeem14/zphisher.git
  ```

- Now go to cloned directory and run `zphisher.sh` -
  ```
  $ cd zphisher
  $ bash zphisher.sh
  ```

- On first launch, It'll install the dependencies and that's it. ***Zphisher*** is installed.

##

### A Note : 
***Termux discourages hacking*** .. So never discuss anything related to *zphisher* in any of the termux discussion groups. For more check : [wiki](https://wiki.termux.com/wiki/Hacking)

##

### CLI Usage

```
$ bash zphisher.sh --help       # Show help message
$ bash zphisher.sh --version    # Show version
$ bash zphisher.sh --log        # View recent log entries
$ bash zphisher.sh --creds      # View saved credentials
$ bash zphisher.sh --ips        # View saved victim IPs
$ bash zphisher.sh --clean      # Clean all temp files
```

##

<p align="left">
  <a href="https://shell.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/taezeem14/zphisher.git&tutorial=README.md" target="_blank"><img src="https://gstatic.com/cloudssh/images/open-btn.svg"></a>
</p>

##

### Installation via ".deb" file

- Download `.deb` files from the [**Latest Release**](https://github.com/taezeem14/zphisher/releases/latest)
- If you are using ***termux*** then download the `*_termux.deb`

- Install the `.deb` file by executing
  ```
  apt install <your path to deb file>
  ```
  Or
  ```
  $ dpkg -i <your path to deb file>
  $ apt install -f
  ```

##

### Run on Docker

- Docker Image Mirror:
  - **DockerHub** : 
    ```
    docker pull htrtech/zphisher
    ```
  - **GHCR** : 
    ```
    docker pull ghcr.io/htr-tech/zphisher:latest
    ```

- By using the wrapper script [**run-docker.sh**](https://raw.githubusercontent.com/htr-tech/zphisher/master/run-docker.sh)

  ```
  $ curl -LO https://raw.githubusercontent.com/htr-tech/zphisher/master/run-docker.sh
  $ bash run-docker.sh
  ```
- Temporary Container

  ```
  docker run --rm -ti htrtech/zphisher
  ```
  - Remember to mount the `auth` directory.

##

<details>
  <summary><h3>Dependencies</h3></summary>

<b>Zphisher</b> requires following programs to run properly - 
- `git`
- `curl`
- `php`
- `unzip`
- `wget`
- `ssh` *(for Serveo tunnel)*

> All the dependencies will be installed automatically when you run **Zphisher** for the first time.
</details>

<details>
  <summary><h3>Tested on</h3></summary>

- **Ubuntu**
- **Debian**
- **Arch**
- **Manjaro**
- **Fedora**
- **Termux**
</details>

##

<h3 align="center"><i>:: Workflow ::</i></h3>
<p align="center">
<img src=".github/misc/workflow.gif"/>
</p>

##

### Fork Maintainer:
<p align="left">
  <b>Muhammad Taezeem</b><br>
  <a href="https://github.com/taezeem" target="_blank"><img src="https://img.shields.io/badge/Github-blue?style=for-the-badge&logo=github"></a>
</p>

### Original Author:
<p align="left">
  <b>TAHMID RAYAT (htr-tech)</b><br>
  <a href="https://tahmidrayat.is-a.dev" target="_blank"><img src="https://img.shields.io/badge/Socials-grey?style=for-the-badge&logo=linktree"></a>
  <a href="https://github.com/htr-tech" target="_blank"><img src="https://img.shields.io/badge/Github-blue?style=for-the-badge&logo=github"></a>
</p>


### *Thanks to all contributors*:

<table>
  <tr align="center">
    <td><a href="https://github.com/1RaY-1"><img src="https://avatars.githubusercontent.com/u/78962948?s=100" /><br /><sub><b>1RaY-1</b></sub></a></td>
    <td><a href="https://github.com/adi1090x"><img src="https://avatars.githubusercontent.com/u/26059688?s=100" /><br /><sub><b>Aditya Shakya</b></sub></a></td>
    <td><a href="https://github.com/AliMilani"><img src="https://avatars.githubusercontent.com/u/59066012?s=100" /><br /><sub><b>Ali Milani</b></sub></a></td>
    <td><a href="https://github.com/Meht-evaS"><img src="https://avatars.githubusercontent.com/u/57435273?s=100" /><br /><sub><b>AmnesiA</b></sub></a></td>
    <td><a href="https://github.com/KasRoudra"><img src="https://avatars.githubusercontent.com/u/78908440?s=100" /><br /><sub><b>KasRoudra</b></sub></a></td>
   <td><a href="https://github.com/MoisesTapia"><img src="https://avatars.githubusercontent.com/u/28166400?s=100" /><br /><sub><b>Moises Tapia</b></sub></a></td>
  </tr>
  <tr align="center">
   <td><a href="https://github.com/E343IO"><img src="https://avatars.githubusercontent.com/u/74646789?s=100" /><br /><sub><b>Mr.Derek</b></sub></a></td>
    <td><a href="https://github.com/BDhackers009"><img src="https://avatars.githubusercontent.com/u/67186139?s=100" /><br /><sub><b>Mustakim Ahmed</b></sub></a></td>
    <td><a href="https://github.com/sepp0"><img src="https://avatars.githubusercontent.com/u/36642137?s=100" /><br /><sub><b>sepp0</b></sub></a></td>
    <td><a href="https://github.com/TripleHat"><img src="https://avatars.githubusercontent.com/u/68332137?s=100" /><br /><sub><b>TripleHat</b></sub></a></td>
    <td><a href="https://github.com/Yisus7u7"><img src="https://avatars.githubusercontent.com/u/64093255?s=100" /><br /><sub><b>Yisus7u7</b></sub></a></td>
  </tr>
<table>

<!-- // -->

