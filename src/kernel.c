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

char* ItoStr(int x){
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

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

unsigned char CharIn(unsigned short port) {
    unsigned char result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

unsigned short ShortIn(unsigned short port) {
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void ShortOut(unsigned short port , unsigned short data) {
    __asm__("out %%ax, %%dx" : :"a" (data), "d" (port));
}

void CharOut(unsigned short port , unsigned char data) {
    __asm__("out %%ax, %%dx" : :"a" (data), "d" (port));
}


void main(){
    Del_boot();
    char *Hello = "Hello kernel ";
    print(Hello);
    
    char* b = ItoStr(123456978);
    print(b);

    

    return ;
}
