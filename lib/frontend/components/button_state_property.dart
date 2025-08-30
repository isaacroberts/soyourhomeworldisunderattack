import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/base_colors.dart';

class ButtonBackgroundColorProperty extends WidgetStateProperty<Color> {
  final Color color;
  ButtonBackgroundColorProperty(this.color);

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.error)) {
      return errorBg;
    }
    //Accessibility
    if (states.contains(WidgetState.selected)) {
      //Presumably selected by keyboard
      //Color is mixed with white
      double lf = .5;
      if (states.contains(WidgetState.pressed)) {
        //Colorize
        lf = .25;
      } else if (states.contains(WidgetState.disabled)) {
        //If disabled
//Compute same as below
        double grey = (color.r + color.g + color.b) / 3;
        //Incorporate existing button state
        grey *= (1 - lf);
        return Color.from(alpha: 1, red: grey, green: grey, blue: grey);
      }
      //Lerp to white
      return Color.lerp(color, Colors.white, lf)!.withAlpha(255);
    } else
    //Disabled
    if (states.contains(WidgetState.disabled)) {
      //Grey, matching luminance and opacity
      double grey = (color.r + color.g + color.b) / 3;

      if (states.contains(WidgetState.pressed)) {
        grey /= 2;
      } else if (states.contains(WidgetState.dragged)) {
        grey *= .75;
      }
      return Color.from(alpha: color.a, red: grey, green: grey, blue: grey);
    } else if (states.contains(WidgetState.dragged)) {
      return Color.from(
          alpha: color.a,
          red: color.r * .8,
          green: color.g * .3,
          blue: color.b * .4);
    } else if (states.contains(WidgetState.pressed)) {
      return color;
    } else if (states.contains(WidgetState.hovered)) {
      return color.withAlpha(0xdd);
    }
//Otherwise, use translucent version of button
    return color.withAlpha(0x99);
  }
}

class ButtonTextColorProperty extends WidgetStateProperty<Color> {
  final Color color;
  ButtonTextColorProperty(this.color);

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.error)) {
      return Colors.white;
    }
    //Accessibility
    if (states.contains(WidgetState.selected)) {
      return color;
    } else
    //Disabled
    if (states.contains(WidgetState.disabled)) {
      //Grey, matching luminance and opacity
      double grey = (color.r + color.g + color.b) / 3;

      if (states.contains(WidgetState.pressed)) {
        grey /= 2;
      } else if (states.contains(WidgetState.dragged)) {
        grey *= .75;
      }
      return Color.from(alpha: color.a, red: grey, green: grey, blue: grey);
    } else if (states.contains(WidgetState.dragged)) {
      return Color.from(
          alpha: color.a,
          red: color.r * .8,
          green: color.g * .3,
          blue: color.b * .4);
    } else if (states.contains(WidgetState.pressed)) {
      return color;
    } else if (states.contains(WidgetState.hovered)) {
      return color.withAlpha(0xdd);
    }
//Otherwise, use translucent version of button
    return color.withAlpha(0x99);
  }
}

class ButtonOverlayColorProperty extends WidgetStateProperty<Color> {
  final Color selectedColor;
  final Color color;
  ButtonOverlayColorProperty(
      {required this.color, required this.selectedColor});

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.error)) {
      return Colors.transparent;
    }
    //Accessibility
    if (states.contains(WidgetState.selected)) {
      //Presumably selected by keyboard
      //Color is mixed with white

      late final Color selAlpha;
      if (states.contains(WidgetState.pressed)) {
//Maximum color
        selAlpha = selectedColor.withAlpha(0x6a);
      } else if (states.contains(WidgetState.disabled)) {
        //Trying its best
        selAlpha = selectedColor.withAlpha(0x10);
      } else {
        //Normal
        selAlpha = selectedColor.withAlpha(0x2a);
      }
      //Blend onto original overlay
      return Color.alphaBlend(selAlpha, color.withAlpha(0x2a));
    } else
    //Disabled
    if (states.contains(WidgetState.disabled)) {
      //Still overlaid with color, preserving visual cohesion
      return color.withAlpha(0x1a);
    } else if (states.contains(WidgetState.dragged)) {
      return color.withAlpha(0x44);
    } else if (states.contains(WidgetState.pressed)) {
      return color.withAlpha(0x6a);
    } else if (states.contains(WidgetState.hovered)) {
      return color.withAlpha(0x2a);
    }
//Otherwise, use translucent version of button
    return color.withAlpha(0x2a);
  }
}
