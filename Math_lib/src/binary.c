#include "../include/binary.h"

void electro_spark(int a, int b, int *light, int *discharge){
    
    //un additionner avec juste 
    int c = a ^ b;
    *light = c;
    
    *discharge = a & b;
    
}

void shogun_flow(int a, int b, int charge_in, int *light, int *charge_out){
    
    int d = 0;
    int e = 0;
    int f = 0;
    
    electro_spark(b, charge_in, &e, &f);
    
    electro_spark(a, e, light, &d);
    
    *charge_out = f | d;
    
    
}


int kairagi_add(int a, int b){
    //shogun_flow, while, << >> 
    unsigned int A = a;

    unsigned int B = b;

    int C = 0;
    int D = 0;

    unsigned int i = 0b10000000000000000000000000000000;
    int mask = 0b1;
    int init = 0;
    int charger = 0;

    while (i != 0)
    {
        shogun_flow((A) & 1, (B) & 1, init, &C, &charger);
        
        A = A >> 1;
        B = B >> 1;
        
        init = charger;

        D = D | (C ? mask : 0);

        i = (i >> 1);
        mask = (mask << 1);
    }

   // D = (D >> 1);
    
    return (D);


}

int kairagi_sub(int a, int b)
{
    return(kairagi_add(a, kairagi_add(~b, 1)));
}