#include "include/Vector2D.h"
#include "include/Vector3D.h"
#include "include/Vector.h"

void __start(void)
{
    Vector tab;
    init(&tab);
    


    push_back(&tab, 6);
    push_back(&tab, 5);
    push_back(&tab, 4);
    push_back(&tab, 3);
    push_back(&tab, 2);
    push_back(&tab, 1);

    printf("%d\n", tab.size);
    printf("\n");

    for (int i = 0; i < tab.size; i++)
    {
        printf("%d\n", tab.array[i]);
    }
    
    printf("\n");

    sort(&tab, 'c');

    for (int i = 0; i < tab.size; i++)
    {
        printf("%d\n", tab.array[i]);
    }
}

int main(void)
{
    
    __start();
    return (0);
}