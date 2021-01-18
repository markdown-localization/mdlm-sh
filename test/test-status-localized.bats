load 'helpers'

setup() {
  setupEnv
  setupExampleLocalized
}

teardown() {
  teardownEnv
}

@test "mdlm status - with original and localized files" {
  run $mdlm status
  [ $status -eq 2 ]
  [ "${lines[0]}" == 'Localization status for all locales.' ]
  [ $(expr "$output" : ".*README.md.* (English):") -ne 0 ]
  [ $(expr "$output" : ".*README-ru.md.* (Русский) - .*synced..*") -ne 0 ]
  [ $(expr "$output" : ".*README-ar.md.* (العَرَبِيَّة) - .*synced..*") -ne 0 ]
  [ $(expr "$output" : ".*README-zh-Hans.md.* (简体中文) - .*synced..*") -ne 0 ]
  [ $(expr "$output" : ".*README-es.md.* (Español) - .*outdated..*") -ne 0 ]
  [ $(expr "$output" : ".*README-fr.md.* (Français) - .*synced..*") -ne 0 ]
  [ "${#lines[@]}" -eq 7 ]
}

@test "mdlm status it - with original and localized files, not existing" {
  run $mdlm status it
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*it (Italiano) - Italian.*:") -ne 0 ]
  [ $(expr "$output" : ".*README.md.* (English):") -ne 0 ]
  [ "${lines[2]}" == '- No localization.' ]
  [ "${lines[3]}" == 'No differences.' ]
  [ "${#lines[@]}" -eq 4 ]
}

@test "mdlm status es - with original and localized files, outdated" {
  run $mdlm status es
  [ $status -eq 2 ]
  [ $(expr "$output" : "Localization status for - .*es (Español) - Spanish.*:") -ne 0 ]
  [ $(expr "$output" : ".*README.md.* (English):") -ne 0 ]
  [ $(expr "$output" : ".*README-es.md.* (Español) - .*outdated..*") -ne 0 ]
  [ "${#lines[@]}" -eq 3 ]
}

@test "mdlm status fr - with original and localized files, synchronized" {
  run $mdlm status fr
  [ $status -eq 0 ]
  [ $(expr "$output" : "Localization status for - .*fr (Français) - French.*:") -ne 0 ]
  [ $(expr "$output" : ".*README.md.* (English):") -ne 0 ]
  [ $(expr "$output" : ".*README-fr.md.* (Français) - .*synced..*") -ne 0 ]
  [ "${#lines[@]}" -eq 4 ]
}
