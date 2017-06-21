# echo.S
minimalistic echo.

## Idea
The idea came from this faissaloo's [echo](https://github.com/faissaloo/echo/blob/master/echo.asm) and [this article](http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html) but ported for GAS assembly language and using the **as** assembler and **ld** linker.
The idea is basically to embed the ELF header, without symbol tables, segments, sections other than text and only one program header that orders the execution to load the file to memory instead of reading the code from the file. The text section will be located at offset 0x0400000 so you might wanna modify that (build.sh) if you're having problems.

*Note: this is only for educational purposes*
