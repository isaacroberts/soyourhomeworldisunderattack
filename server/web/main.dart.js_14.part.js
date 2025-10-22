((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_14",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,C,B={
aMA(d,e,f){var y=new B.Qb(f,d),x=J.l4(d)
y.d=x.pW(d,f,e)
y.b=e==null?x.gNS(d):e
return y},
Qb:function Qb(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Tg:function Tg(d){this.a=d}},F,D
J=c[1]
A=c[0]
E=c[2]
C=c[68]
B=a.updateHolder(c[5],B)
F=c[58]
D=c[86]
B.Qb.prototype={
dj(){var y=this
y.d=J.vg(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b12(this.c)+"]"},
lQ(){return this.b>0},
GX(d,e){return B.aMA(this.c,e,this.a+d)},
FV(d,e){var y,x=this
if(A.fP(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.lf){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Tg("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
axj(d){var y,x,w,v,u,t,s,r,q=this
d=d
if(d==null)d=""
d="json_"+d
q.er(D.pa,d)
u=q.mF()
if(u<=2){q.er(D.kW,d)
return null}y=q.a0o(u)
q.er(D.kW,d)
try{x=E.bJ.eQ(y)
return x}catch(t){w=A.ai(t)
v=A.aI(t)
s=J.cT(w)
r=d
A.Dw(new C.mn(s,r),v)}return null},
iE(d){if(this.FV(0,d)){this.fJ(1)
return!0}return!1},
er(d,e){var y=this
if(y.FV(0,d))y.fJ(1)
else throw A.i(C.eV("Expected "+A.p(d)+" in ChapterFormat (got "+y.ll()+" pos="+y.a+")",e))},
G5(d,e){var y
if(this.FV(0,d))this.fJ(1)
else{y=this.d
y===$&&A.a()
A.dJ(y.getUint8(0))}},
PM(d){return this.G5(d,!1)},
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
return A.dJ(y.getUint8(d))},
ll(){return this.no(0)},
a0o(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dJ(y.getUint8(w));++w}this.fJ(d)
return x},
om(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fJ(1)
return y},
axi(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.fJ(4)
return y},
mF(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.fJ(4)
return y},
q8(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.fJ(4)
return y},
x4(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fJ(1)
return A.dJ(y)},
axm(){var y=this.x4()
if(y==="c")return this.x4()
else if(y==="x")return null
else throw A.i(C.eV("Unsupported character typechar "+y,"?"))},
tF(d){var y,x,w,v,u,t=this,s=t.x4()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.fJ(4)
return A.c_(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.eV("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axh(){return this.tF(!1)},
aGL(){return J.hO(this.c,this.a,this.b)},
fJ(d){this.a+=d
this.b-=d
this.dj()},
LP(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FV(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Qb(v,w)
t=J.l4(w)
u.d=t.pW(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pW(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dj()
throw A.i(C.eV("Run out of buffer on grabUntil","?"))},
a0q(d){return this.LP(d,!1)},
a0p(d){var y
if(d||this.iE(D.p7)){y=this.a4n(D.p8)
y=A.fQ(y,"@OQ!","{")
return A.fQ(y,"@CQ!","}")}return null},
axl(){return this.a0p(!1)},
a4n(d){var y=this.LP(d,!1)
return E.ac.eQ(J.hO(y.c,y.a,y.b))},
gH(d){return this.b}}
B.Tg.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibL:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Qb,B.Tg])})()
A.bh(b.typeUniverse,JSON.parse('{"Tg":{"bL":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_14",e:"endPart",h:b})})($__dart_deferred_initializers__,"OXCTxehSpnlXi9YUHd7VVYMvo9c=");