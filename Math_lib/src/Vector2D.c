#include "../include/Vector2D.h"

Vector2D Sum2D(Vector2D vector0, Vector2D vector1)
{

    Vector2D result;
    result.x = vector0.x + vector1.x;
    result.y = vector0.y + vector1.y;

    return (result);

}
int scalar2D(Vector2D vec0, Vector2D vec1)
{
    int result;
    result = vec0.x * vec1.x + vec0.y * vec1.y;
    return (result);
}