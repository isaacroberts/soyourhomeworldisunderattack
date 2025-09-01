((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_72",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,O,P,K,Q,R,S,I,T,U,V,W,X,F,Y,Z,A_,A0,G,A1,E,H,A2,L,B={PE:function PE(d,e,f){this.a=d
this.b=e
this.c=f},kY:function kY(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=null
_.I$=0
_.J$=g
_.al$=_.W$=0},a95:function a95(){},
b_F(d,e){return new B.BO(d,e)},
BO:function BO(d,e){this.a=d
this.b=e},
a96:function a96(){},
b1r(d){A.aL6(d.a,d.b)
$.fg().a.push(d)},
Pi:function Pi(d){this.a=d},
adx:function adx(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=null},
Ey:function Ey(d,e){var _=this
_.a=0
_.b=d
_.r=_.f=_.e=_.d=_.c=null
_.w=e},
agQ:function agQ(d){this.a=""
this.b=d},
wA:function wA(d){this.a=""
this.b=d},
RI:function RI(d,e){this.c=d
this.a=""
this.b=e},
agP:function agP(d,e){this.a=d
this.b=e
this.c=0},
Hw:function Hw(d,e){this.a=d
this.b=e},
Ix:function Ix(d){this.a=d},
VG:function VG(d,e,f){this.c=d
this.d=e
this.a=f},
VB:function VB(d,e,f,g){var _=this
_.dy=_.dx=null
_.fr=!1
_.b=d
_.d=_.c=-1
_.w=_.r=_.f=_.e=null
_.z=_.y=_.x=!1
_.Q=e
_.as=!1
_.at=f
_.I$=0
_.J$=g
_.al$=_.W$=0
_.a=null},
AC(d,e){return B.b9H(d,e)},
b9H(d,e){var x=0,w=A.O(y.a),v,u,t,s,r,q,p
var $async$AC=A.I(function(f,g){if(f===1)return A.L(g,w)
while(true)switch(x){case 0:x=d==="COPSTING"?3:5
break
case 3:v=D.GY
x=1
break
x=4
break
case 5:x=d==="ICON"?6:8
break
case 6:u=A.tf(e[0],null)
x=9
return A.H(A.cg("misc_code_lib",""),$async$AC)
case 9:A.cf("misc_code_lib")
t=u==null?30:u
v=H.b2u(t,C.b.f6(e,1))
x=1
break
x=7
break
case 8:x=d==="IMAGE"?10:12
break
case 10:s=A.bA("url")
if(e.length!==0)s.b=e[0]
else s.b=null
x=13
return A.H(A.cg("image_lib",""),$async$AC)
case 13:A.cf("image_lib")
v=O.b2w(s.aT())
x=1
break
x=11
break
case 12:x=d==="ELVENCHORUS"||d==="ELVENCHOIR"?14:16
break
case 14:r=B.baf(e,"Speed")
x=17
return A.H(A.cg("elven_chorus_lib",""),$async$AC)
case 17:A.cf("elven_chorus_lib")
v=P.b1d(r)
x=1
break
x=15
break
case 16:x=d==="CUSTOMGOTO"?18:19
break
case 18:q=B.Oh(e,"Link")
if(q==="null")q=null
p=B.Oh(e,"Dest")
x=20
return A.H(A.cg("goto_button_lib",""),$async$AC)
case 20:A.cf("goto_button_lib")
v=K.aQI(p,!0,q,A.b([],y.D))
x=1
break
case 19:case 15:case 11:case 7:case 4:v=new B.Ij(d,"CodeTag")
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$AC,w)},
Oh(d,e){var x,w,v
for(x=d.length,w=0;w<x;++w){v=d[w]
if(C.c.bx(v,e)){v=C.c.OB(C.c.bY(v,e.length))
return C.c.OB(C.c.bx(v,"=")?C.c.bY(v,1):v)}}return null},
aIw(d,e){var x=B.Oh(d,e)
if(x!=null){if(A.aM2(x)==null)A.acF(new B.Pi("Failed to read double param: "+x),null)
return null}else return null},
aNo(d,e){var x=B.Oh(d,e)
if(x==="1")return!0
else if(x==="0")return!1
return null},
baf(d,e){var x=B.Oh(d,e)
if(x!=null)return A.tf(x,null)
else return null},
ban(d){var x,w,v,u,t=d.length,s=y.N
if(t===0)return A.u(s,s)
else{x=A.u(s,s)
for(w=0;w<d.length;d.length===t||(0,A.G)(d),++w){v=C.c.hi(d[w])
u=v.toLowerCase()
if(C.c.bx(u,"link="))x.n(0,"Link",C.c.bY(v,5))
else if(C.c.bx(u,"color="))x.n(0,"Color",C.c.bY(v,6))}return x}},
eV(d,e,f){return B.b9G(d,e,f)},
b9G(d,e,f){var x=0,w=A.O(y.a),v,u,t,s,r,q,p,o,n
var $async$eV=A.I(function(g,h){if(g===1)return A.L(h,w)
while(true)switch(x){case 0:n=B.ban(e)
x=d==="ART"?3:5
break
case 3:x=6
return A.H(A.cg("art_lib",""),$async$eV)
case 6:A.cf("art_lib")
v=R.b_g(f)
x=1
break
x=4
break
case 5:x=d==="FACEBOOK"?7:9
break
case 7:x=10
return A.H(A.cg("facebook_lib",""),$async$eV)
case 10:A.cf("facebook_lib")
v=S.b1y(f)
x=1
break
x=8
break
case 9:x=d==="SHIRT"||d==="PRINTEXACTSHIRT"?11:13
break
case 11:x=14
return A.H(A.cg("shirts_lib",""),$async$eV)
case 14:u=B.aIw(e,"width")
t=B.aIw(e,"width")
A.cf("shirts_lib")
v=I.aSP(t,f,u)
x=1
break
x=12
break
case 13:x=d==="CHAPTERSHIRT"?15:17
break
case 15:x=18
return A.H(A.cg("shirts_lib",""),$async$eV)
case 18:A.cf("shirts_lib")
v=I.aSP(1000,f,800)
x=1
break
x=16
break
case 17:x=d==="BUMPERSTICKER"?19:21
break
case 19:x=22
return A.H(A.cg("shirts_lib",""),$async$eV)
case 22:u=B.aIw(e,"width")
t=B.aIw(e,"width")
A.cf("shirts_lib")
v=I.b_v(t,f,u)
x=1
break
x=20
break
case 21:x=d==="TWEET"?23:25
break
case 23:x=26
return A.H(A.cg("tweet_lib",""),$async$eV)
case 26:A.cf("tweet_lib")
v=T.b6y(f)
x=1
break
x=24
break
case 25:x=d==="SIGN"?27:29
break
case 27:x=30
return A.H(A.cg("signs_lib",""),$async$eV)
case 30:A.cf("signs_lib")
v=W.b5x(f)
x=1
break
x=28
break
case 29:x=d==="BG"?31:33
break
case 31:s=e.length!==0?e[0]:null
x=34
return A.H(A.cg("misc_code_lib",""),$async$eV)
case 34:A.cf("misc_code_lib")
v=H.b_h(s,f)
x=1
break
x=32
break
case 33:x=d==="TICKET"?35:37
break
case 35:x=38
return A.H(A.cg("misc_code_lib",""),$async$eV)
case 38:A.cf("misc_code_lib")
v=H.b6n(f)
x=1
break
x=36
break
case 37:x=d==="POLLSCREEN"?39:41
break
case 39:x=42
return A.H(A.cg("misc_code_lib",""),$async$eV)
case 42:A.cf("misc_code_lib")
v=H.b45(f)
x=1
break
x=40
break
case 41:x=d==="AD"?43:45
break
case 43:x=46
return A.H(A.cg("human_jacks_lib",""),$async$eV)
case 46:A.cf("human_jacks_lib")
v=X.b2r()
x=1
break
x=44
break
case 45:x=d==="TITLE"?47:49
break
case 47:x=50
return A.H(A.cg("title_lib.1",""),$async$eV)
case 50:A.cf("title_lib.1")
v=new Y.X9()
x=1
break
x=48
break
case 49:x=d==="FULLBGAD"?51:53
break
case 51:x=54
return A.H(A.cg("ad_widget_lib",""),$async$eV)
case 54:A.cf("ad_widget_lib")
v=Z.b_5(null,f)
x=1
break
x=52
break
case 53:x=d==="BALLOT"?55:57
break
case 55:r=B.aNo(e,"extra")
q=B.aNo(e,"on")
x=58
return A.H(A.cg("ballot_screen_lib",""),$async$eV)
case 58:A.cf("ballot_screen_lib")
v=A_.b_k(q!==!1,r===!0)
x=1
break
x=56
break
case 57:x=d==="GOTOBUTTON"?59:61
break
case 59:p=e.length!==0?e[0]:null
r=B.aNo(e,"IsChapter")
o=B.Oh(e,"Dest")
A.o(e)
x=62
return A.H(A.cg("goto_button_lib",""),$async$eV)
case 62:A.cf("goto_button_lib")
v=K.aQI(o,r!==!1,p,f)
x=1
break
x=60
break
case 61:x=d==="CHARACTERSELECTIONSCREEN"?63:65
break
case 63:x=66
return A.H(A.cg("character_selection_lib",""),$async$eV)
case 66:A.cf("character_selection_lib")
v=new A1.PI()
x=1
break
x=64
break
case 65:x=d==="FLATEARTHANDYTHUMBNAIL"?67:69
break
case 67:p=n.i(0,"Link")
x=70
return A.H(A.cg("andy_thumbnail_lib",""),$async$eV)
case 70:A.cf("andy_thumbnail_lib")
v=A2.b_9(p,f)
x=1
break
x=68
break
case 69:v=new B.yI(d,f)
x=1
break
case 68:case 64:case 60:case 56:case 52:case 48:case 44:case 40:case 36:case 32:case 28:case 24:case 20:case 16:case 12:case 8:case 4:case 1:return A.M(v,w)}})
return A.N($async$eV,w)},
a6Q(d,e,f){return B.bad(d,e,f)},
bad(d,e,f){var x=0,w=A.O(y.a),v
var $async$a6Q=A.I(function(g,h){if(g===1)return A.L(h,w)
while(true)switch(x){case 0:x=d==="COLUMNS"?3:5
break
case 3:x=6
return A.H(A.cg("columns_lib",""),$async$a6Q)
case 6:A.cf("columns_lib")
v=L.aPE(f)
x=1
break
x=4
break
case 5:x=d==="SIGNCOLUMNS"?7:8
break
case 7:x=9
return A.H(A.cg("columns_lib",""),$async$a6Q)
case 9:A.cf("columns_lib")
v=L.b5y(f)
x=1
break
case 8:case 4:v=new B.Ij(d,"ParsedBlock")
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$a6Q,w)},
C7:function C7(d,e){this.a=d
this.b=e},
Ij:function Ij(d,e){this.a=d
this.b=e},
ok:function ok(d){this.a=d},
Fd:function Fd(d){this.a=d},
C9:function C9(d,e,f){this.a=d
this.b=e
this.c=f},
C8:function C8(d,e,f){this.a=d
this.b=e
this.c=f},
DL:function DL(){},
TI:function TI(){},
yd:function yd(d,e,f){this.a=d
this.b=e
this.c=f},
arQ:function arQ(){},
lc:function lc(){},
w3:function w3(d){this.a=d},
DB:function DB(d,e,f){this.a=d
this.b=e
this.c=f},
DC:function DC(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
yI:function yI(d,e){this.b=d
this.a=e},
aWI(d){switch(d.a){case 0:case 4:case 3:return C.bv
case 2:return C.bL
case 1:case 5:return V.hB}},
RC:function RC(){},
B1:function B1(d,e,f){this.b=d
this.c=e
this.a=f},
Cr:function Cr(d,e,f,g){var _=this
_.d=d
_.e=e
_.b=f
_.a=g},
wc:function wc(d,e,f,g,h){var _=this
_.d=d
_.e=e
_.f=f
_.b=g
_.a=h},
WH:function WH(d,e,f,g){var _=this
_.e=d
_.r=e
_.b=f
_.a=g},
rq:function rq(d){this.a=d},
Cs:function Cs(d,e,f){this.c=d
this.d=e
this.a=f},
jJ:function jJ(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},
WR(d){var x,w,v
for(x=d.length,w=0,v=0;v<x;++v)w|=d[v].a
return new A.n7(w)},
bd7(d){if(d==="l")return C.at
else if(d==="r")return C.eU
else if(d==="c")return C.bX
else if(d==="j")return C.eV
else throw A.i(A.em("Incorrect align character "+d,"[?]"))},
b1W(d){if(d<=100)return C.iz
else if(d<=200)return C.cr
else if(d<=300)return C.b8
else if(d<=400)return C.o
else if(d<=500)return C.S
else if(d<=600)return C.cP
else if(d<=700)return C.bz
else if(d<=800)return C.lW
else if(d<=1000)return C.iA
else return C.S}},D,M,N
J=c[1]
A=c[0]
C=c[2]
O=c[24]
P=c[21]
K=c[23]
Q=c[61]
R=c[17]
S=c[22]
I=c[26]
T=c[28]
U=c[46]
V=c[86]
W=c[27]
X=c[30]
F=c[45]
Y=c[33]
Z=c[16]
A_=c[18]
A0=c[55]
G=c[106]
A1=c[19]
E=c[64]
H=c[25]
A2=c[31]
L=c[20]
B=a.updateHolder(c[4],B)
D=c[105]
M=c[48]
N=c[47]
B.PE.prototype={}
B.kY.prototype={
gQk(){return this.b.a},
gP2(d){return this.b.b},
gFi(){return this.b.c},
ga1R(){var x=this.b
return x.a!=null||x.b!=null||x.c!=null},
i(d,e){var x=this.c
if(e<x.length)return x[e]
else return null},
gH(d){return this.c.length},
gaEY(){return C.d.mw(this.Pw().length/2000)},
acw(d){this.c.push(d)},
ZI(d,e){var x
A.o(d)
if(e==null)e=A.iC()
e.k(0)
x=new A.hD(d,e)
this.c.push(x)
B.b1r(x)},
auY(d){return this.ZI(d,null)},
O_(){var x=0,w=A.O(y.H),v=this,u,t
var $async$O_=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:t=v.c
if(t.length!==0){u=t[0]
if(u instanceof B.rq){v.d=u
C.b.i6(t,0)}}v.Ce()
v.a3()
return A.M(null,w)}})
return A.N($async$O_,w)},
Ce(){var x=0,w=A.O(y.H),v=1,u=[],t=this,s,r,q,p,o,n,m,l,k,j,i,h
var $async$Ce=A.I(function(d,e){if(d===1){u.push(e)
x=v}while(true)switch(x){case 0:s=0,n=t.c
case 2:if(!(s<n.length)){x=4
break}r=n[s]
x=r instanceof B.ok?5:6
break
case 5:v=8
x=11
return A.H(r.a,$async$Ce)
case 11:q=e
n[s]=q
v=1
x=10
break
case 8:v=7
h=u.pop()
p=A.ak(h)
o=A.aD(h)
l=p
k=o
J.ds(l)
j=k==null
if(!j)k.k(0)
i=$.fg()
if(j)k=A.iC()
i.a.push(new A.hD(l,k))
x=10
break
case 7:x=1
break
case 10:case 6:case 3:++s
x=2
break
case 4:t.a3()
return A.M(null,w)
case 1:return A.L(u.at(-1),w)}})
return A.N($async$Ce,w)},
Pw(){var x=this.c
return C.c.hi(new A.a5(x,new B.a95(),A.a2(x).h("a5<1,l>")).bz(0,"\n"))},
Ct(){A.qN(new A.md(this.Pw()))}}
B.BO.prototype={
yX(d,e){return this.a5l(d,!0)},
a5l(d,e){var x=0,w=A.O(y.l),v,u=this,t,s,r
var $async$yX=A.I(function(f,g){if(f===1)return A.L(g,w)
while(true)switch(x){case 0:if(!u.b.l_())throw A.i(A.em("Empty BufferPtr sent to parsePtr",u.a))
x=3
return A.H(u.NS(d.c),$async$yX)
case 3:t=g
s=u.yi()
r=new B.kY(d,t,A.b([],y.D),$.aj())
s.dn(r.gacv(),!1,r.gaEF(),r.gauX())
v=new A.ap(r,s)
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$yX,w)},
NS(d){return this.aEp(d)},
aEp(d){var x=0,w=A.O(y.u),v,u=this,t,s,r,q,p,o,n
var $async$NS=A.I(function(e,f){if(e===1)return A.L(f,w)
while(true)switch(x){case 0:n=u.a
u.b.dU("$",n)
u.b.a5_("/",!0)
u.b.dU("(",n)
t=u.b.Cq()
u.b.dU(",",n)
s=u.b.Cq()
u.b.dU(",",n)
r=u.b.Cq()
u.b.dU(")",n)
u.b.dU("/",n)
q=u.b.kr()
p=u.b
if(q==="_"){p.eW(1)
o=null}else o=p.ax1()
u.b.dU("/",n)
u.a6Z()
n=new B.a96()
t=n.$1(t)
r=n.$1(r)
s=n.$1(s)
n.$1(o)
v=new B.PE(t,s,r)
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$NS,w)},
a6Z(){var x=this,w=!1
while(!0){if(!(!w&&x.b.l_()))break
x.b.Lg(E.kE)
w=x.b.awY("zoinks&")}x.b.hw(D.Ib)},
yi(){var $async$yi=A.I(function(d,e){switch(d){case 2:s=v
x=s.pop()
break
case 1:t.push(e)
x=u}while(true)switch(x){case 0:n=0
case 3:if(!r.b.l_()){x=4
break}u=6
x=9
v=[1]
return A.ez(A.a05(r.Oa()),$async$yi,w)
case 9:u=2
x=8
break
case 6:u=5
m=t.pop()
q=A.ak(m)
p=A.aD(m)
J.ds(q)
x=10
v=[1]
return A.ez(A.a05(new A.hD(q,p)),$async$yi,w)
case 10:if(n>=3){x=1
break}++n
r.b.Lg(";")
x=8
break
case 5:x=2
break
case 8:x=3
break
case 4:case 1:return A.ez(null,0,w)
case 2:return A.ez(t.at(-1),1,w)}})
var x=0,w=A.aIs($async$yi,y.a),v,u=2,t=[],s=[],r=this,q,p,o,n,m
return A.aIA(w)},
a3v(){return new A.eU(this.aEq(),y.b)},
aEq(){var x=this
return function(){var w=0,v=1,u=[]
return function $async$a3v(d,e,f){if(e===1){u.push(f)
w=v}while(true)switch(w){case 0:case 2:if(!x.b.l_()){w=3
break}w=4
return d.b=x.Oa(),1
case 4:w=2
break
case 3:return 0
case 1:return d.c=u.at(-1),3}}}},
Oa(){var x,w,v,u,t,s,r,q,p,o,n=this,m=new B.Ey(C.at,D.cA),l=new B.agQ(m)
for(;n.b.l_();){x=n.b.oa()
w=A.dv(x)
if(x===0){if(n.b.l_())throw A.i(A.em("Null terminator in middle of binary",n.a))}else if(x!==10)if(x===59)return l.a2f()
else if(x===123){v=n.b.a_S(!0)
v.toString
l.a=v}else if(x===40)n.b=m.aEo(n.b)
else if(w==="H"){u=n.b.Cq()
if(u==null)throw A.i(A.em("No text in header",n.a))
l.a=u
v=m.a3u(n.b)
n.b=v
v.dU(D.hP,n.a)
return l.aBv()}else if(w==="S")return n.aEr()
else if(w==="N"){t=n.b.pL()
if(t>2000){m=n.b.a
s=A.iC()
s.k(0)
s.k(0)
$.fg().a.push(new A.hD("Oversized newline in chapter "+n.a+" binary "+A.o(t)+" (pos="+m,s))
t=2000}n.b.eW(1)
return new B.Fd(t)}else if(w==="b"){r=n.b.pL()
t=n.b.pL()
q=n.b.tj(!0)
return new B.C9(r,t,q==null?C.u:q)}else if(w==="P"){if(n.b.ax0()!=null)return D.Hm}else if(w==="C"){p=n.Fs(D.oS)
n.b.dU(D.hP,n.a)
return p}else if(w==="T"){p=n.Fs(D.oT)
n.b.dU(D.hP,n.a)
return p}else if(w==="D"){p=n.Fs(D.oR)
n.b.dU(D.hP,n.a)
return p}else{m=C.c.m(")}]>",w)
v=n.a
o=n.b.a
if(m)throw A.i(A.em("Unmatched paren "+w+" in chapter binary (pos="+o+")",v))
else throw A.i(A.em("Unhandled char "+w+" (code="+x+" pos="+o+") in chapter binary",v))}}A.k7(new A.qM("Unterminated TextHolder (pos="+n.b.a+"; liveHolder="+l.k(0)+")",n.a),null)
return l.a2f()},
aEr(){var x,w,v,u,t,s,r=this,q=A.b([],y.U),p=new B.agP(q,C.at)
if(r.b.hw("(")){r.b.awZ()
p.c=r.b.oa()
p.b=B.bd7(r.b.wL())
if(!r.b.hw(")"))throw A.i(A.em("Unmatched ( in ChapterFormat Span element; (found '"+r.b.kr()+" instead')",r.a))}x=r.b.hw("[")
w=r.b
v=r.a
if(x){u=w.pM()
r.b.dU(".",v)
t=r.b.Gg(0,u)
r.b.eW(u)
r.b.dU("]",v)
while(!0){if(!(t.l_()&&!t.hw("]")))break
s=r.aEt(p,t)
if(s!=null)q.push(s)}}else throw A.i(A.em("No list in span. char="+w.kr()+" pos="+r.b.a,v))
q=p.a2V()
q=A.a4(q,q.$ti.h("D.E"))
q.$flags=1
return new B.yd(q,p.b,p.c)},
aEt(d,e){var x,w,v,u,t,s="font",r=new B.Ey(C.at,D.cA),q=new B.wA(r)
for(;e.l_();)if(e.hw("b")){x=this.b.pL()
w=this.b.pL()
v=this.b.tj(!0)
return new B.RI(new B.C8(x,w,v==null?C.u:v),new B.Ey(C.at,D.cA))}else if(e.hw("{")){u=e.Lg(125).aG4()
q.a=new A.ux(!1).A1(u,0,null,!0)}else if(e.hw("(")){t=e.Lh(41,!0)
t.dU("f",s)
r.c=t.pM()
t.dU("s",s)
r.d=t.pL()
t.dU("w",s)
r.r=new B.Ix(t.oa())
if(t.kr()==="^"){r.w=D.jI
t.eW(1)}else if(t.kr()==="v"){r.w=D.jH
t.eW(1)}if(t.hw(E.kE)){r.e=t.tj(!1)
if(t.hw(E.kE))r.f=t.awX()}}else if(e.hw(";"))return q
else if(e.kr()==="]")throw A.i(A.iK('"Not sure what to do about this" - ending bracket in span fragment'))
else throw A.i(A.em("Unhandled char in FragOfText "+e.kr()+" "+e.a,"frag?"))
return null},
Fs(d){var x,w,v,u,t,s=this,r='Missing open LBRK in CodeBlock (char = "',q=s.b.Ez(58).toUpperCase(),p=y.s,o=A.b([],p)
if(s.b.hw(D.Ic))o=A.b(s.b.Ez(D.Id).split(","),p)
for(p=o.length,x=0;x<p;++x){w=o[x]
v=w.length
if(v>2)o[x]=C.c.a8(w,1,v-1)
else o[x]=""}if(d===D.oT)return new B.ok(B.AC(q,o))
else if(d===D.oS){if(!s.b.hw(E.oW))throw A.i(A.em(r+s.b.kr()+'" pos='+s.b.a+")",s.a))
u=s.b.pM()
p=s.a
s.b.dU(".",p)
t=s.b.Gg(0,u)
s.b.eW(u)
s.b.dU("]",p)
p=new B.BO(p,t).a3v()
p=A.a4(p,p.$ti.h("D.E"))
p.$flags=1
return new B.ok(B.eV(q,o,p))}else if(d===D.oR){if(!s.b.hw(E.oU))throw A.i(A.em(r+s.b.kr()+'" pos='+s.b.a+")",s.a))
u=s.b.pM()
p=s.a
s.b.dU(".",p)
t=s.b.Gg(0,u)
s.b.eW(u)
s.b.dU(E.oV,p)
return new B.ok(B.a6Q(q,o,t))}else throw A.i(D.KT)}}
B.Pi.prototype={
k(d){return"BookCodeException (Error from book's code markers): "+this.a},
$ibC:1}
B.adx.prototype={
gaC2(){return(this.d.a&1)>0},
ga7e(){return(this.d.a&2)>0},
gaGm(){return(this.d.a&4)>0},
gaEj(){return(this.d.a&8)>0},
k(d){var x=this
return"[id:"+x.a+" size:"+A.o(x.b)+" weight:"+x.c.k(0)+" ital:"+((x.d.a&1)>0)+"]"},
gkb(){var x=this.f
if(x==null){x=$.Dy
if(x==null)x=$.Dy=new A.Dx(A.u(y.S,y.c))
x=this.f=x.a5q(this.a)}return x},
ga1_(){var x=this.gkb()
return x==null?null:x.c},
gazi(){var x=this.gkb()
return x==null?null:x.b},
aCo(){var x=this.gkb()
x=x==null?null:x.d.b
if(x==null)x=this.gkb()==null?"Null file":"Unfetched/Default"
return x},
b9(){var x=0,w=A.O(y.z),v,u=this,t
var $async$b9=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:t=u.gkb()
t=t==null?null:t.b9()
x=3
return A.H(y.G.b(t)?t:A.iP(t,y.d),$async$b9)
case 3:v=u.gkb()
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$b9,w)},
hd(){var x=this.gkb()
x=x==null?null:x.d===C.Ez
return x===!0},
DG(){var x,w,v,u,t,s=this,r=null,q=s.gkb()
q=q==null?r:q.c
x=s.d
w=(x.a&1)>0?G.dL:D.iy
v=s.e
u=v==null
t=u?C.a7:v
x=x.ES()
if(u)v=C.a7
return A.iH(r,r,t,r,x,v,r,r,q,r,r,s.b*1.5,w,r,s.c,r,r,!0,r,r,r,r,r,r,r,r)},
a0Z(){var x=this,w=null,v=x.e,u=v==null,t=u?C.bi:v,s=x.d,r=(s.a&1)>0?G.dL:D.iy
s=s.ES()
if(u)v=C.bi
return A.iH(w,w,t,w,s,v,w,w,"Palatino",w,w,x.b*1.5,r,w,x.c,w,w,!0,w,w,w,w,w,w,w,w)},
tW(d){var x,w,v,u,t,s=this,r=null,q=s.gkb()
q=q==null?r:q.c
x=s.d
w=(x.a&1)>0?G.dL:D.iy
v=s.e
u=v==null
t=u?C.a7:v
x=x.ES()
if(u)v=C.a7
return A.iH(r,d,t,r,x,v,r,r,q,r,r,s.b*1.5,w,r,s.c,r,r,!0,r,r,r,r,r,r,r,r)},
Dc(d){var x=this,w=null,v=x.d,u=(v.a&1)>0?G.dL:D.iy,t=x.e,s=t==null,r=s?C.bi:t
v=v.ES()
if(s)t=C.bi
return A.iH(w,d,r,w,v,t,w,w,"Rubik",w,w,x.b*1.5,u,w,x.c,w,w,!0,w,w,w,w,w,w,w,w)}}
B.Ey.prototype={
a2u(){var x,w=this,v=!1
if(w.c===0){x=w.d
if(x==null||x===12)if(w.e==null)if(w.f==null){v=w.r
v=v==null?null:v.a===80
v=v!==!1&&w.w===D.cA}}return v},
a3u(d){var x,w=this,v="font"
if(d.kr()===";"){w.c=0
w.d=12
w.r=D.Em
return d}else{d.dU("f",v)
w.c=d.pM()
d.dU("s",v)
w.d=d.pL()
d.dU("w",v)
w.r=new B.Ix(d.oa())
x=d.nl(0)
if(x==="^"){w.w=D.jI
d.eW(1)}else if(x==="v"){w.w=D.jH
d.eW(1)}else w.w=D.cA
return d}},
aEo(d){var x,w,v,u=this,t="font",s="Unexpected char in font ("
u.a=d.oa()
x=d.wL()
w=d.a
if(x==="l")u.b=C.at
else if(x==="c")u.b=C.bX
else if(x==="r")u.b=C.eU
else if(x==="j")u.b=C.eV
else{u.b=C.at
v=A.aPy(x)
A.af(A.em('Unrecognized alignment char "'+x+'" (='+v.k(v)+") @pos="+w,"?"))}d.l_()
if(d.D4())return d
else if(d.M0()){d=u.a3u(d)
if(d.D4())return d
else if(d.M0()){u.e=d.tj(!0)
if(d.D4())return d
else if(d.M0()){u.f=d.tj(!0)
if(d.D4())return d
else throw A.i(A.em("Unexpected char at end of font ("+d.nl(0)+" pos="+d.a+" [L4])",t))}else throw A.i(A.em(s+d.nl(0)+" pos="+d.a+" [L3])",t))}else throw A.i(A.em(s+d.nl(0)+" pos="+d.a+" [L2])",t))}else throw A.i(A.em(s+d.nl(0)+" pos="+d.a+" [L1])",t))},
tm(){var x,w,v,u=this,t=u.c
if(t==null)t=0
x=u.d
if(x==null)x=12
w=u.r
if(w==null)w=D.Em
v=u.f
return new B.adx(t,x,B.b1W(Math.max(Math.min(C.h.dN(w.a,16),9),1)*100),w,v)}}
B.agQ.prototype={
a2f(){var x,w,v,u,t=this,s=t.b
if(s.w!==D.cA){x=s.tm()
w=t.a
v=s.e
if(v==null)v=C.u
return new B.WH(v,s.w,x,w)}if(s.a2u()){x=s.b
if(x!==C.at||s.a>0){w=t.a
return new B.B1(x,s.a,w)}return new M.Bv(t.a)}else if(s.e!=null){u=s.tm()
x=t.a
w=s.e
if(w==null)w=C.cM
v=s.a
return new B.wc(s.b,w,v,u,x)}else{u=s.tm()
x=t.a
w=s.a
return new B.Cr(s.b,w,u,x)}},
aBv(){var x,w=this.b,v=!1
if(w.c===1){x=w.d
if(x==null||x===24)if(w.e==null)if(w.f==null){v=w.r
v=v==null?null:v.a===80
v=v!==!1&&w.w===D.cA}}x=this.a
if(v)return new B.rq(x)
else{v=w.tm()
return new B.Cs(w.b,v,x)}}}
B.wA.prototype={
Cs(){var x,w=this,v=w.b
if(v.w!==D.cA){x=w.a
return new B.DC(v.tm(),x,v.e,v.w)}else if(v.a2u())return new B.w3(w.a)
else return new B.DB(v.tm(),w.a,v.e)}}
B.RI.prototype={
Cs(){return this.c}}
B.agP.prototype={
a2V(){return new A.eU(this.aCE(),y.h)},
aCE(){var x=this
return function(){var w=0,v=1,u=[],t,s,r
return function $async$a2V(d,e,f){if(e===1){u.push(f)
w=v}while(true)switch(w){case 0:t=x.a,s=t.length,r=0
case 2:if(!(r<t.length)){w=4
break}w=5
return d.b=t[r].Cs(),1
case 5:case 3:t.length===s||(0,A.G)(t),++r
w=2
break
case 4:return 0
case 1:return d.c=u.at(-1),3}}}}}
B.Hw.prototype={
K(){return"SubSuper."+this.b}}
B.Ix.prototype={
ES(){var x=this.a
switch((x&15)/2|0){case 0:return C.i
case 1:return C.eW
case 2:return C.cZ
case 3:return B.WR(A.b([C.eW,C.cZ],y.P))
case 4:return C.hj
case 5:return B.WR(A.b([C.hj,C.eW],y.P))
case 6:return B.WR(A.b([C.hj,C.cZ],y.P))
case 7:return B.WR(A.b([C.hj,C.eW,C.cZ],y.P))}if((x&2)>0){if((x&4)>0)return B.WR(A.b([C.eW,C.cZ],y.P))
return C.eW}if((x&4)>0)return C.cZ
if((x&8)>0)return C.hj
return C.i}}
B.VG.prototype={
a75(d){var x,w,v=null,u=A.b([],y.R)
for(x=this.c,w=0;w<x.length;++w)u.push(x[w].uX(d))
return new A.xT(v,A.co(u,v,v),this.d,v)},
B(d){var x=A.b([],y.A),w=$.aj()
return new A.n1(null,this.a75(d),new B.VB(x,A.av(y.B),C.jo,w),null)}}
B.VB.prototype={
mF(d){if(this.fr)d.eX(C.jn)},
xD(d){this.fr=!0
return this.v5(C.jn)},
kZ(d){var x,w,v,u,t=this,s=new A.t(0,0,0+t.gtl().a,0+t.gtl().b),r=t.aN(null)
r.fc(r)
x=A.bw(r,d.b)
w=A.xX(s,x,C.a9)
if(d.a===C.C0)t.dx=w
else t.dy=w
v=t.dx
if(v!=null&&t.dy!=null){u=t.dy
u.toString
if(!A.mS(v,u).d5(s).gag(0)){t.fr=!0
t.v5(C.jn)}else t.v4(C.d8)}else t.v4(C.d8)
return A.xY(s,x)},
xA(d){var x=this
x.dy=x.dx=null
x.fr=!1
return x.v4(d)},
ot(d){this.fr=!0
return this.v5(d)}}
B.C7.prototype={
K(){return"CodeElementType."+this.b}}
B.Ij.prototype={
bI(d){var x=this.a
return N.aKL("[Needs code element: "+x+" ("+this.b+")]",C.qP,x.toLowerCase())},
d7(){return"[CodeElementNotFound: "+this.a+"]"},
ct(d){var x=this.a
return N.aKL("[Needs code element: "+x+" ("+this.b+")*]",D.MU,x.toLowerCase())}}
B.ok.prototype={
d7(){return"[Loading null...]"},
bI(d){return new A.hG(this.a,this.gxx(),new A.w("FH_"+A.cs(this),y.O),y.W)},
xy(d,e){var x,w=e.b
if(w!=null)return w.bI(d)
else{w=e.c
if(w!=null){x=e.d
return new A.l3(w,x==null?"[no trace":x,null)}else return D.a4a}},
ct(d){return new A.hG(this.a,this.gaz9(),null,y.W)},
aza(d,e){var x,w=e.b
if(w!=null)return w.ct(d)
else{w=e.c
if(w!=null){x=e.d
return new A.l3(w,x==null?"[no trace":x,null)}else return D.a4b}}}
B.Fd.prototype={
d7(){return"\n"},
bI(d){return new A.as(null,this.a,null,null)},
ct(d){return new A.as(null,this.a,null,null)}}
B.C9.prototype={
d7(){return" "},
bI(d){var x=this,w=null,v=x.c
if(v.a<40)return A.br(w,w,C.l,w,w,new A.bt(v,w,A.dO(C.j,-1,1),w,w,w,C.N),w,x.b,w,C.Q,C.Q,w,w,x.a)
return A.br(w,w,C.l,v,w,w,w,x.b,w,C.Q,C.Q,w,w,x.a)},
ct(d){return this.bI(d)}}
B.C8.prototype={
d7(){return" "},
Ty(d){var x=this,w=null,v=x.c
if(v.a<40)return A.br(w,w,C.l,w,w,new A.bt(v,w,A.dO(C.j,-1,1),w,w,w,C.N),w,x.b,w,C.Q,C.Q,w,w,x.a)
return A.br(w,w,C.l,v,w,w,w,x.b,w,C.Q,C.Q,w,w,x.a)},
uX(d){return new A.iN(this.Ty(d),C.cy,null,null)},
ct(d){return new A.iN(this.Ty(d),C.cy,null,null)},
hd(){return!0}}
B.DL.prototype={
d7(){return""},
bI(d){return C.a_},
ct(d){return C.a_}}
B.TI.prototype={
d7(){return""},
bI(d){return D.D5},
ct(d){return D.D5}}
B.yd.prototype={
b9(){var x=0,w=A.O(y.z),v,u=this,t,s,r,q
var $async$b9=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:t=u.a,s=t.length,r=0
case 3:if(!(r<t.length)){x=5
break}q=t[r]
x=!q.hd()?6:7
break
case 6:x=8
return A.H(q.b9(),$async$b9)
case 8:case 7:case 4:t.length===s||(0,A.G)(t),++r
x=3
break
case 5:v=null
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$b9,w)},
hd(){var x,w,v
for(x=this.a,w=x.length,v=0;v<x.length;x.length===w||(0,A.G)(x),++v)if(!x[v].hd())return!1
return!0},
aGo(d){var x,w,v=null,u=A.b([],y.R)
for(x=this.a,w=0;w<x.length;++w)u.push(x[w].ct(d))
return A.aon(v,v,v,C.cg,v,v,!0,v,A.co(u,v,v),this.b,v,v,C.al,C.aC)},
bI(d){var x=this,w=x.b
return new B.jJ(x.c,w,new B.VG(x.a,w,new A.w("span"+A.cs(x),y.O)),D.f3)},
ct(d){return new B.jJ(this.c,this.b,this.aGo(d),D.f3)},
d7(){var x=this.a
return new A.a5(x,new B.arQ(),A.a2(x).h("a5<1,l>")).oz(0)}}
B.lc.prototype={
b9(){var x=0,w=A.O(y.z),v
var $async$b9=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:v=null
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$b9,w)},
hd(){return!0},
ct(d){return this.uX(d)}}
B.w3.prototype={
d7(){return this.a},
uX(d){return A.co(null,C.aW,this.a)}}
B.DB.prototype={
d7(){return this.b},
b9(){var x=0,w=A.O(y.z),v,u=this
var $async$b9=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:v=u.a.b9()
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$b9,w)},
hd(){return this.a.hd()},
uX(d){return A.co(null,this.a.tW(this.c),this.b)},
ct(d){return A.co(null,this.a.Dc(this.c),this.b)}}
B.DC.prototype={
d7(){return this.b},
b9(){var x=0,w=A.O(y.z),v,u=this
var $async$b9=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:v=u.a.b9()
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$b9,w)},
hd(){return this.a.hd()},
a_J(d){var x=this.c
if(x==null)return d
else return new A.i8(x,d,null)},
Qi(d,e){var x=this,w=null,v=x.a,u=e?v.a0Z():v.DG()
v=x.d
if(v===D.jI){v=u.r
v.toString
u=u.wM(v/2,2)
return new A.iN(x.a_J(A.ah(x.b,w,w,w,w,w,u,w,w)),C.mL,C.r,u)}else if(v===D.jH){v=u.r
v.toString
u=u.wM(v/2,1)
return new A.iN(x.a_J(A.ah(x.b,w,w,w,w,w,u,w,w)),C.cy,C.r,u)}else throw A.i(A.dB("Wrong usage of subSuperSpan function"))},
uX(d){var x=this
if(x.d!==D.cA)return x.Qi(d,!1)
else return A.co(null,x.a.tW(x.c),x.b)},
ct(d){var x=this
if(x.d!==D.cA)return x.Qi(d,!0)
return A.co(null,x.a.Dc(x.c),x.b)}}
B.yI.prototype={}
B.RC.prototype={
b9(){return this.b.b9()},
hd(){return this.b.hd()}}
B.B1.prototype={
bI(d){var x=null,w=this.b
return new B.jJ(this.c,w,A.ah(this.a,x,x,x,x,x,d.a2(y.g).r.c,w,x),D.f3)},
ct(d){return this.bI(d)}}
B.Cr.prototype={
b9(){var x=0,w=A.O(y.z),v,u=this
var $async$b9=A.I(function(d,e){if(d===1)return A.L(e,w)
while(true)switch(x){case 0:v=u.b.b9()
x=1
break
case 1:return A.M(v,w)}})
return A.N($async$b9,w)},
hd(){return!1},
aFW(d){var x=this,w=null,v=A.b2(d,C.bK,y.w).w,u=x.b
if(u.b>20)if(v.a.a<500)return A.ah(x.a,w,w,w,w,w,u.DG(),x.d,w)
return A.ah(x.a,w,w,w,w,w,u.DG(),x.d,w)},
bI(d){return new B.jJ(this.e,this.d,this.aFW(d),new A.w("tabs",y.O))},
ct(d){var x=this,w=null,v=x.d
return new B.jJ(x.e,v,A.ah(x.a,w,w,w,w,w,x.b.a0Z(),v,w),D.f3)}}
B.wc.prototype={
bI(d){var x=this,w=null,v=x.d
return new B.jJ(x.f,v,A.ah(x.a,w,w,w,w,w,x.b.tW(x.e),v,w),new A.w("tabs",y.O))},
ct(d){var x=this,w=null,v=x.d
return new B.jJ(x.f,v,A.ah(x.a,w,w,w,w,w,x.b.Dc(x.e),v,w),new A.w("tabs",y.O))}}
B.WH.prototype={
a66(d){var x,w,v,u,t=this,s=null,r=t.r
if(r===D.jI){x=t.b.tW(t.e)
r=x.r
r.toString
return new A.bG(C.bv,s,s,A.ah(t.a,s,s,s,s,s,x.wM(r/2,2),C.at,s),s)}else{w=t.b
v=t.e
u=t.a
if(r===D.jH){x=w.tW(v)
r=x.r
r.toString
return new A.bG(C.fd,s,s,A.ah(u,s,s,s,s,s,x.wM(r/2,2),C.at,s),s)}else return A.ah(u,s,s,s,s,s,w.tW(v),C.at,s)}},
bI(d){return new B.jJ(0,C.at,this.a66(d),D.f3)},
ct(d){var x=null
return new B.jJ(0,C.at,A.ah(this.a,x,x,x,x,x,this.b.Dc(this.e),C.at,x),D.f3)}}
B.rq.prototype={
bI(d){var x=null
return A.ah(this.a,x,x,x,x,x,C.eY,C.bX,x)},
ct(d){return this.bI(d)},
d7(){return"\n"+this.a+"\n"}}
B.Cs.prototype={
bI(d){var x=null,w=this.c
return new A.bG(B.aWI(w),x,x,A.ah(this.a,x,x,x,x,x,this.d.DG(),w,x),x)},
ct(d){return this.a7V(d)}}
B.jJ.prototype={
B(d){var x,w=null,v=B.aWI(this.d),u=A.b2(d,C.bK,y.w).w,t=this.e
t=v.j(0,C.bv)?t:new A.bG(v,w,w,t,w)
x=this.c
if(x===0)return t
else{u=15+u.a.a/8*x
return new A.aH(new A.ac(u,0,u,0),t,w)}}}
var z=a.updateTypes(["c(F,fE<aR>)","~(aR)","~(C[cA?])","~()","l(lc)"])
B.a95.prototype={
$1(d){return d.d7()},
$S:136}
B.a96.prototype={
$1(d){if(d==null||d.length===0||d==="-")return null
return d},
$S:661}
B.arQ.prototype={
$1(d){return d.d7()},
$S:z+4};(function aliases(){var x=B.rq.prototype
x.a7V=x.ct})();(function installTearOffs(){var x=a._instance_1u,w=a.installInstanceTearOff,v=a._instance_0u,u=a._instance_2u
var t
x(t=B.kY.prototype,"gacv","acw",1)
w(t,"gauX",0,1,null,["$2","$1"],["ZI","auY"],2,0,0)
v(t,"gaEF","O_",3)
u(t=B.ok.prototype,"gxx","xy",0)
u(t,"gaz9","aza",0)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(A.C,[B.PE,B.BO,B.Pi,B.adx,B.Ey,B.agQ,B.wA,B.agP,B.Ix,B.lc])
w(B.kY,A.e6)
x(A.dH,[B.a95,B.a96,B.arQ])
w(B.RI,B.wA)
x(A.hV,[B.Hw,B.C7])
x(A.Q,[B.VG,B.jJ])
w(B.VB,A.rW)
x(A.aR,[B.Ij,B.ok,B.Fd,B.C9,B.DL,B.TI,B.yd])
x(B.lc,[B.C8,B.w3,B.DB,B.DC])
w(B.yI,Q.dF)
x(M.hn,[B.RC,B.B1,B.rq])
x(B.RC,[B.Cr,B.wc,B.WH])
w(B.Cs,B.rq)})()
A.bL(b.typeUniverse,JSON.parse('{"kY":{"a7":[]},"Pi":{"bC":[]},"RI":{"wA":[]},"VG":{"Q":[],"c":[]},"VB":{"a7":[]},"Ij":{"aR":[]},"ok":{"aR":[]},"Fd":{"aR":[]},"C9":{"aR":[]},"C8":{"lc":[]},"DL":{"aR":[]},"TI":{"aR":[]},"yd":{"aR":[]},"w3":{"lc":[]},"DB":{"lc":[]},"DC":{"lc":[]},"yI":{"dF":[],"aR":[]},"RC":{"hn":[],"aR":[]},"B1":{"hn":[],"aR":[]},"Cr":{"hn":[],"aR":[]},"wc":{"hn":[],"aR":[]},"WH":{"hn":[],"aR":[]},"rq":{"hn":[],"aR":[]},"Cs":{"hn":[],"aR":[]},"jJ":{"Q":[],"c":[]}}'))
var y=(function rtii(){var x=A.T
return{u:x("PE"),g:x("h2"),W:x("hG<aR>"),G:x("aa<A?>"),a:x("aR"),D:x("r<aR>"),R:x("r<hc>"),U:x("r<wA>"),A:x("r<ef>"),s:x("r<l>"),P:x("r<n7>"),w:x("et"),l:x("+(kY,cd<aR>)"),B:x("ef"),N:x("l"),O:x("w<l>"),h:x("eU<lc>"),b:x("eU<aR>"),z:x("@"),S:x("p"),c:x("rg?"),d:x("A?"),H:x("~")}})();(function constants(){D.GY=new B.DL()
D.Hm=new B.TI()
D.oR=new B.C7(0,"parsedCodeElement")
D.oS=new B.C7(1,"codeBlock")
D.oT=new B.C7(2,"codeTag")
D.Ib=new F.j4(10,0,"NEWLINE")
D.hP=new F.j4(59,15,"SEMICOLON")
D.Ic=new F.j4(60,16,"LGATOR")
D.Id=new F.j4(62,18,"RGATOR")
D.KT=new U.CC("Update CodeElementTypes if ladder")
D.iy=new A0.RB(0,"normal")
D.MU=new A.f(58258,"MaterialIcons",null,!1)
D.D5=new A.as(null,240,null,null)
D.aaF=new A.jF("Getting code element",null,null)
D.a4a=new A.as(null,150,D.aaF,null)
D.aaD=new A.jF("Getting code element (fallback)",null,null)
D.a4b=new A.as(null,150,D.aaD,null)
D.cA=new B.Hw(0,"normal")
D.jH=new B.Hw(1,"subscript")
D.jI=new B.Hw(2,"superscript")
D.f3=new A.w("tabs",y.O)
D.Em=new B.Ix(80)})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_72",e:"endPart",h:b})})($__dart_deferred_initializers__,"c4pflfwQHckGTH/dtxaVL9+GOg4=");