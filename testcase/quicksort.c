int data[10] = {123,52,8,74,62,74,55,44,74,80};
int data_length=10;
void printArray() {
	int i = 0; 
	while (i < data_length) {
		write("\n    Member "); write(i); write(" is ");
		write( data[i]); i=i+1;
	}
}

int partition(int low, int high) {
	int pivot = data[low], i = low, j = high;
	while (i < j) {
		while (i<j && data[j] >= pivot) j=j-1;
			data[i] = data[j];
		while (i<j && data[i] <= pivot) i=i+1;
			data[j] = data[i];
	}
	data[i] = pivot;
	return i;
}

void qsort(int low, int high) {
	int p;
	if (low >= high) return;
	p = partition(low, high);
	qsort(low, p-1);
	qsort(p + 1, high);
}

int main() {
	write("\nExecuting No.");
	write(" quicksort:\n  Before sorting:");
	printArray();
	qsort(0, data_length - 1);
	write("\n  After sorting:");
	printArray();
}

