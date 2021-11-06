static char *VGAptr = (char *)0xb8000;
static int offset = 0;


void print(char* p){
    for (int i = 0; p[i] != 0; i++){
        VGAptr[offset++*2] = p[i];

    }
}

void Del_boot(){
    int* BootRegion = (int *)0x7c00;
    const int BootSize = 512;
    for (int i = 0; i < BootSize; i++){
        BootRegion[i] = 0;
    }
}
void RevArr(char *p,int size){
    for (int i = 0, sw = size/2 ; i < sw ; i++) {
        char tmp = p[i];
        p[i] = p[size-i-1];
        p[size-i-1] = tmp;
    }

}

char * ItoStr(int x){
    char Zero = '0';
    char* str = '\0';
    int size = 0;
    for (int i = 0,  z = 1; ; i++, z *= 10 ){
        int k = x % (z*10);
        size++;
        
        str[i] = Zero + (int)(k / z);
        if (k == x) break;
    }
    str[size] = '\0'; 
    RevArr(str,size);

    return str;
}

void main(){
    Del_boot();
    char *Hello = "Hello kernel\0";
    print(Hello);
    
    char* b = ItoStr(8896055);
    char* a = "why tho???";
    print(b);


    return ;
}
