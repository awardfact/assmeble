#include <stdlib.h>
#include <time.h>
void inimylib(){
    srand(time(NULL));
}
int getnumber(){
    int a;
    a = rand() % 45 + 1;
    return a;
}
