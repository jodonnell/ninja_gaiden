cleanLastBuild = () ->
  os.execute("rm deploy/Ninja.love")
  os.execute("rm deploy/NinjaWindows.zip")
  os.execute("rm -rf deploy/exe")
  os.execute("rm deploy/Ninja.osx.zip")

createLoveFile = () ->
  os.execute("zip -9 -q -r deploy/Ninja.love . -x \\.git/\\* tests/\\* deploy/\\* lunatest/\\* todo.org ")

createWindowsExe = () ->
  os.execute("cat deploy/windows/love.exe deploy/Ninja.love > deploy/exe/Ninja.exe")

copyWindowsFilesIntoBuildDir = () ->
  os.execute("cp -rp deploy/windows deploy/exe")

rmWindowsBuildExe = () ->
  os.execute("rm deploy/exe/love.exe")

createBuildZip = () ->
  os.execute("zip -9 -q -r deploy/NinjaWindows.zip deploy/exe/")

buildWindows = () ->
  copyWindowsFilesIntoBuildDir()
  createWindowsExe()
  rmWindowsBuildExe()
  createBuildZip()

buildMac = () ->
  os.execute("cp deploy/Ninja.love deploy/Ninja.app/Contents/Resources/.")
  os.execute("zip -9 -q -r -y deploy/Ninja.osx.zip deploy/Ninja.app/")

cleanLastBuild()
createLoveFile()
buildWindows()
buildMac()
