#!/bin/bash

MDLM_VERSION="0.0.1"

IANA_TAG_DEFAULT="en|English|English"
# http://www.iana.org/assignments/language-subtag-registry/language-subtag-registry
IANA_TAGS_LIST="aa|aa|Afar
ab|ab|Abkhazian
ae|ae|Avestan
af|af|Afrikaans
ak|ak|Akan
am|am|Amharic
an|an|Aragonese
ar|العَرَبِيَّة|Arabic
as|as|Assamese
av|av|Avaric
ay|ay|Aymara
az|az|Azerbaijani
ba|ba|Bashkir
be|be|Belarusian
bg|bg|Bulgarian
bh|bh|Bihari languages
bi|bi|Bislama
bm|bm|Bambara
bn|বাংলা|Bengali
bo|bo|Tibetan
br|br|Breton
bs|bs|Bosnian
ca|ca|Catalan
ce|ce|Chechen
ch|ch|Chamorro
co|co|Corsican
cr|cr|Cree
cs|cs|Czech
cu|cu|Church Slavic
cv|cv|Chuvash
cy|cy|Welsh
da|da|Danish
de|Deutsch|German
dv|dv|Dhivehi
dz|dz|Dzongkha
ee|ee|Ewe
el|el|Modern Greek (1453-)
en|English|English
eo|eo|Esperanto
es|es|Spanish
et|et|Estonian
eu|eu|Basque
fa|fa|Persian
ff|ff|Fulah
fi|fi|Finnish
fj|fj|Fijian
fo|fo|Faroese
fr|fr|French
fy|fy|Western Frisian
ga|ga|Irish
gd|gd|Scottish Gaelic
gl|gl|Galician
gn|gn|Guarani
gu|gu|Gujarati
gv|gv|Manx
ha|ha|Hausa
he|he|Hebrew
hi|hi|Hindi
ho|ho|Hiri Motu
hr|hr|Croatian
ht|ht|Haitian
hu|hu|Hungarian
hy|hy|Armenian
hz|hz|Herero
ia|ia|Interlingua (International Auxiliary Language Association)
id|id|Indonesian
ie|ie|Interlingue
ig|ig|Igbo
ii|ii|Sichuan Yi
ik|ik|Inupiaq
in|in|Indonesian
io|io|Ido
is|is|Icelandic
it|it|Italian
iu|iu|Inuktitut
iw|iw|Hebrew
ja|日本語|Japanese
ji|ji|Yiddish
jv|jv|Javanese
jw|jw|Javanese
ka|ka|Georgian
kg|kg|Kongo
ki|ki|Kikuyu
kj|kj|Kuanyama
kk|kk|Kazakh
kl|kl|Kalaallisut
km|km|Khmer
kn|kn|Kannada
ko|ko|Korean
kr|kr|Kanuri
ks|ks|Kashmiri
ku|ku|Kurdish
kv|kv|Komi
kw|kw|Cornish
ky|ky|Kirghiz
la|la|Latin
lb|lb|Luxembourgish
lg|lg|Ganda
li|li|Limburgan
ln|ln|Lingala
lo|lo|Lao
lt|lt|Lithuanian
lu|lu|Luba-Katanga
lv|lv|Latvian
mg|mg|Malagasy
mh|mh|Marshallese
mi|mi|Maori
mk|mk|Macedonian
ml|ml|Malayalam
mn|mn|Mongolian
mo|mo|Moldavian
mr|mr|Marathi
ms|ms|Malay (macrolanguage)
mt|mt|Maltese
my|my|Burmese
na|na|Nauru
nb|nb|Norwegian Bokmål
nd|nd|North Ndebele
ne|ne|Nepali (macrolanguage)
ng|ng|Ndonga
nl|nl|Dutch
nn|nn|Norwegian Nynorsk
no|no|Norwegian
nr|nr|South Ndebele
nv|nv|Navajo
ny|ny|Nyanja
oc|oc|Occitan (post 1500)
oj|oj|Ojibwa
om|om|Oromo
or|or|Oriya (macrolanguage)
os|os|Ossetian
pa|pa|Panjabi
pi|pi|Pali
pl|pl|Polish
ps|ps|Pushto
pt|pt|Portuguese
qu|qu|Quechua
rm|rm|Romansh
rn|rn|Rundi
ro|ro|Romanian
ru|Русский|Russian
rw|rw|Kinyarwanda
sa|sa|Sanskrit
sc|sc|Sardinian
sd|sd|Sindhi
se|se|Northern Sami
sg|sg|Sango
sh|sh|Serbo-Croatian
si|si|Sinhala
sk|sk|Slovak
sl|sl|Slovenian
sm|sm|Samoan
sn|sn|Shona
so|so|Somali
sq|sq|Albanian
sr|sr|Serbian
ss|ss|Swati
st|st|Southern Sotho
su|su|Sundanese
sv|sv|Swedish
sw|sw|Swahili (macrolanguage)
ta|ta|Tamil
te|te|Telugu
tg|tg|Tajik
th|th|Thai
ti|ti|Tigrinya
tk|tk|Turkmen
tl|tl|Tagalog
tn|tn|Tswana
to|to|Tonga (Tonga Islands)
tr|tr|Turkish
ts|ts|Tsonga
tt|tt|Tatar
tw|tw|Twi
ty|ty|Tahitian
ug|ug|Uighur
uk|uk|Ukrainian
ur|ur|Urdu
uz|uz|Uzbek
ve|ve|Venda
vi|vi|Vietnamese
vo|vo|Volapük
wa|wa|Walloon
wo|wo|Wolof
xh|xh|Xhosa
yi|yi|Yiddish
yo|yo|Yoruba
za|za|Zhuang
zh|zh|Chinese
zu|zu|Zulu
az-Arab|az-Arab|Azerbaijani in Arabic script
az-Cyrl|az-Cyrl|Azerbaijani in Cyrillic script
az-Latn|az-Latn|Azerbaijani in Latin script
be-Latn|be-Latn|Belarusian in Latin script
bs-Cyrl|bs-Cyrl|Bosnian in Cyrillic script
bs-Latn|bs-Latn|Bosnian in Latin script
de-1901|de-1901|German, traditional orthography
de-1996|de-1996|German, orthography of 1996
de-AT-1901|de-AT-1901|German, Austrian variant, traditional orthography
de-AT-1996|de-AT-1996|German, Austrian variant, orthography of 1996
de-CH-1901|de-CH-1901|German, Swiss variant, traditional orthography
de-CH-1996|de-CH-1996|German, Swiss variant, orthography of 1996
de-DE-1901|de-DE-1901|German, German variant, traditional orthography
de-DE-1996|de-DE-1996|German, German variant, orthography of 1996
en-boont|en-boont|Boontling
en-scouse|en-scouse|Scouse
es-419|es-419|Latin American Spanish
iu-Cans|iu-Cans|Inuktitut in Canadian Aboriginal Syllabic script
iu-Latn|iu-Latn|Inuktitut in Latin script
mn-Cyrl|mn-Cyrl|Mongolian in Cyrillic script
mn-Mong|mn-Mong|Mongolian in Mongolian script
sl-nedis|sl-nedis|Natisone dialect, Nadiza dialect
sl-rozaj|sl-rozaj|Resian, Resianic, Rezijan
sr-Cyrl|sr-Cyrl|Serbian in Cyrillic script
sr-Latn|sr-Latn|Serbian in Latin script
tg-Arab|tg-Arab|Tajik in Arabic script
tg-Cyrl|tg-Cyrl|Tajik in Cyrillic script
uz-Cyrl|uz-Cyrl|Uzbek in Cyrillic script
uz-Latn|uz-Latn|Uzbek in Latin script
yi-Latn|yi-Latn|Yiddish, in Latin script
zh-cmn|zh-cmn|Mandarin Chinese
zh-cmn-Hans|zh-cmn-Hans|Mandarin Chinese (Simplified)
zh-cmn-Hant|zh-cmn-Hant|Mandarin Chinese (Traditional)
zh-gan|zh-gan|Kan or Gan
zh-Hans|简体中文|simplified Chinese
zh-Hans-CN|zh-Hans-CN|PRC Mainland Chinese in simplified script
zh-Hans-HK|zh-Hans-HK|Hong Kong Chinese in simplified script
zh-Hans-MO|zh-Hans-MO|Macao Chinese in simplified script
zh-Hans-SG|zh-Hans-SG|Singapore Chinese in simplified script
zh-Hans-TW|繁體中文|Taiwan Chinese in simplified script
zh-Hant|zh-Hant|traditional Chinese
zh-Hant-CN|zh-Hant-CN|PRC Mainland Chinese in traditional script
zh-Hant-HK|zh-Hant-HK|Hong Kong Chinese in traditional script
zh-Hant-MO|zh-Hant-MO|Macao Chinese in traditional script
zh-Hant-SG|zh-Hant-SG|Singapore Chinese in traditional script
zh-Hant-TW|zh-Hant-TW|Taiwan Chinese in traditional script
zh-wuu|zh-wuu|Shanghaiese or Wu
zh-yue|zh-yue|Cantonese"

