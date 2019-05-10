import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget for inputting content with a fixed length, visually treating each
/// character as a separate segment.
///
/// ## Sample code
///
/// ```dart
/// CodeInput(
///   length: 4,
///   keyboardType: TextInputType.number,
///   builder: CodeInputBuilders.lightCircle(),
///   onFilled: (value) => print('Your input is $value.'),
/// )
/// ```
///
/// See also:
///
/// * [TextField], an input where the characters aren't separated from each
///   other.
typedef CodeInputBuilder = Widget Function(bool hasFocus, String char);

class CodeInput extends StatefulWidget {
  const CodeInput._({
    Key key,
    @required this.length,
    @required this.keyboardType,
    @required this.inputFormatters,
    @required this.builder,
    this.onChanged,
    this.onFilled,
  }) : super(key: key);

  factory CodeInput({
    Key key,
    @required int length,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter> inputFormatters,
    @required CodeInputBuilder builder,
    void Function(String value) onChanged,
    void Function(String value) onFilled,
  }) {
    assert(length != null);
    assert(length > 0, 'The length needs to be larger than zero.');
    assert(length.isFinite, 'The length needs to be finite.');
    assert(keyboardType != null);
    assert(builder != null,
        'The builder is required for rendering the character segments.');

    inputFormatters ??= _createInputFormatters(length, keyboardType);

    return CodeInput._(
      key: key,
      length: length,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      builder: builder,
      onChanged: onChanged,
      onFilled: onFilled,
    );
  }

  /// The length of character entities to always display.
  ///
  /// ## Sample code
  ///
  /// A code input with 4 characters:
  ///
  /// ```dart
  /// CodeInput(length: 4)
  /// ```
  final int length;

  /// The type of thconstard which shows up.
  ///
  /// ## Sample codeconst
  ///
  /// ```dart
  /// CodeInput(keyboardType: TextInputType.number)
  /// ```
  final TextInputType keyboardType;

  /// A list of input formatters which can validate the text as it is being
  /// typed.
  ///
  /// If you specify this parameter, the default input formatters aren't used,
  /// so make sure you really check for everything (like length of the input).
  ///
  /// ## Sample code
  ///
  /// An code input that displays a normal keyboard but only allows for
  /// hexadecimal input:
  ///
  /// ```dart
  /// CodeInput(
  ///   inputFormatters: [
  ///     WhitelistingTextInputFormatter(RegExp('^[0-9a-fA-F]*\$'))
  ///   ]
  /// )
  /// ```
  final List<TextInputFormatter> inputFormatters;

  /// A builder for the character entities.
  ///
  /// See [CodeInputBuilders] for examples.
  final CodeInputBuilder builder;

  /// A callback for changes to the input.
  final void Function(String value) onChanged;

  /// A callback for when the input is filled.
  final void Function(String value) onFilled;

  /// A helping function that creates input formatters for a given length and
  /// keyboardType.
  static List<TextInputFormatter> _createInputFormatters(
      int length, TextInputType keyboardType) {
    final formatters = <TextInputFormatter>[
      LengthLimitingTextInputFormatter(length)
    ];

    // Add keyboard specific formatters.
    // For example, a code input with a number keyboard type probably doesn't
    // want to allow decimal separators or signs.
    if (keyboardType == TextInputType.number) {
      formatters.add(WhitelistingTextInputFormatter(RegExp('^[0-9]*\$')));
    }

    return formatters;
  }

  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  final node = FocusNode();
  final controller = TextEditingController();

  String get text => controller.text;

