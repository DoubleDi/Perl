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


MODULE = Local::perlxs                PACKAGE = Local::perlxs


SV *multiply_matrix_c(left_perl, right_perl)
    SV *left_perl
    SV *right_perl
    CODE:
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
    OUTPUT:
    RETVAL

void greeting()

INCLUDE: const-xs.inc

#include <math.h>

PROTOTYPES: DISABLE


double distance_point(x1,y1,x2,y2)
    double x1
    double y1
    double x2
    double y2

    CODE:
    double ret;
    ret = sqrt( pow(x1-x2, 2) + pow(y1-y2, 2) );
    RETVAL = ret;

    OUTPUT:
    RETVAL


void distance_ext_point(x1,y1,x2,y2)
    double x1
    double y1
    double x2
    double y2

    PPCODE:
    double dx = fabs(x1-x2);
    double dy = fabs(y1-y2);
    double dist = sqrt( pow(dx, 2) + pow(dy, 2) );

    PUSHs(sv_2mortal(newSVnv(dist)));
    PUSHs(sv_2mortal(newSVnv(dx)));
    PUSHs(sv_2mortal(newSVnv(dy)));


double distance_call_point()
    PPCODE:
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


double distance_call_arg_point()
    PPCODE:
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


double distance_pointobj(r_point1, r_point2)
    SV *r_point1
    SV *r_point2
    PPCODE:
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


double distance_pointstruct(point1, point2)
    GEOM_POINT *point1
    GEOM_POINT *point2
    CODE:
    double ret;
    ret = sqrt( pow(point1->x-point2->x,2) + pow(point1->y-point2->y,2));
    free(point1);
    free(point2);
    RETVAL = ret;
    OUTPUT:
    RETVAL


double distance3d_pointstruct(point1, point2)
    GEOM_POINT_3D *point1
    GEOM_POINT_3D *point2
    CODE:
    double ret;
    ret = sqrt( pow(point1->x-point2->x,2) + pow(point1->y-point2->y,2) + pow(point1->z-point2->z,2));
    free(point1);
    free(point2);
    RETVAL = ret;
    OUTPUT:
    RETVAL


double distance_circlestruct(point1, circle)
    GEOM_POINT *point1
    CIRCLE *circle
    CODE:
    double ret;
    ret = fabs(sqrt(pow(point1->x-circle->x, 2)+pow(point1->y-circle->y, 2)) - circle->r);
    free(point1);
    free(circle);
    RETVAL = ret;
    OUTPUT:
    RETVAL


GEOM_POINT *crosspoint_circlestruct(point1, circle)
    GEOM_POINT *point1
    CIRCLE *circle
    CODE:
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
    OUTPUT:
    RETVAL


double distance_call_point_2(name)
    char *name
    PPCODE:
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


double distance_call_arg_point_2(name)
    char *name;

    PPCODE:
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