MDLM_HEADER="<!-- @l10n:h -->"
MDLM_P_OPEN="<!-- @l10n:p"
MDLM_P_CLOSE="@l10n:p -->"

normal=$'\e[0m'
bold=$(tput bold)
green=$(tput setaf 2)
red="$(tput setaf 1)"
yellow=$(tput setaf 3)
blue=$(tput setaf 6)

mdlm_echo() {
  command printf %s\\n "$*" 2>/dev/null
}

mdlm_version() {
  mdlm_echo ${MDLM_VERSION}
}

mdlm_list_locales() {
  local LOCALE_SEARCH="${1}"
  if [ -n "${LOCALE_SEARCH}" ]
  then
    mdlm_echo "${IANA_TAGS_LIST}" | grep -i "${LOCALE_SEARCH}" | awk -F\| '{print $1 " (" $2 ") " $3}'
  else
    mdlm_echo "${IANA_TAGS_LIST}" | awk -F\| '{print $1 " (" $2 ") - " $3}'
  fi
}

validate_locale() {
  local LOCALE="${1}"
  if [ -z "$LOCALE" ]
  then
    mdlm_echo
    mdlm_echo "Please specify locale."
    mdlm_echo "Exiting."
    exit 1
  fi
}

validate_args_count() {
  local MAX_ARGS_COUNT="${1}"
  shift
  if [ $# -gt ${MAX_ARGS_COUNT} ]
  then
    mdlm_echo
    mdlm_echo "Too many arguments provided."
    mdlm_echo "Exiting."
    exit 1
  fi
}

mdlm_add_locale() {
  local NEW_LOCALE="${1}"

  validate_locale $NEW_LOCALE

  local NEW_LOCALE_EXACT="^${NEW_LOCALE}[|]"
  local MATCHING_LOCALE="$(mdlm_list_locales ${NEW_LOCALE_EXACT} | head -n 1)"

  if [ ! -n "${MATCHING_LOCALE}" ]
  then
    mdlm_echo "No matching locales found: ${NEW_LOCALE}"
    exit 1
  fi 

  mdlm_echo "Creating new localization files."
  mdlm_echo

  command echo -n "Please confirm locale - \"${blue}${MATCHING_LOCALE}${normal}\" (yes): "
  read locale_confirmation
  if [ ! -z "$locale_confirmation" ] && [ ! "$locale_confirmation" = "yes" ] && [ ! "$locale_confirmation" = "y" ]
  then
    mdlm_echo
    mdlm_echo "Please choose another locale."
    mdlm_echo "Exiting."
    exit 1
  fi

  # Create localization files.
  local LOCALE_SUFFIX="$(echo ${MATCHING_LOCALE} | awk '{print $1}')"
  local LOCALE_DESCR="$(echo ${MATCHING_LOCALE} | awk '{print $2}' | sed -e 's/[()]//g')"

  local COUNT=0
  local MD_FILES="$(command find * -name "*.md" ! -name "*-[[:alnum:]]*.md" -print | sort)"
  for MD_FILE in ${MD_FILES}
  do
    local MD_FILE_LOCALE=$(echo $MD_FILE | sed -e "s/\./\-${LOCALE_SUFFIX}\./g")

    mdlm_echo
    command echo -n "Localize ${yellow}$MD_FILE${normal} (${yellow}${MD_FILE_LOCALE}${normal})? (yes): "
    read create_confirmation
    if [ ! -z "$create_confirmation" ] && [ ! "$create_confirmation" = "yes" ] && [ ! "$create_confirmation" = "y" ]
    then
      mdlm_echo "Skipped."
    else
      # TODO: if file exists, ask to override or skip.
      HEADER="$(grep "${MDLM_HEADER}" "${MD_FILE}")"
      command echo "${HEADER}" > ${MD_FILE_LOCALE}
      # TODO: replace @l10n hardcode with variable.
      command grep -v "${MDLM_HEADER}" ${MD_FILE} | awk -v RS="(^|\n)#" '{ if ($0) print "<!-- @l10n:p\n#" $0 "@l10n:p -->\nTBD\n"}' >> ${MD_FILE_LOCALE}
      COUNT=$((COUNT+1))
      mdlm_echo "Created."
    fi
  done

  mdlm_update_all_headers

  mdlm_echo
  mdlm_echo "Finished"
  mdlm_echo "Total files created: ${COUNT}"
}

mdlm_update_all_headers() {
  local MD_FILES="$(command find * -name "*.md" ! -name "*-[[:alnum:]]*.md" -print | sort)"
  for MD_FILE in ${MD_FILES}
  do
    MD_FILE_MASK="$(echo ${MD_FILE} | sed -e 's/\.md/\-*\.md/')"
    LOCALES_AVAILABLE="$(find * -wholename "${MD_FILE_MASK}" | sed -e 's/[^-]*-//' -e 's/\.md//')"
    if [ -n "${LOCALES_AVAILABLE}" ]
    then
      # Assemble header.
      DEFAULT_LOCALE_NAME="$(echo ${IANA_TAG_DEFAULT} | awk -F\| '{print $2}')"
      MD_FILE_TRIMMED="$(echo ${MD_FILE} | sed -e 's/.*\///g')"
      NEW_HEADER="[${DEFAULT_LOCALE_NAME}](${MD_FILE_TRIMMED})"
      for NEXT_LOCALE in ${LOCALES_AVAILABLE}
      do
        MD_FILE_LOCALE="$(echo ${MD_FILE_TRIMMED} | sed -e "s/\.md/\-${NEXT_LOCALE}.md/")"
        LOCALE_NAME="$(mdlm_list_locales "^${NEXT_LOCALE}[|]" | head -n 1 | awk '{print $2}' | sed -e 's/[()]//g')"
        NEXT_LOCALE_ENTRY="[${LOCALE_NAME}](${MD_FILE_LOCALE})"
        NEW_HEADER="${NEW_HEADER} | ${NEXT_LOCALE_ENTRY}"
      done

      NEW_HEADER="${NEW_HEADER} | *[Add](\/CONTRIBUTING.md#localization)* ${MDLM_HEADER}"

      # Apply header to all files.
      HEADER_EXISTS="$(grep -c "${MDLM_HEADER}" ${MD_FILE})"

      NEW_HEADER_DEFAULT="$(echo ${NEW_HEADER} | sed -e "s/\([^ ]*\)${MD_FILE_TRIMMED})/**\1${MD_FILE_TRIMMED})**/")"
      if [ ${HEADER_EXISTS} -eq 1 ]
      then
        command sed -i "s/.*${MDLM_HEADER}.*/${NEW_HEADER_DEFAULT}/" ${MD_FILE}
      else
        command sed -i "1 i\\${NEW_HEADER_DEFAULT}" ${MD_FILE}
      fi
      
      # TODO: reuse code for default and others.
      for NEXT_LOCALE in ${LOCALES_AVAILABLE}
      do
        MD_FILE_LOCALE="$(echo ${MD_FILE} | sed -e "s/\.md/\-${NEXT_LOCALE}.md/")"
        MD_FILE_LOCALE_TRIMMED="$(echo ${MD_FILE_LOCALE} | sed -e 's/.*\///g')"
        NEW_HEADER_LOCALE="$(echo ${NEW_HEADER} | sed -e "s/\([^ ]*\)${MD_FILE_LOCALE_TRIMMED})/**\1${MD_FILE_LOCALE_TRIMMED})**/")"
        HEADER_EXISTS="$(grep -c "${MDLM_HEADER}" ${MD_FILE_LOCALE})"
        if [ ${HEADER_EXISTS} -eq 1 ]
        then
          command sed -i "s/.*${MDLM_HEADER}.*/${NEW_HEADER_LOCALE}/" ${MD_FILE_LOCALE}
        else
          command sed -i "1 i\\${NEW_HEADER_LOCALE}" ${MD_FILE_LOCALE}
        fi
      done
      # end of TODO: reuse code for default and others.
    else
      command sed -i "/.*${MDLM_HEADER}.*/d" ${MD_FILE}
    fi
  done
}

