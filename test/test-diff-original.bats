load 'helpers'

setup() {
  setupEnv
  setupExampleOriginal
}

teardown() {
  teardownEnv
}

@test "mdlm diff - with single original file" {
  ls
  run $mdlm diff
  [ $status -eq 0 ]
  [ "${lines[0]}" == 'Localization status for all locales.' ]
  [ "${lines[1]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 2 ]
}

@test "mdlm diff it - with single original file" {
  run $mdlm diff it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ "${lines[1]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 2 ]
}
