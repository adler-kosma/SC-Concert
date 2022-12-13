// to do:
// dymanics on brown-noise perc.
// create more variations in rhythm
// make task: intro a while whithout 'lead you home'
// send lead you home in sam rhythmical pattern as brown noise. with pannerBus and Pbind?


(
ServerOptions.devices;
s.options.inDevice = "16A";
s.options.outDevice = "16A";
s.options.numInputBusChannels = 0;
s.options.numOutputBusChannels = 22;
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
*/
(
~buf0 = Buffer.readChannel(s, "/Users/adele21/Music/SuperCollider/Mobilen/ljuden/10-voice_flix_1.wav", channels:[0]);
~buf1 = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/10-voice_flix.wav", channels:[0]);
~buf2 = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/12-Wood_Block.wav", channels:[0]);
~bdk = Buffer.readChannel(s,"/Users/adele21/Music/For BD6K/lead you home.wav", channels:[0]);
~bdkrev = Buffer.readChannel(s,"/Users/adele21/Music/SuperCollider/lead_you_home_rev_rec_1.aiff", channels:[0]);
a = Bus.audio(s, 2); // master
b = Bus.audio(s, 2); // slave
~pannerBus = Bus.audio(s, 1);
)



(
SynthDef(\gator,  {
	arg inBusA, inBusB, lag=10, clampTime=0.01, relaxTime=0.1, slopeBelow=3, slopeAbove=1, thresh=0.1, speed=1, out=0;
	var kick, pads, snd, freq;
	kick = In.ar(inBusA, 1);
	pads = In.ar(inBusB, 1);
	snd = Compander.ar(pads, kick, thresh, slopeBelow, slopeAbove, clampTime.lag(lag), relaxTime.lag(lag));
/*	freq = Line.kr(0.5, 2.0, 300) * speed;
	snd = PanAz.ar(22, snd, LFSaw.kr(freq), 1, 2, 0);*/
	Out.ar(out, snd);
}).add;

/*SynthDef(\bdkbuffer_test, {
	arg buf, rate=1, start=0, amp=0.001;
	var sig, out;
	sig = PlayBuf.ar(1, buf, rate, 1, start, loop:1);
	sig = PanAz.ar(22, sig, LFSaw.kr(1), 1, 2, 0);
	// sig = sig * amp * EnvGate.new(fadeTime: 3);
	Out.ar(0, sig);
}).add;*/

SynthDef(\bdkbuffer, {
	arg out=0, buf, rate=(-1), start=0;
	var sig = PlayBuf.ar(1, buf, rate, 1, start, loop:1);
	var amp = 0.2/* * Line.kr(0.01, 0.2, 300)*/;
	sig = sig * amp * EnvGate.new(fadeTime: 3);
	Out.ar(out, sig);
}).add;

SynthDef(\buffers, {
	arg out=0, buf, rate=1, amp=0.5, lag=0.1;
	var env = EnvGen.kr(Env.perc, doneAction:2);
	var sig = PlayBuf.ar(1, buf, rate.lag(), 1, startPos:0, doneAction:2);
	sig = sig * amp * env;
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

SynthDef(\panner, {
	arg in=0, out=0, level=0.5, rel=1.0;
	var sig, env;
	env = EnvGen.kr(Env.perc(0.1, rel), doneAction:2);
	sig = In.ar(in) * level * env;
	// pan = PanAz.ar(10, sig, LFSaw.kr(speed));
	Out.ar(out, sig);
}).add;
)

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////PLAY
//////////////////////////////////////////
/*{Out.ar(~pannerBus, (BrownNoise.ar()*0.01))}.play;*/
(
// s.record;
//////////////////////Synths
~gatorsynth = Synth(\gator, [\inBusA, a, \inBusB, b, \slopeBelow, 1.8, \slopeAbove, 1, \clampTime, 0.01, \relaxTime, 0.1, \thresh, 0.1, \out, 0], 1, \addToTail);
~bdksynth = Synth(\bdkbuffer, [\out, ~pannerBus, \buf, ~bdk.bufnum]);



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

Pbus

/////////////////////for PANNER
Pbindef(\panning0,
	\instrument, \panner,
	\in, ~pannerBus,
	\out, Pseq([
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1),
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
).play;

/*Pbindef(\panning0,
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

/*/////////////////////////////////////CHOIR
Pbindef(\panning1,
	\instrument, \brownNoiz,
	\out, Pseq([
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1),
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
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1)
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
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1),
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1),
		[16,17,18,19,20,21],
		[8,9,0,1,16,17]
	], inf),
	\rel, Pseq([0.1/18, 0.5/18, 0.5/18, 0.5/18, 1/18, 0.5/18], inf),
	// \rel, Pseq([3, 3, 3, 1, 3, 3], inf),
	\dur, Pseq([
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([6/18], 6),
		1, Pseq([9/18], 6),
	], inf),
	\amp, Pseq([0.02, Pseq([0.01], 6)], inf),
).play;*/
)

