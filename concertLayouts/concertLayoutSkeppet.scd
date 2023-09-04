
(
p = Pbindef(\midiMoog, \root, 2, \dur, Pseq([1], 300));
m = SimpleMIDIFile( "~/Desktop/intro.mid" );
m.init1( 2, 120, "4/4" );
m.fromPattern( p );
)

m.plot;
m.p.play; // note numbers are not rounded
p.play; // compare
m.write; // when writing to file note numbers are rounded (MIDI file format doesn't allow floats)

/////////////////////////////
// INTRO - Moog73
/////////////////////////////
~reverb.set(\level, 0.1);
Pbindef(\midiMoog).play;

//lek med dur och landa på 0.1
Pbindef(\midiMoog, 	\root, 2, \dur, 0.7/7);
(
Pbindef(\midiMoog,
	\instrument, \saw,
	\dur, Pseq([
		Pseq([
			Pseq([1], 1),
			Pseq([0.7], 1)
		], inf),
	], inf)
);
)

/////////////////////////////
// SOMETHING - Moog73
/////////////////////////////

Pbindef(\midiMoog,
	\degree, Pseq([0,7,5,6,1], inf),
	\dur, Pseq([0.7], inf),
	\root, 2
);


//fade out moog

/*

Filter + Volume S : increase

*/

//SING IT



/////////////////////////////
// CLOSER TO TRUST
/////////////////////////////
//land on D and run this shit


Pbindef(\klank, \outBus, t.a1Bus, \amp1, ~klankAmp, \dur, Pseq([1/3], inf)).play;
Pbindef(\klank, \amp1, ~klankAmp*0.6);

Pbindef(\klank, \outBus, t.a1Bus, \dur, Pseq([1/6, 1/3, 1/3], inf)).play;


Pbindef(\klank, \outBus, t.a1Bus, \amp, ~klankAmp*0.6, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;
/*
Pbindef(\midiMoog, \root, 2, \dur, Pseq([Pseq([11/6], 1), Pseq([3/30], 10 )], inf)).play;
*/

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
);
)
Pbindef(\klank, \amp1, 0.01*~klankAmp); //\amp1 till 0
Pbindef(\klank).stop;

Pbindef(\midiMoog, \dur, 0.5, \degree, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1),Pseq([1,0,7,5,6,3,2,4], 1)], inf)).play;

Pbindef(\midiMoog, \degree, Pseq([2,8,0], 3), \dur, Pseq([0.5, 0.5, 4], 1));
Pbindef(\midiMoog).stop;

/////////////////////////////
// Unusually lost bits //// MOOG 16
/////////////////////////////
//FÖRST: THE CONVERSATION WAS GOOD

//SEN: Snurra skitlångsamt
(
Pbindef(\sawP2,
	\instrument, \saw,
	\group, t.synthGroup,
	\outBus, t.sawBus,
	\dur, 3,
	\amp, Pseq([Pseq([0.3, 0.4, 0.6, 0.7], 1), Pseq([1], inf)], 1)*~sawAmp,
	\atk, 1,
	\rel, 2,
	\scale, Scale.chromatic,
	\degree, Pseq([8,6,3], inf),
	\root, -3,
	\outBus, t.sawBus
).play;
)
Pbindef(\sawP2, \amp, ~sawAmp*1.4);
/*
Pbindef(\sawP2).stop;
*/
//SPELA IN
(
~record = Synth(\record, [\bufNum, t.voiceBuf], t.synthGroup);
~sound = Buffer.readChannel(s, "/Users/adele21/Music/06-Gleimtunnel.wav", channels: [0]);
)

(
~record.free;
~noise = Synth(\playBackBuf, [\outBus, t.bBus, \outBusRev, 0, \bufNum, ~sound, \amp, 1], t.synthGroup);
~reverb.set(\inBus, t.revBus, \outBus, t.outBus1, \level, 0.1);
)
~noise.free;
~voice1 = Synth(\playBackBuf, [\outBus, t.a1Bus, \bufNum, t.voiceBuf, \centerFreq, 300, \bw, 2, \amp, 0.05], t.synthGroup);
~voice2 = Synth(\playBackBuf, [\outBus, t.a2Bus, \bufNum, t.voiceBuf, \centerFreq, 300, \bw, 2, \amp, 0.05], t.synthGroup);
~voice1.set(\amp, 0.3);


~voice1.set(\amp, 0.2);
~voice2.set(\amp, 0.1);

~pannerCircle1.set(\width, 2);
~pannerCircle2.set(\width, 2);

Pbindef(\delayPdef).stop;

~noise.free;

(
~noise.free;
~voice1.free;
~voice2.free;
)

//SAW NER
Pbindef(\sawP2, \amp, ~sawAmp * 0.1);

//nicka till arvid
Pbindef(\midiMoog, \degree, Pseq([0], inf), \dur, Pseq([1], inf), \root, -5, \dur, 1).play;
Pbindef(\midiMoog, \degree, Pseq([[4,1,0,1]], inf)).play;

Pbindef(\midiMoog, \degree, Pseq([[7,3,2, 3], [4,1,0,1], [0,7,4, 7], [2,5,1,5]], inf), \dur, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1),Pseq([1,0,7,5,6,3,2,4], 1)], inf) / 10);

//SAW UPP
Pbindef(\sawP2, \amp, ~sawAmp * 0.7);
//TO STOP
Pbindef(\midiMoog, \degree, Pseq([[7,3,2, 3], [4,1,0,1], [0,7,4,7], [2,5,1,5]], 1));
Pbindef(\midiMoog).stop;

//nicka till arvid
Pbindef(\sawP2, \amp, ~sawAmp * 0.6, \degree, Pseq([9,7,2], inf));
Pbindef(\sawP2, \amp, ~sawAmp * 0.8);
Pbindef(\sawP2, \degree, Pseq([9,7,2], 1), \amp, ~sawAmp * 0.6);
Pbindef(\sawP2).stop;