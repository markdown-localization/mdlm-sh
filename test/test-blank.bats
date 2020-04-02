load 'helpers'

setup() {
  setupEnv
}

teardown() {
  teardownEnv
}

@test "mdlm - with no arguments" {
  run $mdlm
  [ $status -eq 0 ]
  [ $(expr "$output" : "Markdown Localization Manager (Bash) [0-9][0-9.]*") -ne 0 ]
  [ "${lines[1]}" == 'Usage:' ]
  [ "${#lines[@]}" -eq 11 ]
}

@test "mdlm somearg - with wrong arguments" {
  run $mdlm somearg
  [ $status -eq 0 ]
  [ "${lines[0]}" == "Unkown command: 'somearg'" ]
  [ "${#lines[@]}" -eq 12 ]
}
