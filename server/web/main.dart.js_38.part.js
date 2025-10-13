((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_38",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,D,E,A={
a8x(d,e){var x,w=null
if(d.e!=null){x=B.GZ(d)
if(x!=null)x.vf(B.HM(w,w,w,w,w,D.u,w,new A.BY(e,w),w,D.fJ,w,w,w,w,w,w,w,!0,w))}},
BY:function BY(d,e){this.c=d
this.a=e},
EH:function EH(d,e){this.a=d
this.b=e},
avM:function avM(){},
a9U:function a9U(){},
alP:function alP(){},
alQ:function alQ(){},
alR:function alR(){},
tz:function tz(d,e){this.a=d
this.b=e},
avo:function avo(){},
aVF(d){var x,w,v=0,u=null
try{x=B.dW(d,v,u)
return x}catch(w){if(y.b.b(B.aj(w)))return null
else throw w}},
bdg(d){switch(d.a){case 0:return C.C7
case 2:return C.C9
case 1:return C.C8
case 3:return C.a2v
case 4:return C.Ca}},
aKX(d,e){return A.bem(d,e)},
bem(d,e){var x=0,w=B.J(y.e),v,u,t,s,r,q,p
var $async$aKX=B.F(function(f,g){if(f===1)return B.G(g,w)
while(true)switch(x){case 0:if(e===C.WT||e===C.mg)u=!(d.gfd()==="https"||d.gfd()==="http")
else u=!1
if(u)throw B.i(B.hj(d,"url","To use an in-app web view, you must provide an http(s) URL."))
u=$.aQa()
t=d.j(0)
s=A.bdg(e)
r=D.c.bH(t,"http:")||D.c.bH(t,"https:")
q=!0
if(s!==C.C8)if(s!==C.C9){p=r&&s===C.C7
q=p}v=u.aCx(t,!0,!0,D.h6,s===C.Ca,q,q,null)
x=1
break
case 1:return B.H(v,w)}})
return B.I($async$aKX,w)},
aKl(d){return A.bcZ(d)},
bcZ(d){var x=0,w=B.J(y.e),v
var $async$aKl=B.F(function(e,f){if(e===1)return B.G(f,w)
while(true)switch(x){case 0:v=$.aQa().awn(d.j(0))
x=1
break
case 1:return B.H(v,w)}})
return B.I($async$aKl,w)}},C
B=c[0]
D=c[2]
E=c[93]
A=a.updateHolder(c[50],A)
C=c[110]
A.BY.prototype={
LT(){var x=this.c
B.kb(new B.iq(x==null?"?":x))},
v(d){var x=null
return B.cl(B.b([C.VI,D.f_,B.fC(B.ad("Can't open link: ["+B.p(this.c)+"]",x,3,D.ae,x,x,B.M(d).ok.z,x,x),x),B.h0(x,x,E.mb,x,x,this.gLS(),x,x,x)],y.l),D.J,x,D.C,D.G,x)}}
A.EH.prototype={
K(){return"LaunchMode."+this.b}}
A.avM.prototype={}
A.a9U.prototype={}
A.alP.prototype={
awn(d){var x=y.e
return C.yc.jI("canLaunch",B.az(["url",d],y.g,y.o),!1,x).b_(new A.alQ(),x)},
aCx(d,e,f,g,h,i,j,k){var x=y.e
return C.yc.jI("launch",B.az(["url",d,"useSafariVC",i,"useWebView",j,"enableJavaScript",!0,"enableDomStorage",!0,"universalLinksOnly",h,"headers",g],y.g,y.o),!1,x).b_(new A.alR(),x)}}
A.tz.prototype={
K(){return"PreferredLaunchMode."+this.b}}
A.avo.prototype={}
var z=a.updateTypes(["~()"])
A.alQ.prototype={
$1(d){return d===!0},
$S:241}
A.alR.prototype={
$1(d){return d===!0},
$S:241};(function installTearOffs(){var x=a._instance_0u
x(A.BY.prototype,"gLS","LT",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(A.BY,B.L)
w(B.eI,[A.EH,A.tz])
w(B.C,[A.avM,A.a9U])
x(A.avo,B.UL)
x(A.alP,A.avo)
w(B.cM,[A.alQ,A.alR])})()
B.bi(b.typeUniverse,JSON.parse('{"BY":{"L":[],"c":[]}}'))
var y={b:B.w("ht"),l:B.w("r<c>"),o:B.w("C"),g:B.w("l"),e:B.w("y")};(function constants(){C.aj3=new A.a9U()
C.aj7=new A.avM()
C.rh=new B.f(58240,"MaterialIcons",null,!1)
C.VI=new B.cV(C.rh,24,null,null,null,null)
C.aje=new A.EH(0,"platformDefault")
C.WT=new A.EH(1,"inAppWebView")
C.mg=new A.EH(2,"inAppBrowserView")
C.yc=new B.mR("plugins.flutter.io/url_launcher",D.c9,null)
C.C7=new A.tz(0,"platformDefault")
C.C8=new A.tz(1,"inAppWebView")
C.C9=new A.tz(2,"inAppBrowserView")
C.a2v=new A.tz(3,"externalApplication")
C.Ca=new A.tz(4,"externalNonBrowserApplication")})();(function lazyInitializers(){var x=a.lazyFinal,w=a.lazy
x($,"bi5","b_a",()=>new B.C())
w($,"bi4","aQa",()=>{var v=new A.alP()
v.Hi($.b_a())
return v})})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_38",e:"endPart",h:b})})($__dart_deferred_initializers__,"mNbGV5yUS3VYjPNeo9R6fcIX3Mo=");