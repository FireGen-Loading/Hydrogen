static char *VGAptr = (char *)0xb8000;
static int offset = 0;

void main(){
    char Hello[] = "Hello kernel";
    print(Hello,sizeof(Hello[0])/sizeof(Hello));
}

void print(char* p, int size){
    for (int i = 0; i < size; i++)
        VGAptr[offset++] = p[i];

    return ;
}


