#ifndef STDDEF_H
#define STDDEF_H

#if defined(__x86_64__) || defined(__amd64__)
typedef unsigned long long size_t;
typedef long long          ptrdiff_t;
#else
typedef unsigned int       size_t;
typedef int                ptrdiff_t;
#endif

typedef unsigned char *ptr_t;

#define NULL ((char *)0)

#endif
