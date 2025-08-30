((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_76",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,C,D,B={
a88(d,e,f){var y=new B.Pa(f,d),x=J.lT(d)
y.d=x.py(d,f,e)
y.b=e==null?x.ga2t(d):e
return y},
Pa:function Pa(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
S5:function S5(d){this.a=d}},F
J=c[1]
A=c[0]
E=c[2]
C=c[53]
D=c[100]
B=a.updateHolder(c[4],B)
F=c[101]
B.Pa.prototype={
dc(){var y=this
y.d=J.uD(y.c,y.a,y.b)},
kY(){return this.b>0},
G7(d,e){return B.a88(this.c,e,this.a+d)},
EZ(d,e){var y,x=this
if(A.nB(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof C.j0){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.S5("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
fA(d){if(this.EZ(0,d)){this.eT(1)
return!0}return!1},
bH(d,e){var y=this
if(y.EZ(0,d))y.eT(1)
else throw A.i(C.e6("Expected "+A.o(d)+" in ChapterFormat (got "+y.kp()+" pos="+y.a+")",e))},
a4I(d,e){var y,x=this
if(x.EZ(0,d))x.eT(1)
else{y=x.d
y===$&&A.a()
A.ds(y.getUint8(0))
if(e)x.eT(1)}},
OR(d){return this.a4I(d,!1)},
CU(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.my()
return!0}return!1},
LQ(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.my()
return!0}return!1},
nh(d){var y=this.d
y===$&&A.a()
return A.ds(y.getUint8(d))},
kp(){return this.nh(0)},
my(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eT(1)
return y},
a_y(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eT(4)
return y},
lw(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eT(4)
return y},
awt(){var y=this.d
y===$&&A.a()
E.ap.a5e(y,0)},
pJ(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eT(4)
return y},
tb(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eT(1)
return A.ds(y)},
aww(){var y=this,x=y.tb()
if(x==="B")return y.my()
else if(x==="i")return y.a_y()
else if(x==="q")return y.awt()
else if(x==="I")return y.lw()
else if(x==="x")return null
else throw A.i(C.e6("Unsupported int typechar "+x+" (pos="+y.a+")","?"))},
awv(){var y=this.tb()
if(y==="c")return this.tb()
else if(y==="x")return null
else throw A.i(C.e6("Unsupported character typechar "+y,"?"))},
tc(d){var y,x,w,v,u,t=this,s=t.tb()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eT(4)
return A.bW(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.e6("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
a_x(){return this.tc(!1)},
aFh(){return J.hu(this.c,this.a,this.b)},
eT(d){this.a+=d
this.b-=d
this.dc()},
L5(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.EZ(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Pa(v,w)
t=J.lT(w)
u.d=t.py(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.py(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dc()
throw A.i(C.e6("Run out of buffer on grabUntil","?"))},
L4(d){return this.L5(d,!1)},
a_z(d){var y
if(d||this.fA(D.oP)){y=this.Ep(D.oQ)
y=A.h_(y,"@OQ!","{")
return A.h_(y,"@CQ!","}")}return null},
lv(){return this.a_z(!1)},
awx(){var y=this.fA(D.oR)
if(y)return this.Ep(F.I2)
return null},
Ep(d){var y=this.L5(d,!1)
return E.ae.fB(J.hu(y.c,y.a,y.b))},
aws(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.ds(w.getUint8(x))!==d[x])return!1}this.eT(y)
return!0},
gH(d){return this.b}}
B.S5.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibA:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.A,[B.Pa,B.S5])})()
A.bL(b.typeUniverse,JSON.parse('{"S5":{"bA":[]}}'));(function constants(){F.I2=new C.j0(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_76",e:"endPart",h:b})})($__dart_deferred_initializers__,"/MRGPxNcbn8gzg2A9W2I8nDLUew=");