mdlm_rm_locale() {
  local RM_LOCALE="${1}"

  validate_locale $RM_LOCALE

  # TODO: resue from add_locale()
  local RM_LOCALE_EXACT="^${RM_LOCALE}"
  local MATCHING_LOCALE="$(mdlm_list_locales ${RM_LOCALE_EXACT} | head -n 1)"

  if [ ! -n "${MATCHING_LOCALE}" ]
  then
    mdlm_echo "No matching locales found: ${RM_LOCALE}"
    exit 1
  fi 

  mdlm_echo "WARNING: Deleting localization files."
  mdlm_echo

  command echo -n "Please confirm locale - \"${blue}${MATCHING_LOCALE}${normal}\" (yes): "
  read locale_confirmation
  if [ ! -z "$locale_confirmation" ] && [ ! "$locale_confirmation" = "yes" ] && [ ! "$locale_confirmation" = "y" ]
  then
    mdlm_echo
    mdlm_echo "Please choose another locale."
    mdlm_echo "Exiting."
    exit 1
  fi

  local LOCALE_SUFFIX="$(echo ${MATCHING_LOCALE} | awk '{print $1}')"
  local LOCALE_DESCR="$(echo ${MATCHING_LOCALE} | awk '{print $2}' | sed -e 's/[()]//g')"
  # end of TODO: resue from add_locale()

  mdlm_echo
  mdlm_echo "List of files to delete:"
  RM_FILES_LIST="$(find * -name "*-${LOCALE_SUFFIX}.md")"
  mdlm_echo ${yellow}"${RM_FILES_LIST}"${normal}

  mdlm_echo
  command echo -n "Are you sure want to delete all files? (yes): "
  read delete_confirmation
  if [ ! -z "$delete_confirmation" ] && [ ! "$delete_confirmation" = "yes" ] && [ ! "$delete_confirmation" = "y" ]
  then
    mdlm_echo
    mdlm_echo "Cancelled."
    mdlm_echo "Exiting."
    exit 1
  fi
  
  command find * -name "*-${LOCALE_SUFFIX}.md" -exec rm '{}' \;

  mdlm_update_all_headers

  mdlm_echo "Localization files deleted."
}

