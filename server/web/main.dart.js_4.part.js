// Generated by dart2js (, trust primitives, omit checks, lax runtime type, csp, intern-composite-values), the Dart to JavaScript compiler version: 3.8.0.
((s, d, e) => {
  s[d] = s[d] || {};
  s[d][e] = s[d][e] || [];
  s[d][e].push({p: "main.dart.js_4", e: "beginPart"});
})(self, "$__dart_deferred_initializers__", "eventLog");
$__dart_deferred_initializers__.current = function(hunkHelpers, init, holdersList, $) {
  var J, B, C, E, F, G,
  A = {
    IconHolder$(iconIndex, params) {
      var t1 = new A.IconHolder();
      t1.__IconHolder_icon_F = H.List_yDx[iconIndex];
      return t1;
    },
    BGCodeElement_fromString(str, spans) {
      return new A.BGCodeElement(spans);
    },
    ArtHolder$(spans) {
      return new A.ArtHolder(spans);
    },
    Ticket$(spans) {
      return new A.Ticket(spans);
    },
    PollScreen$(spans) {
      return new A.PollScreen(spans);
    },
    Columns_parse(bin) {
      var cols, t1, col, parser,
        _s7_ = "columns";
      bin.consumeUint32$0();
      bin.consumeUint8$0();
      bin.assertConsume$2$debugId("[", _s7_);
      cols = B._setArrayType([], type$.JSArray_List_Holder);
      t1 = type$.JSArray_Holder;
      while (true) {
        if (!(bin.hasMore$0() && bin.getChar$1(0) === "c"))
          break;
        bin.assertConsume$2$debugId("c", _s7_);
        bin.consumeUint32$0();
        bin.assertConsume$2$debugId("[", _s7_);
        col = B._setArrayType([], t1);
        parser = new I.ChapterParser("Columns_obj", bin);
        while (true) {
          if (!(bin.hasMore$0() && bin.getChar$1(0) !== "]"))
            break;
          col.push(parser.readOneHolder$0());
        }
        bin = parser.ptr;
        bin.warnConsume$1("]");
        cols.push(col);
      }
      bin.warnConsume$1("]");
      bin.warnConsume$1(";");
      return new A.Columns(cols);
    },
    Sign$(spans) {
      return new A.Sign(spans);
    },
    Sign2Cols_parse(bin) {
      return new A.Sign2Cols(A.Columns_parse(bin).cols);
    },
    IconHolder: function IconHolder() {
      this.__IconHolder_icon_F = $;
    },
    BGCodeElement: function BGCodeElement(t0) {
      this.spans = t0;
    },
    ArtHolder: function ArtHolder(t0) {
      this.spans = t0;
    },
    Ticket: function Ticket(t0) {
      this.spans = t0;
    },
    PollScreen: function PollScreen(t0) {
      this.spans = t0;
    },
    Columns: function Columns(t0) {
      this.cols = t0;
    },
    _SignWidget: function _SignWidget(t0, t1) {
      this.child = t0;
      this.key = t1;
    },
    Sign: function Sign(t0) {
      this.spans = t0;
    },
    Sign2Cols: function Sign2Cols(t0) {
      this.cols = t0;
    }
  },
  D, H, I;
  J = holdersList[1];
  B = holdersList[0];
  C = holdersList[2];
  E = holdersList[52];
  F = holdersList[51];
  G = holdersList[50];
  A = hunkHelpers.updateHolder(holdersList[20], A);
  D = holdersList[64];
  H = holdersList[65];
  I = holdersList[37];
  A.IconHolder.prototype = {
    element$1(context) {
      var t1 = this.__IconHolder_icon_F;
      t1 === $ && B.throwUnnamedLateFieldNI();
      return B.Icon$(t1, D.Color_oAx, null, 30);
    },
    fallback$1(context) {
      var _null = null,
        t1 = B.Border_Border$all(D.Color_xCN, -1, 2),
        t2 = this.__IconHolder_icon_F;
      t2 === $ && B.throwUnnamedLateFieldNI();
      return B.Container$(_null, B.Icon$(t2, D.Color_oAx, _null, 30), C.Clip_0, _null, new B.BoxDecoration(_null, _null, t1, _null, _null, _null, C.BoxShape_0), 30, _null, _null, 30);
    }
  };
  A.BGCodeElement.prototype = {};
  A.ArtHolder.prototype = {
    element$1(context) {
      var _null = null,
        size = B.InheritedModel_inheritFrom(context, _null, type$.MediaQuery).data.size,
        t1 = size._dx,
        t2 = B.Border_Border$all(C.Color_vnR, -1, 1),
        t3 = B.Border_Border$all(C.Color_vnR, -1, 1);
      return new B.ConstrainedBox(new B.BoxConstraints(t1, t1, size._dy, 1 / 0), B.Container$(_null, F.SingleChildScrollView$(B.Container$(_null, this.renderSpans$1(context), C.Clip_0, _null, new B.BoxDecoration(_null, _null, t3, _null, _null, _null, C.BoxShape_0), _null, _null, _null, _null), _null, _null, _null, C.Axis_0), C.Clip_0, _null, new B.BoxDecoration(_null, _null, t2, _null, _null, _null, C.BoxShape_0), _null, _null, _null, _null), _null);
    }
  };
  A.Ticket.prototype = {};
  A.PollScreen.prototype = {};
  A.Columns.prototype = {
    renderCol$3$crossAxisAlignment$spans(context, crossAxisAlignment, spans) {
      var t2,
        t1 = B._setArrayType([], type$.JSArray_Widget);
      for (t2 = J.get$iterator$ax(spans); t2.moveNext$0();)
        t1.push(t2.get$current().element$1(context));
      return B.Column$(t1, crossAxisAlignment, null, C.MainAxisAlignment_0, C.MainAxisSize_0);
    },
    renderCol$2$spans(context, spans) {
      return this.renderCol$3$crossAxisAlignment$spans(context, C.CrossAxisAlignment_2, spans);
    },
    element$1(context) {
      var t2, t3, _i,
        t1 = B._setArrayType([], type$.JSArray_Widget);
      for (t2 = this.cols, t3 = t2.length, _i = 0; _i < t2.length; t2.length === t3 || (0, B.throwConcurrentModificationError)(t2), ++_i)
        t1.push(new B.Flexible(1, C.FlexFit_1, this.renderCol$2$spans(context, t2[_i]), null));
      return B.Row$(t1, C.CrossAxisAlignment_3, C.MainAxisAlignment_2, C.MainAxisSize_1, null);
    },
    fallback$1(context) {
      return G.IsFallbackProvider$(this.element$1(context), false);
    }
  };
  A._SignWidget.prototype = {
    build$1(context) {
      var _null = null;
      return B.Container$(C.Alignment_0_0, this.child, C.Clip_0, _null, new B.BoxDecoration(D.Color_eUx, _null, B.Border_Border$all(C.Color_vnR, -1, 2), _null, _null, _null, C.BoxShape_0), 400, _null, _null, _null);
    }
  };
  A.Sign.prototype = {
    element$1(context) {
      var t1 = B.Primitives_objectHashCode(this);
      return new A._SignWidget(this.super$SpanHoldingCode$element(context), new B.ValueKey("Sign" + t1, type$.ValueKey_String));
    }
  };
  A.Sign2Cols.prototype = {
    renderCol$3$crossAxisAlignment$spans(context, crossAxisAlignment, spans) {
      var t2,
        t1 = B._setArrayType([], type$.JSArray_Widget);
      for (t2 = J.get$iterator$ax(spans); t2.moveNext$0();)
        t1.push(t2.get$current().element$1(context));
      return B.Column$(t1, crossAxisAlignment, null, C.MainAxisAlignment_0, C.MainAxisSize_0);
    },
    renderCol$2$spans(context, spans) {
      return this.renderCol$3$crossAxisAlignment$spans(context, C.CrossAxisAlignment_2, spans);
    },
    element$1(context) {
      var _null = null,
        t1 = this.cols;
      return new A._SignWidget(B.Row$(B._setArrayType([new B.Flexible(1, C.FlexFit_1, this.renderCol$3$crossAxisAlignment$spans(context, C.CrossAxisAlignment_1, t1[0]), _null), new B.Flexible(1, C.FlexFit_1, this.renderCol$3$crossAxisAlignment$spans(context, C.CrossAxisAlignment_0, t1[1]), _null)], type$.JSArray_Widget), C.CrossAxisAlignment_3, C.MainAxisAlignment_2, C.MainAxisSize_1, _null), _null);
    }
  };
  var typesOffset = hunkHelpers.updateTypes([]);
  (function inheritance() {
    var _inheritMany = hunkHelpers.inheritMany,
      _inherit = hunkHelpers.inherit;
    _inheritMany(B.Holder, [A.IconHolder, A.Columns]);
    _inheritMany(E.SpanHoldingCode, [A.BGCodeElement, A.ArtHolder, A.Ticket, A.PollScreen, A.Sign]);
    _inherit(A._SignWidget, B.StatelessWidget);
    _inherit(A.Sign2Cols, A.Columns);
  })();
  B._Universe_addRules(init.typeUniverse, JSON.parse('{"IconHolder":{"Holder":[]},"BGCodeElement":{"SpanHoldingCode":[],"Holder":[]},"ArtHolder":{"SpanHoldingCode":[],"Holder":[]},"Ticket":{"SpanHoldingCode":[],"Holder":[]},"PollScreen":{"SpanHoldingCode":[],"Holder":[]},"Columns":{"Holder":[]},"_SignWidget":{"StatelessWidget":[],"Widget":[],"DiagnosticableTree":[]},"Sign":{"SpanHoldingCode":[],"Holder":[]},"Sign2Cols":{"Holder":[]}}'));
  var type$ = {
    JSArray_Holder: B.findType("JSArray<Holder>"),
    JSArray_List_Holder: B.findType("JSArray<List<Holder>>"),
    JSArray_Widget: B.findType("JSArray<Widget>"),
    MediaQuery: B.findType("MediaQuery"),
    ValueKey_String: B.findType("ValueKey<String>")
  };
  (function constants() {
    D.Color_eUx = new B.Color(1, 0.34901960784313724, 0.3176470588235294, 0.27058823529411763, C.ColorSpace_0);
    D.Color_oAx = new B.Color(0.5019607843137255, 0, 0, 0, C.ColorSpace_0);
    D.Color_xCN = new B.Color(0.26666666666666666, 0, 0, 0, C.ColorSpace_0);
  })();
};
;
((d, h) => {
  d[h] = d.current;
  d.eventLog.push({p: "main.dart.js_4", e: "endPart", h: h});
})($__dart_deferred_initializers__, "uI4hEyXQ6gl7p/SKAdIkZB6kg7U=");
;