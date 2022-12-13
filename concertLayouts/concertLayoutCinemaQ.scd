
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"INTRO - Moog73 - VE-20 LOOP"
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
(
~reverb.set(\level, 0.10);
Pbindef(\midiMoog).play;
~moog.set(\outBus, t.aBus);
Pbindef(\panning).play;
~mic.set(\outBus, t.aBus);
)
/*

Pbindef(\midiMoog, \dur, 0.7/8); //0.7
Pbindef(\midiMoog, \dur, 0.1); //lek med dur och landa på 0.1
~pannerCircle.set(\dir, 1, \speed, 1);

*/
(
Pbindef(\midiMoog).stop;
Pbindef(\midiMoog1, \dur, Pseq([7], inf), \degree, Pseq([0], 1)).play;
Pbindef(\panning, \freq, 5).play; //VOLUME ON MIC
)

~mic.set(\outBus, t.bBus);
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"ONE - sång PANKOW1 4/5 ".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

(
~pannerCircle.set(\dir, 1, \speed, 0.1);
~reverb.set(\level, 0.1);
Pbindef(\klank, \outBus, t.aBus, \amp1, 1, \dur, Pseq([1/3], inf)).play;
~mic.set(\outBus, t.aBus);
~passGator.set(\outBus, t.panBus); //~passGator
)
/*
~pannerCircle.set(\dir, 1, \speed, 0.1);
Pbindef(\klank, \outBus, t.aBus, \amp1, 1, \dur, Pseq([1/6, 1/3, 1/3], inf)).play;

*/

(

~passGator.set(\outBus, t.panBusD);
Pbindef(\klank, \outBus, t.aBus, \amp1, 1.5, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;
Pbindef(\midiMoog, \root, 2, \dur, Pseq([Pseq([11/6], 1), Pseq([3/30], 10 )], inf)).play;
Pbindef(\midiMoog1).stop;
~moog.set(\outBus, t.bBus);
Pbindef(\panning, \freq, Prand([2, 4, 5, 3], inf));
)

/*
~moog.set(\outBus, t.outBus);
\\ CUTOFF
Pbindef(\panning, \freq, 5); //Byt output 2,3,4,5
Pbindef(\panning, \freq, Prand([2, 4, 5, 3], inf));


*/

(
Pbindef(\midiMoog,
	\dur, Pseq([
		Pseq([1], 1),
		Pseq([0.7], 1),
		Pseq([0.1], 8),
		Pseq([0.5], 3)], inf));
)
/*
~moog.set(\outBus, t.revBus);
Pbindef(\midiMoog, \dur, 0.5);
*/

Pbindef(\klank, \dur, Pseq([1], 1));

(
Pbindef(\midiMoog, \dur, 0.5, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1),Pseq([1,0,7,5,6,3,2,4], 1)], inf)).play;
~moog.set(\outBus, t.aBus);
Pbindef(\klank, \outBus, t.outBus, \amp1, 0.9, \dur, 0.5).play;
~mic.set(\outBus, t.aBus);
)

Pbindef(\midiMoog, \dur, 1);
~moog.set(\outBus, t.outBus);
(
Pbindef(\midiMoog, \degree, 0, \dur, Pseq([5], 1)).play;
Pbindef(\midiMoog1).stop;
Pbindef(\klank, \dur, Pseq([1], 2));
)
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"TWO - Moog77 - KONSERT1 3 - VE-20 67.THIS1".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

1:
(
~korg.set(\outBus, t.outBus); /// VOLUME
~mic.set(\outBus, t.panBusD);
~passGator.set(\outBus, t.panBusD);
~moog.set(\outBus, t.panBusC);
Pbindef(\panning, \freq, Pseq([1,0,2,3], inf), \dur, 1).play; //play with this
)

(
Pbindef(\midiMoog2, //77!!!
	\dur, Pseq([
		Pseq([2/3], 1),
		Pseq([1/3], 1),
	], inf),
	\root, -2,
	\degree, -14,
).play;
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
	\outBus, t.aBus,
	\amp1, 1,
	\scale, Scale.minor,
	\dur, Pseq([1], inf),
	\degree, Pseq([1, 2, -3, 2, 1],inf),
	\root, -2
).play;
)

3:
// VOX LOOP

