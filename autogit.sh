#!/bin/bash

### Functions

yorn() {
  while true
  do
    read -r ANSWER

    if [[ $ANSWER == "s" ]] || [[ $ANSWER == "n" ]]
      then
      break
    fi
  done
}

options() {
  echo "1 - pull"
  echo "2 - push"
  echo "3 - commit"
  echo "4 - merge"
  echo "5 - checkout"
  echo "6 - nova branch"
  echo "0 - Sair"
}

ifoption() {
  while true; do
    # echo "## * Opção inválida! Selecione uma das opções abaixo:"
    options
    echo ""
    read -p "Opção: " OPTION

    if [[ $OPTION == "1" ]] || [[ $OPTION == "2" ]] || [[ $OPTION == "3" ]] || [[ $OPTION == "4" ]] || [[ $OPTION == "5" ]] || [[ $OPTION == "6" ]] || [[ $OPTION == "0" ]]
      then
      break
    fi
  done
}

gall() {
  git add --all;
}

gpull() {
  git pull origin $BRANCHWORDS;
}

gpush() {
  git push origin $BRANCHWORDS;
}

gcommit() {
  git add --all;
  git commit -m "$COMMITWORDS";
}

gmerge() {
  git merge $BRANCHWORDS;
}

gcheckout() {
  git checkout $BRANCHWORDS;
}

gnewBranch() {
  git checkout -b $BRANCHWORDS;
}

again() {
  printf "## * Deseja realizar outra ação com Autogit? [s/n]: "
  yorn

  if [[ $ANSWER == "s" ]]; then
    ifoption
    actions
  elif [[ $ANSWER == "n" ]]; then
    finish && exit
  fi
}

actions() {
  if [[ $OPTION == "1" ]]; then
    echo "## * Digite o nome da branch:"
    read BRANCHWORDS
    gpull
    again

  elif [[ $OPTION == "2" ]]; then
    echo "## * Digite o nome da branch:"
    read BRANCHWORDS
    gpush
    again

  elif [[ $OPTION == "3" ]]; then
    echo "## * Digite o comentário do commit:"
    read -e COMMITWORDS
    gcommit
    again

  elif [[ $OPTION == "4" ]]; then
    echo "## * Digite o nome da branch:"
    read BRANCHWORDS
    gmerge
    again

  elif [[ $OPTION == "5" ]]; then
    echo "## * Digite o nome da branch:"
    read BRANCHWORDS
    gcheckout
    again

  elif [[ $OPTION == "6" ]]; then
    echo "## * Digite o nome da branch:"
    read BRANCHWORDS
    gnewBranch
    again

  elif [[ $OPTION == "0" ]]; then
    finish && exit

  fi
}

finish() {
  echo "####### Autogit finalizado! Até mais! #######"
}

### End Functions

echo "Bem vindo ao Autogit! Selecione uma das opções abaixo:"

ifoption
actions
