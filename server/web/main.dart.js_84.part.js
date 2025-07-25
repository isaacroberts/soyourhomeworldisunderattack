((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_84",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,D,C,E,B={
a3J(d,e,f){var y=new B.M3(f,d),x=J.l7(d)
y.d=x.oK(d,f,e)
y.b=e==null?x.ga_a(d):e
return y},
M3:function M3(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
OO:function OO(d){this.a=d}}
J=c[1]
A=c[0]
D=c[2]
C=c[51]
E=c[104]
B=a.updateHolder(c[29],B)
B.M3.prototype={
cV(){var y=this
y.d=J.tF(y.c,y.a,y.b)},
kn(){return this.b>0},
Ej(d,e){return B.a3J(this.c,e,this.a+d)},
Dp(d,e){var y,x=this
if(A.mQ(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof C.jj){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.OO("Strange type in BufferPtr.typedCodeComparison("+A.m(e)+" "+J.Y(e).k(0)+") (pos="+x.a+")"))},
hq(d){if(this.Dp(0,d)){this.hS(1)
return!0}return!1},
bV(d,e){var y=this
if(y.Dp(0,d))y.hS(1)
else throw A.i(C.dR("Expected "+A.m(d)+" in ChapterFormat (got "+y.mw()+" pos="+y.a+")",e))},
Mm(d){var y
if(this.Dp(0,d))this.hS(1)
else{y=this.d
y===$&&A.a()
A.de(y.getUint8(0))}},
Bu(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.lO()
return!0}return!1},
JF(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.lO()
return!0}return!1},
o6(d){var y=this.d
y===$&&A.a()
return A.de(y.getUint8(d))},
mw(){return this.o6(0)},
lO(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.hS(1)
return y},
Xk(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.hS(4)
return y},
oS(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.hS(4)
return y},
ar5(){var y=this.d
y===$&&A.a()
D.ah.a1C(y,0)},
oQ(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.hS(4)
return y},
ro(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.hS(1)
return A.de(y)},
AZ(){var y=this,x=y.ro()
if(x==="B")return y.lO()
else if(x==="i")return y.Xk()
else if(x==="q")return y.ar5()
else if(x==="I")return y.oS()
else if(x==="x")return null
else throw A.i(C.dR("Unsupported int typechar "+x+" (pos="+y.a+")","?"))},
ar7(){var y=this.ro()
if(y==="c")return this.ro()
else if(y==="x")return null
else throw A.i(C.dR("Unsupported character typechar "+y,"?"))},
rp(d){var y,x,w,v,u,t=this,s=t.ro()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.hS(4)
return A.ax(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(C.dR("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
Xj(){return this.rp(!1)},
azt(){return J.h8(this.c,this.a,this.b)},
hS(d){this.a+=d
this.b-=d
this.cV()},
IU(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.Dp(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.M3(v,w)
t=J.l7(w)
u.d=t.oK(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.oK(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.cV()
throw A.i(C.dR("Run out of buffer on grabUntil","?"))},
IT(d){return this.IU(d,!1)},
Xl(d){var y
if(d||this.hq(E.nj)){y=this.LC(E.nk)
y=A.jc(y,"@OQ!","{")
return A.jc(y,"@CQ!","}")}return null},
oR(){return this.Xl(!1)},
LC(d){var y=this.IU(d,!1)
return D.a5.eN(J.h8(y.c,y.a,y.b))},
ar4(d){var y,x,w
for(y=d.length,x=0;x<y;++x){w=this.d
w===$&&A.a()
if(A.de(w.getUint8(x))!==d[x])return!1}this.hS(y)
return!0},
gG(d){return this.b}}
B.OO.prototype={
k(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibs:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.y,[B.M3,B.OO])})()
A.bz(b.typeUniverse,JSON.parse('{"OO":{"bs":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_84",e:"endPart",h:b})})($__dart_deferred_initializers__,"XXdBNnqt4lv1AboQLdU4mub3L3Y=");