#ifndef __VECTOR3D__H__
#define __VECTOR3D__H__

#include<stdio.h>
#include<stdlib.h>


typedef struct Vector3D{
    int x;
    int y;
    int z;
}Vector3D;

Vector3D Sum3D(Vector3D vector0, Vector3D vector1);
int scalar3D(Vector3D vec0, Vector3D vec1);

#endif