mdlm_status() {
  local SHOW_DIFF="${1}"
  local ST_LOCALE="${2}"

  if [ -n "${ST_LOCALE}" ]
  then
    local MATCHING_LOCALE="$(mdlm_list_locales "^${ST_LOCALE}" | head -n 1)"
    if [ -n "${MATCHING_LOCALE}" ]
    then
      mdlm_echo "Localization status for: ${MATCHING_LOCALE}."
    else
      mdlm_echo "No match locale found: ${ST_LOCALE}. Localization status for all locales."
    fi
  else
    mdlm_echo "Localization status for all locales."
  fi

  local MD_FILES="$(command find * -name "*.md" ! -name "*-[[:alnum:]]*.md" -print | sort)"
  for MD_FILE in ${MD_FILES}
  do
    DEFAULT_LOCALE_NAME="$(echo ${IANA_TAG_DEFAULT} | awk -F\| '{print $2}')"
    mdlm_echo
    mdlm_echo "${yellow}${MD_FILE}${normal} (${DEFAULT_LOCALE_NAME}):"
    MD_FILE_MASK="$(echo ${MD_FILE} | sed -e 's/\.md/\-*\.md/')"
    LOCALES_AVAILABLE="$(find * -wholename "${MD_FILE_MASK}" | sed -e 's/[^-]*-//' -e 's/\.md//' | grep "${ST_LOCALE}")"

    if [ -n "${LOCALES_AVAILABLE}" ]
    then
      for NEXT_LOCALE in ${LOCALES_AVAILABLE}
      do
        MD_FILE_LOCALE="$(echo ${MD_FILE} | sed -e "s/\.md/\-${NEXT_LOCALE}.md/")"
        LOCALE_NAME="$(mdlm_list_locales "^${NEXT_LOCALE}[|]" | head -n 1 | awk '{print $2}' | sed -e 's/[()]//g')"
        
        # TODO: replace l10n hardcode with variable.
        OUTDATED_SECTIONS=$(diff --color -B <(grep -v "@l10n:h" "${MD_FILE_LOCALE}" | sed -e '/@l10n:p -->/,/<!-- @l10n:p/d' -e '/<!-- @l10n:p/d') <(grep -v "${MDLM_HEADER}" "${MD_FILE}") | grep -v -e "[-<>]" | wc -l)
        if [ $OUTDATED_SECTIONS -gt 0 ]
        then
          STATUS="${red}outdated.${normal}"
        else
          STATUS="${green}synced.${normal}"
        fi
        mdlm_echo "* ${yellow}${MD_FILE_LOCALE}${normal} (${LOCALE_NAME}) - ${STATUS}"

        if [ ${SHOW_DIFF} -eq 1 ]
        then
        # TODO: replace l10n hardcode with variable.
          command diff --color -B <(grep -v "@l10n:h" "${MD_FILE_LOCALE}" | sed -e '/@l10n:p -->/,/<!-- @l10n:p/d' -e '/<!-- @l10n:p/d') <(grep -v "${MDLM_HEADER}" "${MD_FILE}")
          mdlm_echo
        fi
      done
    else
      mdlm_echo "- No localization"
    fi
  done
}

