# 8086汇编指令笔记
8086指令系统记录

# 目录
* [寻址方式](#寻址方式)
* [基本指令](#基本指令)
    * [数据传送指令](#数据传送指令)
* [汇编语言格式](#汇编语言格式)
## 寻址方式
寻址方式即为**指令中操作数的表示方式**
1. 立即寻址
2. 寄存器寻址
3. 存储器寻址
4. 外设I/O端口寻址
5. 程序转移操作寻址

立即寻址：16进制立即数如果以A-F开头，则必须在前面加0  
寄存器寻址：操作数**直接保存在寄存器中**  

### 存储器寻址:  
**操作数保存在存储器中**  
EU读取一个存储器操作数时，必须将一个偏移地址传送给BIU,BIU运算后  
产生一个20位的物力地址，然后执行该存取该操作数所需要的总线周期。  
这个**偏移量**成为操作数的**有效地址EA**，表示该操作数所在的存储单元与段起始地址的距离  
关于EA
```
操作数的偏移地址(有效地址EA)直接由指令给出(直接地址值和符号地址两种形式)，
直接地址值用中括号[]括起来，与立即数寻址相区别；符号地址可不使用[]。
符号地址是变量名，要与寄存器分清楚
操作数地址为：DS:偏移地址 或 ES:偏移地址。DS为隐含指定
```
1) 直接寻址  
指令直接给出操作数的偏移地址。INC byte ptr [04a2h]  
2) 寄存器间接寻址  
**偏移地址**保存在**寄存器**中给出。INC byte ptr[bx]  **这里和符号地址区分，所以要用[bx]**
3) 寄存器相对寻址
寄存器的内容与8位或16位位移量之和作为EA 例：mov ax，count[si]  （move ax,[count+si]）
**基址寻址和变址寻址又称为寄存器相对寻址**
4) 基址变址寻址
将基址寄存器（BX或BP）与变址寄存器（SI或DI）内容之和作为操作数所在存储单元的有效地址。
MOV  AX，[BX+DI]   或  MOV  AX，[BX][DI]  
DS:(BX)+(DI) 对应存储单元里一个字送AX。
**如果再加一个8位或16位的位移量，则称为相对基址变址寻址**

### 与转移地址有关的寻址方式
1. 段内直接转移（相对寻址方式）
格式：JMP   SHORT OPR 执行的操作：(IP)←(IP)+8位位移量  
格式：JMP   NEAR PTR OPR  执行的操作：(IP) ← (IP)+16位位移量  
**8位和16位位移量由目标地址OPR确定，可使用符号地址**
2. 段内间接转移
格式：	JMP   WORD PTR  OPR 或JMP   reg
执行的操作：(IP)←(EA)  
**有效地址EA值由OPR的寻址方式确定，可以使用mem或reg**  
**与相对寻址方式的区别在于IP直接变为EA**
3. 段间直接转移  
格式：JMP   FAR PTR  OPR
执行的操作：(IP)←OPR的段内偏移地址  (CS)←OPR所在段的段地址  
**在汇编格式中OPR 可使用符号地址，而机器语言中则要指定转向的偏移地址和段地址**
4. 段间间接转移
格式：JMP  DWORD PTR  OPR
执行的操作：(IP)←(EA)   (CS)←(EA+2)  
**EA由OPR的寻址方式为存储器寻址方式**

## 基本指令

### 数据传送指令

#### 通用数据传送指令
1. **mov**  
指令格式：MOV   dst ， src  执行的操作(8086为16位指令)： dst ← src  
```
(1) 双操作数指令不允许两个操作数同时为段寄 存器或存储器操作数（串操作除外）
(2) 代码段寄存器CS和立即数均不能作为目的操作数立即数也不能传送到段寄存器中。
(3) dest与src必须类型匹配，即同时是字节或字类型。
```
2. **xchg**  
指令格式：XCHG   oprd1 , oprd2 ；
功能：交换oprd1与oprd2的内容

3. **xlat**  
格式：XLAT OPR或XLAT
执行的操作(8086为16位指令)： (AL) ← ((BX)+(AL))
```
(1) BX通常为表格首址，利用该指令实现查表。由于AL只有8位，所以表格长度不能超过256
(2) OPR为表格首地址(一般为符号地址)，只为可读性而设置，不真正发挥作用
```
#### 堆栈和栈操作指令
进栈指令 格式：PUSH reg/mem/seg  
出栈指令 格式：POP reg/mem/seg  
```
堆栈操作都是字操作,进栈时SP自动减2,出栈时SP自动加2  
SS：SP在任何时候都指向当前的栈顶。栈顶指针SP总是指向最后进栈的数据  
栈操作指令，操作数没有立即数
```
#### 标志类指令
`先空着`

#### 地址传送指令
1. **lea**  
格式：  LEA  reg16 ， mem ； 
```
该指令的目的操作数不能使用段寄存器
源操作数可使用除立即数和寄存器外的任一种存储器寻址方式
```
2. **lds/les**  
`先空着`
#### 输入输出指令
`先空着`

