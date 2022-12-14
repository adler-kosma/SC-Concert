s.options.inDevice =  "MacBook Pro Microphone";

(
w = Window.new("player", Rect(
	Window.screenBounds.width*2/3,
	1,
	500,
	500
))
.front
.alwaysOnTop_(true);

~slider = Slider(w.view, Rect(30,20,440,30))
.background_(Color.white)
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,100,4000).postln;
	w.view.background_(Color(obj.value*0.3+0.7,0.8,0.4));
	x.set(\freq, cf);
});
)

(
SynthDef(\simple, {
	arg freq=440;
	var sig;
	sig = PinkNoise.ar(1!2);
	sig = BPF.ar(sig, freq, 0.2);
	Out.ar(0, sig)
}).add;
)

x = Synth(\simple);

x.free;

