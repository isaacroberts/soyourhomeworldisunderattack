((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_13",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,G,C,B={
aMe(d,e,f){var y=new B.Q7(f,d),x=J.l3(d)
y.d=x.pV(d,f,e)
y.b=e==null?x.gNS(d):e
return y},
Q7:function Q7(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
T9:function T9(d){this.a=d}},E,F,D
J=c[1]
A=c[0]
G=c[2]
C=c[65]
B=a.updateHolder(c[5],B)
E=c[83]
F=c[56]
D=c[82]
B.Q7.prototype={
dk(){var y=this
y.d=J.vg(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b0N(this.c)+"]"},
la(){return this.b>0},
GU(d,e){return B.aMe(this.c,e,this.a+d)},
FR(d,e){var y,x=this
if(A.fM(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.jf){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.T9("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
hC(d){if(this.FR(0,d)){this.eQ(1)
return!0}return!1},
dS(d,e){var y=this
if(y.FR(0,d))y.eQ(1)
else throw A.i(C.ex("Expected "+A.p(d)+" in ChapterFormat (got "+y.kA()+" pos="+y.a+")",e))},
a5q(d,e){var y,x=this
if(x.FR(0,d))x.eQ(1)
else{y=x.d
y===$&&A.a()
A.dG(y.getUint8(0))
if(e)x.eQ(1)}},
PL(d){return this.a5q(d,!1)},
DH(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.om()
return!0}return!1},
MC(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.om()
return!0}return!1},
nw(d){var y=this.d
y===$&&A.a()
return A.dG(y.getUint8(d))},
kA(){return this.nw(0)},
axs(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dG(y.getUint8(w));++w}this.eQ(d)
return x},
om(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eQ(1)
return y},
axq(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.eQ(4)
return y},
ol(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.eQ(4)
return y},
q8(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.eQ(4)
return y},
x3(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.eQ(1)
return A.dG(y)},
axt(){var y=this.x3()
if(y==="c")return this.x3()
else if(y==="x")return null
else throw A.i(C.ex("Unsupported character typechar "+y,"?"))},
tI(d){var y,x,w,v,u,t=this,s=t.x3()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.eQ(4)
return A.bV(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.ex("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axo(){return this.tI(!1)},
aGD(){return J.hI(this.c,this.a,this.b)},
eQ(d){this.a+=d
this.b-=d
this.dk()},
LR(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.FR(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Q7(v,w)
t=J.l3(w)
u.d=t.pV(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pV(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dk()
throw A.i(C.ex("Run out of buffer on grabUntil","?"))},
LQ(d){return this.LR(d,!1)},
a0o(d){var y
if(d||this.hC(D.pm)){y=this.OT(D.pn)
y=A.fN(y,"@OQ!","{")
return A.fN(y,"@CQ!","}")}return null},
D4(){return this.a0o(!1)},
axu(){var y=this.hC(D.po)
if(y)return this.OT(E.JJ)
return null},
OT(d){var y=this.LR(d,!1)
return G.af.f2(J.hI(y.c,y.a,y.b))},
axp(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.dG(w.getUint8(x))!==d[x])return!1}this.eQ(y)
return!0},
gH(d){return this.b}}
B.T9.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibL:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Q7,B.T9])})()
A.bo(b.typeUniverse,JSON.parse('{"T9":{"bL":[]}}'));(function constants(){E.JJ=new F.jf(93,25,"RSQR")})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_13",e:"endPart",h:b})})($__dart_deferred_initializers__,"v2PtKu+5u/34Ensfax9z4WQaRuM=");