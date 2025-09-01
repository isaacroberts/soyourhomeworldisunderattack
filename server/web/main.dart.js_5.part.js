((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_5",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,F,B={
aPi(d,e,f){var y=new B.Ps(f,d),x=J.m_(d)
y.d=x.pC(d,f,e)
y.b=e==null?x.ga2N(d):e
return y},
Ps:function Ps(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Sq:function Sq(d){this.a=d}},D,E,C
J=c[1]
A=c[0]
F=c[2]
B=a.updateHolder(c[3],B)
D=c[65]
E=c[45]
C=c[64]
B.Ps.prototype={
dd(){var y=this
y.d=J.uH(y.c,y.a,y.b)},
l_(){return this.b>0},
Gg(d,e){return B.aPi(this.c,e,this.a+d)},
F7(d,e){var y,x=this
if(A.nH(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof E.j4){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Sq("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
hw(d){if(this.F7(0,d)){this.eW(1)
return!0}return!1},
dU(d,e){var y=this
if(y.F7(0,d))y.eW(1)
else throw A.i(A.em("Expected "+A.o(d)+" in ChapterFormat (got "+y.kr()+" pos="+y.a+")",e))},
a5_(d,e){var y,x=this
if(x.F7(0,d))x.eW(1)
else{y=x.d
y===$&&A.a()
A.dv(y.getUint8(0))
if(e)x.eW(1)}},
P1(d){return this.a5_(d,!1)},
D4(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.oa()
return!0}return!1},
M0(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.oa()
return!0}return!1},
nl(d){var y=this.d
y===$&&A.a()
return A.dv(y.getUint8(d))},
kr(){return this.nl(0)},
oa(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eW(1)
return y},
awZ(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eW(4)
return y},
pM(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eW(4)
return y},
pL(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eW(4)
return y},
wL(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eW(1)
return A.dv(y)},
ax0(){var y=this.wL()
if(y==="c")return this.wL()
else if(y==="x")return null
else throw A.i(A.em("Unsupported character typechar "+y,"?"))},
tj(d){var y,x,w,v,u,t=this,s=t.wL()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eW(4)
return A.bU(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(A.em("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
awX(){return this.tj(!1)},
aG4(){return J.hv(this.c,this.a,this.b)},
eW(d){this.a+=d
this.b-=d
this.dd()},
Lh(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.F7(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Ps(v,w)
t=J.m_(w)
u.d=t.pC(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pC(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dd()
throw A.i(A.em("Run out of buffer on grabUntil","?"))},
Lg(d){return this.Lh(d,!1)},
a_S(d){var y
if(d||this.hw(C.oU)){y=this.Ez(C.oV)
y=A.fY(y,"@OQ!","{")
return A.fY(y,"@CQ!","}")}return null},
Cq(){return this.a_S(!1)},
ax1(){var y=this.hw(C.oW)
if(y)return this.Ez(D.Ie)
return null},
Ez(d){var y=this.Lh(d,!1)
return F.af.fE(J.hv(y.c,y.a,y.b))},
awY(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dv(w.getUint8(x))!==d[x])return!1}this.eW(y)
return!0},
gH(d){return this.b}}
B.Sq.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibC:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Ps,B.Sq])})()
A.bL(b.typeUniverse,JSON.parse('{"Sq":{"bC":[]}}'));(function constants(){D.Ie=new E.j4(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_5",e:"endPart",h:b})})($__dart_deferred_initializers__,"ks/XlkRD9ombmQLu7HEawBQRPyQ=");