### 算数运算指令

#### 加法指令
1. **add**  
格式：ADD   DST , SRC
ADD   reg/ mem ， reg/mem /imm 
2. **adc**
格式：ADC   DST , SRC
ADC reg/ mem ， reg/mem /imm   
执行的操作：(DST)←(SRC)+(DST)+CF
3. **inc**  
格式：INC   OPR (reg/mem)
执行的操作：(OPR)←(OPR)+1
```
操作数不能为立即数，常用于修改地址指针
```
4. **sub**  
格式：SUB  DST , SRC
SUB reg/ mem ， reg/mem /imm 
执行的操作：(DST)←(DST)-(SRC)
```
src>dst，CF=1；否则CF=0
```
5. **sbb**  
格式：SBB  DST , SRC
SBB   reg/ mem ， reg/mem /imm
```
带借位，-cf
```
6. **dec**  
格式：DEC  OPR（reg/mem）
执行的操作：(OPR)←(OPR)-1

7. **neg**  
格式：NEG  OPR（reg/mem）求补

8. **cmp**  
格式：CMP   OPR1 , OPR2
CMP   reg/ mem ， reg/mem /imm
```
1.该指令不保存运算结果，只是根据结果设置条件标志位。
2.常和条件转移指令一同使用

对于无符号数，符号位改变同sub  
对于有符号数，符号位的改变如下：
若OF XOR SF=0(OF=SF)，则目的数大于等于源数
若OF XOR SF=1(OF≠SF)，则目的数小于源数 

```
9. **mul/imul**  
格式：MUL  SRC（reg/mem)  
执行的操作：
字节操作数：(AX)←(AL)*(SRC)
字操作数：(DX , AX)←(AX)*(SRC)
10. **div/idiv**  
格式：DIV  SRC（reg/mem）
字节操作：(AL)←(AX)/(SRC)的商 (AH)←(AX)/(SRC)的余数  
字操作：(AX)←(DX,AX)/(SRC)的商  (DX)←(DX,AX)/(SRC)的余数
```
除法运算和cbw，cwd配合使用
```
#### 类型转换指令
1. **cbw**
字节->字
al的内容符号拓展到ah，形成字
```
若(AL)<80H,则(AH)=0;若(AL)>=80H,则(AH)=0FFH
```
2. **cwd**  
字->双字
ax的内容符号拓展到dx
```
执行的操作：AX的内容符号扩展到DX，形成DX，AX中的双字
若(AX)<8000H，则(DX)=0；若 (AX)>=8000H，则(DX)=0FFFFH
```

### 位操作类指令 
#### 逻辑运算指令
1. **and** 按位与  
2. **or** 按位或  
3. **xor**按位异或  
4. **test**逻辑与，但不保存结果  
#### 逻辑移位指令
1. **shl** 逻辑左移，补零
2. **sal** 算数左移，补零
3. **shr** 逻辑右移
3. **sar** 算数右移，最高位为符号位保持不变
4. **rcl** 和**rcr**连同cf一起循环移动

#### 串处理指令
串基本处理指令  
1. **movs**  
2. **lods**  
3. **stos**  
4. **cmps**  
5. **scas**  

与上述指令配合使用的前缀
1. **rep**
2. **repe/repz**
3. **repne/repnz**

```
REP重复串操作直到CX内容为0为止,配合movs，lods，stos。每次执行后面的指令之前
先判断cx是否为零，为否则cx减一，开始执行指令。cx递减不改变标志位
```

1. movs dst，src
```
dst为附加段中的 一组 数，src为数据断种的 一组 数
movsb，movsw.操作数隐含为[es:di],[ds:si]
使用之前要求：
1. si中存源串数据地址，di中存目的串数据地址
2. 数据串长度cx
3. 建立方向标志
```

2. stos dest  
源操作数隐含为al/ax，具体由dest确定  
4. lods src
同stos，功能相反  
3.cmps
要求同movs，功能[es:di]-[ds:si]  

### 转移指令
```
1. 以单个标志位为条件 
JO		opr	；溢出转移，OF=1
JNO	opr	；不溢出转移,OF=0
JS		opr	；结果为负转移,SF=1
JNS	  opr	；结果为正转移,SF=0
JC		opr	；进位转移,CF=1
JNC	opr	；无进位转移,CF=0
JE/JZ	opr	；相等或为零转移,ZF=1
JNE/JNZ	 opr	；不相等或不为零转移,ZF=0
JP/JPE	opr	；奇偶校验为偶转移,PF=1
JNP/JPO opr	；奇偶校验为奇转移,PF=0 
2. 无符号数比较 
JA/JNBE opr	；大于时转移,CF=0∧ZF=0 
JAE/JNB opr	；大于等于时移,CF=0∨ZF=1
JB/JNAE opr	；小于时转移,CF=1∧ZF=0
JBE/JNA opr	；小于等于时移,CF=1∨ZF=1
3. 有符号数比较 
JG/JNLE opr	；大于时转移,SF=OF∧ZF=0
JGE/JNL	 opr	；大于等于时移,SF=OF∨ZF=1
JL/JNGE	 opr	；小于时转移,SF≠OF∧ZF=0
JLE/JNG	 opr	；小于等于时移,SF≠OF∨ZF=1 

```