~sin1 = Synth(\sin, [\freq, 174.61, \outBus, t.panBusC, \amp, 0.1], t.synthGroup);
~sin2 = Synth(\sin, [\freq, 174.61*2, \outBus, t.panBusC, \amp, 0.001], t.synthGroup);

Pbindef(\klank, \degree, Pseq([1, 2, 3, 4, 3, -3, -4, 1, 2, -3], inf));// 1, 2, -3, 2, -1, 2

~pannerCircle.set(\speed, 3, \dir, -1); //0.1-3
~sin1.set(\amp, 0.6);

~moog.set(\outBus, t.aBus); //sustain play with it BASS
~mic.set(\outBus, t.bBus);
~korg.set(\outBus, t.bBus);

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
~sin1.free;
~sin2.free;
Pbindef(\klank).stop;



/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////// SKA JAG BEHÅLLA?°
"THREE - MOOG73 - PANKOW1 4".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

(
~moog.set(\outBus, t.outBus);
~korg.set(\outBus, t.bBus);
~mic.set(\outBus, t.outBus);
~passGator.set(\outBus, t.panBusC);
~pannerCircle.set(\speed, 0.1, \dir, 1);
Pbindef(\midiMoog1, \root, 3);
Pbindef(\midiMoog1).stop;
Pbindef(\midiMoog2).stop;
Pbindef(\klank).stop;
)

1:
(
Pbindef(\klank, \outBus, t.outBus, \degree, 3, \amp1, 0.7, \dur, Pseq([1], inf)).play;
Pbindef(\midiMoog1, \dur, Pseq([1], inf), \degree, Pseq([7,3,2,4,1,0,7,4], inf)).play;
)

1.1:
Pbindef(\midiMoog1, \dur, Pseq([3], 1)); Pbindef(\klank, \dur, Pseq([3], 1));

1.2:

~mic.set(\outBus, t.aBus); ~moog.set(\outBus, t.outBus);

2:
(
Pbindef(\midiMoog1, \dur, Pseq([0.3], inf)).play; Pbindef(\klank,  \degree, 2, \dur, Pseq([0.6], inf)).play;
Pbindef(\panning,
	\dur, Pseq([
		Pseq([1], 1),
		Pseq([0.7], 1),
		Pseq([0.1], 8)
	], inf)).play;
Pbindef(\midiMoog1, \root, 3);
)

3:
Pbindef(\midiMoog1).stop;  Pbindef(\grainP).stop; Pbindef(\klank).stop;

