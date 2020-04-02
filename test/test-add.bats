load 'helpers'

setup() {
  setupEnv
  setupExampleOriginal
}

teardown() {
  teardownEnv
}

@test "mdlm add - no arguments" {
  run $mdlm add
  [ $status -eq 1 ]
}

@test "mdlm add --yes it" {
  run $mdlm add --yes it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Creating new localization files for locale - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ $(expr "$output" : "Creating .*README-it.md.*.") -ne 0 ]
  [ "${lines[2]}" == '- Created.' ]
  [ "${lines[3]}" == 'Finished. Total files created: 1' ]
  [ "${#lines[@]}" -eq 4 ]

  run diff "${ORIG_FILE}" "${ORIG_FILE_EXP_IT}"
  [ $status -eq 0 ]

  run diff "${LCM_FILE_IT}" "${LCM_FILE_IT_EXP_EN_IT}"
  [ $status -eq 0 ]
}

@test "mdlm add --yes it; mdlm add --yes fr - add to locales " {
  run $mdlm add --yes it
  run $mdlm add --yes fr

  run diff "${ORIG_FILE}" "${ORIG_FILE_EXP_IT_FR}"
  [ $status -eq 0 ]

  run diff "${LCM_FILE_IT}" "${LCM_FILE_IT_EXP_EN_IT_FR}"
  [ $status -eq 0 ]

  run diff "${LCM_FILE_FR}" "${LCM_FILE_FR_EXP_EN_IT_FR}"
  [ $status -eq 0 ]
}


@test "mdlm add --yes xyz - non existing locale" {
  run $mdlm add --yes xyz
  [ $status -eq 1 ]
  [ "${lines[0]}" == 'No matching locales found.' ]
  [ "${#lines[@]}" -eq 1 ]
}

@test "mdlm add it fr es - too many arguments" {
  run $mdlm add it fr es
  [ $status -eq 1 ]
  [ $(expr "$output" : "Too many arguments provided. Exiting.") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}
