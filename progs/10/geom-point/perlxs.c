/*
 * This file was generated automatically by ExtUtils::ParseXS version 3.30 from the
 * contents of perlxs.xs. Do not edit this file, edit perlxs.xs instead.
 *
 *    ANY CHANGES MADE HERE WILL BE LOST!
 *
 */

#line 1 "perlxs.xs"
#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"

typedef struct { double x, y; } GEOM_POINT;
typedef struct { double x, y, z; } GEOM_POINT_3D;
typedef struct { double x, y, r; } CIRCLE;

void
greeting() {
    printf("Hello World!\n");
}

double **_multiply_matrix_c(double **left, double **right, int left_row, int left_col, int right_row, int right_col)
{
    int i, j, k;
    if (left_col != right_row) {
        printf("wrong size matrix\n");
        return NULL;
    }
    double **rezult = malloc(left_row * sizeof(double*));
    for (i = 0; i < left_row; i++) {
        rezult[i] = malloc(right_col * sizeof(double));
    }
    for (i = 0; i < left_row; i++) {
        for (k = 0; k < right_col; k++) {
            for (j = 0; j < left_col; j++) {
                rezult[i][k] += left[i][j] * right[j][k];
            }
        }
    }
    return rezult;
}


#line 51 "perlxs.c"
#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#ifndef dVAR
#  define dVAR		dNOOP
#endif


/* This stuff is not part of the API! You have been warned. */
#ifndef PERL_VERSION_DECIMAL
#  define PERL_VERSION_DECIMAL(r,v,s) (r*1000000 + v*1000 + s)
#endif
#ifndef PERL_DECIMAL_VERSION
#  define PERL_DECIMAL_VERSION \
	  PERL_VERSION_DECIMAL(PERL_REVISION,PERL_VERSION,PERL_SUBVERSION)
#endif
#ifndef PERL_VERSION_GE
#  define PERL_VERSION_GE(r,v,s) \
	  (PERL_DECIMAL_VERSION >= PERL_VERSION_DECIMAL(r,v,s))
#endif
#ifndef PERL_VERSION_LE
#  define PERL_VERSION_LE(r,v,s) \
	  (PERL_DECIMAL_VERSION <= PERL_VERSION_DECIMAL(r,v,s))
#endif

/* XS_INTERNAL is the explicit static-linkage variant of the default
 * XS macro.
 *
 * XS_EXTERNAL is the same as XS_INTERNAL except it does not include
 * "STATIC", ie. it exports XSUB symbols. You probably don't want that
 * for anything but the BOOT XSUB.
 *
 * See XSUB.h in core!
 */


/* TODO: This might be compatible further back than 5.10.0. */
#if PERL_VERSION_GE(5, 10, 0) && PERL_VERSION_LE(5, 15, 1)
#  undef XS_EXTERNAL
#  undef XS_INTERNAL
#  if defined(__CYGWIN__) && defined(USE_DYNAMIC_LOADING)
#    define XS_EXTERNAL(name) __declspec(dllexport) XSPROTO(name)
#    define XS_INTERNAL(name) STATIC XSPROTO(name)
#  endif
#  if defined(__SYMBIAN32__)
#    define XS_EXTERNAL(name) EXPORT_C XSPROTO(name)
#    define XS_INTERNAL(name) EXPORT_C STATIC XSPROTO(name)
#  endif
#  ifndef XS_EXTERNAL
#    if defined(HASATTRIBUTE_UNUSED) && !defined(__cplusplus)
#      define XS_EXTERNAL(name) void name(pTHX_ CV* cv __attribute__unused__)
#      define XS_INTERNAL(name) STATIC void name(pTHX_ CV* cv __attribute__unused__)
#    else
#      ifdef __cplusplus
#        define XS_EXTERNAL(name) extern "C" XSPROTO(name)
#        define XS_INTERNAL(name) static XSPROTO(name)
#      else
#        define XS_EXTERNAL(name) XSPROTO(name)
#        define XS_INTERNAL(name) STATIC XSPROTO(name)
#      endif
#    endif
#  endif
#endif

/* perl >= 5.10.0 && perl <= 5.15.1 */


/* The XS_EXTERNAL macro is used for functions that must not be static
 * like the boot XSUB of a module. If perl didn't have an XS_EXTERNAL
 * macro defined, the best we can do is assume XS is the same.
 * Dito for XS_INTERNAL.
 */
#ifndef XS_EXTERNAL
#  define XS_EXTERNAL(name) XS(name)
#endif
#ifndef XS_INTERNAL
#  define XS_INTERNAL(name) XS(name)
#endif

