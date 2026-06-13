#ifndef __VECTOR__H__
#define __VECTOR__H__

#include <stdio.h>
#include <stdlib.h>


typedef struct Vector
{
    int *array;
    int size; 
    
}Vector;


void push_back(Vector *array, int value);
void pop_back(Vector *array, int value);
void clear(Vector *array);
void init(Vector *array);
void sort(Vector *array, char types);




#endif