### 循环指令
```
LOOP  opr	
    执行(CX)←(CX)-1，若(CX)≠0则转移至符号地址opr

LOOPZ/LOOPE  opr
    执行(CX)←(CX)-1,若(CX)≠0且ZF=1则转移至opr

LOOPNZ/LOOPNE	 opr
   执行时,(CX)←(CX)-1,若(CX)≠0且ZF=0则转移至opr
```
### 子程序指令
1. **call**：调用子程序，将断点入栈
2. **ret**：退出子程序，将断点出栈

### 中断指令
1.**键盘单字符输入**  
mov ah，01h  ;DOS功能号:键盘输入  
int 21h      ;DOS调用  
```
执行时，等待键盘输入，键盘按下一键时，若为Contrl-Break键则退出，否则键入字符的ASCII码置入AL中，并在屏幕上显示出来

```
2.**键盘单字符输出**  
MOV  DL，待显示字符的ASCII  
MOV  AH，2  
INT  21H  
```
入口：输出字符的ASCII 送 DL 
```
3. **键盘多字符输入**  
mov dx,数据区首偏移地址
mov ah，0Ah
int 21h
```
数据区ibuf应在ds数据段中事先定义，其定义格式为
ibuf db maxsize，0，size dup(?)
其中maxsize是数据区的最大容纳字节数
0，位实际存放的字符数，是由系统自动填入的
从第三个字节开始存放键入的字符ascii
```
4. **字符串输出**  
mov dx,数据区首偏移地址
mov ah,09h
int 21h
```
入口：ds：dx置字符串首地址，字符串要以美元符号$结束
```
5. **返回操作系统**
4CH号功能，使用方式为:  
MOV AX,4C00H  
INT   21H

## 汇编语言格式

### 格式

#### 汇编语言程序的语句  
[name] opration operand [;comment]  

#### 伪操作
[varialble] memonic operand,...operand [;comments]  

memonic: 说明所用伪操作的助记符。说明数据类型  
db 定义字节  dw 定义字  dd 定义双字  

variable：变量，表示第一个字节的偏移地址。**后面不必加：**

```
字符串可以看做串常数，用单引号把字符串引起，得到的是ascii值  
在定义字的时候低位在后面
例：dw 'ab' b在0000h a就在0001h，b是低位字节
但是db 'ab' a，b各为一个字节。按顺序分配内存，‘a’在0000h
db ? 可以保留空间但不存入数据

 repeat-count DUP(operand, … ,operand)
可以复制操作
```

1. **label**  
定义属性，
对于数据项：variabl-name label type （byte，word，dword）  
对于可执行代码：label-name label type（near，far）  
2. **equ**  
表达式赋值,但**不允许重复定义**  
"="操作可以重复定义  
3. **$地址计数器**  
在汇编程序对源程序汇编时，用地址计数器来保存**当前正在汇编的指令的偏移地址**。  
当$用在伪操作的参数字段时(例如DB的参数)，则和它用在指令中的情况不同，它所表示的是地址计数器的当前值。 

#### 操作符
1. **type**  
取变量字节数的表示类型，取标号数的类型数值。  
2. **length**  
对变量中**使用dup**的情况，取变量所在数组的元素个数  
3. **size**  
同length  
4. **offset**  
取偏移地址  
5. **seg**  
取段基址  
6. **ptr**  
type ptr expression  强制转换属性  
7. **this**  
它可以像PTR一样建立一个指定类型(BYTE、WORD、DWORD)的或指定距离(NEAR或FAR)的地址操作数。
该操作数的段地址和偏移地址与下一个存储单元地址相同。
```
【例】 FIRST_TYPE EQU THIS BYTE
   		     WORD_TABLE  DW  100  DUP(?)
	此时FIRST_TYPE的偏移地址和WORD_TABLE完全相同，但它是字节类型的；而WORD_TABLE则是字类型的。
```
8. **HIGH和LOW / HIGHWORD和LOWWORD**  
取高字节/低字节  字

### 段的定义
    segname SEGMENT [align-type] [combine-type] [use-type] ['class']
                           ┆
    segname ENDS

## 子程序
### 过程定义伪操作
proname **proc** attribute

proname endp  
其中attribute为near或者far  
### 调用和返回
1. **调用** 
call
```
call near ptr subp 
#ip压入堆栈
call far ptr subp
#cs ip压入堆栈
```
2. **返回**
ret

### 子程序的参数传递























