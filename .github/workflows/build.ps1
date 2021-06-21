param (
    [Parameter(Mandatory)] $vs,
    [Parameter(Mandatory)] $arch
)

$ErrorActionPreference = "Stop"

if ($arch -eq "x86") {
	$arch = "Win32"
}

$toolsets = @{
	"vc15" = "v141"
	"vs16" = "v142"
}
$toolset = $toolsets.$vs

New-Item "winlibs_build" -ItemType "directory"
Set-Location "winlibs_build"
cmake -G "Visual Studio 16 2019" -T $toolset -A $arch ".."
cmake --build "." --config "Release"
cmake --install "." --config "Release" --prefix "..\winlibs_out"
cmake --build "." --config "Debug"
cmake --install "." --config "Debug" --prefix "..\winlibs_out"
Remove-Item "..\winlibs_out\lib\cmake" -Recurse
