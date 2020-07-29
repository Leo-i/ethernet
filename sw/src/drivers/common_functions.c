
void copy_array(int *from_array,int *to_array, int from, int to){
    for ( int i = from; i<=to; i++)
        to_array[i] = from_array[i - from];
}