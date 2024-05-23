#!/usr/bin/env sh

# остановить публикацию при ошибках
set -e

# сборка
npm run generate

# переход в каталог сборки
cd .output/public

# если вы деплоите на кастомный домен
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# если вы деплоите на https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git main

# если вы деплоите на https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:Sayadh/solar-credit-calculator.git main:gh-pages

cd -
