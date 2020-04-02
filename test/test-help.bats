load 'helpers'

setup() {
  setupEnv
}

teardown() {
  teardownEnv
}

@test "mdlm help" {
  run $mdlm help
  [ $status -eq 0 ]
  [ $(expr "$output" : "Markdown Localization Manager (Bash) [0-9][0-9.]*") -ne 0 ]
  [ "${lines[1]}" == 'Usage:' ]
  [ "${#lines[@]}" -eq 11 ]
}

@test "mdlm help somearg - ignore additional arguments, just print help" {
  run $mdlm help somearg
  [ $status -eq 0 ]
  [ $(expr "$output" : "Markdown Localization Manager (Bash) [0-9][0-9.]*") -ne 0 ]
  [ "${lines[1]}" == 'Usage:' ]
  [ "${#lines[@]}" -eq 11 ]
}