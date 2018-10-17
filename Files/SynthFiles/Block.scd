[ [ 'sine', {arg freq=440, phase=0, mul=0.4; SinOsc.ar(freq,phase,mul)} ], 
 [ 'play', {arg buffer; {arg rate=1, trigger=1,
 startPos=0, mul=1;
	Mix(PlayBuf.ar(buffer.numChannels, buffer, rate, trigger, startPos, 0)*mul);}
 } ], [ 'loop', {arg buffer; {arg rate=1, trigger=1,
 startPos=0, mul=1;
	Mix(PlayBuf.ar(buffer.numChannels, buffer, rate, trigger, startPos, 1)*mul);}
 } ], [ 'cue', {arg buffer; {arg loop=1,
 mul=1;
	DiskIn.ar(buffer.numChannels, buffer, loop)*mul;} } ], [ 'playpv', {arg
 buffer; {arg rate=1, offset=0, numFrames=2048, winType=1, mul=1;
	var localbuf, chain;
	localbuf = LocalBuf.new(numFrames, 1);
	chain = PV_PlayBuf(localbuf, buffer.bufnum, rate, offset,
 0);
	IFFT(chain, winType)*mul}; } ], [ 'looppv', {arg buffer; {arg rate=1,
 offset=0, numFrames=2048, winType=1, mul=1;
	var localbuf, chain;
	localbuf = LocalBuf.new(numFrames, 1);
	chain = PV_PlayBuf(localbuf, buffer.bufnum, rate, offset,
 1);
	IFFT(chain, winType)*mul}; } ], [ 'playbuf', {arg buffer; {arg 
 rate=1,
 trigger=1, startPos=0, mul=1, loop=1;
	PlayBuf.ar(buffer.numChannels, buffer, rate, trigger, startPos, loop)*mul;} } 
 ], [ 'rec', {arg buffer; {arg recLevel=1, preLevel=0;
	var sig;
	sig = 'input';
	RecordBuf.ar(sig, buffer, 0, recLevel, preLevel, loop: 0); } } ], [ 'recpv', 
 {arg buffer, numChannels=1, numFrames=2048, hop=0.5, wintype=1; {arg
 offset=0, run=1, loop=0, mul=1;
	var sig, localbuf, chain;
	sig = 'input';
	localbuf = LocalBuf(numFrames, numChannels);
	chain = FFT(localbuf, sig, hop/2, wintype);
	chain = PV_RecordBuf(chain, buffer.bufnum, offset, run, loop, 
 hop,
 wintype)*mul}; } ], [ 'recloop', {arg buffer; {arg recLevel=1,
 preLevel=0;
	var sig;
	sig = 'input';
	RecordBuf.ar(sig, buffer, 0, recLevel, preLevel, loop: 1); } } ], [ 
 'looptr', {arg buffer; {arg rate=1, triggerRate=1,
 startPos=0, mul=1;
	PlayBuf.ar(buffer.numChannels, buffer, rate, Impulse.kr(triggerRate),
 startPos, 1)*mul;} } ], [ 'osc1', {arg buffer; {arg freq=400, phase=0,
 mul=0.5; Osc.ar(buffer, freq, phase, mul)} } ], [ 'shaperSine', {arg 
 buffer;
 {arg freq=440, phase=0, mul=0.5;
	Shaper.ar(buffer, SinOsc.ar(freq, phase, mul), 0.5)} } ], [ 'vosc', {arg
 buffer; {arg bufoffset=0, freq=440, phase=0, mul=0.5;
		var bufnum;
		bufnum =
 buffer[0].bufnum;
	VOsc.ar(bufoffset+MouseX.kr(bufnum, bufnum+buffer.size-1), freq, phase, mul)}
 } ], [ 'test2', {arg freq = 400 , amp = 0.4 , mul = 0.4 , harm =
 3;
Saw.ar(freq, amp);
} ], [ 'test1', {arg freq = 400 , amp = 0.4 , mul = 0.4 , harm 
 = 3;
SinOsc.ar(freq, 0, amp);
}  ] ]