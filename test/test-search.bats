load 'helpers'

setup() {
  setupEnv
}

teardown() {
  teardownEnv
}

@test "mdlm search - all locales" {
  run $mdlm search
  [ $status -eq 0 ]
  # Total number of support locales is 225.
  [ "${#lines[@]}" -eq 225 ]
}

@test "mdlm search fr - locales with 'fr' tag or description" {
  run $mdlm search fr
  [ $status -eq 0 ]
  [ "${lines[0]}" == 'af (Afrikaans) - Afrikaans' ]
  [ "${lines[1]}" == 'fr (Français) - French' ]
  [ "${lines[2]}" == 'fy (Frysk) - Western Frisian' ]
  [ "${#lines[@]}" -eq 3 ]
}

@test "mdlm search ^fr - locale tags starting with 'fr'" {
  run $mdlm search ^fr
  [ $status -eq 0 ]
  [ "${lines[0]}" == 'fr (Français) - French' ]
  [ "${#lines[@]}" -eq 1 ]
}

@test "mdlm search ru fr it es - too many arguments" {
  run $mdlm search ru fr it es
  [ $status -eq 1 ]
  [ $(expr "$output" : "Too many arguments provided. Exiting.") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}
