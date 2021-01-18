load 'helpers'

setup() {
  setupEnv
  setupExampleLocalized
}

teardown() {
  teardownEnv
}

@test "mdlm diff - with original and localized files" {
  run $mdlm diff
  [ $status -eq 2 ]
  [ "${lines[0]}" == 'Localization status for all locales.' ]
  [ $(expr "$output" : ".*README-es.md.* (Español) - .*outdated..*") -ne 0 ]
  [ $(expr "$output" : ".*< Here is an outdated text of example..*") -ne 0 ]
  [ $(expr "$output" : ".*> Here is a text of example..*") -ne 0 ]
  [ "${#lines[@]}" -eq 7 ]
}

@test "mdlm diff it - with original and localized files, not existing" {
  run $mdlm diff it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ "${lines[1]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 2 ]
}

@test "mdlm diff es - with original and localized files, outdated" {
  run $mdlm diff es
  [ $status -eq 2 ]
  [ $(expr "$output" : "Localization status for - .*es (Español) - Spanish.*:") -ne 0 ]
  [ $(expr "$output" : ".*README-es.md.* (Español) - .*outdated..*") -ne 0 ]
  [ $(expr "$output" : ".*< Here is an outdated text of example..*") -ne 0 ]
  [ $(expr "$output" : ".*> Here is a text of example..*") -ne 0 ]
  [ "${#lines[@]}" -eq 7 ]
}

@test "mdlm diff fr - with original and localized files, synchronized" {
  run $mdlm diff fr
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*fr (Français) - French.*:") -ne 0 ]
  [ "${lines[1]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 2 ]
}
