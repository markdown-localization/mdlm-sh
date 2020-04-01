#!/bin/bash
###############################################################################
# Naming conventions.
#
# Variables:
# - MDLM_* - configuration variables.
# - LCM_* - abbreviation of 'locale' to avoid confusion with system LC_* vars.
#
# Functions:
# - mdlm_* - custom functions.
MDLM_VERSION="0.0.10"

DEFAULT_LCM_LOCAL="English"

MDLM_HEADER="<!-- @l10n:h -->"
MDLM_P_OPEN="<!-- @l10n:p"
MDLM_P_CLOSE="@l10n:p -->"
MDLM_P_TBD="TBD"
MDLM_IGNORE_START="<!-- @l10n:ignore start -->"
MDLM_IGNORE_END="<!-- @l10n:ignore end -->"

MDLM_ADD_LINK="https://github.com/markdown-localization/markdown-localization-spec#workflow"

normal=$'\e[0m'
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
blue=$(tput setaf 6)

mdlm_echo() {
  command printf %s\\n "$*" 2>/dev/null
}

mdlm_echo_conditional() {
  local CONDITION="${1}"
  shift
  if [ "${CONDITION}" -eq "0" ]; then
    mdlm_echo "$*"
  fi
}

mdlm_validate_args_count() {
  local MIN_COUNT="${1}"
  local MAX_COUNT="${2}"
  local ARGS_COUNT="${3}"

  if [ "${ARGS_COUNT}" -lt "${MIN_COUNT}" ]; then
    mdlm_echo "Not enough arguments provided. Exiting."
    exit 1
  fi

  if [ "${ARGS_COUNT}" -gt "${MAX_COUNT}" ]; then
    mdlm_echo "Too many arguments provided. Exiting."
    exit 1
  fi
}

mdlm_version() {
  mdlm_echo "Markdown Localization Manager - Bash (v${MDLM_VERSION})"
}

mdlm_list_available_locales() {
  local PATTERN="${1}"
  local LCM_LIST
  LCM_LIST="$(list_locales)"

  if [ -n "${PATTERN}" ]; then
    LCM_LIST="$(mdlm_echo "${LCM_LIST}" | grep -i "${PATTERN}")"
  fi

  if [ -n "${LCM_LIST}" ]; then
    mdlm_echo "${LCM_LIST}" | awk -F\| '{print $1 " (" $2 ") - " $3}'
  fi
}

mdlm_find_one_locale() {
  mdlm_list_available_locales "^${1}[|]" | head -n 1
}

mdlm_get_locale_suffix() {
  echo "${1}" | awk '{print $1}'
}

mdlm_get_locale_local_name() {
  echo "${1}" | awk '{print $2}' | sed -e 's/[()]//g'
}

mdlm_validate_locale() {
  local LCM
  LCM="${1}"

  if [ -z "${1}" ]; then
    mdlm_echo "No matching locales found."
    exit 1
  fi

  local LCM_CONFIRM
  command echo -n "Please confirm locale - \"${blue}${LCM}${normal}\" (yes): "
  read -r LCM_CONFIRM

  if [ -n "$LCM_CONFIRM" ] && [ ! "$LCM_CONFIRM" = "yes" ] && [ ! "$LCM_CONFIRM" = "y" ]; then
    mdlm_echo "Please choose another locale. Exiting."
    exit 1
  fi
}

mdlm_find_original_files() {
  command find . -name "*.md" ! -name "*-[[:alnum:]]*.md" -printf '%P\n' | sort
}

mdlm_get_localized_file_name() {
  local ORIG_FILE=${1}
  local LCM_SUFFIX=${2}

  echo "${ORIG_FILE//./-${LCM_SUFFIX}.}"
}

mdlm_copy_original_to_localized_file() {
  local ORIG_FILE=${1}
  local LCM_FILE=${2}
  local HEADER

  HEADER="$(grep "${MDLM_HEADER}" "${ORIG_FILE}")"

  command echo "${HEADER}" > "${LCM_FILE}"
  command grep -v "${MDLM_HEADER}" "${ORIG_FILE}" \
    | sed -e "/$MDLM_IGNORE_START/,/$MDLM_IGNORE_END/d" \
    | awk -v RS="(^|\n)#" -v popen="${MDLM_P_OPEN}" -v pclose="${MDLM_P_CLOSE}" -v ptbd="${MDLM_P_TBD}" \
      '{ if ($0) print popen "\n#" $0 pclose "\n" ptbd "\n"}' >> "${LCM_FILE}"
}

