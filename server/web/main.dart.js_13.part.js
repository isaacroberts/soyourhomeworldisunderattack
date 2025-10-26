((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_13",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,D,B={
aMi(d,e,f){var y=new B.Q1(f,d),x=J.l6(d)
y.d=x.pW(d,f,e)
y.b=e==null?x.gNR(d):e
return y},
Q1:function Q1(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
T8:function T8(d){this.a=d}},F,C
J=c[1]
A=c[0]
E=c[2]
D=c[57]
B=a.updateHolder(c[5],B)
F=c[40]
C=c[76]
B.Q1.prototype={
di(){var y=this
y.d=J.ve(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b0J(this.c)+"]"},
qy(){return this.b>0},
QN(d,e){return B.aMi(this.c,e,this.a+d)},
G_(d,e){var y,x=this
if(A.fM(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.li){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.T8("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
axj(d){var y,x,w,v,u,t,s,r,q=this
d=d
if(d==null)d=""
d="json_"+d
q.fI(C.pm,d)
u=q.tJ()
if(u<=2){q.fJ(u)
q.fI(C.l2,d)
return null}y=q.a0i(u)
q.fI(C.l2,d)
try{x=E.bI.eQ(y)
return x}catch(t){w=A.ai(t)
v=A.aI(t)
s=J.cY(w)
r=d
A.wj(new D.mo(s,r),v)}return null},
jo(d){if(this.G_(0,d)){this.fJ(1)
return!0}return!1},
fI(d,e){var y=this
if(y.G_(0,d))y.fJ(1)
else throw A.i(D.f9("Expected "+A.p(d)+" in ChapterFormat (got "+y.mj()+" pos="+y.a+")",e))},
PF(d,e){var y
if(this.G_(0,d))this.fJ(1)
else{y=this.d
y===$&&A.a()
A.dK(y.getUint8(0))}},
DL(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.q7()
return!0}return!1},
MA(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.q7()
return!0}return!1},
r8(d){var y=this.d
y===$&&A.a()
return A.dK(y.getUint8(d))},
mj(){return this.r8(0)},
a0i(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dK(y.getUint8(w));++w}this.fJ(d)
return x},
q7(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fJ(1)
return y},
axi(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.fJ(4)
return y},
tJ(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.fJ(4)
return y},
q6(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.fJ(4)
return y},
LN(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fJ(1)
return A.dK(y)},
tI(d){var y,x,w,v,u,t=this,s=t.LN()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.fJ(4)
return A.bV(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(D.f9("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axh(){return this.tI(!1)},
aGF(){return J.hM(this.c,this.a,this.b)},
fJ(d){this.a+=d
this.b-=d
this.di()},
LO(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.G_(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Q1(v,w)
t=J.l6(w)
u.d=t.pW(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pW(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.di()
throw A.i(D.f9("Run out of buffer on grabUntil","?"))},
a0k(d){return this.LO(d,!1)},
a0j(d){var y
if(d||this.jo(C.Jd)){y=this.a4k(C.Je)
y=A.fN(y,"@OQ!","{")
return A.fN(y,"@CQ!","}")}return null},
axl(){return this.a0j(!1)},
a4k(d){var y=this.LO(d,!1)
return E.ac.eQ(J.hM(y.c,y.a,y.b))},
gH(d){return this.b}}
B.T8.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibK:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Q1,B.T8])})()
A.bw(b.typeUniverse,JSON.parse('{"T8":{"bK":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_13",e:"endPart",h:b})})($__dart_deferred_initializers__,"8bZaVn6/+TPNZUfdLXHghomUTb8=");