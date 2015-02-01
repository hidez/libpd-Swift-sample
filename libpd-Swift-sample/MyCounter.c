/* Copyright 2015 Hidehisa Yokoyama(hidez).
 *
 * MyCounter: external object for sample
 *
 * @version 0.1.0
 *
 * inlet   : bang  :
 * outlet  : float : number of counter
 */

#include "m_pd.h"

/* -------------------------- MyCounter ------------------------------ */

static t_class *MyCounter_class;

typedef struct _MyCounter{
    t_object x_obj;
    t_outlet *x_outlet;
    t_int i_counter;
} t_MyCounter;

void MyCounter_bang(t_MyCounter *x){
    t_float f = x->i_counter;
    x->i_counter++;
    outlet_float(x->x_outlet, f);
}

void *MyCounter_new(){
    t_MyCounter *x = (t_MyCounter *)pd_new(MyCounter_class);
    x->x_outlet = outlet_new(&x->x_obj, gensym("float"));
    x->i_counter = 0;
    return (void *)x;
}

void MyCounter_setup(void){
    MyCounter_class = class_new(gensym("MyCounter"), (t_newmethod)MyCounter_new, 0, sizeof(t_MyCounter), CLASS_DEFAULT, A_DEFFLOAT, 0);        
    class_addbang(MyCounter_class, MyCounter_bang);
}

/* -------------------------- end of source -------------------------- */