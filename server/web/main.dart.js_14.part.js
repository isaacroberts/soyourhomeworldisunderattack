((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_14",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,C,B={
aMz(d,e,f){var y=new B.Qa(f,d),x=J.l5(d)
y.d=x.pW(d,f,e)
y.b=e==null?x.gNS(d):e
return y},
Qa:function Qa(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Tf:function Tf(d){this.a=d}},F,D
J=c[1]
A=c[0]
E=c[2]
C=c[68]
B=a.updateHolder(c[5],B)
F=c[58]
D=c[86]
B.Qa.prototype={
dj(){var y=this
y.d=J.vg(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b12(this.c)+"]"},
l6(){return this.b>0},
GW(d,e){return B.aMz(this.c,e,this.a+d)},
FV(d,e){var y,x=this
if(A.fP(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.ka){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Tf("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
axl(d){var y,x=this
d="json_"+d
x.er(D.p9,d)
y=x.a0p(x.mF())
x.er(D.pa,d)
return E.bJ.eQ(y)},
i_(d){if(this.FV(0,d)){this.f1(1)
return!0}return!1},
er(d,e){var y=this
if(y.FV(0,d))y.f1(1)
else throw A.i(C.eB("Expected "+A.p(d)+" in ChapterFormat (got "+y.lm()+" pos="+y.a+")",e))},
PN(d,e){var y,x=this
if(x.FV(0,d))x.f1(1)
else{y=x.d
y===$&&A.a()
A.dE(y.getUint8(0))
if(e)x.f1(1)}},
PM(d){return this.PN(d,!1)},
DJ(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.om()
return!0}return!1},
MB(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.om()
return!0}return!1},
no(d){var y=this.d
y===$&&A.a()
return A.dE(y.getUint8(d))},
lm(){return this.no(0)},
a0p(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dE(y.getUint8(w));++w}this.f1(d)
return x},
om(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.f1(1)
return y},
axk(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.f1(4)
return y},
mF(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.f1(4)
return y},
q8(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.f1(4)
return y},
x4(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.f1(1)
return A.dE(y)},
axo(){var y=this.x4()
if(y==="c")return this.x4()
else if(y==="x")return null
else throw A.i(C.eB("Unsupported character typechar "+y,"?"))},
tF(d){var y,x,w,v,u,t=this,s=t.x4()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.f1(4)
return A.c_(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.eB("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axi(){return this.tF(!1)},
aGN(){return J.hO(this.c,this.a,this.b)},
f1(d){this.a+=d
this.b-=d
this.dj()},
LP(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FV(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Qa(v,w)
t=J.l5(w)
u.d=t.pW(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pW(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dj()
throw A.i(C.eB("Run out of buffer on grabUntil","?"))},
LO(d){return this.LP(d,!1)},
a0q(d){var y
if(d||this.i_(D.p7)){y=this.a4n(D.p8)
y=A.fQ(y,"@OQ!","{")
return A.fQ(y,"@CQ!","}")}return null},
axn(){return this.a0q(!1)},
a4n(d){var y=this.LP(d,!1)
return E.ac.eQ(J.hO(y.c,y.a,y.b))},
axj(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dE(w.getUint8(x))!==d[x])return!1}this.f1(y)
return!0},
gH(d){return this.b}}
B.Tf.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibL:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Qa,B.Tf])})()
A.bh(b.typeUniverse,JSON.parse('{"Tf":{"bL":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_14",e:"endPart",h:b})})($__dart_deferred_initializers__,"HtOOLyKXdJc7qDH5sgFm7x8GilU=");