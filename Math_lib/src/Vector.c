#include "../include/Vector.h"

void push_back(Vector *array, int value)
{
    array->size = array->size + 1;
    int size = array->size ;
    int *tmp = realloc(array->array , size*sizeof(int));
    array->array = tmp;
    array->array[size - 1] = value;
    //printf("array size : %d  id = %d array contaiment : %d\n",size,  (size-1), array->array[size -1]);
   

}
void clear(Vector *array)
{

    for (int  i = 0; i < array->size; i++)
    {
        array->array[i] = 0;

    }

    int *tmp = realloc(array->array , 0);
    array->array = tmp;

}
void init(Vector *array)
{
    array->size = 0;
}
void pop_back(Vector *array, int value)
{
    int counter = 0;
    
     for (int i = 0; i < (array->size); i++)
     {
        if (array->array[i] == value)
        {
            counter++;
        }
     }

     int new_size = array->size - counter;

     int *tmp = realloc(array->array, new_size*sizeof(int));
     if (!tmp)
     {
        printf("There is an probleme ! ");
     }
     

     int c__ = 0;
     for (int  i = 0; i < (array->size); i++)
     {

            if(array->array[i] != value)
            {
                tmp[c__] = array->array[i];
                c__++;
            }
            else if(array->array[i] == value)
            {
                c__ = c__;
            }
     }
     
     array->size = array->size - counter;
     array->array = tmp;
     for (int i = 0; i < (new_size); i++)
     {
        array->array[i] = tmp[i];    
     }
     
}
void sort(Vector *array, char types)
{

    

    if (types == 'c')
    {
       int tmp = 0; 
        for (int  i = 0; i < array->size; i++)
        {
            for (int  j = i + 1; j < array->size; j++)
            {
                if (array->array[i] > array->array[j])
                {

                    tmp = array->array[i];
                    array->array[i] = array->array[j];
                    array->array[j] = tmp;

                } 
            }
        } 
    }
    else if(types == 'd')
    {
        int tmp = 0; 
        for (int  i = 0; i < array->size; i++)
        {
            for (int  j = i + 1; j < array->size; j++)
            {
                if (array->array[i] < array->array[j])
                {

                    tmp = array->array[i];
                    array->array[i] = array->array[j];
                    array->array[j] = tmp;

                } 
            }
        }
    }
    else
    {
        printf("invalide char types\n");
    }
    


}