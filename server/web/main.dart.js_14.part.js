((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_14",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,G,C,B={
aMu(d,e,f){var y=new B.Q3(f,d),x=J.l3(d)
y.d=x.pW(d,f,e)
y.b=e==null?x.gNP(d):e
return y},
Q3:function Q3(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Ta:function Ta(d){this.a=d}},E,F,D
J=c[1]
A=c[0]
G=c[2]
C=c[68]
B=a.updateHolder(c[5],B)
E=c[85]
F=c[58]
D=c[84]
B.Q3.prototype={
di(){var y=this
y.d=J.ve(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b0Y(this.c)+"]"},
l7(){return this.b>0},
GT(d,e){return B.aMu(this.c,e,this.a+d)},
FT(d,e){var y,x=this
if(A.fP(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.jg){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Ta("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
hB(d){if(this.FT(0,d)){this.eQ(1)
return!0}return!1},
dR(d,e){var y=this
if(y.FT(0,d))y.eQ(1)
else throw A.i(C.eA("Expected "+A.p(d)+" in ChapterFormat (got "+y.kv()+" pos="+y.a+")",e))},
a5m(d,e){var y,x=this
if(x.FT(0,d))x.eQ(1)
else{y=x.d
y===$&&A.a()
A.dE(y.getUint8(0))
if(e)x.eQ(1)}},
PK(d){return this.a5m(d,!1)},
DI(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.oj()
return!0}return!1},
My(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.oj()
return!0}return!1},
nm(d){var y=this.d
y===$&&A.a()
return A.dE(y.getUint8(d))},
kv(){return this.nm(0)},
axh(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dE(y.getUint8(w));++w}this.eQ(d)
return x},
oj(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eQ(1)
return y},
axf(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eQ(4)
return y},
oi(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eQ(4)
return y},
q8(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eQ(4)
return y},
x0(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eQ(1)
return A.dE(y)},
axi(){var y=this.x0()
if(y==="c")return this.x0()
else if(y==="x")return null
else throw A.i(C.eA("Unsupported character typechar "+y,"?"))},
tE(d){var y,x,w,v,u,t=this,s=t.x0()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eQ(4)
return A.bV(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.eA("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axd(){return this.tE(!1)},
aGG(){return J.hO(this.c,this.a,this.b)},
eQ(d){this.a+=d
this.b-=d
this.di()},
LM(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FT(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Q3(v,w)
t=J.l3(w)
u.d=t.pW(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pW(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.di()
throw A.i(C.eA("Run out of buffer on grabUntil","?"))},
LL(d){return this.LM(d,!1)},
a0m(d){var y
if(d||this.hB(D.p7)){y=this.OS(D.p8)
y=A.fQ(y,"@OQ!","{")
return A.fQ(y,"@CQ!","}")}return null},
D4(){return this.a0m(!1)},
axj(){var y=this.hB(D.p9)
if(y)return this.OS(E.J1)
return null},
OS(d){var y=this.LM(d,!1)
return G.ac.f1(J.hO(y.c,y.a,y.b))},
axe(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dE(w.getUint8(x))!==d[x])return!1}this.eQ(y)
return!0},
gH(d){return this.b}}
B.Ta.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibL:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Q3,B.Ta])})()
A.bi(b.typeUniverse,JSON.parse('{"Ta":{"bL":[]}}'));(function constants(){E.J1=new F.jg(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_14",e:"endPart",h:b})})($__dart_deferred_initializers__,"r1IGPuzSas7A/LB6dt3WeOVpgdw=");