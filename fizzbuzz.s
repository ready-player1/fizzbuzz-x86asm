  .global main
main:
  mov %esp,%ebp
  mov $0x1,%ecx # カウンタ
loop:
  mov $0x0,%edi

print_fizz:
  mov %ecx,%eax # 被除数
  mov $0x3,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  cmp $0x0,%edx # 余りがゼロか
  jne print_buzz
  add $0x1,%edi
  # write
  mov $0x4,%edx
  push %ecx
  lea (fizz),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx

print_buzz:
  mov %ecx,%eax # 被除数
  mov $0x5,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  cmp $0x0,%edx # 余りがゼロか
  jne print_number
  add $0x1,%edi
  # write
  mov $0x4,%edx
  push %ecx
  lea (buzz),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  pop %ecx

print_number:
  test %edi,%edi
  jnz print_newline
  mov %ecx,%eax # 被除数
split_loop:
  mov $0xa,%ebx # 除数
  mov $0x0,%edx # ゼロ拡張
  div %ebx      # 符号なし除算（edxとeaxを連結した値をオペランドの値で割る）
  add $0x30,%edx
  push %edx     # 余りをスタックに格納
  cmp $0x0,%eax # 商がゼロか
  jne split_loop
print_digit:
  mov $0x1,%edx
  push %ecx
  lea 0x4(%esp),%ecx
  mov $0x1,%ebx
  mov $0x4,%eax
  int $0x80
  mov (%esp),%ecx
  add $0x8,%esp
  cmp %esp,%ebp # スタックが空か
  jne print_digit

print_newline:
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

fizz:
  .ascii "Fizz"
buzz:
  .ascii "Buzz"
newline:
  .byte '\n
