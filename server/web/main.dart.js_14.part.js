((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_14",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,G,C,B={
aMf(d,e,f){var y=new B.Q0(f,d),x=J.l2(d)
y.d=x.pV(d,f,e)
y.b=e==null?x.gNK(d):e
return y},
Q0:function Q0(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
T5:function T5(d){this.a=d}},E,F,D
J=c[1]
A=c[0]
G=c[2]
C=c[69]
B=a.updateHolder(c[5],B)
E=c[86]
F=c[59]
D=c[85]
B.Q0.prototype={
di(){var y=this
y.d=J.ve(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b0L(this.c)+"]"},
l5(){return this.b>0},
GR(d,e){return B.aMf(this.c,e,this.a+d)},
FS(d,e){var y,x=this
if(A.fO(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.jh){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.T5("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
hB(d){if(this.FS(0,d)){this.eQ(1)
return!0}return!1},
dR(d,e){var y=this
if(y.FS(0,d))y.eQ(1)
else throw A.i(C.eA("Expected "+A.p(d)+" in ChapterFormat (got "+y.kv()+" pos="+y.a+")",e))},
a5k(d,e){var y,x=this
if(x.FS(0,d))x.eQ(1)
else{y=x.d
y===$&&A.a()
A.dD(y.getUint8(0))
if(e)x.eQ(1)}},
PG(d){return this.a5k(d,!1)},
DG(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.og()
return!0}return!1},
Mu(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.og()
return!0}return!1},
nm(d){var y=this.d
y===$&&A.a()
return A.dD(y.getUint8(d))},
kv(){return this.nm(0)},
axj(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dD(y.getUint8(w));++w}this.eQ(d)
return x},
og(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eQ(1)
return y},
axh(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eQ(4)
return y},
of(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eQ(4)
return y},
q6(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eQ(4)
return y},
x3(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eQ(1)
return A.dD(y)},
axk(){var y=this.x3()
if(y==="c")return this.x3()
else if(y==="x")return null
else throw A.i(C.eA("Unsupported character typechar "+y,"?"))},
tE(d){var y,x,w,v,u,t=this,s=t.x3()
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
axf(){return this.tE(!1)},
aGH(){return J.hM(this.c,this.a,this.b)},
eQ(d){this.a+=d
this.b-=d
this.di()},
LJ(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FS(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Q0(v,w)
t=J.l2(w)
u.d=t.pV(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pV(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.di()
throw A.i(C.eA("Run out of buffer on grabUntil","?"))},
LI(d){return this.LJ(d,!1)},
a0j(d){var y
if(d||this.hB(D.p7)){y=this.OO(D.p8)
y=A.fP(y,"@OQ!","{")
return A.fP(y,"@CQ!","}")}return null},
D3(){return this.a0j(!1)},
axl(){var y=this.hB(D.p9)
if(y)return this.OO(E.IZ)
return null},
OO(d){var y=this.LJ(d,!1)
return G.ac.f1(J.hM(y.c,y.a,y.b))},
axg(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dD(w.getUint8(x))!==d[x])return!1}this.eQ(y)
return!0},
gH(d){return this.b}}
B.T5.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibL:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.B,[B.Q0,B.T5])})()
A.bh(b.typeUniverse,JSON.parse('{"T5":{"bL":[]}}'));(function constants(){E.IZ=new F.jh(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_14",e:"endPart",h:b})})($__dart_deferred_initializers__,"ibjGopoQo1T+iM80Iqmsbzumv/o=");