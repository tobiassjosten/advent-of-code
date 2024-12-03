#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void * a, const void * b)
{
    return ( *(int*)a - *(int*)b );
}

int main(int argc, char *argv[])
{
    int capacity = 10;

    int *first = (int *)malloc(capacity * sizeof(int));
    int *second = (int *)malloc(capacity * sizeof(int));

    char *buffer = NULL;
    size_t len;

    int i = 0;

    while(getline(&buffer, &len, stdin) != -1) {
        char *one = strsep(&buffer, " ");

        int x = atoi(one);
        int y = atoi(buffer);

        if (capacity < i+1) {
            capacity *= 2;
            first = (int *)realloc(first, capacity * sizeof(int));
            second = (int *)realloc(second, capacity * sizeof(int));
        }

        first[i] = x;
        second[i] = y;

        i++;
    }

    // @todo For some reason, the arrays have a 0 item at the beginning. It
    // doesn't affect the result but I'd like to know why.

    int size = i + 1;

    // @todo Figure out this memory stuff. :P What needs to be freed? What
    // happens if it isn't?
    free(buffer);

    qsort(first, size, sizeof(int), compare);
    qsort(second, size, sizeof(int), compare);

    int result = 0;

    for(size_t i = 0; i < size; i++)
    {
        result += first[i] > second[i] ? first[i] - second[i] : second[i] - first[i];
    }

    printf("%d\n", result);

    return 0;
}
