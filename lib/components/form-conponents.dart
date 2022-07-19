import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget{
  String ?containerText;
  Widget ?child;
  double?containerHeight;
  CustomContainer({Key? key, this.child,this.containerText,this.containerHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: containerHeight,
      padding:const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(5, 5),
                blurRadius: 2,
                spreadRadius: 2)
          ],
          borderRadius:BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(containerText!,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),),
          const SizedBox(height: 20,),
          child!
        ],
      ),
    );
  }


}

class CustomRadioRow extends StatelessWidget {
  String? questionText;
  Widget? blocBuilderWidget;
  int?rowNumber;

  CustomRadioRow({Key? key,this.questionText,this.blocBuilderWidget,this.rowNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * .99,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              questionText!,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: blocBuilderWidget!,
          )
        ],
      ),
    );
  }
}


class CustomRadioListTile extends StatelessWidget {
  Key?key;
  int?value;
  int ?groupValue;
  String?title;
  int?index;
  List<String>?titles;
  Function(int?val)?function;
  CustomRadioListTile({Key? key,this.value,this.groupValue,this.function,this.title,this.index,this.titles}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,width: 120,
      child: RadioListTile<int?>(
        value: value,
        groupValue: groupValue,
        onChanged:(int?val){
          function!(val!);
        },
        toggleable: true,

        activeColor:Colors.red ,
        title: Text(titles![index!],style:const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
      ),
    );
  }
}


class CustomFormHeaderText extends StatelessWidget {
  String?headerText;

  CustomFormHeaderText({Key? key,this.headerText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(headerText!,
        style:const TextStyle(
            height: 1,
            color: Colors.teal,
            fontSize: 22,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.double,
            decorationColor: Colors.red));
  }
}


