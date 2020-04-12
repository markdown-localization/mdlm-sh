![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/markdown-localization/mdlm-sh)
[![lint](https://github.com/markdown-localization/mdlm-sh/workflows/lint/badge.svg)](https://github.com/markdown-localization/mdlm-sh/actions?query=workflow:lint)
[![unit-tests](https://github.com/voitau/mdlm-sh/workflows/unit-tests/badge.svg)](https://github.com/markdown-localization/mdlm-sh/actions?query=workflow:unit-tests)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3814/badge)](https://bestpractices.coreinfrastructure.org/projects/3814)

# Markdown Localization Manager

Minimal reference implenentation of [Markdown Localization Specification](https://github.com/markdown-localization/mdlm-spec)

![mdlm demo](https://raw.githubusercontent.com/markdown-localization/mdlm-sh/assets/mdlm-demo.gif)

# Installing and Updating

To install or update mdlm, you should run the install script. To do that, you may either download and run the script manually, or use the following cURL or Wget command:
```sh
curl -o- https://raw.githubusercontent.com/markdown-localization/mdlm-sh/v0.0.18/install.sh | bash
```
```sh
wget -qO- https://raw.githubusercontent.com/markdown-localization/mdlm-sh/v0.0.18/install.sh | bash
```
Running either of the above commands downloads a script and runs it. The script copies mdlm script to `~/.mdlm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, or `~/.bashrc`).

```sh
export MDLM_DIR="$HOME/.mdlm"
alias mdlm='$MDLM_DIR/mdlm.sh'
```

# Usage

## List all supported locales

```console
$ mdlm search
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

```console
$ mdlm search uz
uz (Ўзбек) Uzbek
uz-Cyrl (Ўзбек) Uzbek in Cyrillic script
uz-Latn (O‘zbekcha) Uzbek in Latin script
```

## Add a new locale

```console
$ mdlm add eo
Creating new localization files for locale - "eo (Esperanto) - Esperanto":
Creating example/README-eo.md. Confirm? [Y/n]
- Created.
Creating README-eo.md. Confirm? [Y/n]
- Created.
Finished. Total files created: 2
```

As a result, new README-eo.md file will be created. Localization switcher header will be added to original and localized files.

## Remove a locale

```console
$ mdlm rm eo --yes
Removing localization files for locale - "eo (Esperanto) - Esperanto":
Removing README-eo.md.
- Removed.
Removing example/README-eo.md.
- Removed.
Localization files removed.
```

As a result, README-eo.md will be removed. Localization switcher header will be updated, or removed, if no other localizations available. Optional `--yes` automatically sets yes to all prompts.

## Check synchronization status

```console
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

## Get synchronization diff

Locale argument is optional.

```console
$ mdlm diff es
Localization status for: es (Español) - Spanish.
- example/README-es.md (Español) - outdated.
5c4,5
< Here is an outdated text of example.
---
> Here is a text of example.
>
```

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

# Credits

Special thanks to [nvm-sh/nvm](https://github.com/nvm-sh/nvm) for inpsiration and specifics.
