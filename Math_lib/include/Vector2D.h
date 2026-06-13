#ifndef __VECTOR2D__H__
#define __VECTOR2D__H__

#include<stdio.h>
#include<stdlib.h>


typedef struct Vector2D{
    int x;
    int y;
}Vector2D;

Vector2D Sum2D(Vector2D vector0, Vector2D vector1);
int scalar2D(Vector2D vec0, Vector2D vec1);

#endif