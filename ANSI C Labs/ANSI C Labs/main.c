#include <stdio.h>

#include "ANSICBasics.h"
#include "Pointers.h"

struct Person {
    char *firstName;
    char *lastName;
    int age;
};

typedef struct Person Person;

void Capitalize(char *word)
{
    const char delta = 'a' - 'A';
    word[0] -= delta;
}

//void messWithFolks()
//{
//    Person fred = {
//        .firstName = "Fred",
//        .lastName = "Smith",
//        .age = 42 };
//}

void foolAroundWithArrays(void)
{
    int numbers[10] = { 1, 2, 3 };
    
    for (int i = 0; i < 3; i++) {
        printf("value is %d, address is %p\n", numbers[i], &numbers[i]);
        printf("value is %d, address is %p\n", *(numbers + i), numbers + i);
    }
    
    
//    for (; *numbers != 0; numbers++) {
//        printf("value is %d, address is %p\n", numbers, *numbers);
//    }
    
    int *numberRef = numbers;
    
    printf("numberRef is %p, value is %d\n", numberRef, *numberRef);
    
    for (; *numberRef != 0; numberRef++) {
        printf("value is %d, address is %p\n", *numberRef, numberRef);
    }
}

int main(int argc, const char *argv[])
{
//    char *fred = "fred";
//    Capitalize(fred);
    
//    foolAroundWithArrays();
    
    RunANSICBasics01();
//    RunANSICBasics02();
//    
//    RunPointers01();
//    RunPointers02();
//    RunPointers03();
//    RunPointers04();
//    RunPointers05();

    return 0;
}

