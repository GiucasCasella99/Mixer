import("stdfaust.lib"); 

envelop = abs : max ~ -(1.0/ma.SR) : max(ba.db2linear(-70)) : ba.linear2db;
vmeter(x) = attach(x, envelop(x) : vbargraph("[10][unit:dB]", -70, +5));

ctrlgroup(x)  = chgroup(vgroup("[01] f1", x));
chgroup(x) = hgroup("[01]", x);

pan = ctrlgroup(vslider("[02] pan [style:knob]", 0.5,0,1,0.01)); 
vol = ctrlgroup(vslider("[03] vol", 0.0,0.0,1.0,0.01));

process = _ <: _ * (sqrt(1-pan)), _ * (sqrt(pan)) : _ * (vol), _ *(vol) : chgroup(vmeter), chgroup(vmeter);
