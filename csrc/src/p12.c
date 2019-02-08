#include <stdlib.h>
#include <stdio.h>
#include <string.h>

static void reverse(char *beg, char *end) {
    char *p1 = beg;
    char *p2 = end - 1;
    while (p1 < p2) {
        char tmp = *p1;
        *p1 = *p2;
        *p2 = tmp;
        ++p1;
        --p2;
    }
}

char *p12_intToRoman(int num) {
    const size_t MAX_LEN = 40;
    char *roman = (char *) malloc(MAX_LEN);
    size_t roman_len = 0;
    memset(roman, 0, MAX_LEN);

    if (num > 3999 || num <= 0)
        return roman; // out of range

    const char *symbols = "IVXLCDMNO";
    const size_t symbols_len = strlen(symbols);
    for (size_t i = 0; i < symbols_len && num > 0; i += 2) {
        char one = symbols[i];
        char five = symbols[i + 1];
        char ten = symbols[i + 2];

        int x = num % 10;
        num /= 10;
        char cur[10];
        size_t cur_len = 0;
        if (x == 4) {
            cur[0] = one;
            cur[1] = five;
            cur_len = 2;
        } else if (x == 9) {
            cur[0] = one;
            cur[1] = ten;
            cur_len = 2;
        } else if (x == 10) {
            cur[0] = ten;
            cur_len = 1;
        } else {
            int ones_count = x % 5;
            char *ones_beg;
            if (x >= 5) {
                cur[0] = five;
                ones_beg = cur + 1;
                cur_len = (size_t) (ones_count + 1);
            } else {
                ones_beg = cur;
                cur_len = (size_t) ones_count;
            }
            memset(ones_beg, one, (size_t) ones_count);
        }
        reverse(cur, cur + cur_len);
        memcpy(roman + roman_len, cur, cur_len);
        roman_len += cur_len;
    }
    reverse(roman, roman + roman_len);
    return roman;
}