/* Now, finally, after all this mess, we want an ExtUtils::ParseXS
 * internal macro that we're free to redefine for varying linkage due
 * to the EXPORT_XSUB_SYMBOLS XS keyword. This is internal, use
 * XS_EXTERNAL(name) or XS_INTERNAL(name) in your code if you need to!
 */

#undef XS_EUPXS
#if defined(PERL_EUPXS_ALWAYS_EXPORT)
#  define XS_EUPXS(name) XS_EXTERNAL(name)
#else
   /* default to internal */
#  define XS_EUPXS(name) XS_INTERNAL(name)
#endif

#ifndef PERL_ARGS_ASSERT_CROAK_XS_USAGE
#define PERL_ARGS_ASSERT_CROAK_XS_USAGE assert(cv); assert(params)

/* prototype to pass -Wmissing-prototypes */
STATIC void
S_croak_xs_usage(const CV *const cv, const char *const params);

STATIC void
S_croak_xs_usage(const CV *const cv, const char *const params)
{
    const GV *const gv = CvGV(cv);

    PERL_ARGS_ASSERT_CROAK_XS_USAGE;

    if (gv) {
        const char *const gvname = GvNAME(gv);
        const HV *const stash = GvSTASH(gv);
        const char *const hvname = stash ? HvNAME(stash) : NULL;

        if (hvname)
	    Perl_croak_nocontext("Usage: %s::%s(%s)", hvname, gvname, params);
        else
	    Perl_croak_nocontext("Usage: %s(%s)", gvname, params);
    } else {
        /* Pants. I don't think that it should be possible to get here. */
	Perl_croak_nocontext("Usage: CODE(0x%"UVxf")(%s)", PTR2UV(cv), params);
    }
}
#undef  PERL_ARGS_ASSERT_CROAK_XS_USAGE

#define croak_xs_usage        S_croak_xs_usage

#endif

/* NOTE: the prototype of newXSproto() is different in versions of perls,
 * so we define a portable version of newXSproto()
 */
#ifdef newXS_flags
#define newXSproto_portable(name, c_impl, file, proto) newXS_flags(name, c_impl, file, proto, 0)
#else
#define newXSproto_portable(name, c_impl, file, proto) (PL_Sv=(SV*)newXS(name, c_impl, file), sv_setpv(PL_Sv, proto), (CV*)PL_Sv)
#endif /* !defined(newXS_flags) */

#if PERL_VERSION_LE(5, 21, 5)
#  define newXS_deffile(a,b) Perl_newXS(aTHX_ a,b,file)
#else
#  define newXS_deffile(a,b) Perl_newXS_deffile(aTHX_ a,b)
#endif

#line 195 "perlxs.c"

XS_EUPXS(XS_Local__perlxs_multiply_matrix_c); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_multiply_matrix_c)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "left_perl, right_perl");
    {
	SV *	left_perl = ST(0)
;
	SV *	right_perl = ST(1)
;
	SV *	RETVAL;
#line 48 "perlxs.xs"
    int i, k;
    AV *left_perl_arr = (AV *)SvRV(left_perl);
    AV *right_perl_arr = (AV *)SvRV(right_perl);
    int left_perl_arr_row = av_top_index(left_perl_arr) + 1;
    int right_perl_arr_row = av_top_index(right_perl_arr) + 1;
    SV **tmp = av_fetch(left_perl_arr, 0, 0);
    AV *tmp_arr = (AV *)SvRV(*tmp);
    int left_perl_arr_col = av_top_index(tmp_arr) + 1;
    tmp = av_fetch(right_perl_arr, 0, 0);
    tmp_arr = (AV *)SvRV(*tmp);
    int right_perl_arr_col = av_top_index(tmp_arr) + 1;
    double **left = malloc(left_perl_arr_row * sizeof(double*));
    for (i = 0; i < left_perl_arr_row; i++)  left[i] = malloc(left_perl_arr_col * sizeof(double));
    double **right = malloc(right_perl_arr_row * sizeof(double*));
    for (i = 0; i < right_perl_arr_row; i++)  right[i] = malloc(right_perl_arr_col * sizeof(double));
    for (i = 0; i < left_perl_arr_row; i++) {
        SV *_tmp = av_shift(left_perl_arr);
        tmp_arr = (AV *)SvRV(_tmp);
        for (k = 0; k < left_perl_arr_col; k++) {
            left[i][k] = SvNV(*av_fetch(tmp_arr, k, 0));
        }
    }
    for (i = 0; i < right_perl_arr_row; i++) {
        SV *_tmp = av_shift(right_perl_arr);
        tmp_arr = (AV *)SvRV(_tmp);
        for (k = 0; k < right_perl_arr_col; k++) {
            right[i][k] = SvNV(*av_fetch(tmp_arr, k, 0));
        }
    }
    AV *return_matrix = newAV();
    double **rez = _multiply_matrix_c(left, right, left_perl_arr_row, left_perl_arr_col, right_perl_arr_row, right_perl_arr_col);
    int rez_row = left_perl_arr_row;
    int rez_col = right_perl_arr_col;
    for (i = 0; i < rez_row; i++) {
        AV *newrow = newAV();
        for (k = 0; k < rez_col; k++) {
            SV *elem = newSVnv(rez[i][k]);
            av_push(newrow, elem);
        }
        av_push(return_matrix, newRV_noinc((SV*)newrow));
    }
    RETVAL = newRV_noinc((SV*)return_matrix);
#line 252 "perlxs.c"
	RETVAL = sv_2mortal(RETVAL);
	ST(0) = RETVAL;
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Local__perlxs_greeting); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_greeting)
{
    dVAR; dXSARGS;
    if (items != 0)
       croak_xs_usage(cv,  "");
    {

	greeting();
    }
    XSRETURN_EMPTY;
}


