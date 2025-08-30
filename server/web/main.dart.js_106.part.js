((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_106",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={anW:function anW(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},anX:function anX(){},anY:function anY(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},anV:function anV(){},TA:function TA(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.e=g},xe:function xe(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.kv$=d
_.c9$=e
_.az$=f
_.a=null},Sg:function Sg(d,e,f,g,h,i,j){var _=this
_.fk=d
_.y1=e
_.y2=f
_.cv$=g
_.a8$=h
_.cj$=i
_.b=_.dy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=j
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
aKP(d,e,f){var x=null
return new A.Pn(d,new B.Fp(e,f,!0,!0,!0,B.aQu(),x),x,C.N,!1,x,x,C.jz,!1,x,f,C.W,x,x,C.B,C.ar,x)},
Pn:function Pn(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
_.R8=d
_.RG=e
_.cy=f
_.c=g
_.d=h
_.e=i
_.f=j
_.r=k
_.x=l
_.Q=m
_.as=n
_.at=o
_.ax=p
_.ay=q
_.ch=r
_.CW=s
_.a=t},
Tz:function Tz(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
A=a.updateHolder(c[40],A)
A.anW.prototype={
a2J(d){var x=this.c
return d.vI(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bt(B.b(["scrollOffset: "+B.m(x.a),"crossAxisOffset: "+B.m(x.b),"mainAxisExtent: "+B.m(x.c),"crossAxisExtent: "+B.m(x.d)],y.x),", ")+")"}}
A.anX.prototype={}
A.anY.prototype={
a2V(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.nq(d/x)-1)
return 0},
aeB(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Ek(d){var x=this,w=x.a,v=C.h.bx(d,w)
return new A.anW(C.h.ka(d,w)*x.b,x.aeB(v*x.c),x.d,x.e)},
Yk(d){var x
if(d===0)return 0
x=this.b
return x*(C.h.ka(d-1,this.a)+1)-(x-this.d)}}
A.anV.prototype={}
A.TA.prototype={
Nr(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=x.e
if(t==null)t=u/1
return new A.anY(v,t+x.b,u+w,t,u,B.zz(d.x))}}
A.xe.prototype={
k(d){return"crossAxisOffset="+B.m(this.w)+"; "+this.a6H(0)}}
A.Sg.prototype={
er(d){if(!(d.b instanceof A.xe))d.b=new A.xe(!1,null,null)},
sa3f(d){var x,w,v=this
if(v.fk===d)return
x=!0
if(B.x(d)===B.x(v.fk)){w=v.fk
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.e!=d.e}if(x)v.a4()
v.fk=d},
rA(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bi(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.u.prototype.gW.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.fk.Nr(a8)
t=u.b
s=t>1e-10?u.a*C.d.ka(w,t):0
r=isFinite(v)?u.a2V(v):a7
if(a6.a8$!=null){q=a6.XY(s)
a6.oY(q,r!=null?a6.XZ(r):0)}else a6.oY(0,0)
p=u.Ek(s)
if(a6.a8$==null)if(!a6.IL(s,p.a)){o=u.Yk(a9.grz())
a6.dy=B.ik(a7,!1,a7,a7,o,0,0,0,o,a7)
a9.pc()
return}n=p.a
m=n+p.c
t=a6.a8$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.Ek(k)
h=i.c
g=a6.a_J(a8.vI(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.a8$
h.toString
h.fm(p.a2J(a8))
j=a6.a8$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.l(a6).h("ak.1")
f=r!=null
while(!0){if(!(!f||k<=r)){d=!1
break}i=u.Ek(k)
e=i.c
a0=a8.vI(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).az$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.a_H(a0,j)
if(g==null){d=!0
break}}else g.fm(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.cj$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.Kx(a8,s,t,n,m)
a4=a6.rw(a8,Math.min(x,n),m)
a5=a6.vR(a8,n,m)
a6.dy=B.ik(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,0,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.pc()}}
A.Pn.prototype={
Jb(d){return new A.Tz(this.R8,this.RG,null)}}
A.Tz.prototype={
aE(d){var x=new A.Sg(this.f,y.v.a(d),B.r(y.e,y.g),0,null,null,B.ae(y.d))
x.aD()
return x},
aI(d,e){e.sa3f(this.f)},
Kw(d,e,f,g,h){var x,w
this.a6I(d,e,f,g,h)
x=this.f.Nr(d)
w=this.d.gt2()
w.toString
w=x.Yk(w)
return w}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.v,[A.anW,A.anX,A.anV])
w(A.anY,A.anX)
w(A.TA,A.anV)
w(A.xe,B.eH)
w(A.Sg,B.k2)
w(A.Pn,B.un)
w(A.Tz,B.hy)})()
B.bt(b.typeUniverse,JSON.parse('{"xe":{"eH":[],"et":["y"],"i8":[],"cJ":[]},"Sg":{"k2":[],"cU":[],"ak":["y","eH"],"u":[],"ag":[],"ak.1":"eH","ak.0":"y"},"Pn":{"T":[],"d":[]},"Tz":{"hy":[],"al":[],"d":[]}}'))
var y={d:B.F("d0"),x:B.F("q<k>"),g:B.F("y"),z:B.F("ka"),t:B.F("xe"),v:B.F("h3"),c:B.F("eH"),e:B.F("n")}};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_106",e:"endPart",h:b})})($__dart_deferred_initializers__,"v8mVieGK5wIQwxCaS5NdZtSyuCg=");