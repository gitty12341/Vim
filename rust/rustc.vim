"============================================================================
"File:        rust.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Chad Jablonski <chad.jablonski at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists("g:loaded_syntastic_rust_rustc_checker")
    finish
endif
let g:loaded_syntastic_rust_rustc_checker=1

function! SyntaxCheckers_rust_rustc_IsAvailable()
    return executable("rustc")
endfunction

function! SyntaxCheckers_rust_rustc_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'rustc',
                \ 'args': '--parse-only',
                \ 'subchecker': 'rustc' })

    let errorformat  =
        \ '%E%f:%l:%c: \\d%#:\\d%# %.%\{-}error:%.%\{-} %m,'   .
        \ '%W%f:%l:%c: \\d%#:\\d%# %.%\{-}warning:%.%\{-} %m,' .
        \ '%C%f:%l %m,' .
        \ '%-Z%.%#'

    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'rust',
    \ 'name': 'rustc'})
