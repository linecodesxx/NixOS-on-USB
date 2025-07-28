# Nix Dev Flake.

## So, what is this?
This is my own flake config to build an "easy-going lightweight nix develop". It has more neccessary applications like. To use for developping, it has installed `python`, `nodejs`, etc.

## Installing

### Windows
Install Nix on Windows from [here](nixos.org/download)

Open the nix.conf from `c:\Users\<user>\AppData\Roaming\nix\nix.conf`

Add the line `experimental-features = nix-command flakes`

Open Powershell
```bash
git clone -b Nix-devShell https://github.com/linecodesxx/NixOS-on-USB.git devshell

cd devshell

nix develop
```