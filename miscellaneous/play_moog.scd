s.options.device = "UltraLite-mk4"; //FIRST STEP
s.options.sampleRate = 48000;
s.recChannels = 4;
s.meter;s.plotTree;

~revBus = Bus.audio();
MIDIClient.init;
MIDIIn.connectAll;
MIDIClient.sources;
~midiBus = MIDIOut.new(1);
CmdPeriod.add({(0..127).do{arg n; ~midiBus.noteOff(0,n)}});

(
~moog = Synth(\moog, [\inBus, 2, \outBus, ~revBus]);
~reverb = Synth(\reverb, [\inBus,  ~revBus, \outBus, 0], nil, 'addToTail');
)
~moog.set(\outBus, 0);
~reverb.set(\level, 0.3);
~gator.set(\relaxTime, 0.1 );

Pbindef(\midiMoog).play;
Pbindef(\midiMoog).stop;

~reverb.free;
~moog.free;

(
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
	Out.ar(outBus, rev*level);
	Out.ar(outBus, input);
}).add;

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
		Pseq([-2], 30),
		Pseq([-1], 30),
		Pseq([1], 30),
		Pseq([2], inf),
	], 1),
	\dur, Pseq([
		Pseq([
			Pseq([1], 1),
			Pseq([0.1], 8),
			Pseq([0.7], 1)
		], inf),
	], inf)
);

)