/* INCLUDE:  Including 'const-xs.inc' from 'perlxs.xs' */


XS_EUPXS(XS_Local__perlxs_constant); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_constant)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "sv");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
#line 4 "./const-xs.inc"
#ifdef dXSTARG
	dXSTARG; /* Faster if we have it.  */
#else
	dTARGET;
#endif
	STRLEN		len;
        int		type;
	/* IV		iv;	Uncomment this if you need to return IVs */
	/* NV		nv;	Uncomment this if you need to return NVs */
	/* const char	*pv;	Uncomment this if you need to return PVs */
#line 297 "perlxs.c"
	SV *	sv = ST(0)
;
	const char *	s = SvPV(sv, len);
#line 18 "./const-xs.inc"
	type = constant(aTHX_ s, len);
      /* Return 1 or 2 items. First is error message, or undef if no error.
           Second, if present, is found value */
        switch (type) {
        case PERL_constant_NOTFOUND:
          sv =
	    sv_2mortal(newSVpvf("%s is not a valid Local::perlxs macro", s));
          PUSHs(sv);
          break;
        case PERL_constant_NOTDEF:
          sv = sv_2mortal(newSVpvf(
	    "Your vendor has not defined Local::perlxs macro %s, used",
				   s));
          PUSHs(sv);
          break;
	/* Uncomment this if you need to return IVs
        case PERL_constant_ISIV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHi(iv);
          break; */
	/* Uncomment this if you need to return NOs
        case PERL_constant_ISNO:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_no);
          break; */
	/* Uncomment this if you need to return NVs
        case PERL_constant_ISNV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHn(nv);
          break; */
	/* Uncomment this if you need to return PVs
        case PERL_constant_ISPV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, strlen(pv));
          break; */
	/* Uncomment this if you need to return PVNs
        case PERL_constant_ISPVN:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, iv);
          break; */
	/* Uncomment this if you need to return SVs
        case PERL_constant_ISSV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(sv);
          break; */
	/* Uncomment this if you need to return UNDEFs
        case PERL_constant_ISUNDEF:
          break; */
	/* Uncomment this if you need to return UVs
        case PERL_constant_ISUV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHu((UV)iv);
          break; */
	/* Uncomment this if you need to return YESs
        case PERL_constant_ISYES:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_yes);
          break; */
        default:
          sv = sv_2mortal(newSVpvf(
	    "Unexpected return type %d while processing Local::perlxs macro %s, used",
               type, s));
          PUSHs(sv);
        }
#line 374 "perlxs.c"
	PUTBACK;
	return;
    }
}


/* INCLUDE: Returning to 'perlxs.xs' from 'const-xs.inc' */

#include <math.h>

