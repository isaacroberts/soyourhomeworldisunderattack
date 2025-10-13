((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_61",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,E,B={afc:function afc(d){this.a=d
this.b=null},
b3b(d){return new B.RG(d)},
RG:function RG(d){this.a=d},
wj:function wj(d,e){this.c=d
this.a=e},
Kj:function Kj(d,e,f){var _=this
_.d=d
_.f=_.e=$
_.w=_.r=0
_.dH$=e
_.bd$=f
_.c=_.a=null},
Oi:function Oi(){}},D
A=c[0]
C=c[2]
E=c[83]
B=a.updateHolder(c[27],B)
D=c[100]
B.afc.prototype={
gke(){var x,w=this.b
if(w==null){w=$.DN
if(w==null)w=$.DN=new A.DM(A.x(y.e,y.s))
x=this.a.d
x.toString
x=this.b=w.a5O(x)
w=x}return w},
c8(d){return this.aCM(d)},
aCM(d){var x=0,w=A.J(y.b),v,u=this,t
var $async$c8=A.F(function(e,f){if(e===1)return A.G(f,w)
while(true)switch(x){case 0:x=3
return A.B(u.gke().c8(d),$async$c8)
case 3:t=u.gke()
t.toString
v=t
x=1
break
case 1:return A.H(v,w)}})
return A.I($async$c8,w)}}
B.RG.prototype={
bL(d){var x=C.h.j(A.bl(this)),w=this.a
if(w==null)w=1
return new B.wj(w,new A.n("elvenChorus_"+x,y.q))},
cK(d){var x=C.h.j(A.bl(this)),w=this.a
return new A.cc(new A.aq(null,60,new B.wj(w==null?1:w,D.afi),null),new A.n("ElvenChorusStba_"+x,y.q))},
cs(){return"A Elbereth! Gilthoniel!"}}
B.wj.prototype={
Z(){var x=null
return new B.Kj(A.iR(x,0,!0,x),x,x)}}
B.Kj.prototype={
ak(){var x=this,w=A.yQ(C.bC,x.gLs())
x.e!==$&&A.b1()
x.e=w
$.aM7().c8("ElvenChorus")
x.aA()},
gm4(){var x=this.w,w=this.a.c!==1?this.r:0
return x+24-w},
gQN(){var x=this.a.c
if(x===0)return 12
else if(x===1)return 6
else if(x===2)return 1
A.Do("Incorrect speed on ElvenChorus: "+x+". Values should be 0-2.",null)
return 12},
q3(d){var x,w,v,u=this
if(u.c!=null&&u.d.f.length!==0&&u.w>0){x=u.d
w=x.f
v=C.b.gcp(w).at
v.toString
if(v===0)x.hY(u.gm4()+10,C.T,A.dz(0,C.e.fu(u.gm4()*u.gQN()),0,0))
else{w=C.b.gcp(w).at
w.toString
if(w>=u.gm4()-30)if(u.a.c!==1)x.ey(0)
else x.hY(0,C.hv,A.dz(0,C.e.fu(u.gm4()*u.gQN()*3),0,0))}}},
l(){var x=this.e
x===$&&A.a()
x.aM()
this.d.l()
this.abQ()},
a6j(d){return 2100},
awJ(d){var x=null
return new A.bq(C.fh,x,x,A.ad(d,x,1,x,x,x,$.aM7().a.x5(48,1),x,x),x)},
PA(d){var x=null
return new A.bq(C.fh,x,x,A.ad(d,x,1,x,x,x,$.aM7().a,x,x),x)},
rm(d){return new A.dM(this.a7z(d),y.p)},
a7z(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$rm(e,f,g){if(f===1){u.push(g)
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
aGw(){var x,w,v,u,t,s=this,r=A.b([],y.u)
r.push(C.bM)
x=s.rm("A Elbereth! Gilthoniel!")
w=y.l
v=A.kt(x,s.gawI(),x.$ti.h("K.E"),w)
for(x=s.gPz(),u=0;u<1;++u){t=s.rm(D.Ye[u])
C.b.a2(r,A.kt(t,x,t.$ti.h("K.E"),w))
r.push(D.a5f)
C.b.a2(r,v)
r.push(C.bM)}r.push(new A.aq(s.r,null,null,null))
r.push(C.bM)
return r},
v(d){var x,w,v=this,u=null,t=A.aO(d,C.aZ,y.x).w.a.a
if(v.w>0&&t!==v.r){x=v.f
x===$&&A.a()
w=v.r
x[0]=new A.aq(w,u,u,u)
C.b.sau(x,new A.aq(w,u,u,u))}v.r=t
if(v.w<=0){v.w=v.a6j(d)
x=v.aGw()
v.f!==$&&A.b1()
v.f=x}x=v.r
w=v.f
w===$&&A.a()
return A.fl(new A.aq(x,72,A.TE(w,v.d,u,!1,C.a6,!1),u),u,!0,u,u,'"Passing of the Elves"\nfrom Lord of the Rings',u,u,u,u)}}
B.Oi.prototype={
l(){var x=this,w=x.bd$
if(w!=null)w.G(x.geZ())
x.bd$=null
x.ar()},
bf(){this.bZ()
this.bT()
this.f_()}}
var z=a.updateTypes(["c(l)","~(@)"]);(function aliases(){var x=B.Oi.prototype
x.abQ=x.l})();(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Kj.prototype,"gLs","q3",1)
x(w,"gawI","awJ",0)
x(w,"gPz","PA",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit
w(B.afc,A.C)
w(B.RG,E.hm)
w(B.wj,A.Q)
w(B.Oi,A.T)
w(B.Kj,B.Oi)
x(B.Oi,A.eg)})()
A.bi(b.typeUniverse,JSON.parse('{"wj":{"Q":[],"c":[]},"RG":{"b5":[]},"Kj":{"T":["wj"]}}'))
var y={u:A.w("r<c>"),x:A.w("dP"),q:A.w("n<l>"),l:A.w("c"),p:A.w("dM<l>"),b:A.w("@"),e:A.w("t"),s:A.w("rx?")};(function constants(){var x=a.makeConstList
D.Ye=A.b(x(["Fanuilos heryn aglar / R\xeen athar ann\xfan-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!"]),A.w("r<l>"))
D.a5f=new A.aq(24,null,null,null)
D.JK=new A.o(1,0.058823529411764705,0.1450980392156863,0.054901960784313725,C.d)
D.aap=new A.q(!0,D.JK,null,"Celtic Garamond the 2nd",null,null,24,C.M,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.afi=new A.n("elvenChorus",y.q)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"bkw","aM7",()=>new B.afc(D.aap))})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_61",e:"endPart",h:b})})($__dart_deferred_initializers__,"mwwOlv7P63D5KqrpDNO3+dliVMQ=");