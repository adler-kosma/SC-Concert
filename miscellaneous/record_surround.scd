s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 4;
s.options.sampleRate = 48000;
s.recChannels = 4;
s.meter;

~pan = Bus.audio(s, 1);
~sample = Buffer.readChannel(s,"/Users/adele21/Desktop/breakdown EMS/Bounces/whole-flower.wav", channels: [0]);

~sample1 = Buffer.readChannel(s,"/Users/adele21/Desktop/breakdown EMS/Audio Files/synth1.wav", channels: [0]);

SynthDef(\bufSynth, {
	arg freq, buf, rate=1, start=0, amp=1, atk=0.1, rel=0.5, speed=0.1, dir=1, width=2;
	var sig, env, pan;
	sig = PlayBuf.ar(1, buf, rate, 1, start);
	sig = sig * amp;
	pan = PanAz.ar(4, sig, LFSaw.kr(speed.lag(2)) * dir, width: width);
	Out.ar(0, pan);
}).add;

s.record;
~synth = Synth(\bufSynth, [\buf, ~sample1, \amp, 1, \speed, 0.01]);
~synth.set(\width, 2);
~synth.set(\speed, 0.2);
~synth.set(\speed, 1);
~synth.set(\dir, -1);
~synth.set(\dir, 1);



