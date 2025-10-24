((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_56",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,E,B={afy:function afy(d){this.a=d
this.b=null},
b3E(d){return new B.RX(d)},
RX:function RX(d){this.a=d},
we:function we(d,e){this.c=d
this.a=e},
Kw:function Kw(d,e,f){var _=this
_.d=d
_.f=_.e=$
_.w=_.r=0
_.dv$=e
_.b6$=f
_.c=_.a=null},
Ov:function Ov(){}},D
A=c[0]
C=c[2]
E=c[75]
B=a.updateHolder(c[25],B)
D=c[91]
B.afy.prototype={
gkq(){var x,w=this.b
if(w==null){w=$.DZ
if(w==null)w=$.DZ=new A.DY(A.w(y.e,y.s))
x=this.a.d
x.toString
x=this.b=w.a63(x)
w=x}return w},
c8(d){return this.aCZ(d)},
aCZ(d){var x=0,w=A.K(y.b),v,u=this,t
var $async$c8=A.F(function(e,f){if(e===1)return A.H(f,w)
while(true)switch(x){case 0:x=3
return A.z(u.gkq().c8(d),$async$c8)
case 3:t=u.gkq()
t.toString
v=t
x=1
break
case 1:return A.I(v,w)}})
return A.J($async$c8,w)}}
B.RX.prototype={
bP(d){var x=C.h.j(A.bk(this)),w=this.a
if(w==null)w=1
return new B.we(w,new A.l("elvenChorus_"+x,y.q))},
cR(d){var x=C.h.j(A.bk(this)),w=this.a
return new A.c6(new A.ap(null,60,new B.we(w==null?1:w,D.agm),null),new A.l("ElvenChorusStba_"+x,y.q))},
cw(){return"A Elbereth! Gilthoniel!"}}
B.we.prototype={
Y(){var x=null
return new B.Kw(A.iU(x,0,!0,x),x,x)}}
B.Kw.prototype={
ai(){var x=this,w=A.yX(C.bB,x.gLC())
x.e!==$&&A.aW()
x.e=w
$.aMx().c8("ElvenChorus")
x.aw()},
gmh(){var x=this.w,w=this.a.c!==1?this.r:0
return x+24-w},
gQW(){var x=this.a.c
if(x===0)return 12
else if(x===1)return 6
else if(x===2)return 1
A.Dz("Incorrect speed on ElvenChorus: "+x+". Values should be 0-2.",null)
return 12},
q6(d){var x,w,v,u=this
if(u.c!=null&&u.d.f.length!==0&&u.w>0){x=u.d
w=x.f
v=C.b.gcq(w).at
v.toString
if(v===0)x.i_(u.gmh()+10,C.S,A.dA(0,C.e.fv(u.gmh()*u.gQW()),0,0))
else{w=C.b.gcq(w).at
w.toString
if(w>=u.gmh()-30)if(u.a.c!==1)x.ex(0)
else x.i_(0,C.hB,A.dA(0,C.e.fv(u.gmh()*u.gQW()*3),0,0))}}},
l(){var x=this.e
x===$&&A.a()
x.aN()
this.d.l()
this.ac4()},
a6y(d){return 2100},
awZ(d){var x=null
return new A.bl(C.fn,x,x,A.aa(d,x,1,x,x,x,$.aMx().a.xd(48,1),x,x),x)},
PJ(d){var x=null
return new A.bl(C.fn,x,x,A.aa(d,x,1,x,x,x,$.aMx().a,x,x),x)},
rs(d){return new A.dN(this.a7N(d),y.p)},
a7N(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$rs(e,f,g){if(f===1){u.push(g)
w=v}while(true)switch(w){case 0:t=x.length,s=0
case 2:if(!(s<t)){w=4
break}r=s+100
w=5
return e.b=C.c.a7(x,s,Math.min(r,t)),1
case 5:case 3:s=r
w=2
break
case 4:return 0
case 1:return e.c=u.at(-1),3}}}},
aGI(){var x,w,v,u,t,s=this,r=A.b([],y.u)
r.push(C.bY)
x=s.rs("A Elbereth! Gilthoniel!")
w=y.l
v=A.ku(x,s.gawY(),x.$ti.h("L.E"),w)
for(x=s.gPI(),u=0;u<1;++u){t=s.rs(D.Z4[u])
C.b.a2(r,A.ku(t,x,t.$ti.h("L.E"),w))
r.push(D.a6b)
C.b.a2(r,v)
r.push(C.bY)}r.push(new A.ap(s.r,null,null,null))
r.push(C.bY)
return r},
u(d){var x,w,v=this,u=null,t=A.aO(d,C.b2,y.x).w.a.a
if(v.w>0&&t!==v.r){x=v.f
x===$&&A.a()
w=v.r
x[0]=new A.ap(w,u,u,u)
C.b.sar(x,new A.ap(w,u,u,u))}v.r=t
if(v.w<=0){v.w=v.a6y(d)
x=v.aGI()
v.f!==$&&A.aW()
v.f=x}x=v.r
w=v.f
w===$&&A.a()
return A.ei(new A.ap(x,72,A.TX(w,v.d,u,!1,C.a6,!1),u),u,u,u,!0,u,u,u,'"Passing of the Elves"\nfrom Lord of the Rings',u,u,u,u,u,u,u)}}
B.Ov.prototype={
l(){var x=this,w=x.b6$
if(w!=null)w.G(x.geN())
x.b6$=null
x.ao()},
bf(){this.bZ()
this.bO()
this.eO()}}
var z=a.updateTypes(["c(n)","~(@)"]);(function aliases(){var x=B.Ov.prototype
x.ac4=x.l})();(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Kw.prototype,"gLC","q6",1)
x(w,"gawY","awZ",0)
x(w,"gPI","PJ",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit
w(B.afy,A.D)
w(B.RX,E.hm)
w(B.we,A.P)
w(B.Ov,A.R)
w(B.Kw,B.Ov)
x(B.Ov,A.e8)})()
A.bq(b.typeUniverse,JSON.parse('{"we":{"P":[],"c":[]},"RX":{"b1":[]},"Kw":{"R":["we"]}}'))
var y={u:A.B("r<c>"),x:A.B("dW"),q:A.B("l<n>"),l:A.B("c"),p:A.B("dN<n>"),b:A.B("@"),e:A.B("t"),s:A.B("ry?")};(function constants(){var x=a.makeConstList
D.Z4=A.b(x(["Fanuilos heryn aglar / R\xeen athar ann\xfan-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!"]),A.B("r<n>"))
D.a6b=new A.ap(24,null,null,null)
D.Kc=new A.o(1,0.058823529411764705,0.1450980392156863,0.054901960784313725,C.d)
D.abk=new A.q(!0,D.Kc,null,"Celtic Garamond the 2nd",null,null,24,C.D,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.agm=new A.l("elvenChorus",y.q)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"bkW","aMx",()=>new B.afy(D.abk))})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_56",e:"endPart",h:b})})($__dart_deferred_initializers__,"NNUbfBBH1lmgtOYJNXOZigvO9EM=");