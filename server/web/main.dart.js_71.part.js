((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_71",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,C,D,B={
a74(d,e,f){var y=new B.Oj(f,d),x=J.lC(d)
y.d=x.pr(d,f,e)
y.b=e==null?x.ga1I(d):e
return y},
Oj:function Oj(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Rh:function Rh(d){this.a=d}},F
J=c[1]
A=c[0]
E=c[2]
C=c[53]
D=c[98]
B=a.updateHolder(c[4],B)
F=c[99]
B.Oj.prototype={
d7(){var y=this
y.d=J.ul(y.c,y.a,y.b)},
kO(){return this.b>0},
FA(d,e){return B.a74(this.c,e,this.a+d)},
ED(d,e){var y,x=this
if(A.np(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof C.iS){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Rh("Strange type in BufferPtr.typedCodeComparison("+A.o(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
fz(d){if(this.ED(0,d)){this.eW(1)
return!0}return!1},
br(d,e){var y=this
if(y.ED(0,d))y.eW(1)
else throw A.i(C.dZ("Expected "+A.o(d)+" in ChapterFormat (got "+y.ki()+" pos="+y.a+")",e))},
EM(d,e){var y,x=this
if(x.ED(0,d))x.eW(1)
else{y=x.d
y===$&&A.a()
A.dq(y.getUint8(0))
if(e)x.eW(1)}},
On(d){return this.EM(d,!1)},
Cw(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.mn()
return!0}return!1},
Lk(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.mn()
return!0}return!1},
n8(d){var y=this.d
y===$&&A.a()
return A.dq(y.getUint8(d))},
ki(){return this.n8(0)},
mn(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eW(1)
return y},
Kt(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eW(4)
return y},
mm(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eW(4)
return y},
avt(){var y=this.d
y===$&&A.a()
E.an.a4r(y,0)},
pD(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eW(4)
return y},
tc(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eW(1)
return A.dq(y)},
ZN(){var y=this,x=y.tc()
if(x==="B")return y.mn()
else if(x==="i")return y.Kt()
else if(x==="q")return y.avt()
else if(x==="I")return y.mm()
else if(x==="x")return null
else throw A.i(C.dZ("Unsupported int typechar "+x+" (pos="+y.a+")","?"))},
avv(){var y=this.tc()
if(y==="c")return this.tc()
else if(y==="x")return null
else throw A.i(C.dZ("Unsupported character typechar "+y,"?"))},
td(d){var y,x,w,v,u,t=this,s=t.tc()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eW(4)
return A.ah(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.dZ("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
ZL(){return this.td(!1)},
aE1(){return J.hk(this.c,this.a,this.b)},
eW(d){this.a+=d
this.b-=d
this.d7()},
Kv(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.ED(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Oj(v,w)
t=J.lC(w)
u.d=t.pr(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pr(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.d7()
throw A.i(C.dZ("Run out of buffer on grabUntil","?"))},
Ku(d){return this.Kv(d,!1)},
ZM(d){var y
if(d||this.fz(D.oc)){y=this.E4(D.od)
y=A.iI(y,"@OQ!","{")
return A.iI(y,"@CQ!","}")}return null},
jO(){return this.ZM(!1)},
avw(){var y=this.fz(D.oe)
if(y)return this.E4(F.Hl)
return null},
E4(d){var y=this.Kv(d,!1)
return E.ac.es(J.hk(y.c,y.a,y.b))},
avs(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dq(w.getUint8(x))!==d[x])return!1}this.eW(y)
return!0},
gG(d){return this.b}}
B.Rh.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibx:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.y,[B.Oj,B.Rh])})()
A.bK(b.typeUniverse,JSON.parse('{"Rh":{"bx":[]}}'));(function constants(){F.Hl=new C.iS(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_71",e:"endPart",h:b})})($__dart_deferred_initializers__,"tBi94PYUW00BdSWWZYSAms0HUzU=");