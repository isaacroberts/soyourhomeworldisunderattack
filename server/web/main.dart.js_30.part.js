((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_30",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,G,C,B={
aLh(d,e,f){var y=new B.PJ(f,d),x=J.kV(d)
y.d=x.pL(d,f,e)
y.b=e==null?x.gNO(d):e
return y},
PJ:function PJ(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
SJ:function SJ(d){this.a=d}},E,F,D
J=c[1]
A=c[0]
G=c[2]
C=c[59]
B=a.updateHolder(c[5],B)
E=c[75]
F=c[50]
D=c[74]
B.PJ.prototype={
dg(){var y=this
y.d=J.uT(y.c,y.a,y.b)},
k(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b_R(this.c)+"]"},
l7(){return this.b>0},
GO(d,e){return B.aLh(this.c,e,this.a+d)},
FL(d,e){var y,x=this
if(A.fF(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.j3){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.SJ("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
hz(d){if(this.FL(0,d)){this.eP(1)
return!0}return!1},
dP(d,e){var y=this
if(y.FL(0,d))y.eP(1)
else throw A.i(C.ep("Expected "+A.o(d)+" in ChapterFormat (got "+y.kA()+" pos="+y.a+")",e))},
a5z(d,e){var y,x=this
if(x.FL(0,d))x.eP(1)
else{y=x.d
y===$&&A.a()
A.dy(y.getUint8(0))
if(e)x.eP(1)}},
PK(d){return this.a5z(d,!1)},
DD(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.og()
return!0}return!1},
My(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.og()
return!0}return!1},
nr(d){var y=this.d
y===$&&A.a()
return A.dy(y.getUint8(d))},
kA(){return this.nr(0)},
axg(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dy(y.getUint8(w));++w}this.eP(d)
return x},
og(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eP(1)
return y},
axe(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eP(4)
return y},
of(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eP(4)
return y},
pX(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eP(4)
return y},
x8(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eP(1)
return A.dy(y)},
axh(){var y=this.x8()
if(y==="c")return this.x8()
else if(y==="x")return null
else throw A.i(C.ep("Unsupported character typechar "+y,"?"))},
tA(d){var y,x,w,v,u,t=this,s=t.x8()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eP(4)
return A.bJ(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.ep("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axc(){return this.tA(!1)},
aGn(){return J.hD(this.c,this.a,this.b)},
eP(d){this.a+=d
this.b-=d
this.dg()},
LN(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FL(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.PJ(v,w)
t=J.kV(w)
u.d=t.pL(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pL(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dg()
throw A.i(C.ep("Run out of buffer on grabUntil","?"))},
LM(d){return this.LN(d,!1)},
a0u(d){var y
if(d||this.hz(D.pc)){y=this.OQ(D.pd)
y=A.h_(y,"@OQ!","{")
return A.h_(y,"@CQ!","}")}return null},
D2(){return this.a0u(!1)},
axi(){var y=this.hz(D.pe)
if(y)return this.OQ(E.IY)
return null},
OQ(d){var y=this.LN(d,!1)
return G.ac.f_(J.hD(y.c,y.a,y.b))},
axd(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dy(w.getUint8(x))!==d[x])return!1}this.eP(y)
return!0},
gH(d){return this.b}}
B.SJ.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibK:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.B,[B.PJ,B.SJ])})()
A.bE(b.typeUniverse,JSON.parse('{"SJ":{"bK":[]}}'));(function constants(){E.IY=new F.j3(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_30",e:"endPart",h:b})})($__dart_deferred_initializers__,"DpTackyqXXjehTrDoT+5AUiWdjU=");