mdlm_add_locale() {
  mdlm_echo "Creating new localization files."
  local LCM
  local LCM_SUFFIX
  local ORIG_FILE
  local LCM_FILE
  local COUNT=0

  LCM="$(mdlm_find_one_locale "${1}")"
  mdlm_validate_locale "${LCM}"
  
  LCM_SUFFIX="$(mdlm_get_locale_suffix "${LCM}")"

  for ORIG_FILE in $(mdlm_find_original_files); do
    LCM_FILE=$(mdlm_get_localized_file_name "${ORIG_FILE}" "${LCM_SUFFIX}")

    command echo -n "Localize ${yellow}${ORIG_FILE}${normal} (${yellow}${LCM_FILE}${normal})? (yes): "
    read -r LCM_FILE_CONFIRM
    if [ -n "${LCM_FILE_CONFIRM}" ] && [ ! "${LCM_FILE_CONFIRM}" = "yes" ] && [ ! "${LCM_FILE_CONFIRM}" = "y" ]; then
      mdlm_echo "- Skipped."
    else
      mdlm_copy_original_to_localized_file "${ORIG_FILE}" "${LCM_FILE}"

      COUNT=$((COUNT+1))
      mdlm_echo "- Created."
    fi
  done

  mdlm_update_all_headers
  mdlm_echo "Finished. Total files created: ${COUNT}"
}

mdlm_rm_locale() {
  mdlm_echo "Removing localization files."
  local LCM
  local LCM_SUFFIX
  local RM_ALL_FILES
  local RM_FILE
  
  LCM="$(mdlm_find_one_locale "${1}")"
  mdlm_validate_locale "${LCM}"

  LCM_SUFFIX="$(mdlm_get_locale_suffix "${LCM}")"
  RM_ALL_FILES="$(find . -name "*-${LCM_SUFFIX}.md" -printf '%P\n')"
  
  for RM_FILE in $RM_ALL_FILES; do
    command echo -n "Delete ${yellow}${RM_FILE}${normal} (yes): "
    read RM_CONFIRM
    if [ -n "$RM_CONFIRM" ] && [ ! "$RM_CONFIRM" = "yes" ] && [ ! "$RM_CONFIRM" = "y" ]
    then
      mdlm_echo "- Skipped."
    else
      command rm "${RM_FILE}"
      mdlm_echo "- Removed."
    fi
  done

  mdlm_update_all_headers
  mdlm_echo "Localization files deleted."
}

