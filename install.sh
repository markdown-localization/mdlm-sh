#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

MDLM_VERSION="0.0.17"
MDLM_REMOTE_FILE="https://raw.githubusercontent.com/markdown-localization/mdlm-sh/v${MDLM_VERSION}/mdlm.sh"

mdlm_echo() {
  command printf %s\\n "$*" 2>/dev/null
}

mdlm_install_dir() {
  printf %s "${HOME}/.mdlm"
}

mdlm_download() {
  local FROM="${1}"
  local TO="${2}"
  command curl --fail --compressed -q -s "${FROM}" -o "${TO}"
}

mdlm_detect_profile() {
  local DETECTED_PROFILE
  DETECTED_PROFILE=''

  if [ -f "$HOME/.bashrc" ]; then
    DETECTED_PROFILE="$HOME/.bashrc"
  elif [ -f "$HOME/.bash_profile" ]; then
    DETECTED_PROFILE="$HOME/.bash_profile"
  fi

  if [ -n "$DETECTED_PROFILE" ]; then
    echo "$DETECTED_PROFILE"
  fi
}

mdlm_update_profile() {
  local MDLM_PROFILE
  local PROFILE_INSTALL_DIR

  MDLM_PROFILE="$(mdlm_detect_profile)"
  PROFILE_INSTALL_DIR="$(mdlm_install_dir | command sed "s:^$HOME:\$HOME:")"

  SOURCE_STR="\\nexport MDLM_DIR=\"${PROFILE_INSTALL_DIR}\"\\nalias mdlm='\$MDLM_DIR/mdlm.sh'\\n"

  if [ -z "${MDLM_PROFILE-}" ] ; then
    echo "=> Profile not found. Tried ~/.bashrc and ~/.bash_profile."
    echo "=> Create one of them and run this script again"
    echo "   OR"
    echo "=> Append the following lines to the correct file yourself:"
    command printf "${SOURCE_STR}"
    echo
  else
    if ! command grep -qc '/mdlm.sh' "$MDLM_PROFILE"; then
      echo "=> Appending mdlm source string to $MDLM_PROFILE"
      command printf "${SOURCE_STR}" >> "$MDLM_PROFILE"
    else
      echo "=> mdlm source string already in ${MDLM_PROFILE}"
    fi
  fi
}

mdlm_install() {
  mdlm_echo "Installing Markdown localization manager (Bash) ${MDLM_VERSION}"
  local INSTALL_DIR
  
  INSTALL_DIR="$(mdlm_install_dir)"

  mdlm_echo
  command echo -n "Install ${INSTALL_DIR}? (yes): "
  read -r install_confirmation
  if [ -n "$install_confirmation" ] && [ ! "$install_confirmation" = "yes" ] && [ ! "$install_confirmation" = "y" ]
  then
    mdlm_echo "Cancelled."
  fi

  mkdir -p "$INSTALL_DIR"
  if [ -f "$INSTALL_DIR/mdlm.sh" ]; then
    mdlm_echo "=> mdlm is already installed in $INSTALL_DIR, overriding existing script"
  else
    mdlm_echo "=> Downloading mdlm as script to '$INSTALL_DIR'"
  fi

  MDLM_LOCAL_FILE="$INSTALL_DIR/mdlm.sh"
  mdlm_download "$MDLM_REMOTE_FILE" "$MDLM_LOCAL_FILE" || {
    mdlm_echo
    mdlm_echo "Failed to download '$MDLM_LOCAL_FILE'"
    mdlm_echo "Exiting."
    return 1
  }

  chmod a+x "$MDLM_LOCAL_FILE" || {
    mdlm_echo
    mdlm_echo "Failed to make '$MDLM_LOCAL_FILE' executable."
    mdlm_echo "Exiting."
    return 1
  }

  mdlm_update_profile
  mdlm_echo
  mdlm_echo "Installed."
}

mdlm_install

} # this ensures the entire script is downloaded #
