
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
(
~scale = PatternProxy(Scale.minor);
~degree = PatternProxy(Pseq([Pseq([1,-1,0,6,7,1,4,5,3], 1), Pseq([2,8,0,6,7,1,4,5,3], inf)], 1));
~root = PatternProxy(Pseq([
		Pseq([-2], 18),
		Pseq([-1,-2,-2,-1,-1,0,-1,0], 2),
		Pseq([1,1,1,0,0,0,-1,1,1], 2),
	    Pseq([1,2,1,2,2,1,2,2,1], 2),
		Pseq([2], inf),
	], 1));
x = [ 1.1, 1, 1.01, 1, 1, 1.2, 1, 0.9, 1 ];
~dur = PatternProxy(Prand(x, inf));
w = x.sum;
m = Routine.new({
	loop {
		Pbindef(\midiMoog,
			\type, \midi,
			\midicmd, \noteOn,
			\midiout, t.midiBus,
			\chan, 0,
			\scale, ~scale,
			\root, ~root,
			\degree, ~degree,
			\dur, ~dur,
		).play;
		w.wait;
		Pbindef(\midiMoog).play;

	}
});
)
m.play;
m.reset;
m.stop;
Pbindef(\midiMoog).stop;

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"INTRO - Moog73 - PANKOW1 4/5"
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

x = [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ]; ~dur.source = Pseq(x, inf);
x = [0.2, 0.4, 0.2, 0.4, 0.2, 0.4, 0.2, 0.4, 0.2]; ~dur.source = Pseq(x, inf);
~scale.source = Pwrand([Scale.melodicMinor, Scale.minor], [2,8].normalizeSum, inf);
~root.source = Pseq([2], inf);
~degree.source = Pseq([2,8,0,6,7,1,4,5,3], inf);
~degree.source = Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10), Pseq([1,4,5,3,6,3,2,4], 1), Pseq([1,0,7,5,6,3,2,4], 9)], inf);// 7-8 fuck around

