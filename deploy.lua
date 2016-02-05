require 'class'


function cleanLastBuild()
  os.execute("rm deploy/Ninja.love")
  os.execute("rm deploy/NinjaWindows.zip")
  os.execute("rm -rf deploy/exe")
  os.execute("rm deploy/Ninja.osx.zip")
end

function createLoveFile()
  os.execute("zip -9 -q -r deploy/Ninja.love . -x \\.git/\\* tests/\\* deploy/\\* lunatest/\\* todo.org ")
end

function createWindowsExe()
  os.execute("cat deploy/windows/love.exe deploy/Ninja.love > deploy/exe/Ninja.exe")
end

function copyWindowsFilesIntoBuildDir()
  os.execute("cp -rp deploy/windows deploy/exe")
end

function rmWindowsBuildExe()
  os.execute("rm deploy/exe/love.exe")
end

function createBuildZip()
  os.execute("zip -9 -q -r deploy/NinjaWindows.zip deploy/exe/")
end

function buildWindows()
  copyWindowsFilesIntoBuildDir()
  createWindowsExe()
  rmWindowsBuildExe()
  createBuildZip()
end

function buildMac()
  os.execute("cp deploy/Ninja.love deploy/Ninja.app/Contents/Resources/.")
  os.execute("zip -9 -q -r -y deploy/Ninja.osx.zip deploy/Ninja.app/")
end

cleanLastBuild()
createLoveFile()
buildWindows()
buildMac()
