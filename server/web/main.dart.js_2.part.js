// Generated by dart2js (, trust primitives, omit checks, lax runtime type, csp, intern-composite-values), the Dart to JavaScript compiler version: 3.8.0.
((s, d, e) => {
  s[d] = s[d] || {};
  s[d][e] = s[d][e] || [];
  s[d][e].push({p: "main.dart.js_2", e: "beginPart"});
})(self, "$__dart_deferred_initializers__", "eventLog");
$__dart_deferred_initializers__.current = function(hunkHelpers, init, holdersList, $) {
  var C, D,
  B = {
    ErrorIcon$(exceptionType) {
      return new B.ErrorIcon(exceptionType, null);
    },
    ErrorIcon: function ErrorIcon(t0, t1) {
      this.exceptionType = t0;
      this.key = t1;
    }
  },
  A;
  C = holdersList[0];
  D = holdersList[2];
  B = hunkHelpers.updateHolder(holdersList[4], B);
  A = holdersList[75];
  B.ErrorIcon.prototype = {
    getIcon$0() {
      var t1 = this.exceptionType;
      if (t1 === "_ClientSocketException")
        return A.IconData_59737_RpgAwesome_null_false;
      else if (t1 === "HttpExceptionWithStatus")
        return A.IconData_59737_RpgAwesome_null_false;
      else if (t1 === "BookCodeException")
        return D.IconData_59726_RpgAwesome_null_false;
      else if (t1 === "ChapterFormatException")
        return D.IconData_59726_RpgAwesome_null_false;
      else if (t1 === "FontException")
        return A.IconData_59659_RpgAwesome_null_false;
      else if (t1 === "IdiotException")
        return A.IconData_59889_RpgAwesome_null_false;
      else if (t1 === "_Exception")
        return A.IconData_59867_RpgAwesome_null_false;
      return A.IconData_59849_RpgAwesome_null_false;
    },
    build$1(context) {
      return C.Icon$(this.getIcon$0(), D.Color_5Ht, null, 50);
    }
  };
  var typesOffset = hunkHelpers.updateTypes([]);
  (function inheritance() {
    var _inherit = hunkHelpers.inherit;
    _inherit(B.ErrorIcon, C.StatelessWidget);
  })();
  C._Universe_addRules(init.typeUniverse, JSON.parse('{"ErrorIcon":{"StatelessWidget":[],"Widget":[],"DiagnosticableTree":[]}}'));
};
;
((d, h) => {
  d[h] = d.current;
  d.eventLog.push({p: "main.dart.js_2", e: "endPart", h: h});
})($__dart_deferred_initializers__, "QWmgyDOWK/7IW2XDMxTwR6JUjmE=");
;