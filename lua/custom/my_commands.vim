command! -nargs=1 MyCommand :call MyCommandFunction(<args>)
command! -nargs=0 ESV :call ESV_fn()
command! -nargs=0 Test :call Test_fn()
command! -nargs=0 HS :call Print_HS_fn()
command! -nargs=0 Table :call ToTable()

" command! -range=% Claude call ClaudeScript()
command! -nargs=0 NO call s:run_node_script()

command! -nargs=0 WordPrinter call WordPrinterFn()

let g:tmp_file = '/home/dglinuxtemple/Development/nodejs/ai/tmp.txt'
function! WordPrinterFn()
	" clear file
	call writefile([], g:tmp_file)
  " save initial buffer
  let s:initial_buffer = getline(1, '$')

  " run node script in terminal asynchronously
  terminal node "/home/dglinuxtemple/Development/nodejs/ai/for.js"
  " call jobstart(["node", "/home/dglinuxtemple/Development/nodejs/ai/for.js"])
	" call termopen(["node", "/home/dglinuxtemple/Development/nodejs/ai/for.js"])
	" call input("Press Enter after closing terminal")
	" close

  " wait for file.txt to be populated
  while empty(readfile(g:tmp_file))
    sleep 100m
  endwhile

  " read file.txt
  let s:file_contents = readfile(g:tmp_file)

  " go to end of initial buffer
  call cursor(line('$'), 0)  

  " append file contents
  call append(line('$'), s:file_contents)
endfunction

function! WordPrinterFn3()
  " save initial buffer
  let s:initial_buffer = getline(1, '$')
  " run command and display it
  terminal node "/home/dglinuxtemple/Development/nodejs/ai/for.js"
  " wait for node script to finish
  " sleep 1000ms
  " read file.txt
  " let s:file_contents = readfile('/home/dglinuxtemple/Development/nodejs/ai/tmp.txt')
  " go to end of buffer
  " call cursor(line('$'), 0)
  " put file contents at the end 
  " put =s:file_contents
endfunction

function! WordPrinterFn2()
  " save initial buffer
  let s:initial_buffer = getline(1, '$')
  " run command and display it 
  terminal node "/home/dglinuxtemple/Development/nodejs/ai/wordByWord.js"
  " read file.txt
  let s:file_contents = readfile('/home/dglinuxtemple/Development/nodejs/ai/tmp.txt')
  " put file contents at the end of the initial buffer
  call append(line('$'), s:file_contents) 
endfunction

function! WordPrinterFn1()
	" save initial buffer
	" run command and display it
	terminal node "/home/dglinuxtemple/Development/nodejs/ai/wordByWord.js"
	" read file.txt
	" put file contents at the end of the intial buffer
endfunction

function! s:run_node_script() abort
    let l:cmd = 'node ~/Development/nodejs/ai/options.js'
    let l:result = system(l:cmd)

    " Create a new scratch buffer to display the result
    let l:bufnr = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(l:bufnr, 0, -1, v:true, split(l:result, '\n'))

    " Calculate the center of the screen
    let l:center_row = (nvim_win_get_height(0) - len(split(l:result, '\n'))) / 2
    let l:center_col = (nvim_win_get_width(0) - 50) / 2 " Set the width to 50 columns

    " Open a new floating window in the middle of the screen
    let l:win_id = nvim_open_win(l:bufnr, v:true, {
        \ 'relative': 'editor',
        \ 'row': l:center_row,
        \ 'col': l:center_col,
        \ 'width': 50,
        \ 'height': len(split(l:result, '\n')) + 2,
        \ 'border': 'single',
        \ 'style': 'minimal',
        \ })

    " Wait for user input
    call nvim_win_set_option(l:win_id, 'cursorline', v:false)
    let l:input = nvim_get_input('Select an option: ')
    call nvim_win_close(l:win_id, v:true)

    " Save the selected value in a variable
    let g:node_script_output = l:input
endfunction


function! s:runNodeFzf()
  " Open terminal window
  botright new

  " Run node script, pipe to fzf
  let terminal = termopen('node ~/Development/nodejs/ai/options.js | fzf', {'on_exit': function('s:onExit')})
	let bufnum = bufnr(term_getstatus(terminal))  

  " Send keys to terminal buffer
  call term_sendkeys(bufnum, "\<Esc>i")



  " Prevent closing window right away 
  autocmd QuitPre <buffer> ++once autocmd! QUITPRE

  return ''
endfunction

function! s:onExit(job, code)
  " Get selected result 
  let output = join(getbufline(a:job, 1, '$'), "\n")
  let g:result = matchstr(output, 'selected: \zs.\{-}\ze\n')

  " Close window
  close

  " Remove autocmd
  autocmd! QuitPre <buffer> 
endfunction

function! ClaudeScript()
	let options = systemlist('node ~/Development/nodejs/ai/options.js')
	let selected = 'test'
	" setlocal buftype= setline(1, selected)
	" let selected = fzf#run({'source': options})
	
	"let selected = fzf#run({'source': options, 'bufopts': {'buftype': 'nofile'}})

	"let buffer = fzf#run({'source': options})[:1]
	"let selected = getbufline(buffer[0], 1)[0]



	" get appropriate file contents
  let currentLine = getline('.')
	let start = line("'<")
	let end = line("'>")
	let highlighted = getline(start, end)
	let filepath = expand('%:p')
	" save the file
	exe 'w'
	" create input for the script
	let input = join([currentLine, highlighted, filepath, selected], "\n")
	" run the script
  let path = system('node ~/Development/nodejs/ai/test.js', input)
	" open the output file
	exe 'edit ' . trim(path)
endfunction

function! ESV_fn()
    execute 'normal!mv'
		let line = getline('.')
		let output = system('~/Development/python/esv_cli/esv_master "'.line.'"')
		execute 'normal! o	'.output
		execute 'normal! dk`v'
    execute 'normal! `vk'
endfunction

function! Test_fn()
		let line = getline('.')
    let output = system('~/Development/python/esv_cli/esvim '.line)
    execute 'normal! cc'.output
endfunction

function! Print_HS_fn()
    execute 'normal! aHoly Spirit'
endfunction

function! MyCommandFunction(input)
    execute 'normal! O'.input
endfunction

function! ToTable()
    let csv_file = expand('%')
    let table_buffer = bufadd('Table')
    execute 'buffer ' . table_buffer
    execute 'silent! %delete _'
    execute 'silent! r!python -c "import csv, sys; from tabulate import tabulate; table = list(csv.reader(sys.stdin)); print(tabulate(table, tablefmt=\"psql\"))" < ' . csv_file
    setlocal buftype=nofile bufhidden=hide noswapfile nowrap
    execute 'set filetype=table'
    execute 'setlocal nomodifiable'
endfunction


