#!/bin/bash

rm deploy/Ninja.love
rm deploy/NinjaWindows.zip
rm deploy/Ninja.osx.zip

zip -9 -q -r deploy/Ninja.love . -x \.git/\* tests/\* deploy/\* lunatest/\* todo.org 

cat deploy/windows/love.exe deploy/Ninja.love > deploy/Ninja.exe
rm -rf deploy/exe
cp -rp deploy/windows deploy/exe
mv deploy/Ninja.exe deploy/exe/.
rm deploy/exe/love.exe 
zip -9 -q -r deploy/NinjaWindows.zip deploy/exe/

cp deploy/Ninja.love deploy/Ninja.app/Contents/Resources/.
zip -9 -q -r deploy/Ninja.osx.zip deploy/Ninja.app/
