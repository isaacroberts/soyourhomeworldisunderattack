((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_91",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,D,C,E,B={
a5f(d,e,f){var y=new B.N2(f,d),x=J.lu(d)
y.d=x.oR(d,f,e)
y.b=e==null?x.ga0h(d):e
return y},
N2:function N2(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
PU:function PU(d){this.a=d}}
J=c[1]
A=c[0]
D=c[2]
C=c[55]
E=c[106]
B=a.updateHolder(c[31],B)
B.N2.prototype={
cY(){var y=this
y.d=J.u4(y.c,y.a,y.b)},
kC(){return this.b>0},
EX(d,e){return B.a5f(this.c,e,this.a+d)},
E1(d,e){var y,x=this
if(A.n9(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof C.jC){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.h(new B.PU("Strange type in BufferPtr.typedCodeComparison("+A.m(e)+" "+J.Y(e).k(0)+") (pos="+x.a+")"))},
fL(d){if(this.E1(0,d)){this.fg(1)
return!0}return!1},
bC(d,e){var y=this
if(y.E1(0,d))y.fg(1)
else throw A.h(C.dU("Expected "+A.m(d)+" in ChapterFormat (got "+y.kU()+" pos="+y.a+")",e))},
Nc(d){var y
if(this.E1(0,d))this.fg(1)
else{y=this.d
y===$&&A.a()
A.di(y.getUint8(0))}},
BZ(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.lZ()
return!0}return!1},
Kp(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.lZ()
return!0}return!1},
mE(d){var y=this.d
y===$&&A.a()
return A.di(y.getUint8(d))},
kU(){return this.mE(0)},
lZ(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fg(1)
return y},
Yo(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.fg(4)
return y},
lY(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.fg(4)
return y},
at9(){var y=this.d
y===$&&A.a()
D.ai.a2S(y,0)},
oZ(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.fg(4)
return y},
rE(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fg(1)
return A.di(y)},
Yq(){var y=this,x=y.rE()
if(x==="B")return y.lZ()
else if(x==="i")return y.Yo()
else if(x==="q")return y.at9()
else if(x==="I")return y.lY()
else if(x==="x")return null
else throw A.h(C.dU("Unsupported int typechar "+x+" (pos="+y.a+")","?"))},
atb(){var y=this.rE()
if(y==="c")return this.rE()
else if(y==="x")return null
else throw A.h(C.dU("Unsupported character typechar "+y,"?"))},
rF(d){var y,x,w,v,u,t=this,s=t.rE()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.fg(4)
return A.aA(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.h(C.dU("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
Yn(){return this.rF(!1)},
aBL(){return J.he(this.c,this.a,this.b)},
fg(d){this.a+=d
this.b-=d
this.cY()},
JE(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.E1(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.N2(v,w)
t=J.lu(w)
u.d=t.oR(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.oR(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.cY()
throw A.h(C.dU("Run out of buffer on grabUntil","?"))},
JD(d){return this.JE(d,!1)},
Yp(d){var y
if(d||this.fL(E.nA)){y=this.Ms(E.nB)
y=A.hR(y,"@OQ!","{")
return A.hR(y,"@CQ!","}")}return null},
p_(){return this.Yp(!1)},
Ms(d){var y=this.JE(d,!1)
return D.a5.ek(J.he(y.c,y.a,y.b))},
at8(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.di(w.getUint8(x))!==d[x])return!1}this.fg(y)
return!0},
gG(d){return this.b}}
B.PU.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibp:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.v,[B.N2,B.PU])})()
A.bt(b.typeUniverse,JSON.parse('{"PU":{"bp":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_91",e:"endPart",h:b})})($__dart_deferred_initializers__,"DeHUKbAN5EG975tq7iFpBp2BFQo=");