//////////////////////////////////////////
//////////////////////////////////////////
///////////////////////////////////CHANGES
//////////////////////////////////////////
Pbindef(\panning3, \amp, Pseq([0.01, Pseq([0.03], 6)], inf));
Pbindef(\panning2, \amp, Pseq([0.01, Pseq([0.02], 6)], inf));
Pbindef(\panning1, \amp, Pseq([0.01, Pseq([0.01], 6)], inf));
(
Pbindef(\panning3, \rel, Pseq([3, 3, 3, 1, 3, 3], inf));
Pbindef(\panning2, \rel, Pseq([3, 3, 3, 1, 3, 3], inf));
Pbindef(\panning1, \rel, Pseq([3, 3, 3, 1, 3, 3], inf));
);
(
Pbindef(\panning3, \rel, Pseq([0.1/18, 0.5/18, 0.5/18, 0.5/18, 1/18, 0.5/18], inf));
Pbindef(\panning2, \rel, Pseq([2/18, 2/18, 2/18, 2/18, 2/18, 2/18, 1/18], inf));
Pbindef(\panning1, \rel, Pseq([2/18, 2/18, 2/18, 2/18, 2/18, 2/18, 1/18], inf));
);
(
Pbindef(\panning3, \rel, Pseq([0.1/18, 0.5/18, 0.5/18, 0.5/18, 0.1/18, 0.5/18], inf));
Pbindef(\panning2, \rel, Pseq([0.5/18, 0.5/18, 0.5/18, 0.1/18, 0.5/18, 0.1/18, 0.1/18], inf));
Pbindef(\panning1, \rel, Pseq([0.5/18, 1/18, 0.1/18, 0.1/18, 0.1/18, 0.1/18, 0.1/18], inf));
);
Pbindef(\panning2, \amp, Pseq([0.05, Pseq([0.02], 6)], inf));
Pbindef(\panning1, \amp, Pseq([0.05, Pseq([0.02], 6)], inf));

Pbindef(\panningGator, \rel, Pseq([18/18, Pseq([1/18], 6)], inf));
~bdksynth.set(\rate, 1);
~bdksynth.set(\rate, (-1));
~gatorsynth.set(\speed, 0.2);

~gatorsynth.set(\relaxTime, 0.1);
~gatorsynth.set(\clampTime, 0.1);

Pbindef(\panningGator, \out, a);

/*~bdksynth.set(\amp, 0.03); //Start amp
~bdksynth.set(\amp, 0.1);
~bdksynth.set(\amp, 0.2); //Final amp*/
~gatorsynth.set(\thresh, 0.1, \slopeBelow, 1.8, \slopeAbove, 1, \clampTime, 0.5, \relaxTime, 0.1);

~bdksynth2 = Synth(\bdkbuffer, [\out, 21, \buf, ~bdkrev.bufnum, \rate, (-1)]);
~bdksynth2.set(\rate, (-1), \out, 0);
~bdksynth2.set(\rate, (1), \out, 0);



///////////////////////INNER LOUD SPEAKERS ///Outer: 5, 13, 21
~bdksynth2.set(\out, 0);
~bdksynth2.set(\out, 8);
~bdksynth2.set(\out, 16);

~bdksynth2.set(\out, 21);

~bdksynth2.set(\rate, (-1));
~bdksynth2.free;

(
//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////STOP
//////////////////////////////////////////
Pbindef(\panning3).stop;
Pbindef(\panning2).stop;
Pbindef(\panning1).stop;
Pbindef(\panningGator).stop;
~gatorsynth.free;
~bdksynth.free;
)

