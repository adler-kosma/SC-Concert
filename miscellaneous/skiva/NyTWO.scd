"TWO - Moog77 - KONSERT1 3 - VE-20 67.THIS1".postln;
t = Konsert1();
s.recChannels = 4;

/////////////////////////////////////////////////////////////////////
(
~moog = Synth(\moog, [\inBus, 2, \outBus, 0, \amp, 1], t.synthGroup);
~korg = Synth(\D1200, [\inBus, 3, \outBus, 1], t.synthGroup);

~pannerCircle = Synth(\pannerCircle, [\inBus, t.panBusC, \outBus, 0, \speed, 0.1, \level, 1, \dir, 1], t.panGroup, 'addToTail');
)
/////////////////////////////////////////////////////////////////////

1:

(
s.record;
Pbindef(\midiMoog2, //77!!!
	\dur, Pseq([
		Pseq([2/3], 1),
		Pseq([1/3], 1),
	], inf),
	\root, -2,
	\degree, -14,
).play;

Pbindef(\klank,
	\instrument, \klank,
	\scale, Scale.minor,
	\root, 2,
	\degree, Pseq([4,0,1,2,3,2,1],inf),
	\i_freq, 164.81,
	\val, 466.16,
	\dur, 1/3,
	\sus, 0.1,
	\amp1, 0.4,
	\atk, 0.01,
	\rel, 0.1,
	\outBus, 2,
	\group, t.synthGroup,
);
)

2:
(
Pbindef(\midiMoog2,
	\dur, Pseq([
		Pseq([2/3], 1),
		Pseq([1/6], 2),
	], inf)
).play;

Pbindef(\klank,
	\amp1, 1,
	\scale, Scale.minor,
	\dur, Pseq([1], inf),
	\degree, Pseq([1, 2, -3, 2, 1],inf),
	\root, -2
).play;
)

3:
// VOX LOOP
s.record;
~sin1 = Synth(\sin, [\freq, 174.61, \outBus, t.panBusC, \amp, 0.1], t.synthGroup);
~sin2 = Synth(\sin, [\freq, 174.61*2, \outBus, t.panBusC, \amp, 0.001], t.synthGroup);

Pbindef(\klank, \degree, Pseq([1, 2, 3, 4, 3, -3, -4, 1, 2, -3], inf));// 1, 2, -3, 2, -1, 2
Pbindef(\klank, \degree, Pseq([1, 2, -3, 2, -1, 2], inf));

~pannerCircle.set(\speed, 0.1, \dir, 1); //0.1-3
~sin1.set(\amp, 0.15);
~sin1.set(\freq, 174.61);
~sin2.set(\freq, 174.61*3, \amp, 0.003);

//MOOG sustain play with it BASS

Pbindef(\klank).stop;
Pbindef(\midiMoog2).stop;

4:
(
Pbindef(\midiMoog2, //77!!!
	\dur, Pseq([
		Pseq([
			Pseq([1/6], 2),
			Pseq([1/3], 2),
			Pseq([2/3], 1),
		], 4),
		Pseq([1/3], 3),
	], inf),
).play;

Pbindef(\klank,
	\dur, Pseq([1/3], inf),
	\degree, Pseq([0, 2, -3, 2, 1], inf), // 1, 2, -3, 2, -1, 2
	\root, -2
).play;
)


/*
~pannerCircle.set(\speed, 0.3, \dir, -1);
*/

~sin1.set(\amp, 0.1);
~sin2.set(\amp,0.001);

Pbindef(\klank).stop;

~moog.free;
