# 汇编与接口
汇编与接口的学习笔记。  
基于8086微型处理器
## 目录
* [环境配置](#环境配置)
* [8086简介](#8086简介)

## 环境配置
[Windows10下配置8086的汇编开发环境](http://blog.csdn.net/doniexun/article/details/45438457)

## 8086简介
8086微处理器总线结构：  
16根数据线  
20根地址线  
时钟信号：5M HZ

8086被设计为两个独立的功能部件，即**总线接口部件**和**执行部件**  

**总线接口部件（BIU）**：  
由段寄存器、指令指针、地址形成逻辑、总线控制逻辑和指令队列组成。  
**执行部件（EU）**：  
由通用寄存器、标准寄存器、算术逻辑单元、EU控制系统组成

### 8086编程结构
8086共有14个十六位的寄存器。其中：  
8个通用寄存器  
1个指令指针  
1个标志寄存器  
4个段寄存器  

1. 通用寄存器：  
1）数据寄存器（4个）  
AX：累加器  BX：基址寄存器  CX：计数寄存器  DX：数据寄存器  
每个数据寄存器都可以用来存放8位或者16位的二进制操作数。既可以作为一个16位的寄存器，也可以作为**2个8位**的寄存器  
2）指针寄存器（2个)  
SP：堆栈指针寄存器  BP：基址指针寄存器  
3）变址寄存器（2个)  
SI：源变址寄存器  DI：目的变址寄存器  

2. 指令指针:  
即IP

3. 标志寄存器：  
标志寄存器中**9位**有效  
**6位**状态位
**3位**控制位

4. 段寄存器：  
DS：数据段寄存器  
CS：代码段寄存器  
SS：堆栈段寄存器  
ES：附加段寄存器  

## 指令笔记
[指令笔记](./instruction/instruction.md)
