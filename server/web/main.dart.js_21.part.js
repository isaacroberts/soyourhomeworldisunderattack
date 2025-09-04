((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_21",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={nT:function nT(d,e){this.a=d
this.b=e},
aOX(d,e,f,g,h){var x
if(h!=null||f!=null)x=B.h4(f,h)
else x=null
return new A.B4(d,null,x,C.O,e,null,g)},
qI:function qI(d,e){this.a=d
this.b=e},
rW:function rW(d,e){this.a=d
this.b=e},
B4:function B4(d,e,f,g,h,i,j){var _=this
_.r=d
_.y=e
_.Q=f
_.c=g
_.d=h
_.e=i
_.a=j},
XU:function XU(d,e){var _=this
_.fx=_.fr=_.dy=_.dx=_.db=_.cy=_.cx=_.CW=null
_.e=_.d=$
_.dS$=d
_.bi$=e
_.c=_.a=null},
auo:function auo(){},
aup:function aup(){},
auq:function auq(){},
aur:function aur(){},
aus:function aus(){},
aut:function aut(){},
auu:function auu(){},
auv:function auv(){},
aS5(){var x=new Float64Array(4)
x[3]=1
return new A.p9(x)},
p9:function p9(d){this.a=d}},D
B=c[0]
C=c[2]
A=a.updateHolder(c[40],A)
D=c[57]
A.nT.prototype={
ew(d){return B.qB(this.a,this.b,d)}}
A.qI.prototype={
ew(d){var x=B.iZ(this.a,this.b,d)
x.toString
return x}}
A.rW.prototype={
ew(a8){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=new B.bQ(new Float64Array(3)),a3=new B.bQ(new Float64Array(3)),a4=A.aS5(),a5=A.aS5(),a6=new B.bQ(new Float64Array(3)),a7=new B.bQ(new Float64Array(3))
this.a.a0x(a2,a4,a6)
this.b.a0x(a3,a5,a7)
x=1-a8
w=a2.le(x).V(0,a3.le(a8))
v=a4.le(x).V(0,a5.le(a8))
u=new Float64Array(4)
t=new A.p9(u)
t.bu(v)
t.yh()
s=a6.le(x).V(0,a7.le(a8))
x=new Float64Array(16)
v=new B.aU(x)
r=u[0]
q=u[1]
p=u[2]
o=u[3]
n=r+r
m=q+q
l=p+p
k=r*n
j=r*m
i=r*l
h=q*m
g=q*l
f=p*l
e=o*n
d=o*m
a0=o*l
a1=w.a
x[0]=1-(h+f)
x[1]=j+a0
x[2]=i-d
x[3]=0
x[4]=j-a0
x[5]=1-(k+f)
x[6]=g+e
x[7]=0
x[8]=i+d
x[9]=g-e
x[10]=1-(k+h)
x[11]=0
x[12]=a1[0]
x[13]=a1[1]
x[14]=a1[2]
x[15]=1
v.bm(s)
return v}}
A.B4.prototype={
Y(){return new A.XU(null,null)}}
A.XU.prototype={
mU(d){var x,w,v,u=this,t=null,s=u.CW
u.a.toString
x=y.b
u.CW=x.a(d.$3(s,t,new A.auo()))
s=u.cx
u.a.toString
w=y.f
u.cx=w.a(d.$3(s,t,new A.aup()))
s=y.d
u.cy=s.a(d.$3(u.cy,u.a.y,new A.auq()))
v=u.db
u.a.toString
u.db=s.a(d.$3(v,t,new A.aur()))
u.dx=y.e.a(d.$3(u.dx,u.a.Q,new A.aus()))
v=u.dy
u.a.toString
u.dy=w.a(d.$3(v,t,new A.aut()))
v=u.fr
u.a.toString
u.fr=y.w.a(d.$3(v,t,new A.auu()))
v=u.fx
u.a.toString
u.fx=x.a(d.$3(v,t,new A.auv()))},
B(d){var x,w,v,u,t,s,r,q=this,p=null,o=q.geL(),n=q.CW
n=n==null?p:n.ac(o.gp())
x=q.cx
x=x==null?p:x.ac(o.gp())
w=q.cy
w=w==null?p:w.ac(o.gp())
v=q.db
v=v==null?p:v.ac(o.gp())
u=q.dx
u=u==null?p:u.ac(o.gp())
t=q.dy
t=t==null?p:t.ac(o.gp())
s=q.fr
s=s==null?p:s.ac(o.gp())
r=q.fx
r=r==null?p:r.ac(o.gp())
return B.bk(n,q.a.r,C.l,p,u,w,v,p,p,t,x,s,r,p)}}
A.p9.prototype={
bu(d){var x=d.a,w=this.a,v=x[0]
w.$flags&2&&B.aF(w)
w[0]=v
w[1]=x[1]
w[2]=x[2]
w[3]=x[3]},
a6D(d){var x,w,v,u,t,s=d.a,r=s[0],q=s[4],p=s[8],o=0+r+q+p
if(o>0){x=Math.sqrt(o+1)
r=this.a
r.$flags&2&&B.aF(r)
r[3]=x*0.5
x=0.5/x
r[0]=(s[5]-s[7])*x
r[1]=(s[6]-s[2])*x
r[2]=(s[1]-s[3])*x}else{if(r<q)w=q<p?2:1
else w=r<p?2:0
v=(w+1)%3
u=(w+2)%3
r=w*3
q=v*3
p=u*3
x=Math.sqrt(s[r+w]-s[q+v]-s[p+u]+1)
t=this.a
t.$flags&2&&B.aF(t)
t[w]=x*0.5
x=0.5/x
t[3]=(s[q+u]-s[p+v])*x
t[v]=(s[r+v]+s[q+w])*x
t[u]=(s[r+u]+s[p+w])*x}},
yh(){var x,w,v,u=Math.sqrt(this.gy8())
if(u===0)return 0
x=1/u
w=this.a
v=w[0]
w.$flags&2&&B.aF(w)
w[0]=v*x
w[1]=w[1]*x
w[2]=w[2]*x
w[3]=w[3]*x
return u},
gy8(){var x=this.a,w=x[0],v=x[1],u=x[2],t=x[3]
return w*w+v*v+u*u+t*t},
gH(d){var x=this.a,w=x[0],v=x[1],u=x[2],t=x[3]
return Math.sqrt(w*w+v*v+u*u+t*t)},
le(d){var x=new Float64Array(4),w=new A.p9(x)
w.bu(this)
x[3]=x[3]*d
x[2]=x[2]*d
x[1]=x[1]*d
x[0]=x[0]*d
return w},
ai(a5,a6){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h=this.a,g=h[3],f=h[2],e=h[1],d=h[0],a0=a6.gaHg(),a1=a0.i(0,3),a2=a0.i(0,2),a3=a0.i(0,1),a4=a0.i(0,0)
h=C.d.ai(g,a4)
x=C.d.ai(d,a1)
w=C.d.ai(e,a2)
v=C.d.ai(f,a3)
u=C.d.ai(g,a3)
t=C.d.ai(e,a1)
s=C.d.ai(f,a4)
r=C.d.ai(d,a2)
q=C.d.ai(g,a2)
p=C.d.ai(f,a1)
o=C.d.ai(d,a3)
n=C.d.ai(e,a4)
m=C.d.ai(g,a1)
l=C.d.ai(d,a4)
k=C.d.ai(e,a3)
j=C.d.ai(f,a2)
i=new Float64Array(4)
i[0]=h+x+w-v
i[1]=u+t+s-r
i[2]=q+p+o-n
i[3]=m-l-k-j
return new A.p9(i)},
V(d,e){var x,w=new Float64Array(4),v=new A.p9(w)
v.bu(this)
x=e.a
w[0]=w[0]+x[0]
w[1]=w[1]+x[1]
w[2]=w[2]+x[2]
w[3]=w[3]+x[3]
return v},
Z(d,e){var x,w=new Float64Array(4),v=new A.p9(w)
v.bu(this)
x=e.a
w[0]=w[0]-x[0]
w[1]=w[1]-x[1]
w[2]=w[2]-x[2]
w[3]=w[3]-x[3]
return v},
i(d,e){return this.a[e]},
k(d){var x=this.a
return B.n(x[0])+", "+B.n(x[1])+", "+B.n(x[2])+" @ "+B.n(x[3])}}
var z=a.updateTypes(["nT(@)","j7(@)","qI(@)","rW(@)"])
A.auo.prototype={
$1(d){return new A.nT(y.k.a(d),null)},
$S:z+0}
A.aup.prototype={
$1(d){return new D.j7(y.m.a(d),null)},
$S:z+1}
A.auq.prototype={
$1(d){return new B.ml(y.r.a(d),null)},
$S:185}
A.aur.prototype={
$1(d){return new B.ml(y.r.a(d),null)},
$S:185}
A.aus.prototype={
$1(d){return new A.qI(y.a.a(d),null)},
$S:z+2}
A.aut.prototype={
$1(d){return new D.j7(y.m.a(d),null)},
$S:z+1}
A.auu.prototype={
$1(d){return new A.rW(y.E.a(d),null)},
$S:z+3}
A.auv.prototype={
$1(d){return new A.nT(y.k.a(d),null)},
$S:z+0};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.av,[A.nT,A.qI,A.rW])
w(A.B4,B.wl)
w(A.XU,B.nU)
x(B.dz,[A.auo,A.aup,A.auq,A.aur,A.aus,A.aut,A.auu,A.auv])
w(A.p9,B.C)})()
B.bJ(b.typeUniverse,JSON.parse('{"nT":{"av":["ff?"],"al":["ff?"],"al.T":"ff?","av.T":"ff?"},"qI":{"av":["a1"],"al":["a1"],"al.T":"a1","av.T":"a1"},"rW":{"av":["aU"],"al":["aU"],"al.T":"aU","av.T":"aU"},"B4":{"Q":[],"c":[]},"XU":{"S":["B4"]}}'))
var y=(function rtii(){var x=B.R
return{k:x("ff"),a:x("a1"),r:x("j5"),m:x("cy"),E:x("aU"),b:x("nT?"),e:x("qI?"),d:x("ml?"),f:x("j7?"),w:x("rW?")}})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_21",e:"endPart",h:b})})($__dart_deferred_initializers__,"AonVQvvtiSOQVlJMk7gOi2qrllw=");