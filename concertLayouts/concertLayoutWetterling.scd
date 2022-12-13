/////////////////////////////
// INTRO - Moog73
/////////////////////////////
(
~gatorsettings = (inBusA1:t.a1Bus, inBusA2: t.a1Bus, inBusB:t.bBus, outBus1:t.outBus1, outBus2: t.outBus2, revOut: t.revBus, lag:10, clampT:0.1, relaxTime:1, gate:1, thresh:0.5);
t.gator(~gatorsettings);
)
~reverb.set(\level, 0.01);


Pbindef(\midiMoog).play;
~moog.set(\outBus,t.outBus);

//lek med dur och landa på 0.1
Pbindef(\midiMoog, 	\root, 2, \dur, 0.1);
(
Pbindef(\midiMoog, 	\dur, Pseq([
		Pseq([
			Pseq([1], 1),
			Pseq([0.1], 8),
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
Pbindef(\klank, \outBus, t.a1Bus, \amp1, 0.25, \dur, Pseq([1/3], inf)).play;
Pbindef(\klank).stop;

Pbindef(\klank, \outBus, t.a1Bus, \dur, Pseq([1/6, 1/3, 1/3], inf)).play;


Pbindef(\klank, \outBus, t.a1Bus, \amp, 0.2, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;
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
Pbindef(\klank, \amp1, 0.05); //\amp1 1 till 0
Pbindef(\klank).stop;
Pbindef(\delayPdef,
	\instrument, \delay,
	\group, t.fxGroup,
	\inBus, t.outBus,
	\freq, Prand([2,3,4,5], inf),
	\decay, Pwhite(1,4, inf),
	\root, 4,
	\level, 0.2, //INCREASE IN LEVEL
	\deltime, Pseq([0.5,0.5,0.5,1,0.5],inf),
).play;

Pbindef(\delayPdef).stop;
Pbindef(\midiMoog, \dur, 0.5, \degree, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1),Pseq([1,0,7,5,6,3,2,4], 1)], inf)).play;
Pbindef(\klank).stop;

Pbindef(\midiMoog, \degree, Pseq([2,8,0], 3), \dur, Pseq([0.5, 0.5, 4], 1));
Pbindef(\midiMoog).stop;

/////////////////////////////
// Unusually lost bits //// MOOG 16
/////////////////////////////
//FÖRST: THE CONVERSATION WAS GOOD

//SEN: Snurra skitlångsamt
Pbindef(\sawP2, \outBus, t.sawBus, \amp, Pseq([Pseq([0.08, 0.1, 0.15, 0.2, 0.3], 1), Pseq([0.3], inf)], 1)*0.7, \degree, Pseq([8,6,3], inf)).play;
Pbindef(\sawP2, \amp, 0.5);
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
~noise = Synth(\playBackBuf, [\outBus, t.bBus, \outBusRev, 0, \bufNum, ~sound, \amp, 2], t.synthGroup);
)
~noise.free;
~voice1 = Synth(\playBackBuf, [\outBus, t.a1Bus, \bufNum, t.voiceBuf, \centerFreq, 300, \bw, 2, \amp, 0.6], t.synthGroup);
~voice1.set(\amp, 0.1);
~voice2 = Synth(\playBackBuf, [\outBus, t.a2Bus, \bufNum, t.voiceBuf, \centerFreq, 300, \bw, 2, \amp, 0.3], t.synthGroup);
~voice2.set(\amp, 0.2);

~pannerCircle1.set(\width, 2);
~pannerCircle2.set(\width, 2);

Pbindef(\delayPdef).stop;

~noise.free;
~noise.set(\outBus, t.bBus, \centerFreq, 600, \bw, 3, \amp, 3, \outBusRev, 0);

(
~noise.free;
~voice1.free;
~voice2.free;
)


//nicka till arvid
Pbindef(\midiMoog, \degree, Pseq([0], inf), \dur, Pseq([1], inf), \root, -5, \dur, 1).play;
Pbindef(\midiMoog, \degree, Pseq([[4,1,0,1]], inf)).play;

Pbindef(\midiMoog, \degree, Pseq([[7,3,2, 3], [4,1,0,1], [0,7,4, 7], [2,5,1,5]], inf), \dur, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1),Pseq([1,0,7,5,6,3,2,4], 1)], inf) / 10);

Pbindef(\sawP2, \amp, 0.05);
Pbindef(\sawP2, \amp, 0.12);
//TO STOP
Pbindef(\midiMoog, \degree, Pseq([[7,3,2, 3], [4,1,0,1], [0,7,4,7], [2,5,1,5]], 1));
Pbindef(\midiMoog).stop;

//nicka till arvid
Pbindef(\sawP2, \amp, 0.1, \degree, Pseq([9,7,2], inf));
Pbindef(\sawP2, \degree, Pseq([9,7,2], 1));
Pbindef(\sawP2).stop;