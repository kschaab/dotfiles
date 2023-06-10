install-module posh-git -scope CurrentUser
winget install JanDeDobbeleer.OhMyPosh -s winget
if (!(get-content $profile | select-string "oh-my-posh init pwsh").matches.success) {
  if (!(test-path -Path $profile)) {
    new-item -itemtype file -path $profile -force
  }
  add-content -path $Profile -value @"
import-module posh-git
oh-my-posh init pwsh --config ~/pwsh10k.omp.json | invoke-expression
"@
}
winget install Neovim.Neovim
