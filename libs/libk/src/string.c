#include <string.h>

int memcmp(const unsigned char *lhs, const unsigned char *rhs, size_t n)
{
    size_t i;
    for (i = 0; i < n; i++) {
        if (lhs[i] != rhs[i])
            return (int)lhs[i] - (int)rhs[i];
    }
    return 0;
}

ptr_t memcpy(ptr_t dest, const unsigned char *src, size_t n)
{
    size_t i;
    for (i = 0; i < n; i++)
        dest[i] = src[i];
    return dest;
}

ptr_t memmove(ptr_t dest, const unsigned char *src, size_t n)
{
    size_t i;
    if (dest < src) {
        for (i = 0; i < n; i++)
            dest[i] = src[i];
    } else {
        for (i = n; i > 0; i--)
            dest[i - 1] = src[i - 1];
    }
    return dest;
}

ptr_t memset(ptr_t dest, int c, size_t n)
{
    size_t i;
    for (i = 0; i < n; i++)
        dest[i] = (unsigned char)c;
    return dest;
}

size_t strlen(const char *s)
{
    size_t n = 0;
    while (s[n])
        n++;
    return n;
}
