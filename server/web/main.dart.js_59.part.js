((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_59",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,E,B={afb:function afb(d){this.a=d
this.b=null},
b3_(d){return new B.RF(d)},
RF:function RF(d){this.a=d},
wg:function wg(d,e){this.c=d
this.a=e},
Kl:function Kl(d,e,f){var _=this
_.d=d
_.f=_.e=$
_.w=_.r=0
_.du$=e
_.b6$=f
_.c=_.a=null},
Og:function Og(){}},D
A=c[0]
C=c[2]
E=c[75]
B=a.updateHolder(c[23],B)
D=c[93]
B.afb.prototype={
gkm(){var x,w=this.b
if(w==null){w=$.DU
if(w==null)w=$.DU=new A.DT(A.w(y.e,y.s))
x=this.a.d
x.toString
x=this.b=w.a5R(x)
w=x}return w},
c8(d){return this.aCP(d)},
aCP(d){var x=0,w=A.J(y.b),v,u=this,t
var $async$c8=A.F(function(e,f){if(e===1)return A.G(f,w)
while(true)switch(x){case 0:x=3
return A.B(u.gkm().c8(d),$async$c8)
case 3:t=u.gkm()
t.toString
v=t
x=1
break
case 1:return A.H(v,w)}})
return A.I($async$c8,w)}}
B.RF.prototype={
c4(d){var x=C.h.j(A.bj(this)),w=this.a
if(w==null)w=1
return new B.wg(w,new A.l("elvenChorus_"+x,y.q))},
cU(d){var x=C.h.j(A.bj(this)),w=this.a
return new A.c6(new A.ar(null,60,new B.wg(w==null?1:w,D.ag_),null),new A.l("ElvenChorusStba_"+x,y.q))},
cI(){return"A Elbereth! Gilthoniel!"}}
B.wg.prototype={
Y(){var x=null
return new B.Kl(A.iR(x,0,!0,x),x,x)}}
B.Kl.prototype={
ai(){var x=this,w=A.yY(C.bB,x.gLv())
x.e!==$&&A.aW()
x.e=w
$.aLW().c8("ElvenChorus")
x.aw()},
gmd(){var x=this.w,w=this.a.c!==1?this.r:0
return x+24-w},
gQH(){var x=this.a.c
if(x===0)return 12
else if(x===1)return 6
else if(x===2)return 1
A.RR("Incorrect speed on ElvenChorus: "+x+". Values should be 0-2.",null)
return 12},
q1(d){var x,w,v,u=this
if(u.c!=null&&u.d.f.length!==0&&u.w>0){x=u.d
w=x.f
v=C.b.gcq(w).at
v.toString
if(v===0)x.hX(u.gmd()+10,C.S,A.dz(0,C.e.fs(u.gmd()*u.gQH()),0,0))
else{w=C.b.gcq(w).at
w.toString
if(w>=u.gmd()-30)if(u.a.c!==1)x.ew(0)
else x.hX(0,C.hz,A.dz(0,C.e.fs(u.gmd()*u.gQH()*3),0,0))}}},
l(){var x=this.e
x===$&&A.a()
x.aN()
this.d.l()
this.abV()},
a6m(d){return 2100},
awP(d){var x=null
return new A.bo(C.fm,x,x,A.ac(d,x,1,x,x,x,$.aLW().a.xe(48,1),x,x),x)},
Pv(d){var x=null
return new A.bo(C.fm,x,x,A.ac(d,x,1,x,x,x,$.aLW().a,x,x),x)},
rq(d){return new A.dN(this.a7B(d),y.p)},
a7B(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$rq(e,f,g){if(f===1){u.push(g)
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
aGv(){var x,w,v,u,t,s=this,r=A.b([],y.u)
r.push(C.di)
x=s.rq("A Elbereth! Gilthoniel!")
w=y.l
v=A.kx(x,s.gawO(),x.$ti.h("K.E"),w)
for(x=s.gPu(),u=0;u<1;++u){t=s.rq(D.YM[u])
C.b.a2(r,A.kx(t,x,t.$ti.h("K.E"),w))
r.push(D.a5R)
C.b.a2(r,v)
r.push(C.di)}r.push(new A.ar(s.r,null,null,null))
r.push(C.di)
return r},
v(d){var x,w,v=this,u=null,t=A.aN(d,C.b0,y.x).w.a.a
if(v.w>0&&t!==v.r){x=v.f
x===$&&A.a()
w=v.r
x[0]=new A.ar(w,u,u,u)
C.b.sar(x,new A.ar(w,u,u,u))}v.r=t
if(v.w<=0){v.w=v.a6m(d)
x=v.aGv()
v.f!==$&&A.aW()
v.f=x}x=v.r
w=v.f
w===$&&A.a()
return A.eu(new A.ar(x,72,A.TE(w,v.d,u,!1,C.ab,!1),u),u,u,u,!0,u,u,u,'"Passing of the Elves"\nfrom Lord of the Rings',u,u,u,u,u,u,u)}}
B.Og.prototype={
l(){var x=this,w=x.b6$
if(w!=null)w.G(x.geM())
x.b6$=null
x.ao()},
bf(){this.bZ()
this.bO()
this.eN()}}
var z=a.updateTypes(["c(o)","~(@)"]);(function aliases(){var x=B.Og.prototype
x.abV=x.l})();(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Kl.prototype,"gLv","q1",1)
x(w,"gawO","awP",0)
x(w,"gPu","Pv",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit
w(B.afb,A.C)
w(B.RF,E.iq)
w(B.wg,A.R)
w(B.Og,A.S)
w(B.Kl,B.Og)
x(B.Og,A.e8)})()
A.bw(b.typeUniverse,JSON.parse('{"wg":{"R":[],"c":[]},"RF":{"ba":[]},"Kl":{"S":["wg"]}}'))
var y={u:A.A("r<c>"),x:A.A("dW"),q:A.A("l<o>"),l:A.A("c"),p:A.A("dN<o>"),b:A.A("@"),e:A.A("t"),s:A.A("rz?")};(function constants(){var x=a.makeConstList
D.YM=A.b(x(["Fanuilos heryn aglar / R\xeen athar ann\xfan-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!"]),A.A("r<o>"))
D.a5R=new A.ar(24,null,null,null)
D.JZ=new A.n(1,0.058823529411764705,0.1450980392156863,0.054901960784313725,C.d)
D.aaY=new A.q(!0,D.JZ,null,"Celtic Garamond the 2nd",null,null,24,C.C,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.ag_=new A.l("elvenChorus",y.q)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"bkb","aLW",()=>new B.afb(D.aaY))})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_59",e:"endPart",h:b})})($__dart_deferred_initializers__,"3qfhBIzbrUGEyeDbffyNgVUamGk=");