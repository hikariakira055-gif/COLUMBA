#ifndef __BINARY__H_
#define __BINARY__H_

#include<stdio.h>
#include<stdlib.h>

void electro_spark(int a, int b, int *light, int *discharge);
void shogun_flow(int a, int b, int charge_in, int *light, int *charge_out);
int kairagi_add(int a, int b);
int kairagi_sub(int a, int b);

#endif