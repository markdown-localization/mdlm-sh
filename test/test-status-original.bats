load 'helpers'

setup() {
  setupEnv
  setupExampleOriginal
}

teardown() {
  teardownEnv
}

@test "mdlm status - with single original file" {
  run $mdlm status
  [ $status -eq 0 ]
  [ "${lines[0]}" == 'Localization status for all locales.' ]
  [ $(expr "$output" : ".*README.md.* (English):") -ne 0 ]
  [ "${lines[2]}" == '- No localization.' ]
  [ "${lines[3]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 4 ]
}

@test "mdlm status it - with single original file" {
  run $mdlm status it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ $(expr "$output" : ".*README.md.* (English):") -ne 0 ]
  [ "${lines[2]}" == '- No localization.' ]
  [ "${lines[3]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 4 ]
}
