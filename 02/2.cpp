#include <iostream>

int main() {
    unsigned int sum = 0;

    unsigned int temp = 0;
    unsigned int i = 1;
    for (unsigned int j = 1; j < 4000000; ) {
        if (j % 2 == 0) {
            sum += j;
        }

        temp = j;
        j += i;
        i = temp;
    }

    std::cout << sum << std::endl;
    return 0;
}