mdlm_create_header() {
  local LCM_LIST=${1}
  local ORIG_FILE=${2}

  local ORIG_FILE_NAME
  local NEXT_LCM
  local LCM_LOCAL_NAME
  local LCM_FILE
  local LCM_FILE_NAME
  local HEADER
  
  ORIG_FILE_NAME=${ORIG_FILE//*\//}

  HEADER="[${DEFAULT_LCM_LOCAL}](${ORIG_FILE_NAME})"

  for NEXT_LCM_SUFFIX in ${LCM_LIST}; do
    NEXT_LCM="$(mdlm_find_one_locale "${NEXT_LCM_SUFFIX}")"
    LCM_LOCAL_NAME="$(mdlm_get_locale_local_name "${NEXT_LCM}")"
    LCM_FILE="$(mdlm_get_localized_file_name "${ORIG_FILE}" "${NEXT_LCM_SUFFIX}")"
    LCM_FILE_NAME=${LCM_FILE//*\//}

    HEADER="${HEADER} | [${LCM_LOCAL_NAME}](${LCM_FILE_NAME})"
  done

  echo "${HEADER} | *[Add](${MDLM_ADD_LINK//\//\\\/})* ${MDLM_HEADER}"
}

mdlm_set_selected_header_file() {
  local HEADER=${1}
  local SELECTED_FILE=${2}

  local SELECTED_FILE_NAME
  local NEW_HEADER_DEFAULT
  local HEADER_EXISTS
  
  SELECTED_FILE_NAME=${SELECTED_FILE//*\//}

  # shellcheck disable=SC2001
  NEW_HEADER_DEFAULT="$(echo "${HEADER}" | sed -e "s|\([^ ]*\)${SELECTED_FILE_NAME})|**\1${SELECTED_FILE_NAME})**|g")"
  HEADER_EXISTS="$(grep -c "${MDLM_HEADER}" "${SELECTED_FILE}")"
  if [ "${HEADER_EXISTS}" -eq 1 ]; then
    command sed -i "s/.*${MDLM_HEADER}.*/${NEW_HEADER_DEFAULT}/" "${SELECTED_FILE}"
  else
    command sed -i "1 i\\${NEW_HEADER_DEFAULT}" "${SELECTED_FILE}"
  fi
}

mdlm_update_all_headers() {
  for ORIG_FILE in $(mdlm_find_original_files); do
    local HEADER
    local NEXT_LCM_SUFFIX
    local LCM_FILE
    local LCM_LIST
    
    LCM_LIST="$(mdlm_get_file_localizations "${ORIG_FILE}")"
    if [ -n "${LCM_LIST}" ]; then
      HEADER="$(mdlm_create_header "${LCM_LIST}" "${ORIG_FILE}")"

      mdlm_set_selected_header_file "${HEADER}" "${ORIG_FILE}"
      for NEXT_LCM_SUFFIX in ${LCM_LIST}; do
        LCM_FILE="$(mdlm_get_localized_file_name "${ORIG_FILE}" "${NEXT_LCM_SUFFIX}")"
        mdlm_set_selected_header_file "${HEADER}" "${LCM_FILE}"
      done
    else
      command sed -i "/.*${MDLM_HEADER}.*/d" "${ORIG_FILE}"
    fi
  done
}

mdlm_original_diff() {
  diff --color -B \
    <(grep -v "${MDLM_HEADER}" "${2}" \
      | sed -e "/${MDLM_P_CLOSE}/,/${MDLM_P_OPEN}/d" -e "/${MDLM_P_OPEN}/d" -e "/$MDLM_IGNORE_START/,/$MDLM_IGNORE_END/d") \
    <(grep -v "${MDLM_HEADER}" "${1}" | sed -e "/${MDLM_IGNORE_START}/,/${MDLM_IGNORE_END}/d")
}

mdlm_get_file_localizations() {
  local ORIG_FILE=${1}
  local LCM=${2}
  
  find . -path "./${ORIG_FILE//.md/-*.md}" -printf '%P\n' | sed -e 's/[^-]*-//' -e 's/\.md//' | grep "${LCM}"
}

mdlm_status() {
  local SHOW_DIFF=${1}
  local LCM_PATTERN=${2}
  local LCM

  if [ -n "${LCM_PATTERN}" ]; then
    LCM="$(mdlm_find_one_locale "${LCM_PATTERN}")"
    if [ -n "${LCM}" ]; then
      mdlm_echo "Localization status for: ${LCM}."
    else
      mdlm_echo "No matching locale found. Localization status for all locales."
    fi
  else
    mdlm_echo "Localization status for all locales."
  fi

  local DIFF_COUNT=0
  local ORIG_FILE
  local STATUS
  local LCM_SUFFIX
  local LCM_LIST

  
  for ORIG_FILE in $(mdlm_find_original_files); do
    mdlm_echo_conditional "${SHOW_DIFF}" "${yellow}${ORIG_FILE}${normal} (${DEFAULT_LCM_LOCAL}):"
    LCM_SUFFIX="$(mdlm_get_locale_suffix "${LCM}")"
    LCM_LIST="$(mdlm_get_file_localizations "${ORIG_FILE}" "${LCM_SUFFIX}")"

    if [ -n "${LCM_LIST}" ]; then
      for NEXT_LCM_SUFFIX in ${LCM_LIST}; do
        local NEXT_LCM
        local LCM_LOCAL_NAME
        local LCM_FILE
        local OUTDATED_SECTIONS

        NEXT_LCM="$(mdlm_find_one_locale "${NEXT_LCM_SUFFIX}")"
        LCM_LOCAL_NAME="$(mdlm_get_locale_local_name "${NEXT_LCM}")"
        LCM_FILE="$(mdlm_get_localized_file_name "${ORIG_FILE}" "${NEXT_LCM_SUFFIX}")"
        
        OUTDATED_SECTIONS="$(mdlm_original_diff "${ORIG_FILE}" "${LCM_FILE}" | grep -v -e "[-<>]" -c)"
        if [ "$OUTDATED_SECTIONS" -gt 0 ]; then
          STATUS="${red}outdated.${normal}"
          DIFF_COUNT=$((DIFF_COUNT+1))
        else
          STATUS="${green}synced.${normal}"
        fi

        if [ "${SHOW_DIFF}" -eq 0 ] || [ "$OUTDATED_SECTIONS" -gt 0 ]; then
          mdlm_echo "- ${yellow}${LCM_FILE}${normal} (${LCM_LOCAL_NAME}) - ${STATUS}"
        fi

        if [ "${SHOW_DIFF}" -eq 1 ]; then
          mdlm_original_diff "${ORIG_FILE}" "${LCM_FILE}"
        fi
      done
    else
      mdlm_echo_conditional "$SHOW_DIFF" "- No localization."
    fi
  done

  if [ $DIFF_COUNT -eq 0 ]; then
    mdlm_echo "No differences."
    return 0
  else
    return 2
  fi
}

mdlm_help() {
  mdlm_echo "$(mdlm_version)"
  mdlm_echo "  mdlm help                 Show this message"
  mdlm_echo "  mdlm version              Print out the installed version of mdlm"
  mdlm_echo "  mdlm ls [<pattern>]       List all available locales, matching a given <pattern> if provided"
  mdlm_echo "  mdlm add <locale>         Create localization files for given <locale>"
  mdlm_echo "  mdlm rm <locale>          Remove all localization files for given <locale>"
  mdlm_echo "  mdlm status [<locale>]    Check synchronization status between original and localized versions, for a given <locale> if provided"
  mdlm_echo "  mdlm diff [<locale>]     Show synchronization diff between original and localized versions, for a given <locale> if provided"
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
      mdlm_validate_args_count 0 1 $#
      mdlm_list_available_locales "${1}"
    ;;
    "add")
      mdlm_validate_args_count 1 1 $#
      mdlm_add_locale "${1}"
    ;;
    "rm")
      mdlm_validate_args_count 1 1 $#
      mdlm_rm_locale "${1}"
    ;;
    "status")
      mdlm_validate_args_count 0 1 $#
      mdlm_status 0 "${1}"
    ;;
    "diff")
      mdlm_validate_args_count 0 1 $#
      mdlm_status 1 "${1}"
    ;;
    *)
      mdlm_echo "Unkown command: '${COMMAND}'"
      mdlm_echo
      mdlm_help
  esac
}

