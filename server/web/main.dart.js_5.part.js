((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_5",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,F,B={
aPg(d,e,f){var y=new B.Po(f,d),x=J.kQ(d)
y.d=x.pG(d,f,e)
y.b=e==null?x.gNl(d):e
return y},
Po:function Po(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Sm:function Sm(d){this.a=d}},D,E,C
J=c[1]
A=c[0]
F=c[2]
B=a.updateHolder(c[3],B)
D=c[66]
E=c[46]
C=c[65]
B.Po.prototype={
dd(){var y=this
y.d=J.uK(y.c,y.a,y.b)},
k(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.aZV(this.c)+"]"},
l1(){return this.b>0},
Gp(d,e){return B.aPg(this.c,e,this.a+d)},
Fg(d,e){var y,x=this
if(A.kO(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof E.j3){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Sm("Strange type in BufferPtr.typedCodeComparison("+A.n(e)+" "+J.Z(e).k(0)+") (pos="+x.a+")"))},
hx(d){if(this.Fg(0,d)){this.eO(1)
return!0}return!1},
dP(d,e){var y=this
if(y.Fg(0,d))y.eO(1)
else throw A.i(A.em("Expected "+A.n(d)+" in ChapterFormat (got "+y.kv()+" pos="+y.a+")",e))},
a59(d,e){var y,x=this
if(x.Fg(0,d))x.eO(1)
else{y=x.d
y===$&&A.a()
A.dt(y.getUint8(0))
if(e)x.eO(1)}},
Pb(d){return this.a59(d,!1)},
Df(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.oc()
return!0}return!1},
Ma(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.oc()
return!0}return!1},
nm(d){var y=this.d
y===$&&A.a()
return A.dt(y.getUint8(d))},
kv(){return this.nm(0)},
ax8(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dt(y.getUint8(w));++w}this.eO(d)
return x},
oc(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eO(1)
return y},
ax6(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eO(4)
return y},
ob(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eO(4)
return y},
pP(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eO(4)
return y},
wS(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eO(1)
return A.dt(y)},
ax9(){var y=this.wS()
if(y==="c")return this.wS()
else if(y==="x")return null
else throw A.i(A.em("Unsupported character typechar "+y,"?"))},
tp(d){var y,x,w,v,u,t=this,s=t.wS()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eO(4)
return A.bT(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(A.em("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
ax4(){return this.tp(!1)},
aGk(){return J.hw(this.c,this.a,this.b)},
eO(d){this.a+=d
this.b-=d
this.dd()},
Lq(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.Fg(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Po(v,w)
t=J.kQ(w)
u.d=t.pG(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pG(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dd()
throw A.i(A.em("Run out of buffer on grabUntil","?"))},
Lp(d){return this.Lq(d,!1)},
a03(d){var y
if(d||this.hx(C.oW)){y=this.Om(C.oX)
y=A.hv(y,"@OQ!","{")
return A.hv(y,"@CQ!","}")}return null},
CD(){return this.a03(!1)},
axa(){var y=this.hx(C.oY)
if(y)return this.Om(D.Ic)
return null},
Om(d){var y=this.Lq(d,!1)
return F.ag.fG(J.hw(y.c,y.a,y.b))},
ax5(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dt(w.getUint8(x))!==d[x])return!1}this.eO(y)
return!0},
gH(d){return this.b}}
B.Sm.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibH:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Po,B.Sm])})()
A.bJ(b.typeUniverse,JSON.parse('{"Sm":{"bH":[]}}'));(function constants(){D.Ic=new E.j3(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_5",e:"endPart",h:b})})($__dart_deferred_initializers__,"SwsvgtF6uMtlPD3DiMeIthn1EX8=");