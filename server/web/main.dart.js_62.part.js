((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_62",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,E,B={af2:function af2(d){this.a=d
this.b=null},
b2Z(d){return new B.RC(d)},
RC:function RC(d){this.a=d},
wj:function wj(d,e){this.c=d
this.a=e},
Kg:function Kg(d,e,f){var _=this
_.d=d
_.f=_.e=$
_.w=_.r=0
_.dH$=e
_.bd$=f
_.c=_.a=null},
Od:function Od(){}},D
A=c[0]
C=c[2]
E=c[84]
B=a.updateHolder(c[27],B)
D=c[100]
B.af2.prototype={
gke(){var x,w=this.b
if(w==null){w=$.DN
if(w==null)w=$.DN=new A.DM(A.x(y.e,y.s))
x=this.a.d
x.toString
x=this.b=w.a5M(x)
w=x}return w},
c8(d){return this.aCP(d)},
aCP(d){var x=0,w=A.K(y.b),v,u=this,t
var $async$c8=A.F(function(e,f){if(e===1)return A.H(f,w)
while(true)switch(x){case 0:x=3
return A.C(u.gke().c8(d),$async$c8)
case 3:t=u.gke()
t.toString
v=t
x=1
break
case 1:return A.I(v,w)}})
return A.J($async$c8,w)}}
B.RC.prototype={
bL(d){var x=C.h.j(A.bl(this)),w=this.a
if(w==null)w=1
return new B.wj(w,new A.n("elvenChorus_"+x,y.q))},
cJ(d){var x=C.h.j(A.bl(this)),w=this.a
return new A.cc(new A.ao(null,60,new B.wj(w==null?1:w,D.af7),null),new A.n("ElvenChorusStba_"+x,y.q))},
cs(){return"A Elbereth! Gilthoniel!"}}
B.wj.prototype={
Y(){var x=null
return new B.Kg(A.iR(x,0,!0,x),x,x)}}
B.Kg.prototype={
ak(){var x=this,w=A.yS(C.bC,x.gLp())
x.e!==$&&A.b0()
x.e=w
$.aLS().c8("ElvenChorus")
x.aA()},
gm5(){var x=this.w,w=this.a.c!==1?this.r:0
return x+24-w},
gQK(){var x=this.a.c
if(x===0)return 12
else if(x===1)return 6
else if(x===2)return 1
A.aMJ("Incorrect speed on ElvenChorus: "+x+". Values should be 0-2.",null)
return 12},
q1(d){var x,w,v,u=this
if(u.c!=null&&u.d.f.length!==0&&u.w>0){x=u.d
w=x.f
v=C.b.gcp(w).at
v.toString
if(v===0)x.hY(u.gm5()+10,C.U,A.dn(0,C.e.fu(u.gm5()*u.gQK()),0,0))
else{w=C.b.gcp(w).at
w.toString
if(w>=u.gm5()-30)if(u.a.c!==1)x.ex(0)
else x.hY(0,C.hw,A.dn(0,C.e.fu(u.gm5()*u.gQK()*3),0,0))}}},
l(){var x=this.e
x===$&&A.a()
x.aM()
this.d.l()
this.abR()},
a6h(d){return 2100},
awL(d){var x=null
return new A.bo(C.fh,x,x,A.ad(d,x,1,x,x,x,$.aLS().a.x6(48,1),x,x),x)},
Pw(d){var x=null
return new A.bo(C.fh,x,x,A.ad(d,x,1,x,x,x,$.aLS().a,x,x),x)},
rl(d){return new A.dM(this.a7A(d),y.p)},
a7A(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$rl(e,f,g){if(f===1){u.push(g)
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
aGx(){var x,w,v,u,t,s=this,r=A.b([],y.u)
r.push(C.bM)
x=s.rl("A Elbereth! Gilthoniel!")
w=y.l
v=A.ks(x,s.gawK(),x.$ti.h("G.E"),w)
for(x=s.gPv(),u=0;u<1;++u){t=s.rl(D.Y6[u])
C.b.a2(r,A.ks(t,x,t.$ti.h("G.E"),w))
r.push(D.a55)
C.b.a2(r,v)
r.push(C.bM)}r.push(new A.ao(s.r,null,null,null))
r.push(C.bM)
return r},
v(d){var x,w,v=this,u=null,t=A.aN(d,C.aY,y.x).w.a.a
if(v.w>0&&t!==v.r){x=v.f
x===$&&A.a()
w=v.r
x[0]=new A.ao(w,u,u,u)
C.b.sau(x,new A.ao(w,u,u,u))}v.r=t
if(v.w<=0){v.w=v.a6h(d)
x=v.aGx()
v.f!==$&&A.b0()
v.f=x}x=v.r
w=v.f
w===$&&A.a()
return A.hE(new A.ao(x,72,A.ER(w,v.d,u,!1,C.a6,!1),u),u,!0,u,u,'"Passing of the Elves"\nfrom Lord of the Rings',u,u,u,u)}}
B.Od.prototype={
l(){var x=this,w=x.bd$
if(w!=null)w.G(x.geZ())
x.bd$=null
x.ar()},
bf(){this.bZ()
this.bT()
this.f_()}}
var z=a.updateTypes(["c(l)","~(@)"]);(function aliases(){var x=B.Od.prototype
x.abR=x.l})();(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Kg.prototype,"gLp","q1",1)
x(w,"gawK","awL",0)
x(w,"gPv","Pw",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit
w(B.af2,A.B)
w(B.RC,E.hi)
w(B.wj,A.Q)
w(B.Od,A.T)
w(B.Kg,B.Od)
x(B.Od,A.ef)})()
A.bh(b.typeUniverse,JSON.parse('{"wj":{"Q":[],"c":[]},"RC":{"b4":[]},"Kg":{"T":["wj"]}}'))
var y={u:A.v("r<c>"),x:A.v("dP"),q:A.v("n<l>"),l:A.v("c"),p:A.v("dM<l>"),b:A.v("@"),e:A.v("t"),s:A.v("rv?")};(function constants(){var x=a.makeConstList
D.Y6=A.b(x(["Fanuilos heryn aglar / R\xeen athar ann\xfan-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!"]),A.v("r<l>"))
D.a55=new A.ao(24,null,null,null)
D.JG=new A.o(1,0.058823529411764705,0.1450980392156863,0.054901960784313725,C.d)
D.aaf=new A.q(!0,D.JG,null,"Celtic Garamond the 2nd",null,null,24,C.M,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.af7=new A.n("elvenChorus",y.q)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"bki","aLS",()=>new B.af2(D.aaf))})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_62",e:"endPart",h:b})})($__dart_deferred_initializers__,"iIRercgGWVwny1XboMo1wkkObcU=");