// Generated by dart2js (, trust primitives, omit checks, lax runtime type, csp, intern-composite-values), the Dart to JavaScript compiler version: 3.8.0.
((s, d, e) => {
  s[d] = s[d] || {};
  s[d][e] = s[d][e] || [];
  s[d][e].push({p: "main.dart.js_87", e: "beginPart"});
})(self, "$__dart_deferred_initializers__", "eventLog");
$__dart_deferred_initializers__.current = function(hunkHelpers, init, holdersList, $) {
  var B, C,
  A = {
    _scaledPadding0(context) {
      var t1 = B.Theme_of(context).textTheme.labelLarge,
        defaultFontSize = t1 == null ? null : t1.fontSize;
      if (defaultFontSize == null)
        defaultFontSize = 14;
      t1 = B.MediaQuery__maybeOf(context, C._MediaQueryAspect_4);
      t1 = t1 == null ? null : t1.get$textScaler();
      if (t1 == null)
        t1 = C._LinearTextScaler_1;
      return B.ButtonStyleButton_scaledPadding(new B.EdgeInsets(24, 0, 24, 0), new B.EdgeInsets(12, 0, 12, 0), new B.EdgeInsets(6, 0, 6, 0), defaultFontSize * t1.textScaleFactor / 14);
    },
    _FilledButtonVariant: function _FilledButtonVariant(t0, t1) {
      this.index = t0;
      this._name = t1;
    },
    FilledButton: function FilledButton(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13) {
      var _ = this;
      _._variant = t0;
      _.onPressed = t1;
      _.onLongPress = t2;
      _.onHover = t3;
      _.onFocusChange = t4;
      _.style = t5;
      _.clipBehavior = t6;
      _.focusNode = t7;
      _.autofocus = t8;
      _.statesController = t9;
      _.isSemanticButton = t10;
      _.tooltip = t11;
      _.child = t12;
      _.key = t13;
    },
    _FilledButtonDefaultsM3: function _FilledButtonDefaultsM3(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25) {
      var _ = this;
      _.context = t0;
      _.___FilledButtonDefaultsM3__colors_FI = $;
      _.textStyle = t1;
      _.backgroundColor = t2;
      _.foregroundColor = t3;
      _.overlayColor = t4;
      _.shadowColor = t5;
      _.surfaceTintColor = t6;
      _.elevation = t7;
      _.padding = t8;
      _.minimumSize = t9;
      _.fixedSize = t10;
      _.maximumSize = t11;
      _.iconColor = t12;
      _.iconSize = t13;
      _.iconAlignment = t14;
      _.side = t15;
      _.shape = t16;
      _.mouseCursor = t17;
      _.visualDensity = t18;
      _.tapTargetSize = t19;
      _.animationDuration = t20;
      _.enableFeedback = t21;
      _.alignment = t22;
      _.splashFactory = t23;
      _.backgroundBuilder = t24;
      _.foregroundBuilder = t25;
    },
    _FilledButtonDefaultsM3_backgroundColor_closure: function _FilledButtonDefaultsM3_backgroundColor_closure(t0) {
      this.$this = t0;
    },
    _FilledButtonDefaultsM3_foregroundColor_closure: function _FilledButtonDefaultsM3_foregroundColor_closure(t0) {
      this.$this = t0;
    },
    _FilledButtonDefaultsM3_overlayColor_closure: function _FilledButtonDefaultsM3_overlayColor_closure(t0) {
      this.$this = t0;
    },
    _FilledButtonDefaultsM3_elevation_closure: function _FilledButtonDefaultsM3_elevation_closure() {
    },
    _FilledButtonDefaultsM3_iconColor_closure: function _FilledButtonDefaultsM3_iconColor_closure(t0) {
      this.$this = t0;
    },
    _FilledButtonDefaultsM3_mouseCursor_closure: function _FilledButtonDefaultsM3_mouseCursor_closure() {
    },
    _FilledTonalButtonDefaultsM3: function _FilledTonalButtonDefaultsM3(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25) {
      var _ = this;
      _.context = t0;
      _.___FilledTonalButtonDefaultsM3__colors_FI = $;
      _.textStyle = t1;
      _.backgroundColor = t2;
      _.foregroundColor = t3;
      _.overlayColor = t4;
      _.shadowColor = t5;
      _.surfaceTintColor = t6;
      _.elevation = t7;
      _.padding = t8;
      _.minimumSize = t9;
      _.fixedSize = t10;
      _.maximumSize = t11;
      _.iconColor = t12;
      _.iconSize = t13;
      _.iconAlignment = t14;
      _.side = t15;
      _.shape = t16;
      _.mouseCursor = t17;
      _.visualDensity = t18;
      _.tapTargetSize = t19;
      _.animationDuration = t20;
      _.enableFeedback = t21;
      _.alignment = t22;
      _.splashFactory = t23;
      _.backgroundBuilder = t24;
      _.foregroundBuilder = t25;
    },
    _FilledTonalButtonDefaultsM3_backgroundColor_closure: function _FilledTonalButtonDefaultsM3_backgroundColor_closure(t0) {
      this.$this = t0;
    },
    _FilledTonalButtonDefaultsM3_foregroundColor_closure: function _FilledTonalButtonDefaultsM3_foregroundColor_closure(t0) {
      this.$this = t0;
    },
    _FilledTonalButtonDefaultsM3_overlayColor_closure: function _FilledTonalButtonDefaultsM3_overlayColor_closure(t0) {
      this.$this = t0;
    },
    _FilledTonalButtonDefaultsM3_elevation_closure: function _FilledTonalButtonDefaultsM3_elevation_closure() {
    },
    _FilledTonalButtonDefaultsM3_iconColor_closure: function _FilledTonalButtonDefaultsM3_iconColor_closure(t0) {
      this.$this = t0;
    },
    _FilledTonalButtonDefaultsM3_mouseCursor_closure: function _FilledTonalButtonDefaultsM3_mouseCursor_closure() {
    }
  },
  D;
  B = holdersList[0];
  C = holdersList[2];
  A = hunkHelpers.updateHolder(holdersList[38], A);
  D = holdersList[92];
  A._FilledButtonVariant.prototype = {
    _enumToString$0() {
      return "_FilledButtonVariant." + this._name;
    }
  };
  A.FilledButton.prototype = {
    defaultStyleOf$1(context) {
      var t1, _null = null;
      switch (this._variant.index) {
        case 0:
          t1 = new A._FilledButtonDefaultsM3(context, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, C.Duration_200000, true, C.Alignment_0_0, _null, _null, _null);
          break;
        case 1:
          t1 = new A._FilledTonalButtonDefaultsM3(context, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, _null, C.Duration_200000, true, C.Alignment_0_0, _null, _null, _null);
          break;
        default:
          t1 = _null;
      }
      return t1;
    },
    themeStyleOf$1(context) {
      var t1;
      context.dependOnInheritedWidgetOfExactType$1$0(type$.FilledButtonTheme);
      t1 = B.Theme_of(context);
      return t1.filledButtonTheme.style;
    }
  };
  A._FilledButtonDefaultsM3.prototype = {
    get$_filled_button$_colors() {
      var t1, _this = this,
        value = _this.___FilledButtonDefaultsM3__colors_FI;
      if (value === $) {
        t1 = B.Theme_of(_this.context);
        _this.___FilledButtonDefaultsM3__colors_FI !== $ && B.throwUnnamedLateFieldADI();
        value = _this.___FilledButtonDefaultsM3__colors_FI = t1.colorScheme;
      }
      return value;
    },
    get$textStyle() {
      return new B.WidgetStatePropertyAll(B.Theme_of(this.context).textTheme.labelLarge, type$.WidgetStatePropertyAll_nullable_TextStyle);
    },
    get$backgroundColor() {
      return new B._WidgetStatePropertyWith(new A._FilledButtonDefaultsM3_backgroundColor_closure(this), type$._WidgetStatePropertyWith_nullable_Color);
    },
    get$foregroundColor() {
      return new B._WidgetStatePropertyWith(new A._FilledButtonDefaultsM3_foregroundColor_closure(this), type$._WidgetStatePropertyWith_nullable_Color);
    },
    get$overlayColor() {
      return new B._WidgetStatePropertyWith(new A._FilledButtonDefaultsM3_overlayColor_closure(this), type$._WidgetStatePropertyWith_nullable_Color);
    },
    get$shadowColor() {
      var t1 = this.get$_filled_button$_colors()._shadow;
      if (t1 == null)
        t1 = C.Color_vnR;
      return new B.WidgetStatePropertyAll(t1, type$.WidgetStatePropertyAll_Color);
    },
    get$surfaceTintColor() {
      return C.WidgetStatePropertyAll_G5s;
    },
    get$elevation() {
      return new B._WidgetStatePropertyWith(new A._FilledButtonDefaultsM3_elevation_closure(), type$._WidgetStatePropertyWith_double);
    },
    get$padding() {
      return new B.WidgetStatePropertyAll(A._scaledPadding0(this.context), type$.WidgetStatePropertyAll_EdgeInsetsGeometry);
    },
    get$minimumSize() {
      return C.WidgetStatePropertyAll_Size_64_40;
    },
    get$iconSize() {
      return C.WidgetStatePropertyAll_18;
    },
    get$iconColor() {
      return new B._WidgetStatePropertyWith(new A._FilledButtonDefaultsM3_iconColor_closure(this), type$._WidgetStatePropertyWith_Color);
    },
    get$maximumSize() {
      return C.WidgetStatePropertyAll_HBn;
    },
    get$shape() {
      return C.WidgetStatePropertyAll_oQi;
    },
    get$mouseCursor() {
      return new B._WidgetStatePropertyWith(new A._FilledButtonDefaultsM3_mouseCursor_closure(), type$._WidgetStatePropertyWith_nullable_MouseCursor);
    },
    get$visualDensity() {
      return B.Theme_of(this.context).visualDensity;
    },
    get$tapTargetSize() {
      return B.Theme_of(this.context).materialTapTargetSize;
    },
    get$splashFactory() {
      return B.Theme_of(this.context).splashFactory;
    }
  };
  A._FilledTonalButtonDefaultsM3.prototype = {
    get$_filled_button$_colors() {
      var t1, _this = this,
        value = _this.___FilledTonalButtonDefaultsM3__colors_FI;
      if (value === $) {
        t1 = B.Theme_of(_this.context);
        _this.___FilledTonalButtonDefaultsM3__colors_FI !== $ && B.throwUnnamedLateFieldADI();
        value = _this.___FilledTonalButtonDefaultsM3__colors_FI = t1.colorScheme;
      }
      return value;
    },
    get$textStyle() {
      return new B.WidgetStatePropertyAll(B.Theme_of(this.context).textTheme.labelLarge, type$.WidgetStatePropertyAll_nullable_TextStyle);
    },
    get$backgroundColor() {
      return new B._WidgetStatePropertyWith(new A._FilledTonalButtonDefaultsM3_backgroundColor_closure(this), type$._WidgetStatePropertyWith_nullable_Color);
    },
    get$foregroundColor() {
      return new B._WidgetStatePropertyWith(new A._FilledTonalButtonDefaultsM3_foregroundColor_closure(this), type$._WidgetStatePropertyWith_nullable_Color);
    },
    get$overlayColor() {
      return new B._WidgetStatePropertyWith(new A._FilledTonalButtonDefaultsM3_overlayColor_closure(this), type$._WidgetStatePropertyWith_nullable_Color);
    },
    get$shadowColor() {
      var t1 = this.get$_filled_button$_colors()._shadow;
      if (t1 == null)
        t1 = C.Color_vnR;
      return new B.WidgetStatePropertyAll(t1, type$.WidgetStatePropertyAll_Color);
    },
    get$surfaceTintColor() {
      return C.WidgetStatePropertyAll_G5s;
    },
    get$elevation() {
      return new B._WidgetStatePropertyWith(new A._FilledTonalButtonDefaultsM3_elevation_closure(), type$._WidgetStatePropertyWith_double);
    },
    get$padding() {
      return new B.WidgetStatePropertyAll(A._scaledPadding0(this.context), type$.WidgetStatePropertyAll_EdgeInsetsGeometry);
    },
    get$minimumSize() {
      return C.WidgetStatePropertyAll_Size_64_40;
    },
    get$iconSize() {
      return C.WidgetStatePropertyAll_18;
    },
    get$iconColor() {
      return new B._WidgetStatePropertyWith(new A._FilledTonalButtonDefaultsM3_iconColor_closure(this), type$._WidgetStatePropertyWith_Color);
    },
    get$maximumSize() {
      return C.WidgetStatePropertyAll_HBn;
    },
    get$shape() {
      return C.WidgetStatePropertyAll_oQi;
    },
    get$mouseCursor() {
      return new B._WidgetStatePropertyWith(new A._FilledTonalButtonDefaultsM3_mouseCursor_closure(), type$._WidgetStatePropertyWith_nullable_MouseCursor);
    },
    get$visualDensity() {
      return B.Theme_of(this.context).visualDensity;
    },
    get$tapTargetSize() {
      return B.Theme_of(this.context).materialTapTargetSize;
    },
    get$splashFactory() {
      return B.Theme_of(this.context).splashFactory;
    }
  };
  var typesOffset = hunkHelpers.updateTypes([]);
  A._FilledButtonDefaultsM3_backgroundColor_closure.prototype = {
    call$1(states) {
      var t1;
      if (states.contains$1(0, C.WidgetState_6)) {
        t1 = this.$this.get$_filled_button$_colors().onSurface;
        return B.Color$fromARGB(31, t1.toARGB32$0() >>> 16 & 255, t1.toARGB32$0() >>> 8 & 255, t1.toARGB32$0() & 255);
      }
      return this.$this.get$_filled_button$_colors().primary;
    },
    $signature: 5
  };
  A._FilledButtonDefaultsM3_foregroundColor_closure.prototype = {
    call$1(states) {
      var t1;
      if (states.contains$1(0, C.WidgetState_6)) {
        t1 = this.$this.get$_filled_button$_colors().onSurface;
        return B.Color$fromARGB(97, t1.toARGB32$0() >>> 16 & 255, t1.toARGB32$0() >>> 8 & 255, t1.toARGB32$0() & 255);
      }
      return this.$this.get$_filled_button$_colors().onPrimary;
    },
    $signature: 5
  };
  A._FilledButtonDefaultsM3_overlayColor_closure.prototype = {
    call$1(states) {
      if (states.contains$1(0, C.WidgetState_2))
        return this.$this.get$_filled_button$_colors().onPrimary.withOpacity$1(0.1);
      if (states.contains$1(0, C.WidgetState_0))
        return this.$this.get$_filled_button$_colors().onPrimary.withOpacity$1(0.08);
      if (states.contains$1(0, C.WidgetState_1))
        return this.$this.get$_filled_button$_colors().onPrimary.withOpacity$1(0.1);
      return null;
    },
    $signature: 32
  };
  A._FilledButtonDefaultsM3_elevation_closure.prototype = {
    call$1(states) {
      if (states.contains$1(0, C.WidgetState_6))
        return 0;
      if (states.contains$1(0, C.WidgetState_2))
        return 0;
      if (states.contains$1(0, C.WidgetState_0))
        return 1;
      if (states.contains$1(0, C.WidgetState_1))
        return 0;
      return 0;
    },
    $signature: 129
  };
  A._FilledButtonDefaultsM3_iconColor_closure.prototype = {
    call$1(states) {
      var t1, _this = this;
      if (states.contains$1(0, C.WidgetState_6)) {
        t1 = _this.$this.get$_filled_button$_colors().onSurface;
        return B.Color$fromARGB(97, t1.toARGB32$0() >>> 16 & 255, t1.toARGB32$0() >>> 8 & 255, t1.toARGB32$0() & 255);
      }
      if (states.contains$1(0, C.WidgetState_2))
        return _this.$this.get$_filled_button$_colors().onPrimary;
      if (states.contains$1(0, C.WidgetState_0))
        return _this.$this.get$_filled_button$_colors().onPrimary;
      if (states.contains$1(0, C.WidgetState_1))
        return _this.$this.get$_filled_button$_colors().onPrimary;
      return _this.$this.get$_filled_button$_colors().onPrimary;
    },
    $signature: 5
  };
  A._FilledButtonDefaultsM3_mouseCursor_closure.prototype = {
    call$1(states) {
      if (states.contains$1(0, C.WidgetState_6))
        return C.SystemMouseCursor_basic;
      return C.SystemMouseCursor_click;
    },
    $signature: 36
  };
  A._FilledTonalButtonDefaultsM3_backgroundColor_closure.prototype = {
    call$1(states) {
      var t1, t2;
      if (states.contains$1(0, C.WidgetState_6)) {
        t1 = this.$this.get$_filled_button$_colors().onSurface;
        return B.Color$fromARGB(31, t1.toARGB32$0() >>> 16 & 255, t1.toARGB32$0() >>> 8 & 255, t1.toARGB32$0() & 255);
      }
      t1 = this.$this.get$_filled_button$_colors();
      t2 = t1._secondaryContainer;
      return t2 == null ? t1.secondary : t2;
    },
    $signature: 5
  };
  A._FilledTonalButtonDefaultsM3_foregroundColor_closure.prototype = {
    call$1(states) {
      var t1, t2;
      if (states.contains$1(0, C.WidgetState_6)) {
        t1 = this.$this.get$_filled_button$_colors().onSurface;
        return B.Color$fromARGB(97, t1.toARGB32$0() >>> 16 & 255, t1.toARGB32$0() >>> 8 & 255, t1.toARGB32$0() & 255);
      }
      t1 = this.$this.get$_filled_button$_colors();
      t2 = t1._onSecondaryContainer;
      return t2 == null ? t1.onSecondary : t2;
    },
    $signature: 5
  };
  A._FilledTonalButtonDefaultsM3_overlayColor_closure.prototype = {
    call$1(states) {
      var t1, t2;
      if (states.contains$1(0, C.WidgetState_2)) {
        t1 = this.$this.get$_filled_button$_colors();
        t2 = t1._onSecondaryContainer;
        return (t2 == null ? t1.onSecondary : t2).withOpacity$1(0.1);
      }
      if (states.contains$1(0, C.WidgetState_0)) {
        t1 = this.$this.get$_filled_button$_colors();
        t2 = t1._onSecondaryContainer;
        return (t2 == null ? t1.onSecondary : t2).withOpacity$1(0.08);
      }
      if (states.contains$1(0, C.WidgetState_1)) {
        t1 = this.$this.get$_filled_button$_colors();
        t2 = t1._onSecondaryContainer;
        return (t2 == null ? t1.onSecondary : t2).withOpacity$1(0.1);
      }
      return null;
    },
    $signature: 32
  };
  A._FilledTonalButtonDefaultsM3_elevation_closure.prototype = {
    call$1(states) {
      if (states.contains$1(0, C.WidgetState_6))
        return 0;
      if (states.contains$1(0, C.WidgetState_2))
        return 0;
      if (states.contains$1(0, C.WidgetState_0))
        return 1;
      if (states.contains$1(0, C.WidgetState_1))
        return 0;
      return 0;
    },
    $signature: 129
  };
  A._FilledTonalButtonDefaultsM3_iconColor_closure.prototype = {
    call$1(states) {
      var t1, t2, _this = this;
      if (states.contains$1(0, C.WidgetState_6)) {
        t1 = _this.$this.get$_filled_button$_colors().onSurface;
        return B.Color$fromARGB(97, t1.toARGB32$0() >>> 16 & 255, t1.toARGB32$0() >>> 8 & 255, t1.toARGB32$0() & 255);
      }
      if (states.contains$1(0, C.WidgetState_2)) {
        t1 = _this.$this.get$_filled_button$_colors();
        t2 = t1._onSecondaryContainer;
        return t2 == null ? t1.onSecondary : t2;
      }
      if (states.contains$1(0, C.WidgetState_0)) {
        t1 = _this.$this.get$_filled_button$_colors();
        t2 = t1._onSecondaryContainer;
        return t2 == null ? t1.onSecondary : t2;
      }
      if (states.contains$1(0, C.WidgetState_1)) {
        t1 = _this.$this.get$_filled_button$_colors();
        t2 = t1._onSecondaryContainer;
        return t2 == null ? t1.onSecondary : t2;
      }
      t1 = _this.$this.get$_filled_button$_colors();
      t2 = t1._onSecondaryContainer;
      return t2 == null ? t1.onSecondary : t2;
    },
    $signature: 5
  };
  A._FilledTonalButtonDefaultsM3_mouseCursor_closure.prototype = {
    call$1(states) {
      if (states.contains$1(0, C.WidgetState_6))
        return C.SystemMouseCursor_basic;
      return C.SystemMouseCursor_click;
    },
    $signature: 36
  };
  (function inheritance() {
    var _inherit = hunkHelpers.inherit,
      _inheritMany = hunkHelpers.inheritMany;
    _inherit(A._FilledButtonVariant, B._Enum);
    _inherit(A.FilledButton, B.ButtonStyleButton);
    _inheritMany(B.ButtonStyle, [A._FilledButtonDefaultsM3, A._FilledTonalButtonDefaultsM3]);
    _inheritMany(B.Closure, [A._FilledButtonDefaultsM3_backgroundColor_closure, A._FilledButtonDefaultsM3_foregroundColor_closure, A._FilledButtonDefaultsM3_overlayColor_closure, A._FilledButtonDefaultsM3_elevation_closure, A._FilledButtonDefaultsM3_iconColor_closure, A._FilledButtonDefaultsM3_mouseCursor_closure, A._FilledTonalButtonDefaultsM3_backgroundColor_closure, A._FilledTonalButtonDefaultsM3_foregroundColor_closure, A._FilledTonalButtonDefaultsM3_overlayColor_closure, A._FilledTonalButtonDefaultsM3_elevation_closure, A._FilledTonalButtonDefaultsM3_iconColor_closure, A._FilledTonalButtonDefaultsM3_mouseCursor_closure]);
  })();
  B._Universe_addRules(init.typeUniverse, JSON.parse('{"FilledButton":{"StatefulWidget":[],"Widget":[],"DiagnosticableTree":[]},"_FilledButtonDefaultsM3":{"ButtonStyle":[]},"_FilledTonalButtonDefaultsM3":{"ButtonStyle":[]},"FilledButtonTheme":{"InheritedTheme":[],"InheritedWidget":[],"ProxyWidget":[],"Widget":[],"DiagnosticableTree":[]}}'));
  var type$ = {
    FilledButtonTheme: B.findType("FilledButtonTheme"),
    WidgetStatePropertyAll_Color: B.findType("WidgetStatePropertyAll<Color>"),
    WidgetStatePropertyAll_EdgeInsetsGeometry: B.findType("WidgetStatePropertyAll<EdgeInsetsGeometry>"),
    WidgetStatePropertyAll_nullable_TextStyle: B.findType("WidgetStatePropertyAll<TextStyle?>"),
    _WidgetStatePropertyWith_Color: B.findType("_WidgetStatePropertyWith<Color>"),
    _WidgetStatePropertyWith_double: B.findType("_WidgetStatePropertyWith<double>"),
    _WidgetStatePropertyWith_nullable_Color: B.findType("_WidgetStatePropertyWith<Color?>"),
    _WidgetStatePropertyWith_nullable_MouseCursor: B.findType("_WidgetStatePropertyWith<MouseCursor0?>")
  };
  (function constants() {
    D._FilledButtonVariant_0 = new A._FilledButtonVariant(0, "filled");
    D._FilledButtonVariant_1 = new A._FilledButtonVariant(1, "tonal");
  })();
};
;
((d, h) => {
  d[h] = d.current;
  d.eventLog.push({p: "main.dart.js_87", e: "endPart", h: h});
})($__dart_deferred_initializers__, "3eNO0JvgBzaypLS16AAza6U+G+Q=");
;