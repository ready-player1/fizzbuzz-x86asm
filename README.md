# fizzbuzz-x86asm

FizzBuzz in x86 Assembly using AT&amp;T syntax

## Usage

```
$ gcc -m32 -c -o fizzbuzz.o fizzbuzz.s && ld -m elf_i386 -e main -o fizzbuzz.bin fizzbuzz.o
$ ./fizzbuzz.bin
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
```
