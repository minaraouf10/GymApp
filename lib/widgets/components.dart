import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultFormField(
        { TextEditingController controller,
         TextInputType type,
        bool isPassword = false,
        ValueChanged<String> onSubmitted,
        ValueChanged<String> onChanged,
        GestureTapCallback onTap,
         FormFieldValidator<String> validate,
         String label,
         IconData prefix,
        IconData suffix,
        VoidCallback suffixPressed,
        bool isClickable = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null

            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background =const Color(0xFFFE7C7C),
  bool isUpperCase = true,
   Function() function,
   String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton({
   VoidCallback function,
   String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );


void showToast({
   String text,
   ToastState state
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState {SUCCESS,ERROR,WARRING}

Color chooseToastColor (ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color =Colors.green;
      break;
    case ToastState.ERROR:
      color =Colors.red;
      break;
    case ToastState.WARRING:
      color =Colors.amber;
      break;
  }

  return color;
}