4:
(
Pbindef(\midiMoog1, \root, 2, \dur, Pseq([Pseq([0.3], 30), Pseq([0.1], 20)], inf), \degree, Pseq([7,3,2,4,1,0,7,4], inf)).play;
Pbindef(\panning, \freq, Pseq([2,3,4,5], inf), \dur, Pseq([Pseq([0.1], 20), Pseq([0.1], 20)], inf)).play;
Pbindef(\grainP, \speed, 0.5, \amp, 0.4, \dur, Pseq([Pseq([0.3], 15), Pseq([0.1], 10)], inf)*2).play;
Pbindef(\klank, \outBus, t.outBus, \degree, 4, \amp1, 0.5, \dur, Pseq([Pseq([0.9], 10), Pseq([1], 2)], inf)).play;
)
/*
Pbindef(\klank, \root, 3);
Pbindef(\midiMoog1, \root, 2).play;
Pbindef(\klank, \dur, Pseq([0.6], inf), \amp1, 0.5);
Pbindef(\grainP, \outBus, t.aBus);
*/
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"FOUR - MOOG73/74 - PANKOW1 spår6 - MIC "
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
( //KÖR BA TRYCK HÄR
Pbindef(\grainP).stop;
Pbindef(\midiMoog1).stop;
Pbindef(\midiMoog2).stop;
Pbindef(\midiMoog3).stop;
Pbindef(\midiMoog4).stop;
Pbindef(\midiMoog).stop;
Pbindef(\klank).stop;
Pbindef(\sawP2, \outBus, t.revBus).play;
Pbindef(\panning, \freq, Pseq([2,3,4,5], inf), \dur, Pseq([Pseq([0.1], 20), Pseq([0.1], 20)], inf)).play;
)
~mic.set(\outBus, t.aBus); //DELAY
(
~moog.set(\outBus, t.bBus);
~korg.set(\outBus, t.bBus);
Pbindef(\midiMoog1, \root, 7, \dur, 1, \degree, Pseq([7,3,2,4,1,0,7,4], inf)).play;
Pbindef(\klank, \outBus, t.outBus,\degree, 4, \root, 7 ,\amp1, 0.4, \dur, Pseq([Pseq([1/6], 10), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;
)

Pbindef(\midiMoog1, \root, 7, \dur, Pwrand([0.3, 0.1], [0.7, 0.3], inf)).play;

/*
(
~moog.set(\outBus, t.outBus); ///OBS HÖG VOLYM!, börja på NOLL
~moog.set(\outBus, t.aBus); ///börja på NOLL
~pannerCircle.set(\speed, 1);
~pannerCircle.set(\dir, -1);
Pbindef(\klank).stop;
*/



~korg.set(\outBus, t.revBus); //VOLUME
~pannerCircle.set(\speed, 0.1);
Pbindef(\sawP2, \outBus, t.bBus);
Pbindef(\midiMoog1).stop;
Pbindef(\sawP2).stop;


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"FIVE - Moog73 - KONSERT1 1+2".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
(
~moog.set(\outBus, t.aBus); //RESET
Pbindef(\midiMoog1).stop;
Pbindef(\klank).stop;
Pbindef(\midiMoog4).stop;
~mic.set(\outBus, t.aBus);
~pannerCircle.set(\speed, 0.1);
Pbindef(\brownPan1, \outBus, t.aBus).play; Pbindef(\brownPan0).play;
Pbindef(\panning).play;
)

Pbindef(\brownPan1, \outBus, t.aBus).stop; Pbindef(\brownPan0).stop;

(
~korg.set(\outBus, t.bBus); //KONSERT1 1+2
Pbindef(\brownPan1, \outBus, t.aBus).play; Pbindef(\brownPan0, \outBus, t.aBus).play;
Pbindef(\midiMoog4,
	\dur, Pseq([
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([2/3], 6),
		Pseq([1, Pseq([2/3], 6)], inf)
	], 1),
).play;
)



(
~moog.set(\outBus, t.outBus); ~mic.set(\outBus, t.aBus); ~passGator.set(\outBus, t.panBusD);
Pbindef(\brownPan0).stop; Pbindef(\brownPan1).stop;
Pbindef(\midiMoog4, \root, 4, \dur, Pseq([Pseq([2/3], 6), Pseq([1/3], 6)], inf)).play;
Pbindef(\midiMoog4, \degree, Pseq([Pseq([0,7,3,5,5,2,1], 3), Pseq([0,6,3,5,5,2,1], 3),Pseq([0,5,3,7,6,2,1], 3)], inf)*1);
Pbindef(\klank, \root, 4, \outBus, t.aBus, \amp1, 0.1, \dur, Pseq([1/3], inf)).play;
//Pbindef(\midiMoog4, \root, 4);
~pannerCircle.set(\dir, -1);
~pannerCircle.set(\speed, 0.1);
)

~moog.set(\outBus, t.aBus);
Pbindef(\midiMoog4).stop;

(
Pbindef(\brownPan0).play; Pbindef(\brownPan1).play;
Pbindef(\midiMoog4, \root, 4, \dur, Pseq([Pseq([2/3], 6), Pseq([1/3], 6)], inf)).play;
Pbindef(\klank, \dur, 1).play;
~moog.set(\outBus, t.aBus);
)

Pbindef(\midiMoog4, \root, 4, \dur, Pseq([Pseq([1/3], 6)], inf)).play;

Pbindef(\klank).stop;

Pbindef(\midiMoog4).stop;
/*

~korg.free;
~moog.free;
~mic.free;
~grainSynth.free;
Pbindef(\midiMoog).stop;
Pbindef(\midiMoog1).stop;
Pbindef(\midiMoog2).stop;
Pbindef(\midiMoog3).stop;
Pbindef(\midiMoog4).stop;
Pbindef(\klank).stop;
Pbindef(\brownPan1).stop;
Pbindef(\brownPan0).stop;
Pbindef(\panning).stop;

*/

