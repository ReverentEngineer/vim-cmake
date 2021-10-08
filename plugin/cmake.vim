" Author: Jeff Caffrey-Hill <https://jeff.caffreyhill.com/>

command! -bang -nargs=* -range=-1 CMake
	\ execute cmake#configure(<q-args>)

command! -bang -nargs=* -range=-1 CTest
	\ execute cmake#ctest(<q-args>)
