setupEnv() {
  export MDLM_HOME="$(pwd)"
  export MDLM_DIRECTORY="$(mktemp -d)"
  export MDLM_TEST_HOME="$(mktemp -d)"
  cp ./mdlm.sh $MDLM_TEST_HOME
  export mdlm="$MDLM_TEST_HOME/mdlm.sh"
  cd $MDLM_TEST_HOME
}

teardownEnv() {
  rm -rf $MDLM_DIRECTORY
  rm -rf $MDLM_TEST_HOME
}

setupExampleOriginal() {
  cp -R $MDLM_HOME/test/example-original/* $MDLM_TEST_HOME
  export ORIG_FILE="README.md"
  export LCM_FILE_IT="README-it.md"
  export LCM_FILE_FR="README-fr.md"

  export ORIG_FILE_EXP_IT="README.md.en-it.expected"
  export LCM_FILE_IT_EXP_EN_IT="README-it.md.en-it.expected"

  export ORIG_FILE_EXP_IT_FR="README.md.en-it-fr.expected"
  export LCM_FILE_IT_EXP_EN_IT_FR="README-it.md.en-it-fr.expected"
  export LCM_FILE_FR_EXP_EN_IT_FR="README-fr.md.en-it-fr.expected"
}

setupExampleLocalized() {
  cp -R $MDLM_HOME/test/example-localized/* $MDLM_TEST_HOME
}

