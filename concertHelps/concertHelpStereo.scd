
t = KonsertStereo();
s.meter;s.plotTree;
//o = Server.default.options;
//o.inDevice = "ULN-8";
//o.outDevice = "Headphones";
s.recChannels = 2;

/////////////////////////////
// checklist:
// Buzz on Moog!
// Mic level MOTU: 20
/////////////////////////////
s.recChannels = 2;
(
~gatorsettings = (inBusA:t.aBus, inBusB:t.bBus, lag:5, clampT:0.6, relT:2, thresh:0.2);
t.gator(~gatorsettings);
)
~mic.free;
~kontaktMic.free;
~moog.free;
~moog.set(\outBus, t.outBus);
(
~gatorsettings = (inBusA:t.aBus, inBusB:t.bBus, outBus:t.outBus, lag:5, clampT:0.6, relT:2, thresh:0.2);
t.gator(~gatorsettings);

~moog = Synth(\moog, [\inBus, 2, \outBus, t.outBus], t.synthGroup);
~mic = Synth(\mic, [\inBus, 0, \outBus, 2, \outBusRev, t.revBusVox], t.synthGroup);

~passGator = Synth(\noGator, [\inBus, t.outBus, \outBus, t.panBusOut, \revOut, t.revBus], t.fxGroup, 'addToHead');
~reverb = Synth(\reverb, [\inBus, t.revBus, \outBus, 0], t.fxGroup,'addToTail');
~reverbVox = Synth(\reverbVox, [\inBusVox, t.revBusVox, \outBusVox, 2], t.fxGroup,'addToTail');

~out = Synth(\stereoOut, [\inBus, t.panBusOut, \outBus, 0], t.panGroup);
)

~reverbVox.free;

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
~moog0 = Synth(\moog, [\inBus, 2 , \outBus, 0, \amp, 1]);
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
~out.free;
~reverb.free;
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