//////////////////////////////////////////
//////////////////////////////////////////
////////////////////////////////////RANDOM
//////////////////////////////////////////

(
Pbindef(\panning1,
	\instrument, \brownNoiz,
	\out, Pseq([
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1)
	], inf),
	\rel, 0.3,
	\dur, Pseq([
		Pseq([1, Pseq([8/18], 6)], 3),
		Pseq([1, Pseq([7/18], 6)], 3),
		Pseq([1, Pseq([6/18], 6)], 3),
		Pseq([1, Pseq([5/18], 6)], 3),
		Pseq([1, Pseq([4/18], 6)], 3),
		Pseq([1, Pseq([3/18], 6)], 6),
		Pseq([1, Pseq([1], 6)], 3)
	], 1),
	\amp, Pseq([0.01, Pseq([0.03], 6)], inf),
).play;
)

Pbindef(\panning1, \amp, 0.007).play;

Pbindef(\panning1, \tempo, 60/60).play;
Pbindef(\panningA, \tempo, 60/60).play;


Pbindef(\panning1).stop;
Pbindef(\panningA).stop;

(
Pbindef(\panningA,
	\instrument, Prand([\brownNoiz], inf),
	\out, Pseq([
		[0,1,2,3,4,5],
		[16,17,18,19,20,21],
		[8,9,10,11,12,13],
	], inf),
	\dur, Pseq([1, 1, 1, 1, 1, 1, 1, 1, 9/18], inf),
	\amp, Pseq([0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.009, 0.01, 0.02], inf)
);
)

(
Pbindef(\panningA,
	\instrument, Prand([\brownNoiz], inf),
	\out, Pseq([
		[0,1],
		[2,3],
		[4,5],
		[16,17],
		[18,19],
		[20,21],
		[8,9],
		[10,11],
		[12,13],
	], inf),
	\dur, Pseq([Pseq([6/18], 18), Pseq([3/18],16), Pseq([6/18],18)], inf),
	\amp, Pseq([0.01, Pseq([0.03], 6)], inf),
);
)

//////////////////////////////////////////
//////////////////////////////////////////
///////////////////////////////////BUFFERS
//////////////////////////////////////////

(
Pbindef(\panning1,
	\instrument, \buffers,
	\buf, ~buf2.bufnum,
	\lag, 0.2,
	\rate, Pwhite(0.7, 1.4),
	\out, Pseq([
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1),
		[16,17,18,19,20,21],
		Pseq([16,17,18,19,20,21], 1),
		[8,9,10,11,12,13],
		Pseq([8,9,10,11,12,13],1)
	], inf),
	\dur, Pseq([
		Pseq([1, Pseq([8/18], 6)], 3),
		Pseq([1, Pseq([7/18], 6)], 3),
		Pseq([1, Pseq([6/18], 6)], 3),
		Pseq([1, Pseq([5/18], 6)], 3),
		Pseq([1, Pseq([4/18], 6)], 3),
		Pseq([1, Pseq([3/18], 6)], 6),
		Pseq([1, Pseq([1], 6)], 3)
	], 1),
	\amp, Pseq([0.2, Pseq([0.4], 6)], inf),
).play;
)

(
Pbindef(\panning1,
	\instrument, \buffers,
	\buf, ~buf2.bufnum,
	\lag, 0.05,
	\rate, Pseq([0.5, Pseq([1], 6)], inf),
	\out, Pseq([
		[0,1,2,3,5,0],
		Pseq([0,1,2,3,5,0],1),
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
	], inf),
	\amp, Pseq([0.2, Pseq([0.3], 6)], inf),
).play;

Pbindef(\panningA,
	\instrument, \buffers,
	\buf, ~buf2.bufnum,
	\lag, 0.2,
	\rate, Pseq([0.4, Pseq([0.7], 6)], inf),
	\out, Pseq([
		[0,1,2,3,4,5],
		[16,17,18,19,20,21],
		[8,9,10,11,12,13],
	], inf),
	\dur, Pseq([1, 1, 1, 1, 1, 1, 1, 1, 9/18], inf),
	\amp, Pseq([0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.09, 0.1, 0.2], inf)
).play;
)

