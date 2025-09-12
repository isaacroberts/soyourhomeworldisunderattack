((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_23",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,F,B={
aQ4(d,e,f){var y=new B.PG(f,d),x=J.kQ(d)
y.d=x.pS(d,f,e)
y.b=e==null?x.gNN(d):e
return y},
PG:function PG(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
SE:function SE(d){this.a=d}},D,E,C
J=c[1]
A=c[0]
F=c[2]
B=a.updateHolder(c[3],B)
D=c[63]
E=c[45]
C=c[62]
B.PG.prototype={
df(){var y=this
y.d=J.uK(y.c,y.a,y.b)},
k(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b_H(this.c)+"]"},
l5(){return this.b>0},
GO(d,e){return B.aQ4(this.c,e,this.a+d)},
FN(d,e){var y,x=this
if(A.kO(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof E.iW){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.SE("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
hA(d){if(this.FN(0,d)){this.eU(1)
return!0}return!1},
dR(d,e){var y=this
if(y.FN(0,d))y.eU(1)
else throw A.i(A.et("Expected "+A.o(d)+" in ChapterFormat (got "+y.kB()+" pos="+y.a+")",e))},
a5t(d,e){var y,x=this
if(x.FN(0,d))x.eU(1)
else{y=x.d
y===$&&A.a()
A.dw(y.getUint8(0))
if(e)x.eU(1)}},
PF(d){return this.a5t(d,!1)},
DK(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.og()
return!0}return!1},
Mz(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.og()
return!0}return!1},
nq(d){var y=this.d
y===$&&A.a()
return A.dw(y.getUint8(d))},
kB(){return this.nq(0)},
axa(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dw(y.getUint8(w));++w}this.eU(d)
return x},
og(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eU(1)
return y},
ax8(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eU(4)
return y},
of(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eU(4)
return y},
q3(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eU(4)
return y},
xa(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eU(1)
return A.dw(y)},
axb(){var y=this.xa()
if(y==="c")return this.xa()
else if(y==="x")return null
else throw A.i(A.et("Unsupported character typechar "+y,"?"))},
tF(d){var y,x,w,v,u,t=this,s=t.xa()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eU(4)
return A.bT(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(A.et("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
ax6(){return this.tF(!1)},
aG4(){return J.hx(this.c,this.a,this.b)},
eU(d){this.a+=d
this.b-=d
this.df()},
LP(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FN(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.PG(v,w)
t=J.kQ(w)
u.d=t.pS(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pS(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.df()
throw A.i(A.et("Run out of buffer on grabUntil","?"))},
LO(d){return this.LP(d,!1)},
a0n(d){var y
if(d||this.hA(C.pd)){y=this.OO(C.pe)
y=A.h0(y,"@OQ!","{")
return A.h0(y,"@CQ!","}")}return null},
Da(){return this.a0n(!1)},
axc(){var y=this.hA(C.pf)
if(y)return this.OO(D.J_)
return null},
OO(d){var y=this.LP(d,!1)
return F.ag.eG(J.hx(y.c,y.a,y.b))},
ax7(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dw(w.getUint8(x))!==d[x])return!1}this.eU(y)
return!0},
gH(d){return this.b}}
B.SE.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibI:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.B,[B.PG,B.SE])})()
A.bR(b.typeUniverse,JSON.parse('{"SE":{"bI":[]}}'));(function constants(){D.J_=new E.iW(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_23",e:"endPart",h:b})})($__dart_deferred_initializers__,"7907e8ZHN6KQScC2FkAfRqFFmdA=");