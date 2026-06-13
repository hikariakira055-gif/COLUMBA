#include "../include/Vector3D.h"

Vector3D Sum3D(Vector3D vector0, Vector3D vector1)
{

    Vector3D result;
    result.x = vector0.x + vector1.x;
    result.y = vector0.y + vector1.y;
    result.z = vector0.z + vector1.z;

    return (result);

}
int scalar3D(Vector3D vec0, Vector3D vec1){
    int result;
    result = vec0.x * vec1.x + vec0.y * vec1.y + vec0.z * vec1.z;
    return (result);
}