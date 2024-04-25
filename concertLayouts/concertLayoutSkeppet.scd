
/////////////////////////////
// INTRO - Moog14
/////////////////////////////
Pbindef(\midiMoog, \root, 2).play; ~reverb.set(\level, 0.1); //Filter Release 0% glitch
~reverb.set(\level, 0.6);

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
~reverb.set(\level, 0.05);
)



/////
// moog: WAVE, EG

// OSC2 0%, OPEN ENVS
// ENV Filter R 0%
/////

/////////////////////////////
// Unusually lost bits //// MOOG 16
/////////////////////////////

(
~mic.set(\outBus, t.aBus); ~reverbVox.set(\level, 0);
~playBufBlunt = Synth(\playBackBufMono, [\buf, ~bluntNoiseBuf.bufnum, \outBus, t.bBus, \amp, 0.5], t.synthGroup);
)
~playBufBlunt.set(\amp, 0.4);


(
~reverb.set(\level, 0.05);
~reverbVox.set(\level, 0.1);
~playBufBlunt.free;
~mic.set(\outBus, 4);
)

(
~moog.set(\outBus, t.aBus);
~playBufDrums = Synth(\playBackBufMono, [\buf, ~lostBitsDrumsBuf.bufnum, \outBus, t.bBus, \amp, 0.5], t.synthGroup);
Pbindef(\midiMoog, \degree,
    Pseq([
        Pseq([0, 4, 7, 4], 3),
        Pseq([0, 0, 4, 7], 1),
], inf), \dur,
    Pseq([
        Pseq([1/8, 1/8, 1/8, 1/4], 3),
        Pseq([1/4, 1/8, 1/8, 1/8], 1),
    ], inf) * 1.5,
    \root, -5).play;

~gatorsettings = (revAmp: 0.5, lag:5, clampT:0.6, relT:2, thresh:0.1);
t.gator(~gatorsettings);
)

~playBufDrums.set(\amp, 0.6);

//TO STOP
(
~playBufDrums.free;
Pbindef(\midiMoog).stop;
~moog.set(\outBus, t.outBus);
)
/////////////////////////////
//Give/Take
/////////////////////////////
~reverbVox.set(\level, 0.0);


/////////////////////////////
//To Pieces
/////////////////////////////
(
~playBufToPieces = Synth(\playBackBuf, [\buf, ~toPiecesChoirBuf.bufnum, \outBus, 2, \amp, 0.2], t.synthGroup);
~playBufToPiecesRev = Synth(\playBackBufMono, [\buf, ~toPiecesChoirBufRev.bufnum, \outBus, t.revBus, \amp, 0.1, \loop, 0], t.synthGroup);
~reverbVox.set(\level, 0.05);
)

(
~playBufToPieces.free;
~playBufToPiecesRev.free;
)
~playBufToPieces.set(\amp, 0.2);
~playBufToPiecesRev.set(\amp, 0.1);

/////////////////////////////
// SOMETHING
/////////////////////////////

/////////////////////////////
// CLOSER TO TRUST - MOOG 16
/////////////////////////////

(
~reverb.set(\level, 0.1);
~klankamp = 1;
Pbindef(\klank, \ut, t.aBus, \amp1, 1, \dur, Pseq([1/3], inf)).play;
~playBufBlunt = Synth(\playBackBufMono, [\buf, ~bluntNoiseBuf.bufnum, \outBus, t.bBus, \amp, 0.1], t.synthGroup);
~playBufBlunt.set(\amp, 0.2);
)
Pbindef(\klank, \amp1, 1);
Pbindef(\klank, \dur, Pseq([1/6, 1/3, 1/3], inf)).play;
Pbindef(\klank, \amp1, 1.3);
Pbindef(\klank, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf), \amp1, 1.5).play;
Pbindef(\klank, \amp1, 1.5);

/*(
~moog.set(\outBus, t.bBus);

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
)*/

~reverb.set(\level, 0.5); //increase!

//\amp1 till 0
(
Pbindef(\klank).stop;
~reverb.set(\level, 0.1);
Pbindef(\midiMoog).stop;
)

(
~reverb.set(\level, 0.1);
~moog.set(\outBus, t.outBus);
Pbindef(\midiMoog, \dur, 0.5, \degree, Pseq([0,6,7,1,4,5,3,2,8], inf)).play;
)

(
Pbindef(\midiMoog).stop;
~playBufBlunt.free;
)