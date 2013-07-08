int res;
int fib(int n)
{
	int f1, f2;
	if(n == 0)
		return 1;
	if(n == 1)
		return 1;
	return fib(n-1)+fib(n-2);
}


void main()
{
	res = fib(7);
}
