((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_41",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,D,E,A={
a8E(d,e){var x,w=null
if(d.e!=null){x=B.H5(d)
if(x!=null)x.vg(B.HS(w,w,w,w,w,D.u,w,new A.C4(e,w),w,D.fJ,w,w,w,w,w,w,w,!0,w))}},
C4:function C4(d,e){this.c=d
this.a=e},
EQ:function EQ(d,e){this.a=d
this.b=e},
avT:function avT(){},
aa0:function aa0(){},
alW:function alW(){},
alX:function alX(){},
alY:function alY(){},
tB:function tB(d,e){this.a=d
this.b=e},
avv:function avv(){},
aVK(d){var x,w,v=0,u=null
try{x=B.dW(d,v,u)
return x}catch(w){if(y.b.b(B.aj(w)))return null
else throw w}},
bdk(d){switch(d.a){case 0:return C.C7
case 2:return C.C9
case 1:return C.C8
case 3:return C.a2G
case 4:return C.Ca}},
aL1(d,e){return A.beq(d,e)},
beq(d,e){var x=0,w=B.J(y.e),v,u,t,s,r,q,p
var $async$aL1=B.F(function(f,g){if(f===1)return B.G(g,w)
while(true)switch(x){case 0:if(e===C.X3||e===C.mi)u=!(d.gfd()==="https"||d.gfd()==="http")
else u=!1
if(u)throw B.i(B.hj(d,"url","To use an in-app web view, you must provide an http(s) URL."))
u=$.aQf()
t=d.j(0)
s=A.bdk(e)
r=D.c.bH(t,"http:")||D.c.bH(t,"https:")
q=!0
if(s!==C.C8)if(s!==C.C9){p=r&&s===C.C7
q=p}v=u.aCD(t,!0,!0,D.h7,s===C.Ca,q,q,null)
x=1
break
case 1:return B.H(v,w)}})
return B.I($async$aL1,w)},
aKr(d){return A.bd2(d)},
bd2(d){var x=0,w=B.J(y.e),v
var $async$aKr=B.F(function(e,f){if(e===1)return B.G(f,w)
while(true)switch(x){case 0:v=$.aQf().aws(d.j(0))
x=1
break
case 1:return B.H(v,w)}})
return B.I($async$aKr,w)}},C
B=c[0]
D=c[2]
E=c[94]
A=a.updateHolder(c[50],A)
C=c[112]
A.C4.prototype={
LW(){var x=this.c
B.k9(new B.ir(x==null?"?":x))},
v(d){var x=null
return B.cr(B.b([C.VT,D.jU,B.fV(B.ad("Can't open link: ["+B.p(this.c)+"]",x,3,D.ae,x,x,B.M(d).ok.z,x,x),x),B.h1(x,x,E.md,x,x,this.gLV(),x,x,x)],y.l),D.J,x,D.C,D.F,x)}}
A.EQ.prototype={
K(){return"LaunchMode."+this.b}}
A.avT.prototype={}
A.aa0.prototype={}
A.alW.prototype={
aws(d){var x=y.e
return C.yc.jJ("canLaunch",B.az(["url",d],y.g,y.o),!1,x).b_(new A.alX(),x)},
aCD(d,e,f,g,h,i,j,k){var x=y.e
return C.yc.jJ("launch",B.az(["url",d,"useSafariVC",i,"useWebView",j,"enableJavaScript",!0,"enableDomStorage",!0,"universalLinksOnly",h,"headers",g],y.g,y.o),!1,x).b_(new A.alY(),x)}}
A.tB.prototype={
K(){return"PreferredLaunchMode."+this.b}}
A.avv.prototype={}
var z=a.updateTypes(["~()"])
A.alX.prototype={
$1(d){return d===!0},
$S:153}
A.alY.prototype={
$1(d){return d===!0},
$S:153};(function installTearOffs(){var x=a._instance_0u
x(A.C4.prototype,"gLV","LW",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(A.C4,B.L)
w(B.eJ,[A.EQ,A.tB])
w(B.C,[A.avT,A.aa0])
x(A.avv,B.UR)
x(A.alW,A.avv)
w(B.cM,[A.alX,A.alY])})()
B.bh(b.typeUniverse,JSON.parse('{"C4":{"L":[],"c":[]}}'))
var y={b:B.u("ht"),l:B.u("r<c>"),o:B.u("C"),g:B.u("m"),e:B.u("y")};(function constants(){C.ajk=new A.aa0()
C.ajo=new A.avT()
C.rf=new B.f(58240,"MaterialIcons",null,!1)
C.VT=new B.cU(C.rf,24,null,null,null,null)
C.ajv=new A.EQ(0,"platformDefault")
C.X3=new A.EQ(1,"inAppWebView")
C.mi=new A.EQ(2,"inAppBrowserView")
C.yc=new B.mS("plugins.flutter.io/url_launcher",D.c8,null)
C.C7=new A.tB(0,"platformDefault")
C.C8=new A.tB(1,"inAppWebView")
C.C9=new A.tB(2,"inAppBrowserView")
C.a2G=new A.tB(3,"externalApplication")
C.Ca=new A.tB(4,"externalNonBrowserApplication")})();(function lazyInitializers(){var x=a.lazyFinal,w=a.lazy
x($,"bi9","b_f",()=>new B.C())
w($,"bi8","aQf",()=>{var v=new A.alW()
v.Hl($.b_f())
return v})})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_41",e:"endPart",h:b})})($__dart_deferred_initializers__,"RymtxWDD0QgJyhSvUo+bOYs1a9o=");