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
    echo
    echo "Opções:"
    echo
    echo "1 - pull"
    echo "2 - push"
    echo "3 - commit"
    echo "4 - merge"
    echo "5 - checkout"
    echo "6 - nova branch"
    echo "7 - status"
    echo "0 - Sair"
}

ifoption() {
  while true; do
    # echo "## * Opção inválida! Selecione uma das opções abaixo:"
    options
    echo ""
    read -p "Opção: " OPTION

    if [[ $OPTION == "1" ]] || [[ $OPTION == "2" ]] || [[ $OPTION == "3" ]] || [[ $OPTION == "4" ]] || 
       [[ $OPTION == "5" ]] || [[ $OPTION == "6" ]] || [[ $OPTION == "7" ]] || [[ $OPTION == "0" ]]
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

gStatus() {
  git status;
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
    echo "## * Digite o nome da branch (default: master): "
    read -r BRANCHWORDS

    if [[ $BRANCHWORDS != "" ]]; then
      gpull
    else
      git pull origin master
    fi

    again

  elif [[ $OPTION == "2" ]]; then
    echo "## * Digite o nome da branch (default: master): "
    read -r BRANCHWORDS

    if [[ $BRANCHWORDS != "" ]]; then
      gpush
    else
      git push origin master
    fi

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

  elif [[ $OPTION == "7" ]]; then
    gStatus
    again

  elif [[ $OPTION == "0" ]]; then
    finish && exit

  fi
}

finish() {
  echo "####### Autogit finalizado! Até mais! #######"
}

help() {
    echo "As opções disponíveis no Autogit são:
    
    (1) pull        --> Atualiza os arquivos
    (2) push        --> Envia alterações do(s) arquivo(s) para o repositório
    (3) commit      --> Registra as mudanças do repositório
    (4) merge       --> Junta duas ou mais ramificações do repositório
    (5) checkout    --> Muda de ramificação
    (6) nova branch --> Criar nova ramificação
    (7) status      --> Verifica se há arquivos alterados
    (0) Sair        --> Sair do Autogit"
    echo
    echo "----------------------------------------------"
    echo "
    autogit -h      --> Mostra este help"
    echo
}

### End Functions

echo "Bem vindo ao Autogit!
$(basename "$0") [-h] -- programa para facilitar a entrada de comandos do Git"

while getopts ':h:help:' option; do
    help
    exit
done

ifoption
actions
