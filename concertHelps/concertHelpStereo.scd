
t = KonsertStereo();
s.meter;s.plotTree;
//o = Server.default.options;
//o.inDevice = "ULN-8";

Quarks.install("https://github.com/madskjeldgaard/plugins.quark");

(
~gatorsettings = (inBusA:t.aBus, inBusB:t.bBus, outBus:0, revOut: 0, revAmp: 0.5, lag:5, clampT:0.1, relT:2, thresh:0.1);
t.gator(~gatorsettings);
)
~mic.free;
(
~moog = Synth(\moog, [\inBus, 1, \outBus, t.outBus, \amp, 1], t.synthGroup);
~mic = Synth(\mic, [\inBus, 2, \outBus, t.aBus], t.synthGroup);

~gatorsettings = (inBusA:t.aBus, inBusB:t.bBus, outBus:0, revOut: t.revBus, lag:10, clampT:0.01, relT:0.5, gate:1);
t.gator(~gatorsettings);

~passGator = Synth(\noGator, [\inBus, t.outBus, \outBus, t.panBusOut, \revOut, t.revBus], t.fxGroup, 'addToHead');
~reverb = Synth(\reverb, [\inBus, t.revBus, \outBus, 0], t.fxGroup,'addToTail');

~panAz = Synth(\panAzStereo, [\inBus,  t.panBusOutAz, \outBus, 0, \speed, 0.1, \level, 1, \dir, 1], t.panGroup, 'addToTail');
~out = Synth(\stereoOut, [\inBus, t.panBusOut, \outBus, 0], t.panGroup);
)

//////////////////////TUNING
///////////////////////
///////////////////////
(
~sine = {Out.ar(0, SinOsc.ar(440)*0.04)}.play;
Pbindef(\midiTuning,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\midinote, 69,
	\dur, Pseq([3], inf),
).play;
~moog0 = Synth(\moog, [\inBus, 0, \outBus, 2, \amp, 1]);
)
(
Pbindef(\midiTuning).stop;
~sine.free;
~moog0.free;
)
/////////////////////// STOP
///////////////////////
///////////////////////
(
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
Pbindef(\brownPan).stop;
Pbindef(\brownPan0).stop;
Pbindef(\panning).stop;
)

