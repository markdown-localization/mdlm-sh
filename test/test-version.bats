load 'helpers'

setup() {
  setupEnv
}

teardown() {
  teardownEnv
}

@test "mdlm version" {
  run $mdlm version
  [ $status -eq 0 ]
  [ $(expr "$output" : "Markdown Localization Manager (Bash) [0-9][0-9.]*") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}

@test "mdlm --version" {
  run $mdlm --version
  [ $status -eq 0 ]
  [ $(expr "$output" : "Markdown Localization Manager (Bash) [0-9][0-9.]*") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}

@test "mdlm version somearg - too many arguments" {
  run $mdlm version somearg
  [ $status -eq 1 ]
  [ $(expr "$output" : "Too many arguments provided. Exiting.") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}
