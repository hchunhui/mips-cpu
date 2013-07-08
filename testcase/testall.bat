@echo 测试
@pause

copy final.mif ..\mips\icache.mif
@echo 全指令测试
@pause

copy test.mif ..\mips\icache.mif
@echo C语言用到的指令测试、中断测试
@pause

copy fib.mif ..\mips\icache.mif
@echo fib数列
@pause

copy heapsort.mif ..\mips\icache.mif
@echo 堆排序
@pause

copy quicksort.mif ..\mips\icache.mif
@echo 快速排序
@pause

