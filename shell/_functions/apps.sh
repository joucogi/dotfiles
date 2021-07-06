function export_apps() {
  brew services stop --all
  brew bundle dump --file="${DOTFILES_PATH}/os/mac/Brewfile" --force
  echo 'Brew apps exported!'

  #pip freeze > "$DOTFILES_PATH/langs/python/requirements.txt"
  #echo 'Python apps exported!'

  NPM_APPS="${DOTFILES_PATH}/langs/js/global_modules.txt"
  if [ -f "$NPM_APPS" ]; then
    rm $NPM_APPS
  fi
  ls -1 /usr/local/lib/node_modules | grep -v npm > "$NPM_APPS"
  echo 'NPM apps exported!'
}

function import_apps() {
  brew services stop --all
  brew bundle --file="${DOTFILES_PATH}/os/mac/Brewfile" --force
  echo 'Brew apps imported!'

  #pip install -r "$DOTFILES_PATH/langs/python/requirements.txt"
  #echo 'Python apps imported!'

  xargs -I_ npm install -g "_" < "${DOTFILES_PATH}/langs/js/global_modules.txt"
  echo 'NPM apps imported!'
}