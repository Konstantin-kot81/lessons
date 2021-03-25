#include <stdio.h>
/*
void main() {
    printf("Hello world!\n");
};
*/
/*int card_count = 11;
if (card_count > 10)
puts("Up");

int c = 10;
while (c > 0) {
    puts("UP to you");
    c = c - 1;
}*/

/* Подразумеваетьсяб что имя короче 20 латинских (и 10 кирилических) символов. */
/*
char ex[20];
puts(" Ввидите имя вашей ...");
scanf("%19s", ex);
printf("Дорогая %s \n\n\tС тобой покончено.\n", ex);
*/

int main()
{
char suit = 'H';
switch(suit) {
case 'C':
    puts("Clubs(Трефы)");
    break;
case 'D':
    puts("Diamonds(Бубны)");
    break;
case 'H':
    puts("Hearts(Черви)");
    break;
default:
    puts("Spades(Пики)");
}
}


