  .global main
main:
  mov %esp,%ebp
  mov $0x1,%ecx # カウンタ
loop:

print_fizzbuzz:
  mov %ecx,%eax # 被除数
  mov $0xf,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  cmp $0x0,%edx # 余りがゼロか
  jne print_fizz
  # write
  mov $0x9,%edx
  push %ecx
  lea (fizzbuzz),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx
  jmp increment_counter

print_fizz:
  mov %ecx,%eax # 被除数
  mov $0x3,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  cmp $0x0,%edx # 余りがゼロか
  jne print_buzz
  # write
  mov $0x5,%edx
  push %ecx
  lea (fizz),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx
  jmp increment_counter

print_buzz:
  mov %ecx,%eax # 被除数
  mov $0x5,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  cmp $0x0,%edx # 余りがゼロか
  jne print_number
  # write
  mov $0x5,%edx
  push %ecx
  lea (buzz),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx
  jmp increment_counter

print_number:
  mov %ecx,%eax # 被除数
split_loop:
  mov $0xa,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  push %edx     # 余りをスタックに格納
  cmp $0x0,%eax # 商がゼロか
  jne split_loop
print_digit:
  mov $0x1,%edx
  pop %eax # split_loopでpushした1桁の数をpopする
  push %ecx
  lea (numbers)(%eax),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx
  cmp %esp,%ebp # スタックが空か
  jne print_digit
  # print a newline
  mov $0x1,%edx
  push %ecx
  lea (newline),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx

increment_counter:
  inc %ecx
  cmp $0x10,%ecx
  jne loop
  # exit
  mov $0x0,%ebx
  mov $0x1,%eax
  int $0x80

fizzbuzz:
  .ascii "FizzBuzz\n"
fizz:
  .ascii "Fizz\n"
buzz:
  .ascii "Buzz\n"
newline:
  .byte '\n
numbers:
  .byte '0,'1,'2,'3,'4,'5,'6,'7,'8,'9
