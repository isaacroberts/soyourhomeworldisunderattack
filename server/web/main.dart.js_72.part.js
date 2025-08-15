((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_72",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,C,D,B={
a7k(d,e,f){var y=new B.Op(f,d),x=J.lH(d)
y.d=x.pu(d,f,e)
y.b=e==null?x.ga20(d):e
return y},
Op:function Op(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Rm:function Rm(d){this.a=d}},F
J=c[1]
A=c[0]
E=c[2]
C=c[51]
D=c[93]
B=a.updateHolder(c[4],B)
F=c[94]
B.Op.prototype={
da(){var y=this
y.d=J.uj(y.c,y.a,y.b)},
kU(){return this.b>0},
FQ(d,e){return B.a7k(this.c,e,this.a+d)},
ET(d,e){var y,x=this
if(A.nu(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof C.iU){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Rm("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
fw(d){if(this.ET(0,d)){this.eU(1)
return!0}return!1},
bt(d,e){var y=this
if(y.ET(0,d))y.eU(1)
else throw A.i(C.e1("Expected "+A.o(d)+" in ChapterFormat (got "+y.kk()+" pos="+y.a+")",e))},
F1(d,e){var y,x=this
if(x.ET(0,d))x.eU(1)
else{y=x.d
y===$&&A.a()
A.dq(y.getUint8(0))
if(e)x.eU(1)}},
OB(d){return this.F1(d,!1)},
CG(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.ms()
return!0}return!1},
LD(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.ms()
return!0}return!1},
n9(d){var y=this.d
y===$&&A.a()
return A.dq(y.getUint8(d))},
kk(){return this.n9(0)},
ms(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eU(1)
return y},
KN(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eU(4)
return y},
mr(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eU(4)
return y},
avV(){var y=this.d
y===$&&A.a()
E.ao.a4L(y,0)},
pG(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eU(4)
return y},
td(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eU(1)
return A.dq(y)},
a_1(){var y=this,x=y.td()
if(x==="B")return y.ms()
else if(x==="i")return y.KN()
else if(x==="q")return y.avV()
else if(x==="I")return y.mr()
else if(x==="x")return null
else throw A.i(C.e1("Unsupported int typechar "+x+" (pos="+y.a+")","?"))},
avX(){var y=this.td()
if(y==="c")return this.td()
else if(y==="x")return null
else throw A.i(C.e1("Unsupported character typechar "+y,"?"))},
te(d){var y,x,w,v,u,t=this,s=t.td()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eU(4)
return A.ag(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.e1("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
a__(){return this.te(!1)},
aEw(){return J.hl(this.c,this.a,this.b)},
eU(d){this.a+=d
this.b-=d
this.da()},
KP(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.ET(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Op(v,w)
t=J.lH(w)
u.d=t.pu(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pu(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.da()
throw A.i(C.e1("Run out of buffer on grabUntil","?"))},
KO(d){return this.KP(d,!1)},
a_0(d){var y
if(d||this.fw(D.oq)){y=this.Ei(D.or)
y=A.iJ(y,"@OQ!","{")
return A.iJ(y,"@CQ!","}")}return null},
jO(){return this.a_0(!1)},
avY(){var y=this.fw(D.os)
if(y)return this.Ei(F.HA)
return null},
Ei(d){var y=this.KP(d,!1)
return E.ae.es(J.hl(y.c,y.a,y.b))},
avU(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dq(w.getUint8(x))!==d[x])return!1}this.eU(y)
return!0},
gG(d){return this.b}}
B.Rm.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibx:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.y,[B.Op,B.Rm])})()
A.bO(b.typeUniverse,JSON.parse('{"Rm":{"bx":[]}}'));(function constants(){F.HA=new C.iU(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_72",e:"endPart",h:b})})($__dart_deferred_initializers__,"ERWWRIDPfUrO5ulpdoT4FCSfd6s=");