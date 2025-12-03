((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_16",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,D,B={
aKc(d,e,f){var y=new B.Po(f,d),x=J.l_(d)
y.d=x.pr(d,f,e)
y.b=e==null?x.gN0(d):e
return y},
Po:function Po(d,e){var _=this
_.a=d
_.b=0
_.c=e
_.d=$},
Su:function Su(d){this.a=d}},F,C
J=c[1]
A=c[0]
E=c[2]
D=c[58]
B=a.updateHolder(c[5],B)
F=c[40]
C=c[76]
B.Po.prototype={
da(){var y=this
y.d=J.v7(y.c,y.a,y.b)},
j(d){var y=this.a
return"["+y+"-"+(y+this.b)+" / "+J.aZs(this.c)+"]"},
q3(){return this.b>0},
PY(d,e){return B.aKc(this.c,e,this.a+d)},
Fg(d,e){var y,x=this
if(A.fL(e)){y=x.d
y===$&&A.a()
return y.getUint8(d)===e}else if(typeof e=="string"){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.charCodeAt(0)}else if(e instanceof F.lc){y=x.d
y===$&&A.a()
return y.getUint8(d)===e.c}else throw A.i(new B.Su("Strange type in BufferPtr.typedCodeComparison("+A.p(e)+" "+J.Z(e).j(0)+") (pos="+x.a+")"))},
aw4(d){var y,x,w,v,u,t,s,r,q=this
d=d
if(d==null)d=""
d="json_"+d
q.fz(C.oE,d)
u=q.t8()
if(u<=2){q.fA(u)
q.fz(C.ku,d)
return null}y=q.a_q(u)
q.fz(C.ku,d)
try{x=E.bL.eH(y)
return x}catch(t){w=A.ai(t)
v=A.aD(t)
s=J.cT(w)
r=d
A.wb(new D.mi(s,r),v)}return null},
ja(d){if(this.Fg(0,d)){this.fA(1)
return!0}return!1},
fz(d,e){var y=this
if(y.Fg(0,d))y.fA(1)
else throw A.i(D.f8("Expected "+A.p(d)+" in ChapterFormat (got "+y.lR()+" pos="+y.a+")",e))},
OK(d,e){var y
if(this.Fg(0,d))this.fA(1)
else{y=this.d
y===$&&A.a()
A.dF(y.getUint8(0))}},
D5(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===41){this.pC()
return!0}return!1},
LR(){var y=this.d
y===$&&A.a()
if(y.getUint8(0)===38){this.pC()
return!0}return!1},
qC(d){var y=this.d
y===$&&A.a()
return A.dF(y.getUint8(d))},
lR(){return this.qC(0)},
a_q(d){var y,x="",w=0
while(!0){if(!(w<d&&w<this.b))break
y=this.d
y===$&&A.a()
x+=A.dF(y.getUint8(w));++w}this.fA(d)
return x},
pC(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fA(1)
return y},
aw3(){var y,x=this.d
x===$&&A.a()
y=x.getInt32(0,!1)
this.fA(4)
return y},
t8(){var y,x=this.d
x===$&&A.a()
y=x.getUint32(0,!1)
this.fA(4)
return y},
pB(){var y,x=this.d
x===$&&A.a()
y=x.getFloat32(0,!1)
this.fA(4)
return y},
L5(){var y,x=this.d
x===$&&A.a()
y=x.getUint8(0)
this.fA(1)
return A.dF(y)},
t7(d){var y,x,w,v,u,t=this,s=t.L5()
if(s==="H"){y=t.d
y===$&&A.a()
x=y.getUint8(0)
w=t.d.getUint8(1)
v=t.d.getUint8(2)
u=t.d.getUint8(3)
t.fA(4)
return A.ca(x,w,v,u)}else if(s==="x"||s==="X")return null
else{if(d)throw A.i(D.f8("Unexpected typechar in color ("+s+" "+t.a+")","?"))
return null}},
aw2(){return this.t7(!1)},
aFN(){return J.hH(this.c,this.a,this.b)},
fA(d){this.a+=d
this.b-=d
this.da()},
L6(d,e){var y,x,w,v,u,t,s=this
for(y=0;x=s.b,y<x;){if(s.Fg(y,d)){x=y+(e?1:0)
w=s.c
v=s.a
u=new B.Po(v,w)
t=J.l_(w)
u.d=t.pr(w,v,x)
u.b=x
x=y+1
v=s.a+x
s.a=v
s.d=t.pr(w,v,s.b-=x)
return u}++y}s.a=x
s.b=0
s.da()
throw A.i(D.f8("Run out of buffer on grabUntil","?"))},
a_s(d){return this.L6(d,!1)},
a_r(d){var y
if(d||this.ja(C.HO)){y=this.a3g(C.HP)
y=A.fM(y,"@OQ!","{")
return A.fM(y,"@CQ!","}")}return null},
aw6(){return this.a_r(!1)},
a3g(d){var y=this.L6(d,!1)
return E.aa.eH(J.hH(y.c,y.a,y.b))},
gH(d){return this.b}}
B.Su.prototype={
j(d){return"IdiotException (Unhandled dev error): "+this.a},
$ibK:1}
var z=a.updateTypes([]);(function inheritance(){var y=a.inheritMany
y(A.C,[B.Po,B.Su])})()
A.bv(b.typeUniverse,JSON.parse('{"Su":{"bK":[]}}'))};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_16",e:"endPart",h:b})})($__dart_deferred_initializers__,"lCkPUHjBPaVN+Iw97k/E55a5Fww=");