//ONDAS ALPHA.

//alpha1
//inicio

(SynthDef(\alpha1,{
	arg rate=1,amp=1.3,gate=1,out=0,pan=0;
	var sig,env;
	sig=PlayBuf.ar(2,~a.bufnum,rate,1,0,doneAction:2);
	sig=sig*amp;
	env=EnvGen.kr(Env.new([1,1],[30,30]),gate);
	sig=sig*env;
	sig=Pan2.ar(sig,pan);
	Out.ar(out,sig)
}).play;
)
//alpha2
//mas grave
(
~imp=(0.5,1..10.0).choose;

(SynthDef(\alpha2,{
	arg rate=0.5, impulse=(0.5,1..10.0).choose, star=2, amp=1, gate=1;
	var sig, trig, starPos, env,pan;
	trig = Impulse.kr(impulse);
	pan = Line.kr(-1,1,10);
	starPos = TRand.kr(0,~a.numFrames,Impulse.kr(star));
	sig = PlayBuf.ar(2,~a.bufnum,rate,trig,starPos);
	sig=sig*amp;
	env = EnvGen.kr(Env.asr(40,2,0.1),gate,doneAction:2);
	sig = sig*env;
	sig=Pan2.ar(sig,pan);
	Out.ar(0,sig)
}).play);

~dursalpha0=~eeg4.normalize(3,6);
//~dursalpha0.cos.plot;
Pbind(*[
	instrument:\alpha2,
	dur:Prand(~dursalpha0,1).trace,
	amp:Pwhite(0.01,0.2,40)
]).play)

//alpha3

