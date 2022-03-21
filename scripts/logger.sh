#!/usr/bin/env bash

log () {
  case $1 in
    info)
      echo -e "\n\e[92m[info]: $2"
      ;;

    warn)
      echo -e "\n\e[93m[warn]: $2"
      ;;

    error)
      echo -e "\n\e[91m[error]: $2"
      ;;

    *)
      echo -e "\n\e[92m[$1]: $2"
  esac
}
