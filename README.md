# ninja_gaiden

Here is how to update:

Download latest Mac version.
Unzip, replace /Applications love with the new one.

Bump t.version in conf.moon.

Download zipped Windows 32, copy all the files in it to deploy/windows/

cp -rp /Applications/love.app deploy/Ninja.app (only not quite this, copied to wrong dir).
Update plist.

Download iOS sources
Open in XCode love/platform/xcode/love.xcodeproj
