# Markdown Localization Manager

Minimal reference implenentation based on the [Markdown L10N Specification](https://github.com/markdown-l10n/markdown-l10n-spec)

# Installing and Updating

To install or update mdlm, you should run the install script. To do that, you may either download and run the script manually, or use the following cURL or Wget command:
```sh
curl -o- https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/v0.0.5/install.sh | bash
```
```sh
wget -qO- https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/v0.0.5/install.sh | bash
```
Running either of the above commands downloads a script and runs it. The script copies mdlm script to `~/.mdlm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, or `~/.bashrc`).

```sh
export MDLM_DIR="$HOME/.mdlm"
alias mdlm='$MDLM_DIR/mdlm.sh'
```

# Usage

## List all supported locales

![List locales](https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/assets/mdlm-sh-ls.png)

## List supported locales matching a specific pattern

![List locales matching pattern](https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/assets/mdlm-sh-ls-locale.png)

## Add a new locale

![Add a new locale](https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/assets/mdlm-sh-add.png)

As a result, new README-eo.md file will be created. Localization switcher header will be added to original and localized files.

## Remove a locale

![Remove a locale](https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/assets/mdlm-sh-rm.png)

As a result, README-eo.md will be removed. Localization switcher header will be updated, or removed, if no other localizations available.

## Check synchronization status

![Check sync status](https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/assets/mdlm-sh-status.png)

### Check synchronization status with a diff

![Check sync status with diff](https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/assets/mdlm-sh-status-diff.png)

# Credits
Special thanks to [nvm-sh/nvm](https://github.com/nvm-sh/nvm) for inpsiration and specifics.