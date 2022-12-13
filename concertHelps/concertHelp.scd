t = Konsert1();
s.meter;s.plotTree;
(
~output0 = 2;
~sawAmp = 0.02;
~klankAmp = 0.18;
)
(
~gatorsettings = (inBusA1:t.a1Bus, inBusA2: t.a2Bus, inBusB:t.bBus, outBus1:t.outBus1, outBus2: t.outBus2, revOut: t.revBus, lag:10, clampT:0.1, relaxTime:1, gate:1, thresh:0.1, revAmp:0.5);
t.gator(~gatorsettings);
)
(
~moog = Synth(\moog, [\inBus, 1, \outBus,  t.outBus, \amp, 1], t.synthGroup);
//~korg = Synth(\D1200, [\inBus, 2, \outBus, t.bBus], t.synthGroup);
~mic = Synth(\mic, [\inBus, 0, \outBus, t.vocBus, \amp, 1], t.synthGroup);
~organ = Synth(\mic, [\inBus, 1, \outBus, 6], t.synthGroup);

~gatorsettings = (inBusA1:t.a1Bus, inBusA2: t.a2Bus, inBusB:t.bBus, outBus1:t.outBus1, outBus2: t.outBus2, lag:10, clampT:0.01, relaxTime:0.5, gate:1);
t.gator(~gatorsettings);
~passGator = Synth(\noGator, [\inBus, t.outBus, \inBusV, t.vocBus, \outBus, t.panBus, \outBusV, t.panBus, \revOut, t.revBus, \revVoxAmp, 0.5, \revInpAmp,1], t.fxGroup, 'addToHead');

~reverb = Synth(\reverb, [\inBus, t.revBus, \outBus, t.panBus], t.fxGroup, 'addToTail');
~sawReverb = Synth(\reverb, [\inBus, t.sawBus, \outBus, t.panBusSaw], t.fxGroup, 'addToTail');

~sawPannerCircle = Synth(\pannerCircle, [\inBus,  t.panBusSaw, \outBus, ~output0, \speed, 0.03, \level, 1, \dir, (-1), \width, 3], t.panGroup, 'addToTail');
~pannerCircle1 = Synth(\pannerCircle, [\inBus,  t.outBus1, \outBus, ~output0, \speed, 0.09, \level, 1, \dir, 1, \width, 3], t.panGroup, 'addToTail');
~pannerCircle2 = Synth(\pannerCircle, [\inBus,  t.outBus2, \outBus, ~output0, \speed, 0.09, \level, 1, \dir, (-1), \width, 3], t.panGroup, 'addToTail');
~stereOut = Synth(\outSynth, [\inBus, t.panBus, \outBus, ~output0], t.panGroup);
)
~out.free;
~passGator.free;
~sawPannerCircle2.free;
~pannerCircle2.free;
~sawReverb.free;
~mic.free;
//////////////////////TUNING
///////////////////////
///////////////////////
(
~sine = {Out.ar(, SinOsc.ar(440)*0.04)}.play;
Pbindef(\midiTuning,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\midinote, 69,
	\dur, Pseq([3], inf),
).play;
~moog0 = Synth(\moog, [\inBus, 1, \outBus, 2, \amp, 1]);
)
~moog0.set(\outBus, 2);
(
Pbindef(\midiTuning).stop;
~sine.free;
~moog0.free;
)
/////////////////////// STOP
///////////////////////
///////////////////////
(
~reverb.free;
~konsert.next;
~korg.free;
~moog.free;
~mic.free;
~grainSynth.free;
~gatorsettings.free;
Pbindef(\midiMoog).stop;
Pbindef(\midiMoog1).stop;
Pbindef(\midiMoog2).stop;
Pbindef(\midiMoog3).stop;
Pbindef(\midiMoog4).stop;
Pbindef(\klank).stop;
Pbindef(\brownPan).stop;
Pbindef(\brownPan0).stop;
Pbindef(\panning).stop;
)

