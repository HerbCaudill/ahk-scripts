Param( $Org, $Repo )

$gitPath = "c:\git\"
$OrgPath = Join-Path -Path $gitPath -ChildPath "@$Org" # e.g. c:\git\@herbcaudill
$RepoPath = Join-Path -Path $OrgPath -ChildPath $Repo  # e.g. c:\git\@herbcaudill\my-repo

# create the org directory if it doesn't exist
if (!(Test-Path $OrgPath)) { New-Item -Path $gitPath -Name "@$Org" -ItemType "directory" }

# clone the repo if it doesn't exist
if (!(Test-Path $RepoPath)) { 
  New-Item -Path $OrgPath -Name "$Repo" -ItemType "directory" 
  Set-Location $OrgPath

  git clone https://github.com/$Org/$Repo.git
}
# update it if it does
else {
  Set-Location $RepoPath
  git pull
}

Set-Location $RepoPath

# update dependencies
yarn

# open in VS Code
code .