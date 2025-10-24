((a,b,c)=>{a[b]=a[b]||{}
a[b][c]=a[b][c]||[]
a[b][c].push({p:"main.dart.js_36",e:"beginPart"})})(self,"$__dart_deferred_initializers__","eventLog")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,D,E,A={
a8V(d,e){var x,w=null
if(d.e!=null){x=B.H7(d)
if(x!=null)x.vl(B.HU(w,w,w,w,w,D.r,w,new A.C6(e,w),w,D.fP,w,w,w,w,w,w,w,!0,w))}},
C6:function C6(d,e){this.c=d
this.a=e},
ET:function ET(d,e){this.a=d
this.b=e},
awc:function awc(){},
aag:function aag(){},
amc:function amc(){},
amd:function amd(){},
ame:function ame(){},
tB:function tB(d,e){this.a=d
this.b=e},
avP:function avP(){},
aW2(d){var x,w,v=0,u=null
try{x=B.dZ(d,v,u)
return x}catch(w){if(y.b.b(B.ai(w)))return null
else throw w}},
bdJ(d){switch(d.a){case 0:return C.CC
case 2:return C.CE
case 1:return C.CD
case 3:return C.a3q
case 4:return C.CF}},
aLn(d,e){return A.beP(d,e)},
beP(d,e){var x=0,w=B.K(y.e),v,u,t,s,r,q,p
var $async$aLn=B.F(function(f,g){if(f===1)return B.H(g,w)
while(true)switch(x){case 0:if(e===C.XE||e===C.my)u=!(d.gfd()==="https"||d.gfd()==="http")
else u=!1
if(u)throw B.i(B.hj(d,"url","To use an in-app web view, you must provide an http(s) URL."))
u=$.aQv()
t=d.j(0)
s=A.bdJ(e)
r=D.c.bH(t,"http:")||D.c.bH(t,"https:")
q=!0
if(s!==C.CD)if(s!==C.CE){p=r&&s===C.CC
q=p}v=u.aCK(t,!0,!0,D.hb,s===C.CF,q,q,null)
x=1
break
case 1:return B.I(v,w)}})
return B.J($async$aLn,w)},
aKN(d){return A.bdr(d)},
bdr(d){var x=0,w=B.K(y.e),v
var $async$aKN=B.F(function(e,f){if(e===1)return B.H(f,w)
while(true)switch(x){case 0:v=$.aQv().awD(d.j(0))
x=1
break
case 1:return B.I(v,w)}})
return B.J($async$aKN,w)}},C
B=c[0]
D=c[2]
E=c[84]
A=a.updateHolder(c[48],A)
C=c[100]
A.C6.prototype={
M1(){var x=this.c
B.ka(new B.it(x==null?"?":x))},
u(d){var x=null
return B.cA(B.b([C.Wu,D.jZ,B.ht(B.aa("Can't open link: ["+B.p(this.c)+"]",x,3,D.ae,x,x,B.M(d).ok.z,x,x),x),B.ff(x,x,E.mt,x,x,this.gM0(),x,x,x)],y.l),D.K,x,D.C,D.H,x)}}
A.ET.prototype={
K(){return"LaunchMode."+this.b}}
A.awc.prototype={}
A.aag.prototype={}
A.amc.prototype={
awD(d){var x=y.e
return C.yH.jT("canLaunch",B.ay(["url",d],y.g,y.o),!1,x).b0(new A.amd(),x)},
aCK(d,e,f,g,h,i,j,k){var x=y.e
return C.yH.jT("launch",B.ay(["url",d,"useSafariVC",i,"useWebView",j,"enableJavaScript",!0,"enableDomStorage",!0,"universalLinksOnly",h,"headers",g],y.g,y.o),!1,x).b0(new A.ame(),x)}}
A.tB.prototype={
K(){return"PreferredLaunchMode."+this.b}}
A.avP.prototype={}
var z=a.updateTypes(["~()"])
A.amd.prototype={
$1(d){return d===!0},
$S:242}
A.ame.prototype={
$1(d){return d===!0},
$S:242};(function installTearOffs(){var x=a._instance_0u
x(A.C6.prototype,"gM0","M1",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(A.C6,B.G)
w(B.fr,[A.ET,A.tB])
w(B.D,[A.awc,A.aag])
x(A.avP,B.V2)
x(A.amc,A.avP)
w(B.dj,[A.amd,A.ame])})()
B.bq(b.typeUniverse,JSON.parse('{"C6":{"G":[],"c":[]}}'))
var y={b:B.B("hu"),l:B.B("r<c>"),o:B.B("D"),g:B.B("n"),e:B.B("x")};(function constants(){C.aka=new A.aag()
C.ake=new A.awc()
C.rJ=new B.f(58240,"MaterialIcons",null,!1)
C.Wu=new B.cT(C.rJ,24,null,null,null,null)
C.akl=new A.ET(0,"platformDefault")
C.XE=new A.ET(1,"inAppWebView")
C.my=new A.ET(2,"inAppBrowserView")
C.yH=new B.mW("plugins.flutter.io/url_launcher",D.c4,null)
C.CC=new A.tB(0,"platformDefault")
C.CD=new A.tB(1,"inAppWebView")
C.CE=new A.tB(2,"inAppBrowserView")
C.a3q=new A.tB(3,"externalApplication")
C.CF=new A.tB(4,"externalNonBrowserApplication")})();(function lazyInitializers(){var x=a.lazyFinal,w=a.lazy
x($,"bix","b_z",()=>new B.D())
w($,"biw","aQv",()=>{var v=new A.amc()
v.Hv($.b_z())
return v})})()};
((a,b)=>{a[b]=a.current
a.eventLog.push({p:"main.dart.js_36",e:"endPart",h:b})})($__dart_deferred_initializers__,"YT1EnTrVss6/IfBxrSmaFBfbCVw=");