(
~amps1 = ~eeg1.normalize(0.4,0.6);
~freqs1 = ~eeg1.normalize(800,808);
~ritmo1 = ~acelerometroX.normalize(1,80000);

SynthDef.new(\alpha3, {

	arg freq1=800,freqfin1=820,freq2=829,freqfin2=807,amp=0.6,amp1=0.4,amp2=0.3,
	atk1=10,dec1=5,sus1=0.01,rel1=20,
	atk2=10,dec2=5,sus2=0.01,rel2=20,
	freqmod1=4,freqmod2=9,ampmod=0.5,ampmod1=0.2,ampmod2=0.2,
	freqfilter=400,
	out=0, pan=2, gate=1;

	var sin1, sin2,sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,5,amp),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(Line.kr(freq2,freqfin2,7,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
	env1=EnvGen.ar(Env.perc(atk1,rel1,ampmod),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);
	sin1=sin1*env1*amp1;
	sin2=sin2*env2*amp2;
	sig=(sin1+sin2)*(amp);
	sig=LPF.ar(sig,freqfilter);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).add;

Pbind(*[
	instrument:Pwrand([\alpha3],[10,4,5].normalizeSum,inf),
	freq2:Pseq(~freqs1,1).trace,
	dur:Pseq([10],6),
	amp:Pseq(~amps1,1).trace,
	\rel1: Pseq(~ritmo1,1)
]).play;
)

//alpha4

(
~amps2 = ~eeg2.normalize(0.1,0.6);
~freqs2 = ~eeg2.normalize(800,880);

SynthDef.new(\alpha4, {

	arg freq1=800,freqfin1=880,freq2=879,freqfin2=803,amp=0.6,amp1=0.4,amp2=0.3,
	atk1=3,dec1=5,sus1=0.01,rel1=30,
	atk2=3,dec2=5,sus2=0.01,rel2=30,
	freqmod1=7,freqmod2=4,ampmod=0.5,ampmod1=0.2,ampmod2=0.2,
	freqfilter=300,
	out=0, pan=1, gate=1;

	var sin1, sin2,sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,5,amp),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(Line.kr(freq2,freqfin2,7,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
	env1=EnvGen.ar(Env.perc(atk1,rel1,ampmod),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);
	sin1=sin1*env1*amp1;
	sin2=sin2*env2*amp2;
	sig=(sin1+sin2)*(amp);
	sig=LPF.ar(sig,freqfilter);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).add;

Pbind(*[
	instrument:\alpha4,
	\freq1:Pseq(~freqs2,1).trace,
	dur:Pseq([6],5),
	amp:Pseq(~amps2,1).trace
]).play;
)

// alpha5

(
~amps3 = ~eeg3.normalize(0.1,1);
~freqs3 = ~acelerometroX.normalize(400,435);

SynthDef(\alpha5, {

	arg freq1=400,freqfin1=440,freq2=403,freqfin2=437,amp=1, out=0, pan=1, gate=1,
	atk1=10.dec1=5,sus1=0.01,rel1=40,
	atk2=10,dec2=5,sus2=0.01,rel2=40,
	freqmod1=7,freqmod2=4,ampmod=0.5,ampmod1=0.2,ampmod2=0.2,
	freqfilter=800;

	var sin1, sin2, mod1,mod2,sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,5,amp),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(XLine.kr(freq2,freqfin2,7,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
	mod1=SinOsc.ar(Line.kr(freq1*0.5,freqfin1*2/3,5,amp/3),0,SinOsc.kr(freqmod1*2/3,0,ampmod1/3));
	mod2=SinOsc.ar(XLine.kr(freq2*2/3,freqfin2*2/3,5,amp/3),0,SinOsc.kr(freqmod2*2/3,0,ampmod2/3));
	env1=EnvGen.ar(Env.perc(atk1,rel1,ampmod),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);
	sin1=sin1*mod1*env1;
	sin2=sin2*mod2*env2;
	sig=(sin1+sin2)*(amp);
	sig=LPF.ar(sig,freqfilter);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).add;

Pbind(*[
	instrument:\alpha5,
	freq: Pseq(~freqs3,1),
	dur:Pseq(~acelerometroY,6),
	amp:Pseq(~amps3*2,1).trace
]).play;
)


//alpha8
//1050 Hz / complejo K match

(
~amps3 = ~eeg3.normalize(0.1,1);
~freqs3 = ~eeg1.normalize(400,4395);
~freqs3.maxItem;
SynthDef(\alpha6, {

	arg freq1=1050,freqfin1=1050,freq2=1050,freqfin2=1100,amp=1, out=0, pan=1, gate=1,
	atk1=30.dec1=7,sus1=0.01,rel1=40,
	atk2=30,dec2=7,sus2=0.01,rel2=40,
	freqmod1=7,freqmod2=4,ampmod=0.6,ampmod1=0.2,ampmod2=0.2,
	freqfilter=800;

	var sin1, sin2,sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,5,amp),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(XLine.kr(freq2,freqfin2,7,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
	env1=EnvGen.ar(Env.perc(atk1,rel1,ampmod),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);
	sin1=sin1*env1;
	sin2=sin2*env2;
	sig=(sin1+sin2)*amp;
	sig=LPF.ar(sig,freqfilter);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).add;

Pbind(*[
	instrument:\alpha6,
	freq: Pseq(~freqs3,1),
	dur:Pseq(~delta.normalize(10,15),6),
	amp:Pseq(~amps3,1).trace
]).play;
)



////////////////////////


//Sinoidales de 1050 Hz

//escalado para frecuencia.
(
~alpha1=~alpha1.normalize(800,5000);
~alpha1=~alpha2.normalize(880,5080);
~delta=~delta.normalize(-1,1);
~theta=~theta.normalize(-1,1);
)

//crear buffers
~freq1=Buffer.loadCollection(s,~alpha1);
~freq2=Buffer.loadCollection(s,~alpha2);
~amp1=Buffer.loadCollection(s,~delta);
~amp2=Buffer.loadCollection(s,~theta);

//sintes
(
SynthDef(\alphaX, {
	arg freqmod1=4,freqmod2=7, ampmod1=0.5,ampmod2=0.5,
	atk1=1,dec1=10,sus1=1,rel1=12,
	atk2=1,dec2=10,sus2=1,rel2=12,
	amp=0.8, out=1, pan=1,gate=1;

	var freq1,freq2,amp1,amp2,sin1,sin2,sig,env1,env2;
	freq1=PlayBuf.kr(1,~freq1,6,doneAction:2);
	freq2=PlayBuf.kr(1,~freq2,6,doneAction:2);
	amp1=PlayBuf.kr(1,~amp1,6,doneAction:2);
	amp2=PlayBuf.kr(1,~freq1,6,doneAction:2);

	sin1=SinOsc.ar(freq1,0,(SinOsc.kr(freqmod1,0,amp1)));
	sin2=SinOsc.ar(freq2,0,(SinOsc.kr(freqmod2,0,amp2)));
	env1=EnvGen.ar(Env.adsr(atk1,dec1,sus1,rel1),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);

	sin1=sin1*env1;
	sin2=sin2*env2;
	sig=(sin1+sin2)*(amp);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).play;
)

(SynthDef(\ringModulation2,{
	arg amp=0.5, out=0;
	var input, buf, sig;
	input=SoundIn.ar(0,amp);
	buf=PlayBuf.kr(1,~b2,16.666666,doneAction:2);
	sig=SinOsc.ar(buf,0,0.5);
	sig=sig*input;
	Out.ar(out,sig);
}).play);




//alpha8

~amps3 = ~eeg3.normalize(0.1,1);
~freqs3 = ~eeg1.normalize(400,4395);
~freqs3.maxItem;
SynthDef(\alpha8, {

	arg freq1=1050,freqfin1=1050,freq2=1050,freqfin2=1100,amp=1, out=0, pan=1, gate=1,
	atk1=10.dec1=5,sus1=0.01,rel1=40,
	atk2=10,dec2=5,sus2=0.01,rel2=40,
	freqmod1=7,freqmod2=4,ampmod=0.6,ampmod1=0.2,ampmod2=0.2,
	freqfilter=1000;

	var sin1, sin2,sig, env1,env2;

	sin1=SinOsc.ar(Line.kr(freq1,freqfin1,5,amp),0,SinOsc.kr(freqmod1,0,ampmod1));
	sin2=SinOsc.ar(XLine.kr(freq2,freqfin2,7,0.5),0,SinOsc.kr(freqmod2,0,ampmod2));
	env1=EnvGen.ar(Env.perc(atk1,rel1,ampmod),gate,doneAction:2);
	env2=EnvGen.ar(Env.adsr(atk2,dec2,sus2,rel2),gate,doneAction:2);
	sin1=sin1*env1;
	sin2=sin2*env2;
	sig=(sin1+sin2)*amp;
	sig=LPF.ar(sig,freqfilter);
	sig=Pan2.ar(sig,pan);

	Out.ar(out,sig)
}).add;

Pbind(*[
	instrument:\alpha8,
	freq: Pseq(~freqs3,1),
	dur:Pseq(~delta.normalize(10,15),6),
	amp:Pseq(~amps3,1).trace
]).play;

Synth(\alpha8,[\freqmod1,5])
