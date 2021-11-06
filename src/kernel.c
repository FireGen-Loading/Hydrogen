static char *VGAptr = (char *)0xb8000;
static int offset = 0;

void print(char* p, int size){
    for (int i = 0; i < size; i++)
        VGAptr[offset++*2] = p[i];

    return ;
}

void main(){
    char *Hello = "Hello kernel";
    print(Hello,12);
}




