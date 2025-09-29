((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_53",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,B={af1:function af1(d){this.a=d
this.b=null},
b31(d){return new B.RH(d)},
RH:function RH(d){this.a=d},
wj:function wj(d,e){this.c=d
this.a=e},
Ko:function Ko(d,e,f){var _=this
_.d=d
_.f=_.e=$
_.w=_.r=0
_.dI$=e
_.be$=f
_.c=_.a=null},
Ok:function Ok(){}},D,E
A=c[0]
C=c[2]
B=a.updateHolder(c[27],B)
D=c[96]
E=c[81]
B.af1.prototype={
gkh(){var x,w=this.b
if(w==null){w=$.DV
if(w==null)w=$.DV=new A.DU(A.y(y.e,y.s))
x=this.a.d
x.toString
x=this.b=w.a5S(x)
w=x}return w},
c9(d){return this.aCT(d)},
aCT(d){var x=0,w=A.K(y.b),v,u=this,t
var $async$c9=A.F(function(e,f){if(e===1)return A.H(f,w)
while(true)switch(x){case 0:x=3
return A.E(u.gkh().c9(d),$async$c9)
case 3:t=u.gkh()
t.toString
v=t
x=1
break
case 1:return A.I(v,w)}})
return A.J($async$c9,w)}}
B.RH.prototype={
c1(d){var x=C.h.j(A.bk(this)),w=this.a
if(w==null)w=1
return new B.wj(w,new A.o("elvenChorus_"+x,y.q))},
d_(d){var x=C.h.j(A.bk(this)),w=this.a
return new A.cQ(new A.au(null,60,new B.wj(w==null?1:w,D.afJ),null),new A.o("ElvenChorusStba_"+x,y.q))},
cC(){return"A Elbereth! Gilthoniel!"}}
B.wj.prototype={
Y(){var x=null
return new B.Ko(A.jE(x,0,!0,x),x,x)}}
B.Ko.prototype={
ak(){var x=this,w=A.yS(C.bJ,x.gLx())
x.e!==$&&A.b0()
x.e=w
$.aLS().c9("ElvenChorus")
x.aA()},
gm7(){var x=this.w,w=this.a.c!==1?this.r:0
return x+24-w},
gQP(){var x=this.a.c
if(x===0)return 12
else if(x===1)return 6
else if(x===2)return 1
A.aMJ("Incorrect speed on ElvenChorus: "+x+". Values should be 0-2.",null)
return 12},
q3(d){var x,w,v,u=this
if(u.c!=null&&u.d.f.length!==0&&u.w>0){x=u.d
w=x.f
v=C.b.gcq(w).at
v.toString
if(v===0)x.hY(u.gm7()+10,C.N,A.dD(0,C.e.fC(u.gm7()*u.gQP()),0,0))
else{w=C.b.gcq(w).at
w.toString
if(w>=u.gm7()-30)if(u.a.c!==1)x.ew(0)
else x.hY(0,C.hz,A.dD(0,C.e.fC(u.gm7()*u.gQP()*3),0,0))}}},
l(){var x=this.e
x===$&&A.a()
x.aM()
this.d.l()
this.abW()},
a6n(d){return 2100},
awU(d){var x=null
return new A.bp(C.fl,x,x,A.ag(d,x,1,x,x,x,$.aLS().a.x6(48,1),x,x),x)},
PB(d){var x=null
return new A.bp(C.fl,x,x,A.ag(d,x,1,x,x,x,$.aLS().a,x,x),x)},
rq(d){return new A.dN(this.a7F(d),y.p)},
a7F(d){return function(){var x=d
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
r.push(C.bM)
x=s.rq("A Elbereth! Gilthoniel!")
w=y.l
v=A.kv(x,s.gawT(),x.$ti.h("G.E"),w)
for(x=s.gPA(),u=0;u<1;++u){t=s.rq(D.YO[u])
C.b.a3(r,A.kv(t,x,t.$ti.h("G.E"),w))
r.push(D.a5P)
C.b.a3(r,v)
r.push(C.bM)}r.push(new A.au(s.r,null,null,null))
r.push(C.bM)
return r},
v(d){var x,w,v=this,u=null,t=A.aR(d,C.bk,y.x).w.a.a
if(v.w>0&&t!==v.r){x=v.f
x===$&&A.a()
w=v.r
x[0]=new A.au(w,u,u,u)
C.b.sau(x,new A.au(w,u,u,u))}v.r=t
if(v.w<=0){v.w=v.a6n(d)
x=v.aGv()
v.f!==$&&A.b0()
v.f=x}x=v.r
w=v.f
w===$&&A.a()
return A.hA(new A.au(x,72,A.EY(w,v.d,u,u,!1,C.a8,!1),u),u,!0,u,u,'"Passing of the Elves"\nfrom Lord of the Rings',u,u,u,u)}}
B.Ok.prototype={
l(){var x=this,w=x.be$
if(w!=null)w.G(x.gf_())
x.be$=null
x.ao()},
bh(){this.bZ()
this.bT()
this.f0()}}
var z=a.updateTypes(["c(l)","~(@)"]);(function aliases(){var x=B.Ok.prototype
x.abW=x.l})();(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Ko.prototype,"gLx","q3",1)
x(w,"gawT","awU",0)
x(w,"gPA","PB",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit
w(B.af1,A.C)
w(B.RH,E.it)
w(B.wj,A.Q)
w(B.Ok,A.S)
w(B.Ko,B.Ok)
x(B.Ok,A.eg)})()
A.bo(b.typeUniverse,JSON.parse('{"wj":{"Q":[],"c":[]},"RH":{"b4":[]},"Ko":{"S":["wj"]}}'))
var y={u:A.w("t<c>"),x:A.w("dS"),q:A.w("o<l>"),l:A.w("c"),p:A.w("dN<l>"),b:A.w("@"),e:A.w("r"),s:A.w("rC?")};(function constants(){var x=a.makeConstList
D.YO=A.b(x(["Fanuilos heryn aglar / R\xeen athar ann\xfan-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!"]),A.w("t<l>"))
D.a5P=new A.au(24,null,null,null)
D.Kq=new A.n(1,0.058823529411764705,0.1450980392156863,0.054901960784313725,C.d)
D.aaP=new A.q(!0,D.Kq,null,"Celtic Garamond the 2nd",null,null,24,C.L,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.afJ=new A.o("elvenChorus",y.q)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"bke","aLS",()=>new B.af1(D.aaP))})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_53",e:"endPart",h:b})})($__dart_deferred_initializers__,"aXMjRu/UzIVq/X2YwXvxPebhZgo=");