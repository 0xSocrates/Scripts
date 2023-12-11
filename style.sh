#!/bin/bash
Blue='\e[0;34m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
PURPLE='\e[0;35m'
NC='\033[0m' # reset color

print_color() {
    printf "${1}${2}${NC}\n"
}

# Kullanım
# print_color $renk "mesaj"
# örn: 
# print_color $Blue "Bu mesajı mavi renke yaz andından terminal normal renkte devam eder"
