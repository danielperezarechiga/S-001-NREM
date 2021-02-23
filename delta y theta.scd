//ONDAS THETA Y DELTA.

//Theta1 - 60 segundos.

(
//ampstheta1
r = k[2].asFloat;
y =r.tan.plot;
~ampstheta1 = r.normalize(0.1,0.7);
~ampstheta1.plot;

//freqstheta1
g = k[6].asFloat;
g.tan;
~freqstheta1 = g.normalize(18,25);
~freqstheta1.plot;

SynthDef.new(\Theta1, {

	arg freq1=18,freqfin1=25,freq2=90,freqfin2=80,amp=0.5, amp1=0.3,amp2=0.2, out=0, pan=1, gate=1,
	atk1=10,dec1=5,sus1=0.01,rel1=40,
	atk2=10,dec2=5,sus2=0.01,rel2=40,
	freqmod1=3,freqmod2=4,ampmod=0.5,ampmod1=0.2,ampmod2=0.2,freqpulse=2,
	freqfilter=400;

	var sin1, sin2, sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,7,0.5),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(XLine.kr(freq2,freqfin2,5,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
	env1=EnvGen.ar(Env.perc(atk1,rel1,ampmod),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);
	sin1=sin1*env1;
	sin2=sin2*env2;
	sig=sin1+sin2;
	sig=LPF.ar(sig,freqfilter);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).add;

Pbind(*[
	instrument:\Theta1,
	freq1:Pseq(~freqstheta1,1).trace,
	dur:Pseq([10,10],3),
	amp:Pseq(~ampstheta1,1).trace
]).play;
)

//Theta2

(
//freqDelta1
p = k[5].asFloat;
q = p.normalize(20,400);
~freqDelta1 = q.keep(10);
~freqDelta1.plot;  //visualizar

//freqTheta1
m = k[6].asFloat;
n = m.normalize(22,500);
~freqTheta1 = n.keep(10);
~freqTheta1.plot;  //visualizar

//ritmoRAW
r = k[4].asFloat;
t = r.normalize(0.1,10);
//~ritmoRaw = t.keep(100000)
~ritmoRaw = t.keep(10);
~ritmoRaw.plot;  //visualizar

//amplitud con Acelererometro X
h=~acelerometroX/2;
~ampsTheta1=h.keep(20);
~ampsTheta1.plot;

SynthDef(\Theta2, {

	arg sig,sin1,sin2,env1,env2,ampmod;

	var freq1=40,freq2=80 ,freqmod=Rand.new(2,10),amp1=0.8,amp2=0.8,
	atk1=0.1,sus1=0.4,rel1=10,curve1=1,
	atk2=5,sus2=0.5,rel2=10,curve2=4,
	pan=0,amp=0.5,out=0,gate=1;

	ampmod=SinOsc.kr(freqmod,0,0.5);

	sin1=SinOsc.ar(freq1,0,ampmod);
	sin2=SinOsc.ar(freq2,0,amp2);
	env1=EnvGen.ar(Env.asr(atk1,sus1,rel1,curve1),gate,doneAction:2);
	env2=EnvGen.ar(Env.asr(atk2,sus2,rel2,curve2),gate,doneAction:2);
    sin1=sin1*env1;
	sin2=sin2*env2;
	sig=sin1*sin2;

	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig);

}).add;

Pbind(*[
	instrument: \Theta2,
	freq1: Pseq(~freqDelta1,1).trace,
	freq2: Pseq(~freqTheta1,1).trace,
	freqmod: Pwhite(2,10,100).trace,
    amp:Pseq(~ampsTheta1,1).trace,
	dur: Pseq(~ritmoRaw,1).trace,
]).play;

)
