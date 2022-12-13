
(
ServerOptions.devices;
s.options.inDevice = "Aggregate Device";
s.options.outDevice = "Aggregate Device";
s.options.numInputBusChannels = 0;
s.options.numOutputBusChannels = 22;
s.options.recChannels = 22;
s.boot;
s.meter;
)

s.plotTree;

/*
Klangwürfel 1: 0-5 (channel 1-6)
 - The the left of the desk
Klanfwürfel 2: 8-13 (channel 9-14)
 - In the back
Klangwürfel 3: 16-21 (channel 17-22)
 - In the front

Membrane no. 1, 4, 5 face the inside of the triangle
Membrane no. 2, 3, 6 face wall
*/
(
~bdk = Buffer.readChannel(s,"/Users/adele21/Music/For BD6K/lead you home.wav", channels:[0]);
~bdkrev = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/lead_you_home_rev_rec_1.aiff", channels:[0]);
a = Bus.audio(s, 2); // master
b = Bus.audio(s, 2); //slave
)

(
SynthDef(\gator,  {
	arg inBusA, inBusB, lag=10, clampTime=0.01, relaxTime=0.1, slopeBelow=3, slopeAbove=1, thresh=0.1, speed=1, out=0;
	var kick, pads, snd, freq;
	kick = In.ar(inBusA, 1);
	pads = In.ar(inBusB, 1);
	snd = Compander.ar(pads, kick, thresh, slopeBelow, slopeAbove, clampTime.lag(lag), relaxTime.lag(lag));
	freq = Line.kr(0.5, 2.0, 300) * speed;
	snd = PanAz.ar(22, snd, LFSaw.kr(freq)*(-1), 1, 2, 0);
	Out.ar(out, snd);
}).add;

SynthDef(\bdkbuffer, {
	arg out, buf, rate=(-1), start=0, amp=1;
	var sig, line;
	sig = PlayBuf.ar(1, buf, rate, 1, start, loop:1);
	line = 1;//Line.ar(0.1, 0.3, 200);
	sig = sig * amp * EnvGate.new(fadeTime: 3) * line;
	Out.ar(out, sig);
}).add;

SynthDef(\whiteNoiz, {
	arg out, amp=0.01;
	var sig, env;
	env = EnvGen.kr(Env.perc(), doneAction:2);
	sig = WhiteNoise.ar(amp) * env * 2;
	Out.ar(out, sig);
}).add;

SynthDef(\brownNoiz, {
	arg out, amp=0.01, rel=1.0;
	var sig, env;
	env = EnvGen.kr(Env.perc(0.1, rel), doneAction:2);
	sig = BrownNoise.ar(amp) * env * 3;
	Out.ar(out, sig);
}).add;

SynthDef(\bdkbuffer1, {
	arg out, buf, rate=(-1), start=0, amp=1;
	var sig, line;
	sig = PlayBuf.ar(1, buf, rate, 1, start, loop:1);
	line = 1; //Line.ar(0.02, 0.3, 300);
	sig = sig * amp * EnvGate.new(fadeTime: 3) * line;
	Out.ar(out, sig);
}).add;

SynthDef(\discreteOut, {|in, out, freq, gate = 1|
	var input, env;
	env = EnvGen.kr(Env.asr(0.01, 1, 0.05), gate, doneAction: 2);
	input = In.ar(in) * env;
	Out.ar(freq, input);
}).add;
)

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////PLAY
//////////////////////////////////////////
(
~reaperOSC = NetAddr.new("127.0.0.1", 8000);
~reaperOSC.sendMsg("T/record");
//////////////////////Stuff
/*~synthGroup = Group(s);
~pannerGroup = Group.after(~synthGroup);

//////////////////////Synths
~gatorsynth = Synth(\gator, [\inBusA, a, \inBusB, b, \slopeBelow, 1.8, \slopeAbove, 1, \clampTime, 0.01, \relaxTime, 0.1, \thresh, 0.1, \out, 24], 1, \addToTail);
~bdksynth = Synth(\bdkbuffer, [\amp, 1, \out, b, \buf, ~bdk.bufnum]);
~bdksynth1 = Synth(\bdkbuffer1, [\out, ~pannerBus, \buf, ~bdkrev.bufnum, \rate, (-1), \amp, 3], ~synthGroup);

/////////////////////for GATOR
Pbindef(\panningGator,
	\instrument, \brownNoiz,
	\tempo, 60/60,
	\out, a,
	\rel, Pseq([18/18, Pseq([4/18], 6)], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf),
	\amp, 0.05,
).play;

/////////////////////for PANNER

Pbindef(\panning0,
	\instrument, \discreteOut,
	\group, ~pannerGroup,
	\in, ~pannerBus,
	\freq, Pseq([
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
	], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf)
).play;*/

/////////////////////////////////////CHOIR
Pbindef(\panning1,
	\instrument, \brownNoiz,
	\out, Pseq([
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
	], inf),
	\rel, Pseq([2/18, 2/18, 2/18, 2/18, 2/18, 2/18, 1/18], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf),
	\amp, Pseq([0.032, Pseq([0.015], 6)], inf),
).play;


Pbindef(\panning2,
	\instrument, \brownNoiz,
	\out, Pseq([
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
	], inf),
	\rel, Prand([2/18, 2/18, 2/18, 2/18, 2/18, 2/18, 1/18], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
		1, Pseq([9/18], 6),
	], inf),
	\amp, Pseq([0.02, Pseq([0.012], 2), 0.03, Pseq([0.014], 3)], inf),
).play;

Pbindef(\panning3,
	\instrument, \brownNoiz,
	\out, Pseq([
		Pseq([16,17,18,19,20,21], 1),
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
		[16,17,18,19,20,21],
		[8,9,0,1,16,17]
	], inf),
	\rel, Pseq([0.1/18, 0.5/18, 0.5/18, 0.5/18, 1/18, 0.5/18], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf),
	\amp, Pseq([0.02, Pseq([0.01], 6)], inf),
).play;
)


(
//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////STOP
//////////////////////////////////////////
Pbindef(\panning3).stop;
Pbindef(\panning2).stop;
Pbindef(\panning1).stop;
Pbindef(\panningGator).stop;
Pbindef(\panning0).stop;
~gatorsynth.free;
~bdksynth.free;
~bdksynth1.free;
);

//////////////////////////////////////////
//////////////////////////////////////////
///////////////////////////////////CHANGES
//////////////////////////////////////////
Pbindef(\panning2, \instrument, \whiteNoiz);
Pbindef(\panning3, \instrument, \whiteNoiz);
Pbindef(\panning1, \instrument, \whiteNoiz);

