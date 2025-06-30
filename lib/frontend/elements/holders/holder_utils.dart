import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import 'holder_base.dart';
import 'span_holding_code.dart';

class HolderUtils {
  static String stripOutTextFromFrags(List<FragOfText> frags) {
    String text = '';
    for (FragOfText f in frags) {
      if (f is FragBody) {
        text += f.text;
      }
    }
    return text;
  }

  static String stripOutText(List<Holder> holders) {
    String text = '';
    for (Holder h in holders) {
      if (h is TextHolder) {
        text += h.text;
        text += '\n';
      } else if (h is SpanOfText) {
        text += stripOutTextFromFrags(h.spans);
        text += '\n';
      } else if (h is SpanHoldingCode) {
        text += stripOutText(h.spans);
        text += '\n';
      }
    }
    return text;
  }
}
