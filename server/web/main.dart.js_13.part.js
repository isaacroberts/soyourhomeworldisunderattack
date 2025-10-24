((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_13",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,D,B={
aMU(d,e,f){var y=new B.Qh(f,d),x=J.l3(d)
y.d=x.q0(d,f,e)
y.b=e==null?x.gNZ(d):e
return y},
Qh:function Qh(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Tq:function Tq(d){this.a=d}},F,C
J=c[1]
A=c[0]
E=c[2]
D=c[63]
B=a.updateHolder(c[5],B)
F=c[54]
C=c[76]
B.Qh.prototype={
dj(){var y=this
y.d=J.vc(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.b1o(this.c)+"]"},
n9(){return this.b>0},
H4(d,e){return B.aMU(this.c,e,this.a+d)},
G3(d,e){var y,x=this
if(A.fO(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.lf){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Tq("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
axu(d){var y,x,w,v,u,t,s,r,q=this
d=d
if(d==null)d=""
d="json_"+d
q.er(C.pt,d)
u=q.mS()
if(u<=2){q.fi(u)
q.er(C.l4,d)
return null}y=q.a0w(u)
q.er(C.l4,d)
try{x=E.bI.eR(y)
return x}catch(t){w=A.ai(t)
v=A.aH(t)
s=J.cZ(w)
r=d
A.DA(new D.mq(s,r),v)}return null},
iL(d){if(this.G3(0,d)){this.fi(1)
return!0}return!1},
er(d,e){var y=this
if(y.G3(0,d))y.fi(1)
else throw A.i(D.fa("Expected "+A.p(d)+" in ChapterFormat (got "+y.lt()+" pos="+y.a+")",e))},
Ge(d,e){var y
if(this.G3(0,d))this.fi(1)
else{y=this.d
y===$&&A.a()
A.dK(y.getUint8(0))}},
PT(d){return this.Ge(d,!1)},
DP(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.ot()
return!0}return!1},
MI(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.ot()
return!0}return!1},
nx(d){var y=this.d
y===$&&A.a()
return A.dK(y.getUint8(d))},
lt(){return this.nx(0)},
a0w(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dK(y.getUint8(w));++w}this.fi(d)
return x},
ot(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fi(1)
return y},
axt(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.fi(4)
return y},
mS(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.fi(4)
return y},
qb(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.fi(4)
return y},
LU(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fi(1)
return A.dK(y)},
tK(d){var y,x,w,v,u,t=this,s=t.LU()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.fi(4)
return A.bV(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(D.fa("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
axs(){return this.tK(!1)},
aGS(){return J.hP(this.c,this.a,this.b)},
fi(d){this.a+=d
this.b-=d
this.dj()},
LV(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.G3(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Qh(v,w)
t=J.l3(w)
u.d=t.q0(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.q0(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.dj()
throw A.i(D.fa("Run out of buffer on grabUntil","?"))},
a0y(d){return this.LV(d,!1)},
a0x(d){var y
if(d||this.iL(C.pq)){y=this.a4x(C.pr)
y=A.fP(y,"@OQ!","{")
return A.fP(y,"@CQ!","}")}return null},
axw(){return this.a0x(!1)},
a4x(d){var y=this.LV(d,!1)
return E.ac.eR(J.hP(y.c,y.a,y.b))},
gH(d){return this.b}}
B.Tq.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibM:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.D,[B.Qh,B.Tq])})()
A.bq(b.typeUniverse,JSON.parse('{"Tq":{"bM":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_13",e:"endPart",h:b})})($__dart_deferred_initializers__,"PbAPlvNET3vs7BNlcaXsdNrk7sM=");