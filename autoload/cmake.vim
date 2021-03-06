" Author: Jeff Caffrey-Hill <https://jeff.caffreyhill.com/>

if exists("g:autoloaded_cmake")
  finish
endif

let g:autoloaded_cmake = 1

if !exists("g:default_cmake_build_dir")
	let g:default_cmake_build_dir = "build"
endif

if !exists("g:ctest_args")
  let g:ctest_args = ""
endif

if !exists("g:cmake_args")
  let g:cmake_args = ""
endif

function! cmake#is_cmake() abort
   if exists("b:is_cmake")
      return b:is_cmake
   endif

   let cmakelists = globpath(".", "CMakeLists.txt", 0, 1)
   let b:is_cmake = len(cmakelists) > 0
   return b:is_cmake
endfunction

function! cmake#find_build_dir() abort
  
  " Check for in place build
  let build_dir = globpath(".", "CMakeCache.txt", 0, 1)
  if len(build_dir) == 1
     return fnamemodify(build_dir[0], ":p:h")
  endif
  
  " Check for out of place builds
  let build_dir = globpath("./**", "CMakeCache.txt", 0, 1)
  if len(build_dir) == 1
     return fnamemodify(build_dir[0], ":p:h")
  endif
endfunction

function! cmake#setup() abort
  if exists("g:loaded_rooter")
    Rooter
  endif
  if cmake#is_cmake()
    if !exists("b:cmake_build_dir")
    	let b:cmake_build_dir = cmake#find_build_dir()
		if !b:cmake_build_dir
			let b:cmake_build_dir = g:default_cmake_build_dir
		endif
    endif
    let &makeprg='cmake --build '.b:cmake_build_dir.' --'
  endif
endfunction

function! cmake#configure(...) abort
  if cmake#is_cmake()
    call cmake#setup()
    if !exists("b:cmake_build_dir")
       let b:cmake_build_dir = g:default_cmake_build_dir
    endif
    let cmake_command = "!cmake ".g:cmake_args." ".join(a:000, " ")." -S . -B ".b:cmake_build_dir 
	if exists("g:loaded_dispatch")
		execute "Dispatch ".cmake_command
	else
		execute "".cmake_command.""
	endif
  endif
endfunction

function! cmake#ctest(...) abort
  if cmake#is_cmake()
	call cmake#setup()
  	let ctest_command ="!ctest --test-dir ".b:cmake_build_dir." ".g:ctest_args." ".join(a:000, " ") 
	if exists("g:loaded_dispatch")
		execute "Dispatch ".ctest_command
	else
		execute "".ctest_command.""
	endif
  endif
endfunction
