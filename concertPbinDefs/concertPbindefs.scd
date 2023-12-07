
/////////////////////// Pbindef's

///////////////////////
///////////////////////
///////////////////////

Pbindef(\midiMoog,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([0,7,5,6,3,2,4], 1),
		Pseq([
			Pseq([2,8,0,6,7,1,4,5,3], 10),
			Pseq([1,4,5,3,6,3,2,4], 1),
			Pseq([1,0,7,5,6,3,2,4], 9)], inf)
	], 1),
	\root, 2,
	\dur, Pseq([
		Pseq([
			Pseq([1], 1),
			Pseq([0.1], 8),
			Pseq([0.7], 1)
		], inf),
	], inf)
);

Pbindef(\klank,
	\instrument, \klank,
	\group, t.synthGroup,
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
	\ut, t.aBus,
);