XS_EUPXS(XS_Local__perlxs_distance_point); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_point)
{
    dVAR; dXSARGS;
    if (items != 4)
       croak_xs_usage(cv,  "x1, y1, x2, y2");
    {
	double	x1 = (double)SvNV(ST(0))
;
	double	y1 = (double)SvNV(ST(1))
;
	double	x2 = (double)SvNV(ST(2))
;
	double	y2 = (double)SvNV(ST(3))
;
	double	RETVAL;
	dXSTARG;
#line 109 "perlxs.xs"
    double ret;
    ret = sqrt( pow(x1-x2, 2) + pow(y1-y2, 2) );
    RETVAL = ret;

#line 407 "perlxs.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Local__perlxs_distance_ext_point); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_ext_point)
{
    dVAR; dXSARGS;
    if (items != 4)
       croak_xs_usage(cv,  "x1, y1, x2, y2");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	double	x1 = (double)SvNV(ST(0))
;
	double	y1 = (double)SvNV(ST(1))
;
	double	x2 = (double)SvNV(ST(2))
;
	double	y2 = (double)SvNV(ST(3))
;
#line 124 "perlxs.xs"
    double dx = fabs(x1-x2);
    double dy = fabs(y1-y2);
    double dist = sqrt( pow(dx, 2) + pow(dy, 2) );

    PUSHs(sv_2mortal(newSVnv(dist)));
    PUSHs(sv_2mortal(newSVnv(dx)));
    PUSHs(sv_2mortal(newSVnv(dy)));
#line 439 "perlxs.c"
	PUTBACK;
	return;
    }
}


XS_EUPXS(XS_Local__perlxs_distance_call_point); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_call_point)
{
    dVAR; dXSARGS;
    if (items != 0)
       croak_xs_usage(cv,  "");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	double	RETVAL;
	dXSTARG;
#line 135 "perlxs.xs"
    int count;
    double x1, y1, x2, y2;
    ENTER;
    SAVETMPS;
    PUSHMARK(SP);
    PUTBACK;
    count = call_pv("Local::perlxs::get_points", G_ARRAY|G_NOARGS);

    SPAGAIN;
    if (count != 4) croak("call get_points trouble\n");
    x1 = POPn;
    y1 = POPn;
    x2 = POPn;
    y2 = POPn;
    double dist = sqrt( pow(x1-x2, 2) + pow(y1-y2, 2) );
    FREETMPS;
    LEAVE;
    PUSHs(sv_2mortal(newSVnv(dist)));
#line 476 "perlxs.c"
	PUTBACK;
	return;
    }
}


XS_EUPXS(XS_Local__perlxs_distance_call_arg_point); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_call_arg_point)
{
    dVAR; dXSARGS;
    if (items != 0)
       croak_xs_usage(cv,  "");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	double	RETVAL;
	dXSTARG;
#line 157 "perlxs.xs"
    int count;
    double x1, y1, x2, y2;

    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    XPUSHs(sv_2mortal(newSViv(1)));
    PUTBACK;
    count = call_pv("Local::perlxs::get_points", G_ARRAY);
    SPAGAIN;
    if (count != 2) croak("call get_points trouble\n");
    x1 = POPn;
    y1 = POPn;

    PUSHMARK(SP);
    XPUSHs(sv_2mortal(newSViv(2)));
    PUTBACK;
    count = call_pv("Local::perlxs::get_points", G_ARRAY);
    SPAGAIN;
    if (count != 2) croak("call get_points trouble\n");
    x2 = POPn;
    y2 = POPn;

    double dist = sqrt( pow(x1-x2, 2) + pow(y1-y2, 2) );
    FREETMPS;
    LEAVE;
    PUSHs(sv_2mortal(newSVnv(dist)));
#line 523 "perlxs.c"
	PUTBACK;
	return;
    }
}


XS_EUPXS(XS_Local__perlxs_distance_pointobj); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_pointobj)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "r_point1, r_point2");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	SV *	r_point1 = ST(0)
;
	SV *	r_point2 = ST(1)
;
	double	RETVAL;
	dXSTARG;
#line 191 "perlxs.xs"
    double x1,y1,x2,y2;
    SV **_x1, **_y1, **_x2, **_y2, *_point1, *_point2;
    HV *point1, *point2;
    if(!(SvOK(r_point1) && SvROK(r_point1) && SvOK(r_point2) && SvROK(r_point2))){
        croak("Point must be a hashref");
    }
    _point1 = SvRV(r_point1); _point2 = SvRV(r_point2);
    if( SvTYPE(_point1) != SVt_PVHV || SvTYPE(_point2) != SVt_PVHV){
        croak("Point must be a hashref");
    }
    point1 = (HV*)_point1; point2 = (HV*)_point2;
    if(!(hv_exists(point1, "x", 1) && hv_exists(point2, "x", 1) &&
            hv_exists(point1, "y", 1) && hv_exists(point2, "y", 1))){
        croak("Point mush contain x and y keys");
    }
    _x1 = hv_fetch(point1, "x", 1, 0); _y1 = hv_fetch(point1, "y", 1, 0);
    _x2 = hv_fetch(point2, "x", 1, 0); _y2 = hv_fetch(point2, "y", 1, 0);
    if( !(_x1 && _x2 && _y1 && _y2)){ croak("Non allow NULL in x and y coords"); }
    x1 = SvNV(*_x1); x2 = SvNV(*_x2);
    y1 = SvNV(*_y1); y2 = SvNV(*_y2);
    PUSHs(sv_2mortal(newSVnv(sqrt( pow(x1-x2,2) + pow(y1-y2,2)))));
