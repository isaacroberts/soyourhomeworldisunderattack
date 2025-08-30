((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_77",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,C,D,B={
a7H(d,e,f){var y=new B.OQ(f,d),x=J.lL(d)
y.d=x.pz(d,f,e)
y.b=e==null?x.ga2b(d):e
return y},
OQ:function OQ(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
RL:function RL(d){this.a=d}},F
J=c[1]
A=c[0]
E=c[2]
C=c[54]
D=c[98]
B=a.updateHolder(c[4],B)
F=c[99]
B.OQ.prototype={
df(){var y=this
y.d=J.uq(y.c,y.a,y.b)},
kS(){return this.b>0},
FV(d,e){return B.a7H(this.c,e,this.a+d)},
EY(d,e){var y,x=this
if(A.nw(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof C.iX){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.RL("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
fA(d){if(this.EY(0,d)){this.eV(1)
return!0}return!1},
bv(d,e){var y=this
if(y.EY(0,d))y.eV(1)
else throw A.i(C.e4("Expected "+A.o(d)+" in ChapterFormat (got "+y.kl()+" pos="+y.a+")",e))},
F7(d,e){var y,x=this
if(x.EY(0,d))x.eV(1)
else{y=x.d
y===$&&A.a()
A.ds(y.getUint8(0))
if(e)x.eV(1)}},
OF(d){return this.F7(d,!1)},
CO(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.mr()
return!0}return!1},
LG(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.mr()
return!0}return!1},
n9(d){var y=this.d
y===$&&A.a()
return A.ds(y.getUint8(d))},
kl(){return this.n9(0)},
mr(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eV(1)
return y},
KS(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eV(4)
return y},
mq(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eV(4)
return y},
awc(){var y=this.d
y===$&&A.a()
E.aq.a4V(y,0)},
pL(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eV(4)
return y},
tg(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eV(1)
return A.ds(y)},
a_e(){var y=this,x=y.tg()
if(x==="B")return y.mr()
else if(x==="i")return y.KS()
else if(x==="q")return y.awc()
else if(x==="I")return y.mq()
else if(x==="x")return null
else throw A.i(C.e4("Unsupported int typechar "+x+" (pos="+y.a+")","?"))},
awe(){var y=this.tg()
if(y==="c")return this.tg()
else if(y==="x")return null
else throw A.i(C.e4("Unsupported character typechar "+y,"?"))},
th(d){var y,x,w,v,u,t=this,s=t.tg()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eV(4)
return A.ag(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.e4("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
a_c(){return this.th(!1)},
aER(){return J.ho(this.c,this.a,this.b)},
eV(d){this.a+=d
this.b-=d
this.df()},
KU(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.EY(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.OQ(v,w)
t=J.lL(w)
u.d=t.pz(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pz(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.df()
throw A.i(C.e4("Run out of buffer on grabUntil","?"))},
KT(d){return this.KU(d,!1)},
a_d(d){var y
if(d||this.fA(D.oG)){y=this.Ep(D.oH)
y=A.fW(y,"@OQ!","{")
return A.fW(y,"@CQ!","}")}return null},
jP(){return this.a_d(!1)},
awf(){var y=this.fA(D.oI)
if(y)return this.Ep(F.HV)
return null},
Ep(d){var y=this.KU(d,!1)
return E.ae.ev(J.ho(y.c,y.a,y.b))},
awb(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.ds(w.getUint8(x))!==d[x])return!1}this.eV(y)
return!0},
gI(d){return this.b}}
B.RL.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibx:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.z,[B.OQ,B.RL])})()
A.bK(b.typeUniverse,JSON.parse('{"RL":{"bx":[]}}'));(function constants(){F.HV=new C.iX(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_77",e:"endPart",h:b})})($__dart_deferred_initializers__,"OonFDgOaDROz9pI/zG819H1rphY=");