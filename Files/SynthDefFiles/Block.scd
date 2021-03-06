[ [ 'test2', {arg freq = 400 -> [200.0,1000, \exp, {|val| val.round}], amp
 = 0.4 -> [0,1], mul = 0.4 -> [0,0.5], harm = 3-> [1,10, {|val| val.round;}];
	Saw.ar(freq, amp);} ], [ 'test1', {arg freq = 400 -> [200.0,1000, \exp, {|val|
 val.round}], amp = 0.4 -> [0,1], mul = 0.4 -> [0,0.5], harm = 3-> [1,10,
 {|val|
 val.round;}];
SinOsc.ar(freq, 0, amp);
} ], [ 'sine', {arg freq=440 -> [20, 20000, \exp], phase=0 -> [-2pi, 2pi], mul=0.4 -> [0,1]; SinOsc.ar(freq,phase,mul)} ], [ 'play', {arg rate=1 -> [0.1,10], trigger=1 -> [0,1, {|val| val.round(1)}], startPos=0 -> [0,1], mul=1 -> [0,2];
	PlayBuf.ar(\buffer.numChannels, \buffer, rate, trigger, startPos.linlin(0,1,0, \buffer.numFrames), 0)*mul;} ], [ 'loop', {arg rate=1 -> [0.1,10], trigger=1 -> [0,1, {|val| val.round(1)}], startPos=0 -> [0,1], mul=1 -> [0,2];
	PlayBuf.ar(\buffer.numChannels, \buffer, rate, trigger, startPos.linlin(0,1,0, \buffer.numFrames), 1)*mul;} ], [ 'cue', {arg loop=1 -> [0,1, {|val| val.round(1)}], mul=1 -> [0,2];
	DiskIn.ar(\buffer.numChannels, \buffer, loop)*mul;} ], [ 'playpv', {arg rate=1 -> [0.1,10], offset=0 -> [0,1], numFrames=0.6 -> [0,1,\lin, 0.1], winType=0 -> [-1,1, {|val| val.round(1)}], mul=1 -> [0,2];
	var localbuf, chain;
	localbuf = LocalBuf.new(numFrames.linexp(0,1,32,32768), \buffer.numChannels);
		chain = PV_PlayBuf(localbuf, \buffer.bufnum, rate, offset.linlin(0,1,0, \buffer.numFrames),
 0);
	IFFT(chain, winType)*mul} ], [ 'looppv', {arg rate=1 -> [0.1,10], offset=0 -> [0,1], numFrames=0.6 -> [0,1,\lin, 0.1], winType=0 -> [-1,1, {|val| val.round(1)}], mul=1 -> [0,2];
	var localbuf, chain;
	localbuf = LocalBuf.new(numFrames.linexp(0,1,32,32768), \buffer.numChannels);
		chain = PV_PlayBuf(localbuf, \buffer.bufnum, rate, offset.linlin(0,1,0, \buffer.numFrames),
 1);
	IFFT(chain, winType)*mul} ], [ 'playbuf', {arg rate=1 -> [0.1,10], trigger=1 -> [0,1, {|val| val.round(1)}], startPos=0 -> [0,1], mul=1 -> [0,2], loop=1 -> [0,1, {|val| val.round(1)}];
	PlayBuf.ar(\buffer.numChannels, \buffer, rate, trigger, startPos.linlin(0,1,0, \buffer.numFrames), loop)*mul;} ], [ 'rec', {arg recLevel=1 -> [0,2], preLevel=0 -> [0,2], fade=0.01 -> [0,0.1];
	var sig;
	sig = \in;
		sig = sig * Env.linen(fade,  (\duration-(fade*2)), fade, 1, 'sin').kr;
	RecordBuf.ar(sig, \buffer.bufnum, 0, recLevel, preLevel, loop: 0); } ], [ 'recpv', {arg numChannels=1 -> [1,10, {|val| val.round(1)}], numFrames=0.6 -> [0,1,\lin, 0.1], hop=0.5 -> [0,1], winType=0 -> [-1,1, {|val| val.round(1)}], offset=0 -> [0,1], run=1 -> [0,1, {|val| val.round(1)}], loop=0 -> [0,1, {|val| val.round(1)}], mul=1 -> [0,2], fade=0.01 -> [0,0.1];
	var sig, localbuf, chain;
	sig = \in;
	sig = sig * Env.linen(fade,  (\duration-(fade*2)), fade, 1, 'sin').kr;
	localbuf = LocalBuf(numFrames.linexp(0,1,32,32768), numChannels);
	chain = FFT(localbuf, sig, hop/2, winType);
	chain = PV_RecordBuf(chain, \buffer.bufnum, offset.linlin(0,1,0, \buffer.numFrames), run, loop, hop, winType)*mul} ], [ 'recloop', {arg recLevel=1 -> [0,2], preLevel=0 -> [0,2], fade=0.01 -> [0,0.1];
	var sig;
	sig = \in;
	sig = sig * Env.asr(fade, 1, fade, 'sin').kr;
	RecordBuf.ar(sig, \buffer.bufnum, 0, recLevel, preLevel, loop: 1); } ], [ 'looptr', {arg rate=1 -> [0.1,10], triggerRate=1 -> [0.1,10], startPos=0 -> [0,1], mul=1 -> [0,2];
	PlayBuf.ar(\buffer.numChannels, \buffer, rate, Impulse.kr(triggerRate),
 startPos.linlin(0,1,0, \buffer.numFrames), 1)*mul;} ], [ 'osc1', {arg freq=400 -> [20,20000, \exp], phase=0 -> [-2pi, 2pi], mul=0.5 -> [0,2]; Osc.ar(\buffer, freq, phase, mul)} ], [ 'shaperSine', {arg freq=440 -> [20,20000, \exp], phase=0 -> [-2pi, 2pi], mul=0.5 -> [0,2];
	Shaper.ar(\buffer, SinOsc.ar(freq, phase, mul), 0.5)} ], [ 'vosc', {arg bufoffset=0 -> [0,10], freq=440 -> [20,20000, \exp], phase=0 -> [-2pi, 2pi], mul=0.5 -> [0,2];
		var buffer, bufnum;
	buffer = \buffer;
	bufnum = buffer[0].bufnum;
	VOsc.ar(bufoffset+MouseX.kr(bufnum, bufnum+buffer.size-1), freq, phase, mul)} ], [ 'loopAll', {arg rate=1 -> [0.1,10], trigger=1 -> [0,1, {|val| val.round(1)}], startPos=0 -> [0,1], mul=1 -> [0,2];
	var buffer, play;
	buffer = \buffer;
	play = buffer.collect{|item|
		PlayBuf.ar(item.numChannels, item, rate, trigger, startPos.linlin(0,1,0, item.numFrames), 1)*mul;};
	play.sum/play.size;
} ], [ 'audioin', {arg bus=1 -> [1,8], mul= 1 -> [0,4];
	SoundIn.ar((bus.round(1)-1).max(0), mul);} ], [ 'grainbuf', {arg rate=1 -> [0.1,10], freq= 1 -> [0.5,50], dur = 0.1 -> [0.0001, 0.1, {|val|val.round(0.0001)}], startPos=0 -> [0,1], interp=1 -> [0,4, {|val| val.round(1)}], pan= 0 -> [-1,1];
	var buffer;
	buffer = \buffer;
	BufGrain.ar(Impulse.kr(freq), dur, \buffer, rate, startPos, interp); 	
	/*GrainBuf.ar(buffer.numChannels, Impulse.kr(freq), dur, buffer[0], rate, startPos, interp, pan); 	*/
} ], [ 'grainfm', {arg freq= 1 -> [0.5,50], dur = 0.1 -> [0.0001, 0.1, {|val| val.round(0.0001)}], carfreq= 440 -> [20,20000, \exp], modFreq=200 -> [1,1000, \exp], index= 1 -> [0.1,10], pan = 0 -> [-1,1];
	GrainFM.ar(1, Impulse.kr(freq), dur, carfreq, modFreq, index, pan); 	
} ], [ 'formletfun', {arg my= 1000 -> [400,3200];
	var amp;
    amp = LFPulse.kr(0.5,0,0.5);
        Formlet.ar(Dust.ar(12,[0.05,0.05]) * amp, my * exprand(0.5,2.0), 0.005, 0.1);
} ], [ 'sinenv', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], phase=0 -> [-2pi, 2pi], mul=0.4 -> [0,2], attack=0.01 -> [0.0001,0.5], decay = 0.3 -> [0.001,0.4], sustain= 0.5 -> [0.1,1], release = 1 -> [0.01,3], octMul=1 -> [0.25,4];
	var cps;
	cps = Latch.ar(freq*octMul, trig);
	SinOsc.ar(cps,phase,mul) * EnvGen.kr(Env.adsr(attack, decay, sustain, release), trig);
} ], [ 'blipenv', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], numharm=0 -> [0, 200], mul=0.4 -> [0,1], attack=0.01 -> [0.0001,0.5], decay = 0.3 -> [0.001,0.4], sustain= 0.5 -> [0.1,1], release = 1 -> [0.01,3]; 
	Blip.ar(freq,numharm,mul) * EnvGen.kr(Env.adsr(attack, decay, sustain, release), trig);
} ], [ 'blipdissenv', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], diss=0 -> [0, 1], mul=0.4 -> [0,1], attack=0.01 -> [0.0001,0.5], decay = 0.3 -> [0.001,0.4], sustain= 0.5 -> [0.1,1], release = 1 -> [0.01,3]; 
	Blip.ar(freq,(diss.sqrt)*200,mul) * EnvGen.kr(Env.adsr(attack, decay, sustain, release), trig);
} ], [ 'sinekey', {arg key=0 -> [0, 23, {|val| val.round(1)}], oct=1 -> [0.25,4], phase=0 -> [-2pi, 2pi], mul=0.4 -> [0,1], lag = 0.01 => [0,0.1]; 
	var chord;
	chord = Select.kr(key, [
		([60, 64, 67]+0).midicps*oct,
		([60, 64, 67]+1).midicps*oct,
		([60, 64, 67]+2).midicps*oct,
		([60, 64, 67]+3).midicps*oct,
		([60, 64, 67]+4).midicps*oct,
		([60, 64, 67]+5).midicps*oct,
		([60, 64, 67]+6).midicps*oct,
		([60, 64, 67]+7).midicps*oct,
		([60, 64, 67]+8).midicps*oct,
		([60, 64, 67]+9).midicps*oct,
		([60, 64, 67]+10).midicps*oct,
		([60, 64, 67]+11).midicps*oct,
		([60, 63, 67]+0).midicps*oct,
		([60, 63, 67]+1).midicps*oct,
		([60, 63, 67]+2).midicps*oct,
		([60, 63, 67]+3).midicps*oct,
		([60, 63, 67]+4).midicps*oct,
		([60, 63, 67]+5).midicps*oct,
		([60, 63, 67]+6).midicps*oct,
		([60, 63, 67]+7).midicps*oct,
		([60, 63, 67]+8).midicps*oct,
		([60, 63, 67]+9).midicps*oct,
		([60, 63, 67]+10).midicps*oct,
		([60, 63, 67]+11).midicps*oct,
	]);	
	Mix.ar(SinOsc.ar([chord[0].lag(lag), chord[1].lag(lag), chord[2].(lag)],phase,mul/3));
	} ], [ 'sinekey2', {arg key=0 -> [0, 23, {|val| val.round(1)}], oct=1 -> [0.25,4], phase=0 -> [-2pi, 2pi], mul=0.4 -> [0,1], lag = 0.01 => [0,0.1], inv1=0 -> [-24, 24, {|val| val.round(12)}], inv2=0 -> [-24, 24, {|val| val.round(12)}], inv3=0 -> [-24, 24, {|val| val.round(12)}]; 
	var chord;
	chord = Select.kr(key, [
		([60+inv1, 64+inv2, 67+inv3]+0).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+1).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+2).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+3).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+4).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+5).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+6).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+7).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+8).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+9).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+10).midicps*oct,
		([60+inv1, 64+inv2, 67+inv3]+11).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+0).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+1).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+2).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+3).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+4).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+5).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+6).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+7).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+8).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+9).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+10).midicps*oct,
		([60+inv1, 63+inv2, 67+inv3]+11).midicps*oct,
	]);	
	Mix.ar(SinOsc.ar([chord[0].lag(lag), chord[1].lag(lag), chord[2].(lag)],phase,mul/3));
	} ], [ 'karplus', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], decayTime = 2.0 -> [0.2,4], att = 0 -> [0,0.01], dec = 0.001 -> [0,0.1];
    var burstEnv, signalOut, delayTime;
    delayTime = freq.min(2000).reciprocal;
	delayTime = Latch.ar(delayTime, trig);
    burstEnv = EnvGen.kr(Env.perc(att, dec), trig);
	signalOut = CombL.ar(PinkNoise.ar(burstEnv), 0.1, delayTime, decayTime)} ], [ 'sinenv2', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], phase=0 -> [-2pi, 2pi], mul=0.4 -> [0,2], attack=0.01 -> [0.0001,0.5], decay = 0.3 -> [0.001,0.4], sustain= 0.5 -> [0.1,1], release = 1 -> [0.01,3]; 
	var cps;
	cps = Latch.ar(freq, trig);
	SinOsc.ar(cps,phase,mul) * EnvGen.kr(Env.adsr(attack, decay, sustain, release), trig);
} ], [ 'sawenv', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], mul=0.4 -> [0,2], attack=0.01 -> [0.0001,0.5], decay = 0.3 -> [0.001,0.4], sustain= 0.5 -> [0.1,1], release = 1 -> [0.01,3], octMul=1 -> [0.25,4]; 
	var cps;
	cps = Latch.ar(freq*octMul, trig);
	Saw.ar(cps,mul) * EnvGen.kr(Env.adsr(attack, decay, sustain, release), trig);
} ], [ 'squarenv', {arg trig = 1 -> [0,1,{|val| val.round(1)}], freq=440 -> [20, 20000, \exp], width=0.5 -> [0, 1], mul=0.4 -> [0,2], attack=0.01 -> [0.0001,0.5], decay = 0.3 -> [0.001,0.4], sustain= 0.5 -> [0.1,1], release = 1 -> [0.01,3], octMul=1 -> [0.25,4];
	var cps;
	cps = Latch.ar(freq*octMul, trig);
	Pulse.ar(cps,width,mul) * EnvGen.kr(Env.adsr(attack, decay, sustain, release), trig);
} ], [ 'noise', {arg mul=0.5->[0,1];
	WhiteNoise.ar(mul);
} ], [ 'blip', {arg freq=10 -> [0.1,30], mul=0.5->[0,1], freq2 = 1200 -> [200,2000,\exp];
	Decay.ar(Impulse.ar(freq), 0.25, LFCub.ar(freq2, 0, 0.1)) *mul;
} ] ]