  @override
  Widget build(BuildContext context) {
    // We'll display the visual widget and a not shown EditableText for doing
    // the actual work on top of each other.
    return Stack(children: <Widget>[
      // This is the actual EditableText wrapped in a Container with zero
      // dimensions.
      Container(
          width: 0.0,
          height: 0.0,
          child: EditableText(
            obscureText: true,
            controller: controller,
            focusNode: node,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            backgroundCursorColor: Colors.black,
            style: TextStyle(),
            // Doesn't really matter.
            cursorColor: Colors.black,
            // Doesn't really matter.
            onChanged: (value) => setState(() {
                  widget.onChanged?.call(value);
                  if (value.length == widget.length) {
                    widget.onFilled?.call(value);
                  }
                }),
          )),
      // These are the actual character widgets. A transparent container lies
      // right below the gesture detector, so all taps get collected, even
      // the ones between the character entities.
      GestureDetector(
          onTap: () {
            final focusScope = FocusScope.of(context);
            focusScope.requestFocus(FocusNode());
            Future.delayed(Duration.zero, () => focusScope.requestFocus(node));
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.length, (i) {
                final hasFocus = controller.selection.start == i;
                final char = i < text.length ? text[i] : '';
                final characterEntity = widget.builder(hasFocus, char);

                assert(
                    characterEntity != null,
                    'The builder for the character entity at position $i '
                    'returned null. It did${hasFocus ? ' not' : ''} have the '
                    'focus and the character passed to it was \'$char\'.');

                return characterEntity;
              }),
            ),
          )),
    ]);
  }
}

/// An abstract class that provides some commonly-used builders for the
/// character entities.
///
/// * [containerized]: A builder putting chars in an animated container.
/// * [circle]: A builder putting chars in circles.
/// * [lightCircle]: A builder putting chars in light circles.
/// * [darkCircle]: A builder putting chars in dark circles.
abstract class CodeInputBuilders {
  /// Builds the input inside an animated container.
  static CodeInputBuilder containerized({
    Duration animationDuration = const Duration(milliseconds: 50),
    @required Size totalSize,
    @required Size emptySize,
    @required Size filledSize,
    @required BoxDecoration emptyDecoration,
    @required BoxDecoration filledDecoration,
    bool obscureText = false,
  }) {
    return (bool hasFocus, String char) => Container(
        width: totalSize.width,
        height: totalSize.height,
        alignment: Alignment.center,
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: char.isEmpty ? emptyDecoration : filledDecoration,
            width: char.isEmpty ? emptySize.width : filledSize.width,
            height: char.isEmpty ? emptySize.height : filledSize.height,
            alignment: Alignment.center,
            child: _buildContent(char, obscureText)));
  }

  static _buildContent(String char,bool obscureText){
    if (obscureText) {
     return Icon(Icons.radio_button_checked,
                color: char.isEmpty ? Colors.transparent : Colors.white);
    } else {
      return Text(char,
              style: char.isEmpty ? TextStyle(fontSize: 0.0) : TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.normal));
    }
  }

  /// Builds the input inside a circle.
  static CodeInputBuilder circle(
      {double totalRadius = 25.0,
      double emptyRadius = 10.0,
      double filledRadius = 20.0,
      @required Border border,
      @required Color color,
      bool obscureText = false}) {
    final decoration = BoxDecoration(
      shape: BoxShape.circle,
      border: border,
      color: color,
    );

    return containerized(
        totalSize: Size.fromRadius(totalRadius),
        emptySize: Size.fromRadius(emptyRadius),
        filledSize: Size.fromRadius(filledRadius),
        emptyDecoration: decoration,
        filledDecoration: decoration,
        obscureText: obscureText);
  }

  /// Builds the input inside a light circle.
  static CodeInputBuilder lightCircle({
    double totalRadius = 25.0,
    double emptyRadius = 10.0,
    double filledRadius = 20.0,
    bool obscureText = false
  }) {
    return circle(
        totalRadius: totalRadius,
        emptyRadius: emptyRadius,
        filledRadius: filledRadius,
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.white10,
        obscureText: obscureText);
  }

  /// Builds the input inside a light circle.
  static CodeInputBuilder darkCircle({
    double totalRadius = 25.0,
    double emptyRadius = 10.0,
    double filledRadius = 20.0,
    bool obscureText = false
  }) {
    return circle(
        totalRadius: totalRadius,
        emptyRadius: emptyRadius,
        filledRadius: filledRadius,
        border: Border.all(color: Colors.black, width: 1.0),
        color: Colors.black12,
        obscureText: obscureText);
  }
}
