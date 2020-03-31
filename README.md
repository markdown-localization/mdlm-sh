# Markdown Localization Manager

Minimal reference implenentation based on the [Markdown L10N Specification](https://github.com/markdown-l10n/markdown-l10n-spec)

# Installing and Updating

To install or update mdlm, you should run the install script. To do that, you may either download and run the script manually, or use the following cURL or Wget command:
```sh
curl -o- https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/v0.0.8/install.sh | bash
```
```sh
wget -qO- https://raw.githubusercontent.com/markdown-l10n/mdlm-sh/v0.0.8/install.sh | bash
```
Running either of the above commands downloads a script and runs it. The script copies mdlm script to `~/.mdlm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, or `~/.bashrc`).

```sh
export MDLM_DIR="$HOME/.mdlm"
alias mdlm='$MDLM_DIR/mdlm.sh'
```

# Usage

## List all supported locales

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
```

## List supported locales matching a specific pattern

```
$ mdlm ls uz
uz (Ўзбек) Uzbek
uz-Cyrl (Ўзбек) Uzbek in Cyrillic script
uz-Latn (O‘zbekcha) Uzbek in Latin script
```

## Add a new locale

```
$ mdlm add eo
Creating new localization files.

Please confirm locale - "eo (Esperanto) Esperanto" (yes): 

Localize example/README.md (example/README-eo.md)? (yes): 
Created.

Localize README.md (README-eo.md)? (yes): n
Skipped.

Finished
Total files created: 1
```

As a result, new README-eo.md file will be created. Localization switcher header will be added to original and localized files.

## Remove a locale

```
$ mdlm rm eo
WARNING: Deleting localization files.

Please confirm locale - "eo (Esperanto) Esperanto" (yes): 

List of files to delete:
example/README-eo.md

Are you sure want to delete all files? (yes): 
Localization files deleted.
```

As a result, README-eo.md will be removed. Localization switcher header will be updated, or removed, if no other localizations available.

## Check synchronization status

```
$ mdlm status
Localization status for all locales.

example/README.md (English):
* example/README-ru.md (Русский) - synced.
* example/README-ar.md (العَرَبِيَّة) - synced.
* example/README-zh-Hans.md (简体中文) - synced.
* example/README-es.md (Español) - outdated.
* example/README-fr.md (Français) - synced.

README.md (English):
* README-ru.md (Русский) - synced.
```

### Check synchronization status with a diff

```
$ mdlm status --diff
Localization status for all locales.

example/README.md (English):
* example/README-ru.md (Русский) - synced.
* example/README-ar.md (العَرَبِيَّة) - synced.
* example/README-zh-Hans.md (简体中文) - synced.
* example/README-es.md (Español) - outdated.
5c4,5
< Here is an outdated text of example.
---
> Here is a text of example.
> 
* example/README-fr.md (Français) - synced.

README.md (English):
* README-ru.md (Русский) - synced.
```

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

# Credits

Special thanks to [nvm-sh/nvm](https://github.com/nvm-sh/nvm) for inpsiration and specifics.