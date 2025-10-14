((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_64",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,E,F,B={afi:function afi(d){this.a=d
this.b=null},
b3g(d){return new B.RN(d)},
RN:function RN(d){this.a=d},
wk:function wk(d,e){this.c=d
this.a=e},
Kq:function Kq(d,e,f){var _=this
_.d=d
_.f=_.e=$
_.w=_.r=0
_.dH$=e
_.bd$=f
_.c=_.a=null},
Op:function Op(){}},D
A=c[0]
C=c[2]
E=c[95]
F=c[85]
B=a.updateHolder(c[27],B)
D=c[102]
B.afi.prototype={
gkg(){var x,w=this.b
if(w==null){w=$.DU
if(w==null)w=$.DU=new A.DT(A.x(y.e,y.s))
x=this.a.d
x.toString
x=this.b=w.a5T(x)
w=x}return w},
c8(d){return this.aCS(d)},
aCS(d){var x=0,w=A.J(y.b),v,u=this,t
var $async$c8=A.F(function(e,f){if(e===1)return A.G(f,w)
while(true)switch(x){case 0:x=3
return A.B(u.gkg().c8(d),$async$c8)
case 3:t=u.gkg()
t.toString
v=t
x=1
break
case 1:return A.H(v,w)}})
return A.I($async$c8,w)}}
B.RN.prototype={
bL(d){var x=C.h.j(A.bl(this)),w=this.a
if(w==null)w=1
return new B.wk(w,new A.n("elvenChorus_"+x,y.q))},
cK(d){var x=C.h.j(A.bl(this)),w=this.a
return new A.cc(new A.aq(null,60,new B.wk(w==null?1:w,D.afz),null),new A.n("ElvenChorusStba_"+x,y.q))},
ct(){return"A Elbereth! Gilthoniel!"}}
B.wk.prototype={
Y(){var x=null
return new B.Kq(A.iS(x,0,!0,x),x,x)}}
B.Kq.prototype={
ak(){var x=this,w=A.yU(C.bC,x.gLv())
x.e!==$&&A.aX()
x.e=w
$.aMc().c8("ElvenChorus")
x.aA()},
gm4(){var x=this.w,w=this.a.c!==1?this.r:0
return x+24-w},
gQQ(){var x=this.a.c
if(x===0)return 12
else if(x===1)return 6
else if(x===2)return 1
A.Dv("Incorrect speed on ElvenChorus: "+x+". Values should be 0-2.",null)
return 12},
q3(d){var x,w,v,u=this
if(u.c!=null&&u.d.f.length!==0&&u.w>0){x=u.d
w=x.f
v=C.b.gcq(w).at
v.toString
if(v===0)x.hX(u.gm4()+10,C.T,A.dA(0,C.e.fu(u.gm4()*u.gQQ()),0,0))
else{w=C.b.gcq(w).at
w.toString
if(w>=u.gm4()-30)if(u.a.c!==1)x.ey(0)
else x.hX(0,C.hw,A.dA(0,C.e.fu(u.gm4()*u.gQQ()*3),0,0))}}},
l(){var x=this.e
x===$&&A.a()
x.aM()
this.d.l()
this.abU()},
a6n(d){return 2100},
awO(d){var x=null
return new A.bo(C.fh,x,x,A.ad(d,x,1,x,x,x,$.aMc().a.x7(48,1),x,x),x)},
PC(d){var x=null
return new A.bo(C.fh,x,x,A.ad(d,x,1,x,x,x,$.aMc().a,x,x),x)},
rn(d){return new A.dM(this.a7D(d),y.p)},
a7D(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$rn(e,f,g){if(f===1){u.push(g)
w=v}while(true)switch(w){case 0:t=x.length,s=0
case 2:if(!(s<t)){w=4
break}r=s+100
w=5
return e.b=C.c.a6(x,s,Math.min(r,t)),1
case 5:case 3:s=r
w=2
break
case 4:return 0
case 1:return e.c=u.at(-1),3}}}},
aGD(){var x,w,v,u,t,s=this,r=A.b([],y.u)
r.push(E.c0)
x=s.rn("A Elbereth! Gilthoniel!")
w=y.l
v=A.kv(x,s.gawN(),x.$ti.h("K.E"),w)
for(x=s.gPB(),u=0;u<1;++u){t=s.rn(D.Yp[u])
C.b.a2(r,A.kv(t,x,t.$ti.h("K.E"),w))
r.push(D.a5q)
C.b.a2(r,v)
r.push(E.c0)}r.push(new A.aq(s.r,null,null,null))
r.push(E.c0)
return r},
v(d){var x,w,v=this,u=null,t=A.aN(d,C.aZ,y.x).w.a.a
if(v.w>0&&t!==v.r){x=v.f
x===$&&A.a()
w=v.r
x[0]=new A.aq(w,u,u,u)
C.b.sau(x,new A.aq(w,u,u,u))}v.r=t
if(v.w<=0){v.w=v.a6n(d)
x=v.aGD()
v.f!==$&&A.aX()
v.f=x}x=v.r
w=v.f
w===$&&A.a()
return A.eu(new A.aq(x,72,A.TK(w,v.d,u,!1,C.a6,!1),u),u,u,u,!0,u,u,u,'"Passing of the Elves"\nfrom Lord of the Rings',u,u,u,u,u,u,u)}}
B.Op.prototype={
l(){var x=this,w=x.bd$
if(w!=null)w.G(x.geZ())
x.bd$=null
x.ar()},
bf(){this.bZ()
this.bT()
this.f_()}}
var z=a.updateTypes(["c(m)","~(@)"]);(function aliases(){var x=B.Op.prototype
x.abU=x.l})();(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Kq.prototype,"gLv","q3",1)
x(w,"gawN","awO",0)
x(w,"gPB","PC",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit
w(B.afi,A.C)
w(B.RN,F.hm)
w(B.wk,A.Q)
w(B.Op,A.T)
w(B.Kq,B.Op)
x(B.Op,A.eg)})()
A.bh(b.typeUniverse,JSON.parse('{"wk":{"Q":[],"c":[]},"RN":{"b5":[]},"Kq":{"T":["wk"]}}'))
var y={u:A.u("r<c>"),x:A.u("dP"),q:A.u("n<m>"),l:A.u("c"),p:A.u("dM<m>"),b:A.u("@"),e:A.u("t"),s:A.u("rz?")};(function constants(){var x=a.makeConstList
D.Yp=A.b(x(["Fanuilos heryn aglar / R\xeen athar ann\xfan-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!"]),A.u("r<m>"))
D.a5q=new A.aq(24,null,null,null)
D.JL=new A.o(1,0.058823529411764705,0.1450980392156863,0.054901960784313725,C.d)
D.aaA=new A.q(!0,D.JL,null,"Celtic Garamond the 2nd",null,null,24,C.M,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.afz=new A.n("elvenChorus",y.q)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"bkA","aMc",()=>new B.afi(D.aaA))})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_64",e:"endPart",h:b})})($__dart_deferred_initializers__,"yps4p5T7TGzemfO0HH4Madxmya8=");