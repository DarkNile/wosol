import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../constants/style/colors.dart';
import '../../constants/style/fonts.dart';

enum TextFieldValidation {
  normal,
  valid,
  notValid,
}

class EmailTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;

  // final double validatePadding;
  final String hint;
  final String label;
  final String validateText;
  final bool enabled;
  final bool isWithIcon;

  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function(String value)? onSubmit;
  final Function(String value)? onChange;
  final Function()? onTap;
  final TextCapitalization textCapitalization;
  final TextFieldValidation fieldValidation;
  final Iterable<String>? autofill;
  final Function(PointerDownEvent)? onTapOutside;
  final InputBorder? border;

  const EmailTextField({
    super.key,
    this.focusNode,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.autofill,
    this.border,
    this.hint = "example@email.com",
    this.textInputAction = TextInputAction.next,
    // this.validatePadding = 20,
    this.enabled = true,
    this.isWithIcon = true,
    required this.controller,
    this.validateText = 'This email is invalid',
    required this.onSubmit,
    this.onChange,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    required this.fieldValidation,
    this.label = "Email",
    this.onTapOutside,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isTextFieldEmpty = (widget.controller.text.isEmpty ||
            widget.controller.text.trim() == "");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: AppConstants.edge(
              padding: EdgeInsets.only(
                top: widget.marginTop,
                bottom: widget.marginBottom,
                right: widget.marginRight,
                left: widget.marginLeft,
              ),
            ),
            padding: const EdgeInsets.only(top: 4),
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              minLines: null,
              focusNode: widget.focusNode,
              onChanged: widget.onChange,
              onTapOutside: (pointerDownEvent) {
                widget.onTapOutside;
                FocusManager.instance.primaryFocus?.unfocus();
              },
              autocorrect: false,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              onFieldSubmitted: widget.onSubmit,
              autofillHints: widget.autofill,
              style:
                  AppFonts.small.copyWith(fontSize: 14, color: AppColors.logo),
              controller:
                  widget.enabled ? widget.controller : TextEditingController(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: !(widget.enabled)
                    ? AppColors.darkBlue200
                    : isTextFieldEmpty
                        ? AppColors.white
                        : AppColors.orange50,
                prefixIcon: widget.isWithIcon
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          'assets/icons/sms.svg',
                          width: 24,
                          height: 24,
                          colorFilter: isTextFieldEmpty
                              ? null
                              : const ColorFilter.mode(
                                  AppColors.logo, BlendMode.srcIn),
                        ),
                      )
                    : null,
                labelText: widget.label,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: AppFonts.medium.copyWith(
                  fontSize: 12,
                  color: AppColors.darkBlue500Base,
                ),
                hintText: widget.hint,
                hintStyle: AppFonts.small.copyWith(
                  fontSize: 16,
                  color: AppColors.darkBlue400,
                ),
                contentPadding: AppConstants.edge(
                    padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                )),
                disabledBorder: widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue200,
                      ),
                    ),
                border: widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue200,
                      ),
                    ),
                focusedBorder: widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.logo,
                      ),
                    ),
                enabled: widget.enabled,
                filled: true,
                enabledBorder:
                    (widget.fieldValidation == TextFieldValidation.notValid)
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.logo,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          )
                        : widget.border ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.darkBlue200,
                              ),
                            ),
              ),
            ),
          ),
          if (widget.fieldValidation == TextFieldValidation.notValid)
            Padding(
              padding: AppConstants.edge(
                  padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 8,
              )),
              child: Text(
                widget.validateText,
                style: AppFonts.small.copyWith(
                  fontSize: 14,
                  color: AppColors.logo,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextFieldValidation fieldValidation;
  final bool enabled;
  final bool signup;
  final double marginRight;
  final double marginLeft;
  final double marginTop;
  final double marginBottom;
  final String? validateText;
  final String? hintText;

  final Function()? onTextFieldTap;
  final FocusNode? focusNode;
  final String label;
  final double validatePadding;
  final double hintTextSize;
  final Function(String value) onSubmit;
  final Function(String value) onChange;
  final Iterable<String>? autofill;
  final Color suffixIconColor;
  final Function(PointerDownEvent)? onTapOutside;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.fieldValidation,
    this.suffixIconColor = AppColors.black,
    this.enabled = true,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.validateText,
    this.validatePadding = 20,
    this.hintTextSize = 16,
    this.signup = false,
    this.onTextFieldTap,
    this.focusNode,
    this.hintText,
    this.autofill,
    this.label = "Password",
    this.onTapOutside,
    required this.onSubmit,
    required this.onChange,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isTextFieldEmpty = true;
  bool isObscureText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isTextFieldEmpty = (widget.controller.text.isEmpty ||
            widget.controller.text.trim() == "");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: widget.onTextFieldTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: AppConstants.edge(
                padding: EdgeInsets.only(
              right: widget.marginRight,
              left: widget.marginLeft,
              top: widget.marginTop,
              bottom: widget.marginBottom,
            )),
            padding: const EdgeInsets.only(top: 4),
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
              onChanged: widget.onChange,
              onTapOutside: (pointerDownEvent) {
                widget.onTapOutside;
                FocusManager.instance.primaryFocus?.unfocus();
              },
              textInputAction: TextInputAction.done,
              obscuringCharacter: '●',
              onFieldSubmitted: widget.onSubmit,
              obscureText: isObscureText,
              autofillHints: widget.autofill,
              style:
                  AppFonts.small.copyWith(fontSize: 14, color: AppColors.logo),
              controller:
                  widget.enabled ? widget.controller : TextEditingController(),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: !(widget.enabled)
                    ? AppColors.darkBlue200
                    : isTextFieldEmpty
                        ? AppColors.white
                        : AppColors.orange50,
                labelText: widget.label,
                labelStyle: AppFonts.medium.copyWith(
                  fontSize: 12,
                  color: AppColors.darkBlue500Base,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Padding(
                  padding: AppConstants.edge(
                      padding: const EdgeInsets.only(right: 12)),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: SvgPicture.asset("assets/icons/eye.svg"),
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    color: AppColors.black,
                  ),
                ),
                prefixIcon: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    'assets/icons/lock.svg',
                    width: 24,
                    height: 24,
                    colorFilter: isTextFieldEmpty
                        ? null
                        : const ColorFilter.mode(
                            AppColors.logo, BlendMode.srcIn),
                  ),
                ),
                hintText: widget.hintText ?? "Password",
                hintStyle: AppFonts.small.copyWith(
                  fontSize: widget.hintTextSize,
                  color: AppColors.darkBlue400,
                ),
                contentPadding: AppConstants.edge(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 18,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.logo,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.logo,
                  ),
                ),
                enabled: widget.enabled,
                filled: true,
                enabledBorder:
                    (widget.fieldValidation == TextFieldValidation.notValid)
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.logo,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          )
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.darkBlue200,
                            ),
                          ),
              ),
            ),
          ),
          if (widget.fieldValidation == TextFieldValidation.notValid &&
              widget.validateText != null)
            Align(
              alignment: AppConstants.localizationController
                          .currentLocale()
                          .languageCode ==
                      'en'
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Padding(
                padding: AppConstants.edge(
                    padding: EdgeInsets.only(
                  left: widget.validatePadding,
                  right: widget.validatePadding,
                  top: 8,
                )),
                child: Text(
                  widget.validateText ?? '',
                  style: AppFonts.small.copyWith(
                    fontSize: 14,
                    color: AppColors.logo,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;
  final double validatePadding;
  final String hint;
  final String label;
  final bool validate;
  final bool isNameValid;
  final String validateText;
  final bool enabled;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;
  final Function(String value)? onSubmit;
  final Function(String value)? onChange;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onTap;
  final Widget? icon;
  final Widget? prefixIcon;
  final double? height;
  final double? width;
  final Color fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool isWithValidationMsg;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final EdgeInsets? contentPadding;
  final bool? readOnly;
  final bool isObscureText;
  final bool expands;

  const CustomTextField({
    super.key,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.readOnly = false,
    this.hint = "name",
    this.textInputAction = TextInputAction.next,
    required this.validate,
    this.isNameValid = false,
    this.validatePadding = 20,
    this.enabled = true,
    required this.textEditingController,
    this.validateText = 'This name is already in use',
    required this.onSubmit,
    this.onTapOutside,
    this.textInputType = TextInputType.text,
    this.onChange,
    this.onTap,
    this.border,
    this.prefixIcon,
    this.icon,
    this.contentPadding,
    this.height = 58,
    this.width,
    this.inputFormatters,
    this.fillColor = AppColors.white,
    this.focusNode,
    this.hintStyle,
    this.isWithValidationMsg = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.isObscureText = false,
    required this.label,
    required this.expands,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.edge(
          padding: EdgeInsets.only(
        top: marginTop,
        bottom: marginBottom,
        left: marginLeft,
        right: marginRight,
      )),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: height,
              padding: const EdgeInsets.only(top: 4),
              width: width ?? double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: TextFormField(
                expands: expands,
                maxLines: null,
                // minLines: null,
                onTap: onTap,
                readOnly: readOnly ?? false,
                focusNode: focusNode,
                showCursor: focusNode != null ? focusNode!.hasFocus : null,
                inputFormatters: inputFormatters,
                onChanged: onChange,
                textInputAction: textInputAction,
                onFieldSubmitted: onSubmit,
                style: AppFonts.small.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
                controller: textEditingController,
                keyboardType: textInputType,
                onTapOutside: (pointerDownEvent) {
                  onTapOutside;
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: AppFonts.medium
                      .copyWith(color: AppColors.darkBlue500Base, fontSize: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  //suffixIcon: SvgPicture.asset("assets/icons/eye.svg"),
                  prefixIcon: prefixIcon,
                  prefixIconConstraints: const BoxConstraints(),
                  hintText: hint,
                  hintStyle: hintStyle ??
                      AppFonts.small.copyWith(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                  contentPadding: contentPadding ??
                      AppConstants.edge(
                          padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 12,
                        bottom: 16,
                      )),
                  border: border ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.logo,
                        ),
                      ),
                  focusedBorder: border ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.logo,
                        ),
                      ),
                  fillColor: fillColor,
                  enabled: enabled,
                  filled: true,
                  enabledBorder: (!validate)
                      ? OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.logo,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        )
                      : border ??
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.logo,
                            ),
                          ),
                ),
              ),
            ),
            if (!validate && isWithValidationMsg)
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  validateText,
                  style: AppFonts.small.copyWith(
                    fontSize: 14,
                    color: AppColors.logo,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
