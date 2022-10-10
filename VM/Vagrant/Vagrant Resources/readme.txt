
vagrant ssh error "vagrant@127.0.0.1: Permission denied (publickey,gssapi-keyex,gssapi-with-mic)"

the fix is to force vagrant ssh to use ssh binary from vagrant installation by setting an environment variable

in the CMD shell...

set VAGRANT_PREFER_SYSTEM_BIN=0 - will set it temporarily for this CMD shell

setx VAGRANT_PREFER_SYSTEM_BIN "0" - will set it permanently for all CMD shells (assuming enough permissions)

#####

vagrant ssh error (command just hangs)

can happen when vagrant ssh uses the ssh binary from operating system (problem on windows in particular)

the fix is to force vagrant ssh to use ssh binary from git bash by setting an environment variable

in the GIT BASH shell...

export VAGRANT_PREFER_SYSTEM_BIN=1 - will set it temporarily for this GIT BASH shell

add the export command to your .bash_profile - will set it permanently for all GIT BASH shells