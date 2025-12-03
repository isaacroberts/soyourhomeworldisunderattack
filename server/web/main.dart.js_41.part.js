((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_41",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,D,E,A={
a7r(d,e){var x,w=null
if(d.e!=null){x=B.GE(d)
if(x!=null)x.uM(B.Hr(w,w,w,w,w,D.v,w,new A.BR(e,w),w,D.fp,w,w,w,w,w,w,w,!0,w))}},
BR:function BR(d,e){this.c=d
this.a=e},
Eu:function Eu(d,e){this.a=d
this.b=e},
auz:function auz(){},
a8L:function a8L(){},
akI:function akI(){},
akJ:function akJ(){},
akK:function akK(){},
ts:function ts(d,e){this.a=d
this.b=e},
auc:function auc(){},
aTa(d){var x,w,v=0,u=null
try{x=B.dW(d,v,u)
return x}catch(w){if(y.b.b(B.ai(w)))return null
else throw w}},
baC(d){switch(d.a){case 0:return C.Bo
case 2:return C.Bq
case 1:return C.Bp
case 3:return C.a1j
case 4:return C.Br}},
aII(d,e){return A.bbH(d,e)},
bbH(d,e){var x=0,w=B.I(y.e),v,u,t,s,r,q,p
var $async$aII=B.D(function(f,g){if(f===1)return B.F(g,w)
while(true)switch(x){case 0:if(e===C.VO||e===C.lU)u=!(d.gf0()==="https"||d.gf0()==="http")
else u=!1
if(u)throw B.i(B.hb(d,"url","To use an in-app web view, you must provide an http(s) URL."))
u=$.aNO()
t=d.j(0)
s=A.baC(e)
r=D.c.bA(t,"http:")||D.c.bA(t,"https:")
q=!0
if(s!==C.Bp)if(s!==C.Bq){p=r&&s===C.Bo
q=p}v=u.aBz(t,!0,!0,D.fP,s===C.Br,q,q,null)
x=1
break
case 1:return B.G(v,w)}})
return B.H($async$aII,w)},
aI8(d){return A.bak(d)},
bak(d){var x=0,w=B.I(y.e),v
var $async$aI8=B.D(function(e,f){if(e===1)return B.F(f,w)
while(true)switch(x){case 0:v=$.aNO().av7(d.j(0))
x=1
break
case 1:return B.G(v,w)}})
return B.H($async$aI8,w)}},C
B=c[0]
D=c[2]
E=c[90]
A=a.updateHolder(c[51],A)
C=c[106]
A.BR.prototype={
Ld(){var x=this.c
B.k2(new B.io(x==null?"?":x))},
v(d){var x=null
return B.d1(B.b([C.UU,D.jo,B.hN(B.ad("Can't open link: ["+B.p(this.c)+"]",x,3,D.ac,x,x,B.R(d).ok.z,x,x),x),B.hm(x,x,E.lP,x,x,this.gLc(),x,x,x)],y.l),D.T,x,D.F,D.P,x)}}
A.Eu.prototype={
K(){return"LaunchMode."+this.b}}
A.auz.prototype={}
A.a8L.prototype={}
A.akI.prototype={
av7(d){var x=y.e
return C.xu.jy("canLaunch",B.av(["url",d],y.g,y.o),!1,x).aY(new A.akJ(),x)},
aBz(d,e,f,g,h,i,j,k){var x=y.e
return C.xu.jy("launch",B.av(["url",d,"useSafariVC",i,"useWebView",j,"enableJavaScript",!0,"enableDomStorage",!0,"universalLinksOnly",h,"headers",g],y.g,y.o),!1,x).aY(new A.akK(),x)}}
A.ts.prototype={
K(){return"PreferredLaunchMode."+this.b}}
A.auc.prototype={}
var z=a.updateTypes(["~()"])
A.akJ.prototype={
$1(d){return d===!0},
$S:232}
A.akK.prototype={
$1(d){return d===!0},
$S:232};(function installTearOffs(){var x=a._instance_0u
x(A.BR.prototype,"gLc","Ld",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(A.BR,B.M)
w(B.f5,[A.Eu,A.ts])
w(B.C,[A.auz,A.a8L])
x(A.auc,B.U1)
x(A.akI,A.auc)
w(B.cW,[A.akJ,A.akK])})()
B.bv(b.typeUniverse,JSON.parse('{"BR":{"M":[],"c":[]}}'))
var y={b:B.y("hk"),l:B.y("r<c>"),o:B.y("C"),g:B.y("m"),e:B.y("z")};(function constants(){C.ahA=new A.a8L()
C.ahE=new A.auz()
C.qz=new B.f(58240,"MaterialIcons",null,!1)
C.UU=new B.cY(C.qz,24,null,null,null,null,null)
C.ahK=new A.Eu(0,"platformDefault")
C.VO=new A.Eu(1,"inAppWebView")
C.lU=new A.Eu(2,"inAppBrowserView")
C.xu=new B.mN("plugins.flutter.io/url_launcher",D.c5,null)
C.Bo=new A.ts(0,"platformDefault")
C.Bp=new A.ts(1,"inAppWebView")
C.Bq=new A.ts(2,"inAppBrowserView")
C.a1j=new A.ts(3,"externalApplication")
C.Br=new A.ts(4,"externalNonBrowserApplication")})();(function lazyInitializers(){var x=a.lazyFinal,w=a.lazy
x($,"bfp","aXE",()=>new B.C())
w($,"bfo","aNO",()=>{var v=new A.akI()
v.GK($.aXE())
return v})})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_41",e:"endPart",h:b})})($__dart_deferred_initializers__,"m78Pdl9Qj5wP8c35v3/wSDdG6QE=");