#line 567 "perlxs.c"
	PUTBACK;
	return;
    }
}


XS_EUPXS(XS_Local__perlxs_distance_pointstruct); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_pointstruct)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "point1, point2");
    {
	GEOM_POINT *	point1;
	GEOM_POINT *	point2;
	double	RETVAL;
	dXSTARG;

	{
    	double typemap_x, typemap_y;
    	if(!(SvOK(ST(0)) && SvROK(ST(0)))){ croak("Point must be a hashref"); }
    	SV *typemap__point = SvRV(ST(0));
    	if( SvTYPE(typemap__point) != SVt_PVHV ){croak("Point must be a hashref");}
    	HV *typemap_point = (HV*)typemap__point;
    	if(!(hv_exists(typemap_point, "x", 1) && hv_exists(typemap_point, "y", 1))){
            croak("Point mush contain x and y keys");
        }
    	SV **typemap__x = hv_fetch(typemap_point, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_point, "y", 1, 0);
    	if( !(typemap__x && typemap__y) ){ croak("Non allow NULL in x and y coords");}
    	typemap_x = SvNV(*typemap__x); typemap_y = SvNV(*typemap__y);
    	GEOM_POINT * pt = malloc(sizeof(GEOM_POINT));
    	pt->x = typemap_x; pt->y = typemap_y;
    	point1 = (GEOM_POINT *)pt;
	}
;

	{
    	double typemap_x, typemap_y;
    	if(!(SvOK(ST(1)) && SvROK(ST(1)))){ croak("Point must be a hashref"); }
    	SV *typemap__point = SvRV(ST(1));
    	if( SvTYPE(typemap__point) != SVt_PVHV ){croak("Point must be a hashref");}
    	HV *typemap_point = (HV*)typemap__point;
    	if(!(hv_exists(typemap_point, "x", 1) && hv_exists(typemap_point, "y", 1))){
            croak("Point mush contain x and y keys");
        }
    	SV **typemap__x = hv_fetch(typemap_point, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_point, "y", 1, 0);
    	if( !(typemap__x && typemap__y) ){ croak("Non allow NULL in x and y coords");}
    	typemap_x = SvNV(*typemap__x); typemap_y = SvNV(*typemap__y);
    	GEOM_POINT * pt = malloc(sizeof(GEOM_POINT));
    	pt->x = typemap_x; pt->y = typemap_y;
    	point2 = (GEOM_POINT *)pt;
	}
;
#line 218 "perlxs.xs"
    double ret;
    ret = sqrt( pow(point1->x-point2->x,2) + pow(point1->y-point2->y,2));
    free(point1);
    free(point2);
    RETVAL = ret;
#line 629 "perlxs.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Local__perlxs_distance3d_pointstruct); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance3d_pointstruct)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "point1, point2");
    {
	GEOM_POINT_3D *	point1;
	GEOM_POINT_3D *	point2;
	double	RETVAL;
	dXSTARG;

	{
    	double typemap_x, typemap_y, typemap_z;
    	if(!(SvOK(ST(0)) && SvROK(ST(0)))){ croak("Point must be a hashref"); }
    	SV *typemap__point = SvRV(ST(0));
    	if( SvTYPE(typemap__point) != SVt_PVHV ){croak("Point must be a hashref");}
    	HV *typemap_point = (HV*)typemap__point;
    	if(!(hv_exists(typemap_point, "x", 1) && hv_exists(typemap_point, "y", 1) && hv_exists(typemap_point, "z", 1))){
    		croak("Point mush contain x and y keys");
    	}
    	SV **typemap__x = hv_fetch(typemap_point, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_point, "y", 1, 0);
    	SV **typemap__z = hv_fetch(typemap_point, "z", 1, 0);
    	if( !(typemap__x && typemap__y && typemap__z)){ croak("Non allow NULL in x or y or z coords");}
    	typemap_x = SvNV(*typemap__x);
    	typemap_y = SvNV(*typemap__y);
    	typemap_z = SvNV(*typemap__z);
    	GEOM_POINT_3D * pt = malloc(sizeof(GEOM_POINT_3D));
    	pt->x = typemap_x; pt->y = typemap_y; pt->z = typemap_z;
    	point1 = (GEOM_POINT_3D *)pt;
	}
;

	{
    	double typemap_x, typemap_y, typemap_z;
    	if(!(SvOK(ST(1)) && SvROK(ST(1)))){ croak("Point must be a hashref"); }
    	SV *typemap__point = SvRV(ST(1));
    	if( SvTYPE(typemap__point) != SVt_PVHV ){croak("Point must be a hashref");}
    	HV *typemap_point = (HV*)typemap__point;
    	if(!(hv_exists(typemap_point, "x", 1) && hv_exists(typemap_point, "y", 1) && hv_exists(typemap_point, "z", 1))){
    		croak("Point mush contain x and y keys");
    	}
    	SV **typemap__x = hv_fetch(typemap_point, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_point, "y", 1, 0);
    	SV **typemap__z = hv_fetch(typemap_point, "z", 1, 0);
    	if( !(typemap__x && typemap__y && typemap__z)){ croak("Non allow NULL in x or y or z coords");}
    	typemap_x = SvNV(*typemap__x);
    	typemap_y = SvNV(*typemap__y);
    	typemap_z = SvNV(*typemap__z);
    	GEOM_POINT_3D * pt = malloc(sizeof(GEOM_POINT_3D));
    	pt->x = typemap_x; pt->y = typemap_y; pt->z = typemap_z;
    	point2 = (GEOM_POINT_3D *)pt;
	}
;
#line 231 "perlxs.xs"
    double ret;
    ret = sqrt( pow(point1->x-point2->x,2) + pow(point1->y-point2->y,2) + pow(point1->z-point2->z,2));
    free(point1);
    free(point2);
    RETVAL = ret;
#line 697 "perlxs.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Local__perlxs_distance_circlestruct); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_circlestruct)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "point1, circle");
    {
	GEOM_POINT *	point1;
	CIRCLE *	circle;
	double	RETVAL;
	dXSTARG;

	{
    	double typemap_x, typemap_y;
    	if(!(SvOK(ST(0)) && SvROK(ST(0)))){ croak("Point must be a hashref"); }
    	SV *typemap__point = SvRV(ST(0));
    	if( SvTYPE(typemap__point) != SVt_PVHV ){croak("Point must be a hashref");}
    	HV *typemap_point = (HV*)typemap__point;
    	if(!(hv_exists(typemap_point, "x", 1) && hv_exists(typemap_point, "y", 1))){
            croak("Point mush contain x and y keys");
        }
    	SV **typemap__x = hv_fetch(typemap_point, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_point, "y", 1, 0);
    	if( !(typemap__x && typemap__y) ){ croak("Non allow NULL in x and y coords");}
    	typemap_x = SvNV(*typemap__x); typemap_y = SvNV(*typemap__y);
    	GEOM_POINT * pt = malloc(sizeof(GEOM_POINT));
    	pt->x = typemap_x; pt->y = typemap_y;
    	point1 = (GEOM_POINT *)pt;
	}
;

	{
    	double typemap_x, typemap_y, typemap_r;
    	if(!(SvOK(ST(1)) && SvROK(ST(1)))){ croak("Circle must be a hashref"); }
    	SV *typemap__circle = SvRV(ST(1));
    	if( SvTYPE(typemap__circle) != SVt_PVHV ){croak("Circle must be a hashref");}
    	HV *typemap_circle = (HV*)typemap__circle;
    	if(!(hv_exists(typemap_circle, "x", 1) && hv_exists(typemap_circle, "y", 1) && hv_exists(typemap_circle, "r", 1))){
    		croak("Point mush contain x and y keys");
    	}
    	SV **typemap__x = hv_fetch(typemap_circle, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_circle, "y", 1, 0);
    	SV **typemap__r = hv_fetch(typemap_circle, "r", 1, 0);
    	if( !(typemap__x && typemap__y && typemap__r)){ croak("Non allow NULL in x or y or r coords");}
    	typemap_x = SvNV(*typemap__x);
    	typemap_y = SvNV(*typemap__y);
    	typemap_r = SvNV(*typemap__r);
    	CIRCLE * pt = malloc(sizeof(CIRCLE));
    	pt->x = typemap_x; pt->y = typemap_y; pt->r = typemap_r;
    	circle = (CIRCLE *)pt;
	}
;
#line 244 "perlxs.xs"
    double ret;
    ret = fabs(sqrt(pow(point1->x-circle->x, 2)+pow(point1->y-circle->y, 2)) - circle->r);
    free(point1);
    free(circle);
    RETVAL = ret;
#line 762 "perlxs.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Local__perlxs_crosspoint_circlestruct); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_crosspoint_circlestruct)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "point1, circle");
    {
	GEOM_POINT *	point1;
	CIRCLE *	circle;
	GEOM_POINT *	RETVAL;

	{
    	double typemap_x, typemap_y;
    	if(!(SvOK(ST(0)) && SvROK(ST(0)))){ croak("Point must be a hashref"); }
    	SV *typemap__point = SvRV(ST(0));
    	if( SvTYPE(typemap__point) != SVt_PVHV ){croak("Point must be a hashref");}
    	HV *typemap_point = (HV*)typemap__point;
    	if(!(hv_exists(typemap_point, "x", 1) && hv_exists(typemap_point, "y", 1))){
            croak("Point mush contain x and y keys");
        }
    	SV **typemap__x = hv_fetch(typemap_point, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_point, "y", 1, 0);
    	if( !(typemap__x && typemap__y) ){ croak("Non allow NULL in x and y coords");}
    	typemap_x = SvNV(*typemap__x); typemap_y = SvNV(*typemap__y);
    	GEOM_POINT * pt = malloc(sizeof(GEOM_POINT));
    	pt->x = typemap_x; pt->y = typemap_y;
    	point1 = (GEOM_POINT *)pt;
	}
;

	{
    	double typemap_x, typemap_y, typemap_r;
    	if(!(SvOK(ST(1)) && SvROK(ST(1)))){ croak("Circle must be a hashref"); }
    	SV *typemap__circle = SvRV(ST(1));
    	if( SvTYPE(typemap__circle) != SVt_PVHV ){croak("Circle must be a hashref");}
    	HV *typemap_circle = (HV*)typemap__circle;
    	if(!(hv_exists(typemap_circle, "x", 1) && hv_exists(typemap_circle, "y", 1) && hv_exists(typemap_circle, "r", 1))){
    		croak("Point mush contain x and y keys");
    	}
    	SV **typemap__x = hv_fetch(typemap_circle, "x", 1, 0);
    	SV **typemap__y = hv_fetch(typemap_circle, "y", 1, 0);
    	SV **typemap__r = hv_fetch(typemap_circle, "r", 1, 0);
    	if( !(typemap__x && typemap__y && typemap__r)){ croak("Non allow NULL in x or y or r coords");}
    	typemap_x = SvNV(*typemap__x);
    	typemap_y = SvNV(*typemap__y);
    	typemap_r = SvNV(*typemap__r);
    	CIRCLE * pt = malloc(sizeof(CIRCLE));
    	pt->x = typemap_x; pt->y = typemap_y; pt->r = typemap_r;
    	circle = (CIRCLE *)pt;
	}
;
#line 257 "perlxs.xs"
    double rez_len;
    rez_len = fabs(sqrt(pow(point1->x - circle->x, 2) + pow(point1->y - circle->y, 2)) - circle->r);
    double len;
    len = sqrt(pow(point1->x - circle->x, 2) + pow(point1->y - circle->y, 2));
    double x;
    x = (circle->x - point1->x) * rez_len / len;
    double y;
    y = (circle->y - point1->y) * rez_len / len;
    GEOM_POINT *ret_point;
    ret_point = malloc(sizeof(GEOM_POINT));
    ret_point->x = point1->x + x;
    ret_point->y = point1->y + y;
    free(point1);
    free(circle);
    RETVAL = ret_point;
#line 836 "perlxs.c"
	{
	    SV * RETVALSV;
	    RETVALSV = sv_newmortal();
    {
	    GEOM_POINT * typemap__struct = (GEOM_POINT *)RETVAL;
	    SV *x = newSVnv(typemap__struct->x);
	    SV *y = newSVnv(typemap__struct->y);
	    HV *point = newHV();
	    hv_store(point, "x", 1, x, 0);
	    hv_store(point, "y", 1, y, 0);
	    SV *ref = newRV_noinc((SV*)point);
	    sv_setsv(RETVALSV, ref);
    }
	    ST(0) = RETVALSV;
	}
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Local__perlxs_distance_call_point_2); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_call_point_2)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "name");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	char *	name = (char *)SvPV_nolen(ST(0))
;
	double	RETVAL;
	dXSTARG;
#line 279 "perlxs.xs"
    int count;
    double x1, y1, x2, y2;
    ENTER;
    SAVETMPS;
    PUSHMARK(SP);
    PUTBACK;
    count = call_pv(name, G_ARRAY|G_NOARGS);

    SPAGAIN;
    if (count != 4) croak("call get_points trouble\n");
    x1 = POPn;
    y1 = POPn;
    x2 = POPn;
    y2 = POPn;
    double dist = sqrt( pow(x1-x2, 2) + pow(y1-y2, 2) );
    FREETMPS;
    LEAVE;
    PUSHs(sv_2mortal(newSVnv(dist)));
#line 889 "perlxs.c"
	PUTBACK;
	return;
    }
}


