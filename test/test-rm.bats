load 'helpers'

setup() {
  setupEnv
  setupExampleOriginal
}

teardown() {
  teardownEnv
}

@test "mdlm rm - no arguments" {
  run $mdlm rm
  [ $status -eq 1 ]
}

@test "mdlm rm --yes it" {
  $mdlm add --yes it >/dev/null 2>&1
  run $mdlm rm --yes it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Removing localization files for locale - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ $(expr "$output" : "Removing .*README-it.md.*.") -ne 0 ]
  [ "${lines[2]}" == '- Removed.' ]
  [ "${lines[3]}" == 'Localization files removed.' ]
  [ "${#lines[@]}" -eq 4 ]
}

@test "mdlm rm --yes it - no localized files exist" {
  run $mdlm rm --yes it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Removing localization files for locale - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ "${lines[1]}" == 'Localization files removed.' ]
  [ "${#lines[@]}" -eq 2 ]
}

@test "mdlm rm --yes xyz - non existing locale" {
  run $mdlm rm --yes xyz
  [ $status -eq 1 ]
  [ "${lines[0]}" == 'No matching locales found.' ]
  [ "${#lines[@]}" -eq 1 ]
}
@test "mdlm rm it fr es - too many arguments" {
  run $mdlm rm it fr es
  [ $status -eq 1 ]
  [ $(expr "$output" : "Too many arguments provided. Exiting.") -ne 0 ]
  [ "${#lines[@]}" -eq 1 ]
}