~reverb.set(\level, 0.15);
~moog.set(\outBus, t.vocBus);
~mic.set(\outBus, t.vBus);
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"ONE - sång".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
//
// (
// ~moog.set(\outBus, t.bBus);
// Pbindef(\klank, \outBus, t.aBus, \amp1, 1, \dur, Pseq([1/3], inf)).play;
// ~mic.set(\outBus, t.outBus);
// ~passGator.set(\outBus, t.panBus);
// )
// /*
// ~mic.set(\outBus, t.aBus)
// ~pannerCircle.set(\dir, -1, \speed, 0.1);
// Pbindef(\klank, \outBus, t.aBus, \amp1, 1, \dur, Pseq([1/6, 1/3, 1/3], inf)).play;
//
// */
//
// (
// ~passGator.set(\outBus, t.panBusD);
// Pbindef(\klank, \outBus, t.vBus, \amp1, 1, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;
// ~dur.source = Pseq([Pseq([11/6], 1), Pseq([3/30], 10 )], inf);
// ~moog.set(\outBus, t.bBus);
// )
//
// /*
// ~moog.set(\outBus, t.outBus);
// \\ CUTOFF
// Pbindef(\panning, \freq, 5);
//
//
// */
//
//
// ~dur.source = Pseq([
// 	Pseq([1], 1),
// 	Pseq([0.7], 1),
// 	Pseq([0.1], 8),
// Pseq([0.5], 3)], inf);
//
// /*
// ~moog.set(\outBus, t.revBus);
// Pbindef(\klank, \outBus, t.bBus, \amp1, 0.6);
// Pbindef(\midiMoog, \dur, 0.5);
// */
//
// Pbindef(\klank).stop;
//
// (
// ~dur.source = 0.5;
// ~degree.source = Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1), Pseq([1,0,7,5,6,3,2,4], 9)], inf).play;
//
// ~moog.set(\outBus, t.aBus);
// Pbindef(\klank, \outBus, t.bBus, \amp1, 0.9).play;
// //~mic.set(\outBus, t.bBus);
// )
// ~dur.source = 1;
// ~moog.set(\outBus, t.outBus);
// (
// ~degree.source =  0;
// ~dur.source = Pseq([5], 1);
// Pbindef(\midiMoog).stop;
// p.stop;
// )
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"TWO - Moog73 - KONSERT1 4/(5)".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
(
~passGator.set(\outBus, t.panBusD);
~moog.set(\outBus, t.aBus);
~root.source = -32;
~degree.source =  Pseq([0], inf);
~dur.source = Pseq([Pseq([1/3], 1), Pseq([4/3], 1), Pseq([1/2], 1)], inf)*1;
~grainSynth = Synth(\grainBuf, [\buf, ~perc.bufnum, \minRate, 0.1, \maxRate, 0.12, \outBus, t.aBus, \lineDur, 100, \amp, 0.4], t.synthGroup);
~korg.set(\outBus, t.bBus);
Pbindef(\panning, \freq, Pseq([5,4,3,2], inf)).play;
Pbindef(\klank, \outBus, t.bBus, \root, -3, \degree, Pseq([0,3,-1,1],inf), \amp1, 1, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;

)
/*
Pbindef(\klank, \degree, Pseq([5,0,1,4,3,2,1],inf));
~pannerCircle.set(\speed, 4, \dir, -1);

~passGator.set(\outBus, t.panBusC);
*/

( //PLAY WITH IT
~grainSynth.set(\amp, 2, \minRate, 2.05, \maxRate, 4, \minFreq, 0.11, \maxFreq, 1);

)
(
~moog.set(\outBus, t.aBus);
~grainSynth.set(\outBus, t.outBus);
Pbindef(\panning).play; //on and off
)

(

~grainSynth.set(\minRate, 0.1, \maxRate, 0.2, \minFreq, 0.5, \maxFreq, Pkey(\minFreq)*1.0001);
~dur.source = Pseq([Pseq([1/3], 1),Pseq([4/3], 1),Pseq([1/2], 1)], inf)*0.5;
)
~grainSynth.free;
/*

~pannerCircle.set(\speed, 5, \dir, 1);
jättehög speed!
*/
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"THREE - MOOG73 - PANKOW1 4".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

	/*
	~moog.set(\outBus, t.outBus);
	~passGator.set(\outBus, t.panBusC);
	Pbindef(\midiMoog1, \root, 3);
	Pbindef(\midiMoog1).stop;
	Pbindef(\midiMoog2).stop;
	*/
//1:
(
~pannerCircle.set(\speed, 0.1, \dir, 1);
~mic.set(\outBus, t.outBus);
~dur.source = Pseq([1], inf);
~root.source = 2;
~degree.source = Pseq([7,3,2,4,1,0,7,4], inf); [7,3,2,4,1,0,7,4].scramble;
m.play;
Pbindef(\klank, \outBus, t.outBus, \degree, 3, \amp1, 0.7, \dur, Pseq([1], inf));

)
//
~dur.source = Pseq([3], 1); Pbindef(\klank, \dur, Pseq([3], 1));
//
~mic.set(\outBus, t.aBus); ~moog.set(\outBus, t.outBus);
//

x = [ 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.7 ];
~dur.source = Pseq(x, inf);
~degree.source = Pseq([7,3,2,4,1,-1,8,4], inf);
~root.source = Prand([-3,2,2,-5,2], inf);
w = x.sum;
m.play;
Pbindef(\midiMoog).play; Pbindef(\klank, \degree, 2, \dur, Pseq([0.6], inf)).play;


Pbindef(\panning).play;

(
//////////////////////
"THREE MOOG OSC1 16'- KONSERT1 6".postln; //OBS OBS OBS OBS
//////////////////////
// Moog - OSC 16'

~root.source = 4;
~dur.source = Pseq([Pseq([0.3], 24), Pseq([0.1], 24)], inf);
~degree.source = Pseq([7,3,2,4,1,0,7,4], inf);
Pbindef(\panning, \freq, Pseq([2,3,4,5], inf), \dur, Pseq([Pseq([0.1], 20), Pseq([0.1], 20)], inf)).play;
Pbindef(\grainP, \speed, 0.7, \amp, 0.4, \dur, Pseq([Pseq([0.3], 15), Pseq([0.1], 10)], inf)*2).play;
Pbindef(\klank, \outBus, t.outBus, \root, 4, \degree, Pseq([Pseq([0], 50), Pseq([-1], 30)], inf), \amp1, 0.6, \dur, 0.1/*Pseq([Pseq([0.9], 10), Pseq([1], 2)], inf)*/).play;
)
~degree.source = Pseq([Pseq([7,3,2,4,1,0,7,4], 3), Pseq([3,0,7,3,2,4,0,8], 2)], inf);
~scale.source = Scale.mixolydian;
~scale.source = Scale.minor;
~dur.source = Pseq([Pseq([0.3], 24), Pseq([0.1], 24)], inf);

x = Array.fill(8, {arg i; i* i.rand(0.1,0.5)});
x = [ 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3 ].rand + 0.1;
~dur.source = Pseq(x, inf); // * LINEEXP?
w = x.sum;
(0.1,0.3)

////////////////////////////////////////////////////////////////////////////HÄR HAR JAG INTE GJORT MER
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
Pbindef(\midiMoog).stop;
Pbindef(\klank).stop;
Pbindef(\sawP2, \outBus, t.revBus).play;
Pbindef(\panning).play;
)
(

~moog.set(\outBus, t.bBus);
~mic.set(\outBus, t.aBus);
~korg.set(\outBus, t.bBus);
Pbindef(\midiMoog1, \root, 7, \dur, 1, \degree, Pseq([7,3,2,4,1,0,7,4, Pseq([ 0, 7, 2, 1, 4, 4, 7, 3 ], 3)], inf)).play;
Pbindef(\klank, \outBus, t.outBus, \root, 7 ,\amp1, 0.4, \dur, Pseq([Pseq([1/6], 10), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;

)
Pbindef(\klank).stop; Pbindef(\sawP2, \outBus, t.revBus).stop;
Pbindef(\midiMoog1, \root, 7, \dur, Pwrand([0.3, 0.1], [0.7, 0.3], inf)).play; //.stop

	/*
	(
	~moog.set(\outBus, t.outBus); ///OBS HÖG VOLYM!, börja på NOLL
	~moog.set(\outBus, t.aBus); ///börja på NOLL
	~pannerCircle.set(\speed, 0.1);
	~pannerCircle.set(\dir, 1);
	*/




    Pbindef(\klank).stop;
    ~korg.set(\outBus, t.revBus); //VOLUME

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"FIVE - Moog73 - KONSERT1 1+2".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
(
    ~korg.set(\outBus, t.bBus);
	~moog.set(\outBus, t.aBus);
	Pbindef(\midiMoog1).stop;
	Pbindef(\klank).stop;
	~mic.set(\outBus, t.outBus);
	~pannerCircle.set(\speed, 1);
    Pbindef(\sawP2).play;

Pbindef(\brownPan1, \outBus, t.aBus).play; Pbindef(\brownPan0).play;

)
(
Pbindef(\sawP2, \root, 4, \amp, 0.06).play;
Pbindef(\brownPan1, \outBus, t.aBus).stop; Pbindef(\brownPan0).stop;
)
(
Pbindef(\sawP2).stop;
    Pbindef(\brownPan1, \outBus, t.outBus).play; Pbindef(\brownPan0).play;
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
	/*
	~moog.set(\outBus, t.outBus); ~mic.set(\outBus, t.aBus);
Pbindef(\brownPan1, \outBus, t.aBus).play;
	Pbindef(\midiMoog4).stop;
	~passGator.set(\outBus, t.panBusD);
    Pbindef(\panning).play;

	*/

(
	Pbindef(\brownPan0).stop; Pbindef(\brownPan1).stop;
	Pbindef(\midiMoog4, \root, 4, \dur, Pseq([Pseq([2/3], 6), Pseq([1/3], 6)], inf)*0.);
	Pbindef(\midiMoog4, \degree, Pseq([Pseq([0,7,3,5,5,2,1], 3), Pseq([0,6,3,5,5,2,1], 3),Pseq([0,5,3,7,6,2,1], 3)], inf));

	Pbindef(\klank, \root, 4, \outBus, t.aBus, \amp1, 0.7, \dur, Pseq([1/3], inf)).play;
	//Pbindef(\midiMoog4, \root, 4);
	~pannerCircle.set(\dir, -1);
	~pannerCircle.set(\speed, 1 );

)


/*
Pbindef(\midiMoog4, \dur, 5).stop;
Pbindef(\midiMoog4, \degree, 0, \dur, 1/3);
Pbindef(\brownPan0).play; Pbindef(\brownPan1).play;
Pbindef(\midiMoog4, \root, 4, \dur, Pseq([
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([2/3], 6),
	], inf));

Pbindef(\klank, \dur, 1); Pbindef(\midiMoog4, \degree, 0);
*/

/*
~konsert.next;
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

