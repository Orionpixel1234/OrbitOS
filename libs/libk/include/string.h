#ifndef STRING_H
#define STRING_H

#include <stddef.h>

int    memcmp(const unsigned char *lhs, const unsigned char *rhs, size_t n);
ptr_t  memcpy(ptr_t dest, const unsigned char *src, size_t n);
ptr_t  memmove(ptr_t dest, const unsigned char *src, size_t n);
ptr_t  memset(ptr_t dest, int c, size_t n);
size_t strlen(const char *s);

#endif
