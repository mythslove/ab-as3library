
/*

Gyro is a tweening engine
Gyro makes things move
Gyro is customizable
Gyro is extendable
Gyro is in alpha (NOT complete)
Gyro is event-based 
Gyro can tween by time or frames (steps)
Gyro's ease types (in, out, etc.) are automatic

Copyright (c) 2008 Trevor McCauley

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Last updated: February 04, 2007:

Changes:
Removed TweenEvent.RESUME
Renamed TweenEvent to GyroEvent
Removed AbstractTween.resume()
Removed AbstractTween.repeatSeemless
Added StepTweener.repeatSeemless
Removed AbstractTween.repeat (use repeatCount > 0)
AbstractTween.repeatCount now defines the number of times repetition should occur. -1 is forever
Added (static)AbstractTween.REPEAT_FOREVER (defined as -1)
Added AbstractTween.currentRepeat
Added AbstractTween.reverse()
Added AbstractTween.autoReverse
Fixed filter interpolators
Filter interterpolators now use shortest path for rotations
Added InterpolateAngleProperty class
Added Sequence.currentItem
Added Sequence.getItemAt()
Added Sequence.removeItem()
Removed ease_internal namespace to simplify use of Ease class
Renamed Ease.ease_internal::call() to Ease.easeMethod()
Renamed Ease.call() to Ease.apply()
Updated (and included new) Javadoc documentation tags

So, it's Alpha... what's usable?
StepTweener
TimeTweener
All Interpolate classes
Ease and all Ease classes
Sequence

What's not usable?
Seeker and Modifier classes are still early
Orbit, Orient and Trejectory are empty shells
Path is not usable yet (I don't think) but mostly there

Last updated: February 01, 2007:

Current version announced

*/

// Example code:
// movie clip instances: box (w/ drop shadow), box2 (w/ different drop shadow), cross, cannon, jar 
import com.senocular.gyro.*;

// create tween over 50 steps using exponential easing (power of 2) in
var t1:StepTweener = new StepTweener(50, new EaseExponential(2, Ease.IN));
// tween box's x property from 15 to 150
t1.addProperty(box, "x", 15, 150);
// tween box's y property from 15 to 150, overriding default ease with circular ease
t1.addProperty(box, "y", 15, 150, new EaseCircular(Ease.OUT_TO_BACK_OUT));
// tween box's first filter (index 0) to match box2's filter
var shadowTween:IInterpolate = new InterpolateDropShadowFilter(box.filters[0], box.filters[0], box2.filters[0], box, 0); 
t1.addInterpolate(shadowTween);

// create tween over 10 steps using exponential easing (power of 2) out
var t2:StepTweener = new StepTweener(10, new EaseExponential(2, Ease.OUT));
// tween box's x property from 150 to 15
t2.addProperty(box, "x", 150, 15);
// tween box's x property from 15 to 150
t2.addProperty(box, "y", 15, 150);

// create a new sequence of tweens
var q:Sequence = new Sequence();
// add tween t1
q.addItem(t);
// add tween t2
q.addItem(t2);
// start the sequence to play t2 after t1
q.start();

// create tween over 3 seconds (defaults as linear tween)
var t3:TimeTweener = new TimeTweener(3000);
// tween cannon's x property from 50 to 250
t3.addProperty(cannon, "x", 50, 250);
// repeat the tween seemlessly
t3.repeatCount = AbstractTweener.REPEAT_FOREVER;
// start tweening
t3.start();

// create a seeker to seek the box's x property constantly by 2 pixels
var s:Seeker = new Seeker(box, "x", new SeekConstant(2));
// change the event priority to -1 to occur before other events
s.eventPriority = -1;
// make the cross's x property seek the box's x property
s.addProperty(cross, "x");

// create a modifier to constantly change a value constantly by 2 pixels
var m:Modifier = new Modifier(new ModifyConstant(2));
// constantly change the jar's rotation by 2
m.addProperty(jar, "rotation");