list_locales() {
  echo "aa|Afaraf|Afar
        ab|Аҧсуа|Abkhazian
        ae|Avesta|Avestan
        af|Afrikaans|Afrikaans
        ak|Akan|Akan
        am|አማርኛ|Amharic
        an|Aragonés|Aragonese
        ar|العَرَبِيَّة|Arabic
        as|অসমীয়া|Assamese
        av|Авар|Avaric
        ay|Aymar|Aymara
        az|Azərbaycanca|Azerbaijani
        ba|Башҡорт|Bashkir
        be|Беларуская|Belarusian
        bg|Български|Bulgarian
        bh|भोजपुरी|Bihari languages
        bi|Bislama|Bislama
        bm|Bamanankan|Bambara
        bn|বাংলা|Bengali
        bo|བོད་ཡིག|Tibetan
        br|Brezhoneg|Breton
        bs|Bosanski|Bosnian
        ca|Català|Catalan
        ce|Нохчийн|Chechen
        ch|Chamoru|Chamorro
        co|Corsu|Corsican
        cr|Nehiyaw|Cree
        cs|Česky|Czech
        cu|Church Slavic|Church Slavic
        cv|Чăваш|Chuvash
        cy|Cymraeg|Welsh
        da|Dansk|Danish
        de|Deutsch|German
        dv|ދިވެހި|Dhivehi
        dz|རྫོང་ཁ|Dzongkha
        ee|Eʋegbe|Ewe
        el|Ελληνικά|Modern Greek (1453-)
        en|English|English
        eo|Esperanto|Esperanto
        es|Español|Spanish
        et|Eesti|Estonian
        eu|Euskara|Basque
        fa|فارسی|Persian
        ff|Fulfulde|Fulah
        fi|Suomi|Finnish
        fj|Na Vosa Vakaviti|Fijian
        fo|Føroyskt|Faroese
        fr|Français|French
        fy|Frysk|Western Frisian
        ga|Gaeilge|Irish
        gd|Gàidhlig|Scottish Gaelic
        gl|Galego|Galician
        gn|Avañe'ẽ|Guarani
        gu|ગુજરાતી|Gujarati
        gv|Gaelg|Manx
        ha|هَوُسَ|Hausa
        he|עברית|Hebrew
        hi|हिन्दी|Hindi
        ho|Hiri Motu|Hiri Motu
        hr|Hrvatski|Croatian
        ht|Kreyòl ayisyen|Haitian
        hu|Magyar|Hungarian
        hy|Հայերեն|Armenian
        hz|Otjiherero|Herero
        ia|Interlingua|Interlingua (International Auxiliary Language Association)
        id|Bahasa Indonesia|Indonesian
        ie|Interlingue|Interlingue
        ig|Igbo|Igbo
        ii|四川彝语|Sichuan Yi
        ik|Iñupiak|Inupiaq
        in|bahasa Indonesia|Indonesian
        io|Ido|Ido
        is|Íslenska|Icelandic
        it|Italiano|Italian
        iu|ᐃᓄᒃᑎᑐᑦ|Inuktitut
        ja|日本語|Japanese
        ji|Yiddish|Yiddish
        jv|Basa Jawa|Javanese
        ka|ქართული|Georgian
        kg|KiKongo|Kongo
        ki|Gĩkũyũ|Kikuyu
        kj|Kuanyama|Kuanyama
        kk|Қазақша|Kazakh
        kl|Kalaallisut|Kalaallisut
        km|ភាសាខ្មែរ|Khmer
        kn|ಕನ್ನಡ|Kannada
        ko|한국어|Korean
        kr|Kanuri|Kanuri
        ks|कश्मीरी|Kashmiri
        ku|كوردی|Kurdish
        kv|Коми|Komi
        kw|Kernewek|Cornish
        ky|Кыргызча|Kirghiz
        la|Latina|Latin
        lb|Lëtzebuergesch|Luxembourgish
        lg|Luganda|Ganda
        li|Limburgs|Limburgan
        ln|Lingála|Lingala
        lo|ລາວ|Lao
        lt|Lietuvių|Lithuanian
        lu|Luba-Katanga|Luba-Katanga
        lv|Latviešu|Latvian
        mg|Malagasy|Malagasy
        mh|Kajin Majel|Marshallese
        mi|Māori|Maori
        mk|Македонски|Macedonian
        ml|മലയാളം|Malayalam
        mn|Монгол|Mongolian
        mo|Moldovenească|Moldavian
        mr|मराठी|Marathi
        ms|Bahasa Melayu|Malay (macrolanguage)
        mt|bil-Malti|Maltese
        my|Myanmasa|Burmese
        na|Dorerin Naoero|Nauru
        nb|Norwegian Bokmål|Norwegian Bokmål
        nd|Sindebele|North Ndebele
        ne|नेपाली|Nepali (macrolanguage)
        ng|Oshiwambo|Ndonga
        nl|Nederlands|Dutch
        nn|Norsk (nynorsk)|Norwegian Nynorsk
        no|Norsk (bokmål / riksmål)|Norwegian
        nr|isiNdebele|South Ndebele
        nv|Diné bizaad|Navajo
        ny|Chi-Chewa|Nyanja
        oc|Occitan|Occitan (post 1500)
        oj|ᐊᓂᔑᓈᐯᒧᐎᓐ|Ojibwa
        om|Oromoo|Oromo
        or|ଓଡ଼ିଆ|Oriya (macrolanguage)
        os|Иронау|Ossetian
        pa|ਪੰਜਾਬੀ|Panjabi
        pi|Pāli|Pali
        pl|Polski|Polish
        ps|پښتو|Pushto
        pt|Português|Portuguese
        qu|Runa Simi|Quechua
        rm|Rumantsch|Romansh
        rn|Kirundi|Rundi
        ro|Română|Romanian
        ru|Русский|Russian
        rw|Kinyarwandi|Kinyarwanda
        sa|संस्कृतम्|Sanskrit
        sc|Sardu|Sardinian
        sd|सिनधि|Sindhi
        se|Davvisámegiella|Northern Sami
        sg|Sängö|Sango
        sh|Srpskohrvatski|Serbo-Croatian
        si|සිංහල|Sinhala
        sk|Slovenčina|Slovak
        sl|Slovenščina|Slovenian
        sm|Gagana Samoa|Samoan
        sn|chiShona|Shona
        so|Soomaaliga|Somali
        sq|Shqip|Albanian
        sr|Српски|Serbian
        ss|SiSwati|Swati
        st|Sesotho|Southern Sotho
        su|Basa Sunda|Sundanese
        sv|Svenska|Swedish
        sw|Kiswahili|Swahili (macrolanguage)
        ta|தமிழ்|Tamil
        te|తెలుగు|Telugu
        tg|Тоҷикӣ|Tajik
        th|ไทย|Thai
        ti|ትግርኛ|Tigrinya
        tk|Туркмен|Turkmen
        tl|Tagalog|Tagalog
        tn|Setswana|Tswana
        to|Lea Faka-Tonga|Tonga (Tonga Islands)
        tr|Türkçe|Turkish
        ts|Xitsonga|Tsonga
        tt|Tatarça|Tatar
        tw|Twi|Twi
        ty|Reo Mā\`ohi|Tahitian
        ug|Uyƣurqə|Uighur
        uk|Українська|Ukrainian
        ur|اردو|Urdu
        uz|Ўзбек|Uzbek
        ve|Tshivenḓa|Venda
        vi|Việtnam|Vietnamese
        vo|Volapük|Volapük
        wa|Walon|Walloon
        wo|Wollof|Wolof
        xh|isiXhosa|Xhosa
        yi|ייִדיש|Yiddish
        yo|Yorùbá|Yoruba
        za|Cuengh|Zhuang
        zh|简体中文|Chinese
        zu|isiZulu|Zulu
        az-Arab|آذربايجان|Azerbaijani in Arabic script
        az-Cyrl|Aзәрбајҹан дили|Azerbaijani in Cyrillic script
        az-Latn|Azərbaycanca|Azerbaijani in Latin script
        be-Latn|Biełaruskaja|Belarusian in Latin script
        bs-Cyrl|Босански|Bosnian in Cyrillic script
        bs-Latn|Иosanski|Bosnian in Latin script
        iu-Cans|ᐃᓄᒃᑎᑐᑦ|Inuktitut in Canadian Aboriginal Syllabic script
        iu-Latn|Inuktitut|Inuktitut in Latin script
        mn-Cyrl|Монгол|Mongolian in Cyrillic script
        mn-Mong|Mongɣol|Mongolian in Mongolian script
        sl-nedis|Nadiza dialect of Slovenian|Natisone dialect, Nadiza dialect
        sl-rozaj|Rezijan dialect of Slovenian|Resian, Resianic, Rezijan
        sr-Cyrl|Српски|Serbian in Cyrillic script
        sr-Latn|Srpski|Serbian in Latin script
        tg-Arab|تاجیکی|Tajik in Arabic script
        tg-Cyrl|Тоҷикӣ|Tajik in Cyrillic script
        uz-Cyrl|Ўзбек|Uzbek in Cyrillic script
        uz-Latn|O‘zbekcha|Uzbek in Latin script
        yi-Latn|Yidish|Yiddish, in Latin script
        zh-cmn|官话|Mandarin Chinese
        zh-cmn-Hans|官话|Mandarin Chinese (Simplified)
        zh-cmn-Hant|官話|Mandarin Chinese (Traditional)
        zh-gan|贛語|Kan or Gan
        zh-Hans|简体中文|simplified Chinese
        zh-Hans-CN|zh-Hans-CN|PRC Mainland Chinese in simplified script
        zh-Hans-HK|zh-Hans-HK|Hong Kong Chinese in simplified script
        zh-Hans-MO|zh-Hans-MO|Macao Chinese in simplified script
        zh-Hans-SG|zh-Hans-SG|Singapore Chinese in simplified script
        zh-Hans-TW|繁體中文|Taiwan Chinese in simplified script
        zh-Hant|漢語|traditional Chinese
        zh-Hant-CN|zh-Hant-CN|PRC Mainland Chinese in traditional script
        zh-Hant-HK|zh-Hant-HK|Hong Kong Chinese in traditional script
        zh-Hant-MO|zh-Hant-MO|Macao Chinese in traditional script
        zh-Hant-SG|zh-Hant-SG|Singapore Chinese in traditional script
        zh-Hant-TW|zh-Hant-TW|Taiwan Chinese in traditional script
        zh-wuu|zh-wuu|Shanghaiese or Wu
        zh-yue|粵語|Cantonese" | sed -e 's/^[\ ]*//g'
}

mdlm "$@"