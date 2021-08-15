" ========================================
" == Functions ===========================
" ========================================

function! FixFormatting()
  %s/\r\(\n\)/\1/eg
  retab
  %s/\s\+$//e
  nohlsearch
endfunction

function! FormatSmlComments()
  normal ^
  s/(\*/ */g
  normal gv
  s/ \*)//g
  normal A *)
  normal gvo
  normal r(gvo
  nohlsearch
endfunction

function! YankWholeBuffer(to_system_clipboard)
  if a:to_system_clipboard
    normal maggVG"*y`a
  else
    normal maggyG`a
  endif
endfunction

function! MakeMarkdownHeading(level)
  if a:level == 1
    normal! yypVr=k
  elseif a:level == 2
    normal! yypVr-k
  endif
endfunction

function! PromoteToLet()
  normal Ilet(:
  normal f=hi)
  normal f=s{
  normal lxA }
  execute "normal ddma?\\v(let|describe|context|feature)\<cr>p=="

  if getline(line(".") + 1) != ""
    normal o
  end

  normal `a
endfunction

function! ToggleRubyBlockSyntax()
  if match(getline('.'), "do") != -1
    execute "normal! ^/do\<cr>ciw{ "
    execute "normal! lxma"
    execute "normal! jjdd`aJA }"
  else
    execute "normal! ^f{sdo"
    execute "normal! /\|\<cr>nli\<cr>"
    execute "normal! $xxoend"
    execute "normal! kk"
  end
endfunction

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! CorrectSpelling()
  normal ma
  let word_before_correction = expand("<cword>")
  let original_setting = &spell

  set spell
  normal 1z=

  let word_after_correction = expand("<cword>")

  if tolower(word_after_correction) == word_before_correction
    undo
  endif

  normal `a
  let &spell = original_setting
endfunction

function! RunCurrentFile()
  if &filetype == "ruby"
    if InRailsApp()
      call RunCommand("bin/rails\\ runner\\ " . PathToCurrentFile())
    else
      call RunCommand("ruby \"" . PathToCurrentFile() . "\"")
    endif
  elseif &filetype == "sml"
    call RunCommand("rlwrap mosml -P full " . PathToCurrentFile())
  elseif &filetype == "javascript"
    call RunCommand("node " . PathToCurrentFile())
  elseif &filetype == "shell"
    call RunCommand("sh " . PathToCurrentFile())
  elseif &filetype == "python"
    call RunCommand("python " . PathToCurrentFile())
  elseif &filetype == "php"
    call RunCommand("php " . PathToCurrentFile())
  elseif &filetype == "haskell"
    call RunCommand("runhaskell\\ " . PathToCurrentFile())
  elseif &filetype == "sh"
    call RunCommand("sh " . PathToCurrentFile())
  elseif &filetype == "elixir"
    call RunCommand("elixir " . PathToCurrentFile())
  elseif &filetype == "coffee"
    call RunCommand("coffee " . PathToCurrentFile())
  elseif &filetype == "tex"
    call RunCommand("pdflatex\\ " . PathToCurrentFile() . "\\ &&\\ open\\ " . substitute(expand("%"), "\.tex$", ".pdf", ""))
  elseif &filetype == "java"
    call RunCommand("javac *.java && java " . substitute(expand("%"), "\.java$", "", ""))
  elseif &filetype == "c"
    let x = substitute(expand("%"), "\.c$", "", "")
    call RunCommand("gcc -o " . x . " " . PathToCurrentFile() . " && ./" . x)
  else
    echo "Dunno how to run such a file..."
  endif
endfunction

function! RunCommand(cmd)
  exec 'tabe term://' . a:cmd
endfunction

function! PathToCurrentFile()
  return expand('%:p')
endfunction

function! InTmux()
  silent exec '!in_tmux'
  exec "redraw!"

  if v:shell_error
    return 0
  else
    return 1
  endif
endfunction

function! NumberOfTmuxPanes()
  return system('number_of_tmux_panes')
endfunction

function! FilenameIncludes(pattern)
  return match(expand('%:p'), a:pattern) != -1
endfunction

function! ReadFileAsString(path)
  return join(readfile(a:path), "\n")
endfunction

function! InRailsApp(...)
  return filereadable("app/controllers/application_controller.rb")
endfunction

function! UsesDocker(...)
  return filereadable("Dockerfile")
endfunction

function! HasScriptTestFile(...)
  return filereadable("script/test")
endfunction

function! InPhpProject(...)
  return filereadable("composer.json")
endfunction

function! HasGemfile(...)
  return filereadable("Gemfile")
endfunction

function! TestsInRails(filepath)
  return InRailsApp() && (match(ReadFileAsString(a:filepath), 'rails_helper') != -1)
endfunction

function! IncludesRspecGem(filepath)
  return HasGemfile() && match(ReadFileAsString("Gemfile"), 'rspec') != -1
endfunction

function! WithRspecFocusTag(filepath)
  return match(ReadFileAsString(a:filepath), 'focus: true') != -1
endfunction

function! WithCucumberFocusTag(filepath)
  return match(ReadFileAsString(a:filepath), '@focus') != -1
endfunction

function! HasRspecFocusTag(filepath)
  return match(ReadFileAsString(a:filepath), 'focus: true') != -1
endfunction

function! PasteFromSystemClipBoard()
  let os = system("uname")
  if os == "Linux"
    read !xclip -selection clipboard -out
  else
    execute "normal! \<esc>o\<esc>\"+]p"
  end
endfunction

function! RemoveFancyCharacters()
  let typo = {}
  let typo["“"] = '"'
  let typo["”"] = '"'
  let typo["‘"] = "'"
  let typo["’"] = "'"
  let typo["–"] = '--'
  let typo["—"] = '---'
  let typo["…"] = '...'
  :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction

function! MakeList()
  s/^/\=(line('.')-line("'<")+1).'. '"'"))
endfunction

function! SetIndentation(level)
  let &shiftwidth=a:level
  let &softtabstop=a:level
endfunction

function! IndentEntireFile()
  normal! magg=G`a
endfunction

function! CloseExtraPane()
  if &filetype == "gundo"
    execute ":GundoToggle"
  else
    execute ":cclose"
    execute ":pclose"
  end
endfunction

function! JsBindFunction()
  execute "normal! mm$?function\<cr>f{%a.bind(this)\<esc>`m"
endfunction

function! RunCode()
  if &filetype == "javascript"
    execute "normal :w !node\<cr>"
  elseif &filetype == "ruby"
    execute "normal :w !ruby\<cr>"
  endif
endfunction

function! MergeTabs()
 if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  vsplit
  execute "buffer " . bufferName
endfunction

function! GotoDefinitionInSplit(split)
  if a:split
    split
  endif
  execute "tag " . expand("<cword>")
endfunction

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

function! PasteMarkdownLink()
  let link = system("markdown_link_for " . s:get_visual_selection())
  execute "normal! gvs" . link
endfunction

function! ToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction

let g:davidpdrsn_zoomed = 0
function! Zoom()
  if g:davidpdrsn_zoomed
    let g:davidpdrsn_zoomed = 0
    wincmd =
  else
    let g:davidpdrsn_zoomed = 1
    vertical resize 9999
    resize 9999
  end
endfunction

function! CtrlPCurrentDir()
  let pwd = getcwd()
  execute "CtrlP " . pwd
endfunction

function! GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! s:format_imports()
  let text = GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  " delete selection
  normal gvd

  let message = system("/Users/david/dev/minor/format-scala-imports/target/debug/format-scala-imports", text)
  let lines = split(message, "\n")
  call append(lnum1 - 1, lines)

  normal k
endfunction

command! -range FormatImports call s:format_imports()

function! SearchForSelectedWord()
  let word = GetVisualSelection()
  tabedit
  execute "Rg " . word
endfunction

function! ExtractTempToQuery()
  execute "normal! ^ddma?def\<cr>"
  normal %
  execute "normal! o\<cr>def "
  execute "normal! pkJt=xxxi\<cr>\<esc>oend"
  execute "normal! `a"
endfunction

function! CompileLatex()
  let filename = expand('%:p')
  call jobstart("pdflatex " . filename)
endfunction

function! Markoff()
  let filename = expand('%:p')
  call jobstart("open -a Markoff " . filename)
endfunction
command! Markoff :call Markoff()

function! Skim()
  let filename = expand('%:p')
  let filename = substitute(filename, "\.tex$", ".pdf", "")
  call jobstart("open -a Skim " . filename)
endfunction
command! Skim :call Skim()

function! Write()
  set nonumber
  set norelativenumber
  set colorcolumn=999
  set nohlsearch
endfunction
command! Write :call Write()

function! NeomakeStatusLine()
  let acc = []
  let errors = neomake#statusline#LoclistCounts()
  for pair in items(errors)
    let key = pair[0]
    let value = pair[1]
    let str = key . ": " . value
    call add(acc, str)
  endfor
  if len(acc) == 0
    return " | ✔"
  else
    return " | ✖ " . join(acc, ", ") . " ✖ "
  endif
endfunction

function! FuzzyFileFind(path)
  " if filereadable(".git/HEAD")
  "   execute "GFiles --others --cached --exclude-standard " . a:path
  " else
    execute "Files " . a:path
  " endif
endfunction

function! LurmigSet(cmd)
  let full_cmd = "lurmig set \"cargo watch --clear -x \\\"" . a:cmd . "\\\"\""
  execute "silent !" . full_cmd
endfunction

command! -nargs=1 Lur :call LurmigSet("<args>")

" <test-running-functions>
  " Functions used to run tests in a terminal split and automatically closing
  " the split if the tests are green. If they're red, jump forward to the
  " word 'Failure'
  function! TerminalRun(cmd)
    execute "new"
    call termopen(a:cmd, {
          \ 'on_exit': function('TerminalOnExit'),
          \ 'buf': expand('<abuf>')
          \})
    execute "normal i"
  endfunction

  function! TerminalOnExit(job_id, exit_code, event) dict
    if a:exit_code == 0
      execute "bd! " . s:test_buffer_number
      wincmd =
    else
      wincmd =
    endif
  endfunction

  function! TerminalOnTermClose(buf)
    let s:test_buffer_number = a:buf
  endfunction
" </test-running-functions>

function! FifoRun(cmd)
  let pwd = getcwd()
  execute "silent !runner --pwd " . pwd . " --cmd '" . a:cmd . "'"
endfunction

function! TestRun(cmd)
  call FifoRun(a:cmd)
endfunction

function! FormatSql()
  let path = expand('%:p')
  write
  execute "silent !~/bin/format_sql_file \"" . path . "\""
  edit
endfunction

function! RunSqlQuery()
  let path = expand('%:p')
  write
  new
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nowrap
  execute "read !psql " . $TONSSER_PRODUCTION_DATABASE . " -f " . path
  call FixFormatting()
endfunction

function! SmartRun(cmd)
  silent! let output = system('runner --check')

  if output == "Found at least one instance running\n"
    call FifoRun(a:cmd)
  else
    call TerminalRun(a:cmd)
  endif
endfunction

function! Ready(...)
  silent execute "! /Users/david/dotfiles/bin/notify Build ready"
endfunction

function! ImportBuild()
  call lsp#send_request('metals', {
    \ 'method': 'workspace/executeCommand',
    \ 'params': {
    \   'command': 'build-import',
    \ },
    \ 'on_notification': function('Ready'),
    \ })
endfunction
