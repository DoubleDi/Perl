#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"

MODULE = first::perlxs		PACKAGE = first::perlxs		

INCLUDE: const-xs.inc