mdlm_help() {
  MDLM_VERSION="$(mdlm version)"
  mdlm_echo "Markdown Localization Manager (v${MDLM_VERSION})"
  mdlm_echo "  mdlm help                 Show this message"
  mdlm_echo "  mdlm version              Print out the installed version of mdlm"
  mdlm_echo "  mdlm ls [<pattern>]       List all available locales, matching a given <pattern> if provided"
  mdlm_echo "  mdlm add <locale>         Create localization files for given <locale>"
  mdlm_echo "  mdlm rm <locale>          Remove all localization files for given <locale>"
  mdlm_echo "  mdlm status [<locale>]    Synchronization status between original and localized versions, for a given <locale> if provided"
  mdlm_echo "    --diff                  Shows diff, if available."
}

mdlm() {
  if [ $# -lt 1 ]; then
    mdlm help
    return
  fi

  local COMMAND
  COMMAND="${1-}"
  shift

  case $COMMAND in
    "help" | "--help")
      mdlm_help
    ;;
    "version" | "--version")
      mdlm_version
    ;;
    "ls" | "list")
      validate_args_count 1 $@

      local LOCALE_SEARCH="${1}"
      mdlm_list_locales ${LOCALE_SEARCH}
    ;;
    "add")
      validate_args_count 1 $@

      local NEW_LOCALE="${1}"
      mdlm_add_locale ${NEW_LOCALE}
    ;;
    "rm")
      validate_args_count 1 $@

      local RM_LOCALE="${1}"
      mdlm_rm_locale ${RM_LOCALE}
    ;;
    "status")
      validate_args_count 2 $@

      local SHOW_DIFF=0
      local ST_LOCALE=""
      while [ $# -ne 0 ]
      do
        case "$1" in
          --diff)
            SHOW_DIFF=1
            shift
          ;;
          *)
            ST_LOCALE="$1"
            shift
          ;;
        esac
      done

      mdlm_status ${SHOW_DIFF} ${ST_LOCALE}
    ;;
    *)
      mdlm_echo "Unkown command: '${COMMAND}'"
      mdlm_echo
      mdlm_help
  esac
}

mdlm "$@"
