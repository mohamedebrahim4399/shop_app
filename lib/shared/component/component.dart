import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type,
  final bool isSecure=false ,
  final onSubmit ,
  final onChange ,
  final onTap,
  required final validate,
  required String label,
  required Widget prefix,
  final suffix,
})=> TextFormField(
  onTap: onTap,
  controller: controller,
  obscureText: isSecure,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: prefix,
    suffixIcon: suffix,
  ),
);

Widget defaultButton({
  required final String text,
  required final function,
})=>Container(
  child: MaterialButton(
    onPressed: function,
    child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )),
  ),
  width: double.infinity,
  height: 55,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(7),
    color: Colors.blue,
  ),
);

Widget defaultTextButton({
  required final String text,
  required final function
 })=>TextButton(onPressed: function, child: Text(text.toUpperCase()),);

Future showToast({required String message,required ToastState state}){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: changeColor(state: state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastState{Error,Waring,Success}

Color changeColor({required ToastState state}){

  Color color;
  switch(state){
    case ToastState.Success:
      color =Colors.green;
      break;
    case ToastState.Error:
      color =Colors.red;
      break;
    case ToastState.Waring:
      color =Colors.yellow;
      break;
  }

  return color;
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


