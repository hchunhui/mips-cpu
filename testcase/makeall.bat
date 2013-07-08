@echo 从C程序生成汇编码
@pause
..\compiler\bc0c -m spim fib.c -o fib.s
@pause
..\compiler\bc0c -m spim heapsort.c -o heapsort.s
@pause
..\compiler\bc0c -m spim quicksort.c -o quicksort.s
@pause
@echo 从汇编码生成MIF文件
@pause
..\compiler\as < fib.s > fib.mif
@pause
..\compiler\as < heapsort.s > heapsort.mif
@pause
..\compiler\as < quicksort.s > quicksort.mif
@pause
..\compiler\as < test.s > test.mif
@pause
..\compiler\as < final.s > final.mif
@pause
