"============================================================================
"File:        elixir.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Richard Ramsden <rramsden at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================
if exists("g:loaded_syntastic_elixir_elixir_checker")
    finish
endif
let g:loaded_syntastic_elixir_elixir_checker=1

" TODO: we should probably split this into separate checkers
function! SyntaxCheckers_elixir_elixir_IsAvailable() dict
    return executable('elixir') && executable('mix')
endfunction

function! SyntaxCheckers_elixir_elixir_GetLocList() dict

    let make_options = {}
    let compile_command = 'elixir'
    let mix_file = syntastic#util#findInParent('mix.exs', expand('%:p:h'))

    if filereadable(mix_file)
        let compile_command = 'mix compile'
        let make_options['cwd'] = fnamemodify(mix_file, ':p:h')
    endif

    let make_options['makeprg'] = self.makeprgBuild({ 'exe': compile_command })

    let make_options['errorformat'] = '** %*[^\ ] %f:%l: %m'

    return SyntasticMake(make_options)
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'elixir',
    \ 'name': 'elixir'})
