s.recChannels = 7;
s.meter;s.plotTree;
(
Pbindef(\midiMoog,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~midiBus,
	\chan, 0,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([0,7,5,6,3,2,4], 1),
		Pseq([
			Pseq([2,8,0,6,7,1,4,5,3], 10),
			Pseq([1,4,5,3,6,3,2,4], 1),
			Pseq([1,0,7,5,6,3,2,4], 9)], inf)
	], 1),
	\root, Pseq([
		Pseq([-1], 30), //Gå ett helt tonsteg upp för varje tonartshöjning /Arvid
		Pseq([0], 30),
		Pseq([1], 30),
		Pseq([2], inf),
	], 1),
	\dur, Pseq([Pseq([1], 4), Pseq([0.2], 10)], inf),
);
)

s.record;
Pbindef(\midiMoog).play;
Pbindef(\midiMoog,\dur, Pseq([Pseq([1], 4), Pseq([0.2], 10)], inf));
Pbindef(\midiMoog, \dur, 0.9);
Pbindef(\midiMoog, \dur, 0.1);
Pbindef(\midiMoog, \degree, 0, \dur, Pseq([5], 1)).play;



Pbindef(\midiMoog).stop;

(
~aBus = Bus.audio();
~bBus = Bus.audio();
~revBus = Bus.audio();
~midiBus = MIDIOut.new(1);
CmdPeriod.add({(0..127).do{arg n; ~midiBus.noteOff(0,n)}});
)

(
~korg = Synth(\D1200, [\inBus, 3, \outBus, ~bBus]);
~gator = Synth(\gator, [\inBusA, ~aBus, \inBusB, ~bBus], nil, 'addToTail');
~moog = Synth(\moog, [\inBus, 2, \outBus, ~aBus]);
~revsynth = Synth(\reverb, [\inBus, ~revBus], nil, 'addToTail');
)

(
~korg.free;
~gator.free;
~moog.free;
~revsynth.free;
)

(
SynthDef.new(\D1200,{
	arg inBus, outBus, amp=1;
	var input;
	input = SoundIn.ar(inBus) * amp;
	Out.ar(outBus, input);
	Out.ar(6, input); //recording
}).add;

SynthDef(\gator,  {
	arg inBusA, inBusB, gate=1, lag=10, clampTime=0.01, relaxTime=0.1, thresh=0.5,
	slopeBelow=3, slopeAbove=1;
	var kick, pads, vocal, snd, env, outSig;
	env = EnvGen.kr(Env.asr(), gate, doneAction: 2);
	kick = In.ar(inBusA, 1);
	pads = In.ar(inBusB, 1);
	snd = Compander.ar(pads, kick, thresh, slopeBelow, slopeAbove, clampTime.lag(lag), relaxTime.lag(lag));
	outSig = (kick + snd) * env;
	Out.ar(0, outSig);
	Out.ar(~revBus, outSig);
	Out.ar(3, snd); //recording
}).add;

SynthDef.new(\moog, {
	arg inBus, outBus, amp=1;
	var input, filter, filter0;
	input = SoundIn.ar(inBus) * amp;
	filter = BBandStop.ar(input, 400, 2);
	filter0 = LPF.ar(filter, 1000);
	Out.ar(outBus, filter0);
	Out.ar(2, filter0); //recording
}).add;

SynthDef(\reverb, {
	arg inBus, outBus, level=0.1, gate=1;
	var input, env, rev;
	env = EnvGen.ar(Env.asr(), gate, doneAction: 2);
	input = In.ar(inBus, 1) * env * level.lag(10);
	input = Pan2.ar(input);
	rev = NHHall.ar(input, 5, 0.5, 200, 0.5, 4000, 0.1, 0.5, 0.5, 0.2, 0.3);
	Out.ar(0, rev*0.6);
	Out.ar(4, rev*0.6); //recording
}).add;
)