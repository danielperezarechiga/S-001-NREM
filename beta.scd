//ONDAS BETA.

//delta interfiriedo en beta



//betadelta1

(
~ampsetA3 = Array.rand(50,0.03,0.3);

SynthDef.new(\betadelta1,{

	arg freq1=4.1628,freqfin1=250,freq2=614,freqfin2=619.4807,amp=~ampsetA3, amp1=0.3,amp2=0.2, out=0, pan=1, gate=1,
	atk1=35,dec1=5,sus1=0.01,rel1=40,
	atk2=30,dec2=5,sus2=0.01,rel2=40,
	freqmod1=9,freqmod2=17,ampmod=0.5,ampmod1=0.2,ampmod2=0.2,
	freqfilter=4000;

	var sin1, sin2, sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,10,0.3),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(XLine.kr(freq2,freqfin2,3,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
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
	instrument:\betadelta1,
	dur:Pseq([5,5],2),
	amp:Pseq(~ampsetA3*0.08,inf).trace
]).play;
)

Buffer.freAll;

(
~ampsetA3 = Array.rand(50,0.03,0.3);

SynthDef.new(\betadelta1,{

	arg freq1=8.1628,freqfin1=252,freq2=1,freqfin2=612.4807,amp=~ampsetA3, amp1=0.3,amp2=0.2, out=0, pan=1, gate=1,
	atk1=35,dec1=5,sus1=0.01,rel1=40,
	atk2=30,dec2=5,sus2=0.01,rel2=40,
	freqmod1=9,freqmod2=17,ampmod=0.5,ampmod1=0.2,ampmod2=0.2,
	freqfilter=4000;

	var sin1, sin2, sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,10,0.3),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(XLine.kr(freq2,freqfin2,3,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
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
	instrument:\betadelta1,
	dur:Pseq([5,5],2),
	amp:Pseq(~eeg1.normalize(0.001,0.5),inf).trace
]).play;
)
