任务：参考crcbgenqcsig.m，testcrcbgenqcsig.m，仿照示例代码，实现一种其他的离散信号

- 将最终结果交到github，**记得先pull再push！**  

- 注意MATLAB代码的一些语法细节

- Example taken from textbook (“Swarm intelligence methods for Statistical Regression”, Chapter 1)

  ![image-20220208141428028](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208141428028.png)

  

- 好的代码风格：
  - 函数的命名
  - 注释：简短的描述
    1. is used to generate contents report
    2. usage format；“help+函数名”
    3. 描述这段代码的作用；输入输出的含义
    4. 代码的作者；时间
  - 变量使用cpp驼峰命名风格
  - 将function和script分开

---

第二节：

奈奎斯特采样定理：选取采样频率

- 模拟信号的采样频率是带宽的2倍

- 在傅里叶变换不能用解析法得到的时候，使用“best guess approach” 得到采样频率

  ![image-20220208145107072](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208145107072.png)

- 该瞬时频率不是傅里叶频率

![image-20220208145751847](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208145751847.png)



-----

第三节：

![image-20220208150438252](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208150438252.png)

![image-20220208151931680](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208151931680.png)

![image-20220208152225827](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208152225827.png)

![image-20220208152834085](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208152834085.png)

----

第四节

![image-20220208153708830](C:\Users\17742\AppData\Roaming\Typora\typora-user-images\image-20220208153708830.png)

