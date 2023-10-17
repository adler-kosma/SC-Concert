
/////////////////////////////
// INTRO - Moog14
/////////////////////////////
~reverb.set(\level, 0.1); //increase!
Pbindef(\midiMoog, \root, 2).play;

Pbindef(\midiMoog).stop;

(
Pbindef(\midiMoog,
	\root, 2,
	\degree, Pseq([
		Pseq([0, 7, 5, 6, 3, 2, 4, 1], 3),
		Pseq([0, 7, 5, 6, 3, 2, 4, 2, 8], 1),
		Pseq([0, 6, 7, 1, 4, 5, 3, 2, 8], 2),
		Pseq([0, 6, 7, 1, 4, 5, 3, 1, 4, 5, 3, 6, 3, 2, 4, 1], 1),
	], 4),
	\dur, Pseq([0.5], inf),
).play;
~reverb.set(\level, 0.1);
)

/////
// moog: WAVE, EG

/////////////////////////////
// SOMETHING - Moog14
/////////////////////////////

// OSC2 0%, OPEN ENVS
// ENV Filter R 0%
/////


/////////////////////////////
// Unusually lost bits //// MOOG 16 - CLICK 'VALUE' FOR APPERGIO
/////////////////////////////

~mic.set(\outBus, t.aBus);
~moog.set(\outBus, t.bBus);
~playBuf.play;
Pbindef(\midiMoog, \degree, 0, \dur, Pseq([1], inf), \root, -5, \dur, 1).play;

//TO STOP
Pbindef(\midiMoog).stop;


/////////////////////////////
// CLOSER TO TRUST - MOOG 16
/////////////////////////////

~klankamp = 0.5;
Pbindef(\klank, \outBus, t.aBus, \amp1, ~klankamp * 0.5, \dur, Pseq([1/3], inf)).play;
Pbindef(\klank, \amp1, ~klankamp * 0.7);

Pbindef(\klank, \dur, Pseq([1/6, 1/3, 1/3], inf)).play;


Pbindef(\klank, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;
/*
Pbindef(\midiMoog, \root, 2, \dur, Pseq([Pseq([11/6], 1), Pseq([3/30], 10 )], inf)).play;
*/
//Moog till bBus
~moog.set(\outBus, t.bBus);

(
Pbindef(\midiMoog,
	\root, 2,
	\dur, Pseq([
		Pseq([1], 1),
		Pseq([0.7], 1),
		Pseq([0.1], 8),
		Pseq([0.5], 3)], inf),
	\degree, Pseq([
		Pseq([0,7,5,6,3,2,4], 1),
		Pseq([
			Pseq([2,8,0,6,7,1,4,5,3], 10),
			Pseq([1,4,5,3,6,3,2,4], 1),
			Pseq([1,0,7,5,6,3,2,4], 9)], inf)
	], 1),
).play;
)

~reverb.set(\level, 0.2); //increase!

Pbindef(\klank, \amp1, 0.1*~klankamp); //\amp1 till 0
Pbindef(\klank).stop;

Pbindef(\midiMoog, \dur, 0.5, \degree, Pseq([2,8,0,6,7,1,4,5,3], inf)).play;

Pbindef(\midiMoog).stop;
