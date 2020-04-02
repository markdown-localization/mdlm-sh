load 'helpers'

setup() {
  setupEnv
}

teardown() {
  teardownEnv
}

@test "mdlm status" {
  $mdlm status
  run $mdlm status
  [ $status -eq 0 ]
  [ "${lines[0]}" == 'Localization status for all locales.' ]
  [ "${lines[1]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 2 ]
}

@test "mdlm status it" {
  run $mdlm status it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ "${lines[1]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 2 ]
}

@test "mdlm status it fr es - too many arguments" {
  run $mdlm status it fr es
  [ $status -eq 1 ]
  [ $(expr "$output" : "Too many arguments provided. Exiting.") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}
