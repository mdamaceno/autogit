#!/bin/bash

### Functions

yorn() {
  while true
  do
    echo "Deseja continuar? [s/n]"
    read ANSWER

    if [[ $ANSWER == "s" ]] || [[ $ANSWER == "n" ]]
    then
      break
    fi
  done
}

options() {
  echo "Selecione uma das opções abaixo:"
  echo "1 - merge"
  echo "2 - checkout"
  read OPTION
}

finish() {
  echo "####### Autogit finalizado! Até mais! #######"
}

### End Functions

echo "Bem vindo ao Autogit! Digite o comentário do commit:"

read COMMITWORDS

git add --all;

echo "Estes são os arquivos a serem enviados:"

git status;

yorn

test "$ANSWER" = "n" && finish && exit

echo "Agora, digite o nome da branch:"

read BRANCHWORDS

git commit -m "$COMMITWORDS";

echo "Você pode fazer o push dos arquivos agora."

yorn

if [[ "$ANSWER" = "n" ]]; then

  echo "Você pode continuar mais ações:"

  yorn

  if [[ "$ANSWER" = "s" ]]; then
    
    options

    if [[ "$OPTION" = "1" ]]; then
      echo "Qual o nome da branch que deseja fazer o merge?"
      read BRANCHWORDS
      git merge read $BRANCHWORDS

    elif [[ "$OPTION" = "2" ]]; then
      echo "Qual o nome da branch que deseja acessar?"
      read BRANCHWORDS
      git checkout $BRANCHWORDS

    else
      finish
    fi

  elif [[ "$ANSWER" = "n" ]]; then
    finish
  fi

else
  git push origin $BRANCHWORDS;
fi
