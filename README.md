# Markdown Localization Manager
Minimal reference implenentation based on the [Markdown L10N Specification](https://github.com/markdown-l10n/markdown-l10n-spec)

# Installing and Updating
To install or update mdlm, you should run the install script. To do that, you may either download and run the script manually, or use the following cURL or Wget command:
```sh
curl -o- https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/v0.0.4/install.sh | bash
```
```sh
wget -qO- https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/v0.0.4/install.sh | bash
```
Running either of the above commands downloads a script and runs it. The script copies mdlm script to `~/.mdlm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, or `~/.bashrc`).

```sh
export MDLM_DIR="$HOME/.mdlm"
alias mdlm='$MDLM_DIR/mdlm.sh'
```

# Usage
## List all available locales
```
$ mdlm ls
aa (Afaraf) - Afar
ab (Аҧсуа) - Abkhazian
ae (Avesta) - Avestan
af (Afrikaans) - Afrikaans
ak (Akan) - Akan
am (አማርኛ) - Amharic
an (Aragonés) - Aragonese
ar (العَرَبِيَّة) - Arabic
as (অসমীয়া) - Assamese
av (Авар) - Avaric
...
[List of all supported locales goes here]
...
```

## List a list of locales matching a specific pattern
```
$ mdlm ls uz
uz (Ўзбек) Uzbek
uz-Cyrl (Ўзбек) Uzbek in Cyrillic script
uz-Latn (O‘zbekcha) Uzbek in Latin script
```

## Add a new locale
```
$ mdlm add zh-Hans
Creating new localization files.

Please confirm locale - "zh-Hans (简体中文) simplified Chinese" (yes): 

Localize CONTRIBUTING.md (CONTRIBUTING-zh-Hans.md)? (yes): n
Skipped.

Localize README.md (README-zh-Hans.md)? (yes): 
Created.

Finished
Total files created: 1
```
As a result, new README-zh-Hans.md file will be created. Localization switcher header will be added to original and localized files.

## Remove a locale
```
$ mdlm rm zh-Hans
WARNING: Deleting localization files.

Please confirm locale - "zh-Hans (简体中文) simplified Chinese" (yes): 

List of files to delete:
README-zh-Hans.md

Are you sure want to delete all files? (yes): 
Localization files deleted.

```
As a result, README-zh-Hans.md will be removed. Localization switcher header will be updated, or removed, if no other localizations available.

## Check synchronization status
```
$ mdlm status 
Localization status for all locales.

CONTRIBUTING.md (English):
- No localization

README.md (English):
* README-it.md (it) - synced.
* README-zh-Hans.md (简体中文) - outdated.
```

### Check synchronization status with a diff
```
$ mdlm status --diff
Localization status for all locales.

CONTRIBUTING.md (English):
- No localization

README.md (English):
* README-it.md (it) - synced.

* README-zh-Hans.md (简体中文) - outdated.
65a67,74
> $ mdlm status
> Localization status for all locales.
> 
> CONTRIBUTING.md (English):
> - No localization
> 
> README.md (English):
> * README-zh-Hans.md (简体中文) - synced.
```

# Credits
Special thanks to [nvm-sh/nvm](https://github.com/nvm-sh/nvm) for inpsiration and specifics.