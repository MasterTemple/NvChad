" Syntax file for .mt files

syntax clear
syntax case match

set filetype=mt
syntax match mtFunction "\v\w+\ze\(" contains=mtFunctionName
syntax match mtFunctionName "\v\w+" contained

highlight link mtFunction Keyword 
highlight link mtFunctionName Function

syntax region mtString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link mtString String
