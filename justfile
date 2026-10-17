# https://cheatography.com/linux-china/cheat-sheets/justfile/

set dotenv-load

# list
default:
	@just --list

# sync using jj
sync:
	jj describe -m "sync $(date +%Y-%m-%d)" && jj new && jj tug && jj git push -r @-
