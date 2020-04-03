
Thank you for your interest in contributing!

Any contribution is very welcome, including but not limited to:
* cleaning the Bash code, making it more portable across other shells and standard compliant.
* localizing the documentation.
* anything what you think is incorrect or missing here.

Bug report:
* please submit as an issue and provide steps to reproduce.

Coding style:
* please use 2 spaces indentation
* split into reasobly small functions
* use local variables

Code analysis
* use shellcheck to perform static code analysis

Unit testing
* all user facing commands and argument variations have to be unit tested with bats
* each command that has an input prompt, has to have an option to assume default value (e.g. --yes)
