((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_83",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={apL:function apL(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},apM:function apM(){},apN:function apN(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},apK:function apK(){},V3:function V3(d,e,f){this.b=d
this.c=e
this.e=f},xu:function xu(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.kI$=d
_.c3$=e
_.au$=f
_.a=null},TI:function TI(d,e,f,g,h,i,j){var _=this
_.ew=d
_.y1=e
_.y2=f
_.c5$=g
_.a5$=h
_.cb$=i
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
aNB(d,e,f){var x=null
return new A.QK(d,new B.G9(e,f,!0,!0,!0,B.aTm(),x),x,C.N,!1,x,x,C.jZ,x,!1,x,0,x,f,C.a3,x,x,C.A,C.as,x)},
QK:function QK(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w){var _=this
_.R8=d
_.RG=e
_.cy=f
_.c=g
_.d=h
_.e=i
_.f=j
_.r=k
_.w=l
_.x=m
_.y=n
_.z=o
_.Q=p
_.as=q
_.at=r
_.ax=s
_.ay=t
_.ch=u
_.CW=v
_.a=w},
V2:function V2(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
A=a.updateHolder(c[40],A)
A.apL.prototype={
a4h(d){var x=this.c
return d.t3(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bw(B.b(["scrollOffset: "+B.o(x.a),"crossAxisOffset: "+B.o(x.b),"mainAxisExtent: "+B.o(x.c),"crossAxisExtent: "+B.o(x.d)],y.x),", ")+")"}}
A.apM.prototype={}
A.apN.prototype={
a4v(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.lq(d/x)-1)
return 0},
agC(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
EY(d){var x=this,w=x.a,v=C.h.bL(d,w)
return new A.apL(C.h.kq(d,w)*x.b,x.agC(v*x.c),x.d,x.e)},
ZI(d){var x
if(d===0)return 0
x=this.b
return x*(C.h.kq(d-1,this.a)+1)-(x-this.d)}}
A.apK.prototype={}
A.V3.prototype={
OE(d){var x=this.c,w=Math.max(0,d.w-x*4)/5,v=this.e
if(v==null)v=w/1
return new A.apN(5,v+this.b,w+x,v,w,B.zZ(d.x))}}
A.xu.prototype={
k(d){return"crossAxisOffset="+B.o(this.w)+"; "+this.a8r(0)}}
A.TI.prototype={
e7(d){if(!(d.b instanceof A.xu))d.b=new A.xu(!1,null,null)},
sa4R(d){var x,w,v=this
if(v.ew===d)return
x=!0
if(B.x(d)===B.x(v.ew)){w=v.ew
if(w.b===d.b)if(w.c===d.c)x=w.e!=d.e}if(x)v.a3()
v.ew=d},
t8(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
b0(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.m.prototype.gI.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.ew.OE(a8)
t=u.b
s=t>1e-10?u.a*C.d.kq(w,t):0
r=isFinite(v)?u.a4v(v):a7
if(a6.a5$!=null){q=a6.Zk(s)
a6.pC(q,r!=null?a6.Zl(r):0)}else a6.pC(0,0)
p=u.EY(s)
if(a6.a5$==null)if(!a6.Jy(s,p.a)){o=u.ZI(a9.gt7())
a6.dy=B.eo(a7,!1,a7,a7,o,0,0,0,o,a7,a7)
a9.pM()
return}n=p.a
m=n+p.c
t=a6.a5$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.EY(k)
h=i.c
g=a6.a1a(a8.t3(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.a5$
h.toString
h.f_(p.a4h(a8))
j=a6.a5$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.k(a6).h("ac.1")
f=r!=null
while(!0){if(!(!f||k<=r)){d=!1
break}i=u.EY(k)
e=i.c
a0=a8.t3(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).au$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.a18(a0,j)
if(g==null){d=!0
break}}else g.f_(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.cb$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.Lu(a8,s,t,n,m)
a4=a6.mh(a8,Math.min(x,n),m)
a5=a6.lp(a8,n,m)
a6.dy=B.eo(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,0,a4,0,a3,a7,a7)
if(a3===m)a9.R8=!0
a9.pM()}}
A.QK.prototype={
K1(d){return new A.V2(this.R8,this.RG,null)}}
A.V2.prototype={
aC(d){var x=new A.TI(this.f,y.v.a(d),B.t(y.e,y.g),0,null,null,B.a7(y.d))
x.aE()
return x},
aJ(d,e){e.sa4R(this.f)},
Lt(d,e,f,g,h){var x,w
this.a8s(d,e,f,g,h)
x=this.f.OE(d)
w=this.d.gtz()
w.toString
w=x.ZI(w)
return w}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.y,[A.apL,A.apM,A.apK])
w(A.apN,A.apM)
w(A.V3,A.apK)
w(A.xu,B.eO)
w(A.TI,B.ka)
w(A.QK,B.uB)
w(A.V2,B.hE)})()
B.bK(b.typeUniverse,JSON.parse('{"xu":{"eO":[],"mJ":[],"e3":["w"],"ig":[],"cF":[]},"TI":{"ka":[],"bL":[],"ac":["w","eO"],"m":[],"ae":[],"ac.1":"eO","ac.0":"w"},"QK":{"R":[],"c":[]},"V2":{"hE":[],"af":[],"c":[]}}'))
var y={d:B.N("dn"),x:B.N("r<l>"),g:B.N("w"),z:B.N("kh"),t:B.N("xu"),v:B.N("h9"),c:B.N("eO"),e:B.N("p")}};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_83",e:"endPart",h:b})})($__dart_deferred_initializers__,"COeXfoJ4jHKoPZi9PjQo7V6TYoY=");