XS_EUPXS(XS_Local__perlxs_distance_call_arg_point_2); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Local__perlxs_distance_call_arg_point_2)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "name");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	char *	name = (char *)SvPV_nolen(ST(0))
;
	double	RETVAL;
	dXSTARG;
#line 303 "perlxs.xs"
    int count;
    double x1, y1, x2, y2;

    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    XPUSHs(sv_2mortal(newSViv(1)));
    PUTBACK;
    count = call_pv(name, G_ARRAY);
    SPAGAIN;
    if (count != 2) croak("call get_points_2 trouble\n");
    x1 = POPn;
    y1 = POPn;

    PUSHMARK(SP);
    XPUSHs(sv_2mortal(newSViv(2)));
    PUTBACK;
    count = call_pv(name, G_ARRAY);
    SPAGAIN;
    if (count != 2) croak("call get_points trouble\n");
    x2 = POPn;
    y2 = POPn;

    double dist = sqrt( pow(x1-x2, 2) + pow(y1-y2, 2) );
    FREETMPS;
    LEAVE;
    PUSHs(sv_2mortal(newSVnv(dist)));
#line 938 "perlxs.c"
	PUTBACK;
	return;
    }
}

#ifdef __cplusplus
extern "C"
#endif
XS_EXTERNAL(boot_Local__perlxs); /* prototype to pass -Wmissing-prototypes */
XS_EXTERNAL(boot_Local__perlxs)
{
#if PERL_VERSION_LE(5, 21, 5)
    dVAR; dXSARGS;
#else
    dVAR; dXSBOOTARGSXSAPIVERCHK;
#endif
#if (PERL_REVISION == 5 && PERL_VERSION < 9)
    char* file = __FILE__;
#else
    const char* file = __FILE__;
#endif

    PERL_UNUSED_VAR(file);

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
#if PERL_VERSION_LE(5, 21, 5)
    XS_VERSION_BOOTCHECK;
#  ifdef XS_APIVERSION_BOOTCHECK
    XS_APIVERSION_BOOTCHECK;
#  endif
#endif

        newXS_deffile("Local::perlxs::multiply_matrix_c", XS_Local__perlxs_multiply_matrix_c);
        newXS_deffile("Local::perlxs::greeting", XS_Local__perlxs_greeting);
        newXS_deffile("Local::perlxs::constant", XS_Local__perlxs_constant);
        newXS_deffile("Local::perlxs::distance_point", XS_Local__perlxs_distance_point);
        newXS_deffile("Local::perlxs::distance_ext_point", XS_Local__perlxs_distance_ext_point);
        newXS_deffile("Local::perlxs::distance_call_point", XS_Local__perlxs_distance_call_point);
        newXS_deffile("Local::perlxs::distance_call_arg_point", XS_Local__perlxs_distance_call_arg_point);
        newXS_deffile("Local::perlxs::distance_pointobj", XS_Local__perlxs_distance_pointobj);
        newXS_deffile("Local::perlxs::distance_pointstruct", XS_Local__perlxs_distance_pointstruct);
        newXS_deffile("Local::perlxs::distance3d_pointstruct", XS_Local__perlxs_distance3d_pointstruct);
        newXS_deffile("Local::perlxs::distance_circlestruct", XS_Local__perlxs_distance_circlestruct);
        newXS_deffile("Local::perlxs::crosspoint_circlestruct", XS_Local__perlxs_crosspoint_circlestruct);
        newXS_deffile("Local::perlxs::distance_call_point_2", XS_Local__perlxs_distance_call_point_2);
        newXS_deffile("Local::perlxs::distance_call_arg_point_2", XS_Local__perlxs_distance_call_arg_point_2);
#if PERL_VERSION_LE(5, 21, 5)
#  if PERL_VERSION_GE(5, 9, 0)
    if (PL_unitcheckav)
        call_list(PL_scopestack_ix, PL_unitcheckav);
#  endif
    XSRETURN_YES;
#else
    Perl_xs_boot_epilog(aTHX_ ax);
#endif
}

