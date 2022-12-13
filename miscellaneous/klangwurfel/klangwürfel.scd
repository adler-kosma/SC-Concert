// to do:
// dymanics on brown-noise perc.
// create more variations in rhythm
// make task: intro a while whithout 'lead you home'
// send lead you home in sam rhythmical pattern as brown noise. with pannerBus and Pbind?


(
ServerOptions.devices;
s.options.inDevice = "Aggregate Device";
s.options.outDevice = "Aggregate Device";
s.options.numInputBusChannels = 0;
s.options.numOutputBusChannels = 66;
s.options.recChannels = 22;
s.boot;
s.meter;
)

s.plotTree;

~mfx = MasterFX(s, 22, [\limiter]); //create masterbus
(
ProxyChain.add(
	\reverb, \filter-> { |in|
		NHHall.ar(in, 1, 0.5, 200);
});
)
(
ProxyChain.add(
	\limiter, \filter-> { |in|
		Limiter.ar(in, 0.5);
});
)


~mfx.add(\limiter, 1);


MasterFX.clear('localhost');

/*[
"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/10-voice_flix_1.wav",
"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/10-voice_flix.wav"
]
Klangwürfel 1: 0-5 (channel 1-6)
 - The the left of the desk
Klanfwürfel 2: 8-13 (channel 9-14)
 - In the back
Klangwürfel 3: 16-21 (channel 17-22)
 - In the front

Membrane no. 1, 4, 5 face the inside of the triangle
Membrane no. 2, 3, 6 face wall
*/""
(
~buf0 = Buffer.readChannel(s, "/Users/adele21/Music/SuperCollider/Mobilen/ljuden/10-voice_flix_1.wav", channels:[0]);
~buf1 = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/10-voice_flix.wav", channels:[0]);
~buf2 = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/12-Wood_Block.wav", channels:[0]);
~bdk = Buffer.readChannel(s,"/Users/adele21/Music/For BD6K/lead you home.wav", channels:[0]);
~bdkrev = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/klangwürfel-lead you home/lead_you_home_rev_rec_1.aiff", channels:[0,1]);
a = Bus.audio(s, 2); // master
~pannerBus = Bus.audio(s);
)
~bdkrev.free;
(
SynthDef(\gator,  {
	arg inBusA, inBusB, lag=10, clampTime=0.01, relaxTime=0.1, slopeBelow=3, slopeAbove=1, thresh=0.1, speed=1, out=0;
	var kick, pads, snd, freq;
	kick = In.ar(inBusA, 1);
	pads = In.ar(inBusB, 1);
	snd = Compander.ar(pads, kick, thresh, slopeBelow, slopeAbove, clampTime.lag(lag), relaxTime.lag(lag));
	freq = Line.kr(0.5, 2.0, 300) * speed;
    snd = PanAz.ar(22, snd, LFSaw.kr(freq), 1, 2, 0);
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
	sig = WhiteNoise.ar(amp) * env;
	Out.ar(out, sig);
}).add;

SynthDef(\brownNoiz, {
	arg out, amp=0.01, rel=1.0;
	var sig, env;
	env = EnvGen.kr(Env.perc(0.1, rel), doneAction:2);
	sig = BrownNoise.ar(amp) * env;
	Out.ar(out, sig);
}).add;

SynthDef(\bdkbuffer1, {
	arg out, buf, rate=(-1), start=0, amp=1;
	var sig, line;
	sig = PlayBuf.ar(1, buf, rate, 1, start, loop:1);
	line = Line.ar(0.02, 0.3, 300);
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

//////////////////////Synths
~gatorsynth = Synth(\gator, [\inBusA, a, \inBusB, b, \slopeBelow, 1.8, \slopeAbove, 1, \clampTime, 0.01, \relaxTime, 0.1, \thresh, 0.1, \out, 24], 1, \addToTail);
Pbindef(\panningGator).play;
~bdksynth = Synth(\bdkbuffer, [\amp, 1.2, \out, b, \buf, ~bdk.bufnum]);
~bdksynth1 = Synth(\bdkbuffer1, [\out, ~pannerBus, \buf, ~bdkrev.bufnum, \rate, (-1), \amp, 2], ~synthGroup);
Pbindef(\panning3).play;
Pbindef(\panning2).play;
Pbindef(\panning1).play;

Pbindef(\panning0).play;
)
(

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
);

/////////////////////for PANNER
~synthGroup = Group(s);
~pannerGroup = Group.after(~synthGroup);

Pbindef(\panning0,
	\instrument, \discreteOut,
	\group, ~pannerGroup,
	\in, ~pannerBus,
	\freq, Pseq([
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1)
	], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf)
);

/*
Pbindef(\panning0,
	\type, \set,
	\id, ~bdksynth1,
	\args, #[out],
	\out, Pseq([
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1)
	], inf),
	//\rel, Pseq([2/18, 2/18, 2/18, 2/18, 2/18, 2/18, 1/18], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf)
);*/

/////////////////////////////////////CHOIR
Pbindef(\panning1,
	\instrument, \brownNoiz,
	\out, Pseq([
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1)
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
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1)
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
);

Pbindef(\panning3,
	\instrument, \brownNoiz,
	\out, Pseq([
		Pseq([16,17,18,19,20,21], 1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
		[0,1,2,3,4,5],
		Pseq([0,1,2,3,4,5],1),
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
);
)

//////////////////////////////////////////
//////////////////////////////////////////
///////////////////////////////////CHANGES
//////////////////////////////////////////
Pbindef(\panning2, \instrument, \whiteNoiz);
Pbindef(\panning3, \instrument, \whiteNoiz);
Pbindef(\panning1, \instrument, \whiteNoiz);

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
)

