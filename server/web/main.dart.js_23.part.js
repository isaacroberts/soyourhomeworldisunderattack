((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_23",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,F,B={
aPO(d,e,f){var y=new B.PD(f,d),x=J.kO(d)
y.d=x.pN(d,f,e)
y.b=e==null?x.gNJ(d):e
return y},
PD:function PD(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
SA:function SA(d){this.a=d}},D,E,C
J=c[1]
A=c[0]
F=c[2]
B=a.updateHolder(c[3],B)
D=c[63]
E=c[45]
C=c[62]
B.PD.prototype={
de(){var y=this
y.d=J.uK(y.c,y.a,y.b)},
k(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b_q(this.c)+"]"},
l4(){return this.b>0},
GL(d,e){return B.aPO(this.c,e,this.a+d)},
FJ(d,e){var y,x=this
if(A.kM(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof E.iW){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.SA("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
hz(d){if(this.FJ(0,d)){this.eS(1)
return!0}return!1},
dQ(d,e){var y=this
if(y.FJ(0,d))y.eS(1)
else throw A.i(A.eq("Expected "+A.o(d)+" in ChapterFormat (got "+y.kz()+" pos="+y.a+")",e))},
a5n(d,e){var y,x=this
if(x.FJ(0,d))x.eS(1)
else{y=x.d
y===$&&A.a()
A.dw(y.getUint8(0))
if(e)x.eS(1)}},
PB(d){return this.a5n(d,!1)},
DG(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.oe()
return!0}return!1},
Mv(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.oe()
return!0}return!1},
np(d){var y=this.d
y===$&&A.a()
return A.dw(y.getUint8(d))},
kz(){return this.np(0)},
ax0(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dw(y.getUint8(w));++w}this.eS(d)
return x},
oe(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eS(1)
return y},
awZ(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eS(4)
return y},
od(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eS(4)
return y},
pZ(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eS(4)
return y},
x9(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eS(1)
return A.dw(y)},
ax1(){var y=this.x9()
if(y==="c")return this.x9()
else if(y==="x")return null
else throw A.i(A.eq("Unsupported character typechar "+y,"?"))},
tB(d){var y,x,w,v,u,t=this,s=t.x9()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eS(4)
return A.bT(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(A.eq("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
awX(){return this.tB(!1)},
aFU(){return J.hv(this.c,this.a,this.b)},
eS(d){this.a+=d
this.b-=d
this.de()},
LL(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FJ(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.PD(v,w)
t=J.kO(w)
u.d=t.pN(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pN(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.de()
throw A.i(A.eq("Run out of buffer on grabUntil","?"))},
LK(d){return this.LL(d,!1)},
a0h(d){var y
if(d||this.hz(C.p9)){y=this.OK(C.pa)
y=A.h_(y,"@OQ!","{")
return A.h_(y,"@CQ!","}")}return null},
D6(){return this.a0h(!1)},
ax2(){var y=this.hz(C.pb)
if(y)return this.OK(D.IT)
return null},
OK(d){var y=this.LL(d,!1)
return F.ag.fO(J.hv(y.c,y.a,y.b))},
awY(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dw(w.getUint8(x))!==d[x])return!1}this.eS(y)
return!0},
gH(d){return this.b}}
B.SA.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibI:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.B,[B.PD,B.SA])})()
A.bR(b.typeUniverse,JSON.parse('{"SA":{"bI":[]}}'));(function constants(){D.IT=new E.iW(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_23",e:"endPart",h:b})})($__dart_deferred_initializers__,"UsfCf6gQzV9tTpGMTA1z9oTogdo=");