import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-button.dart';
@immutable
class MapDestinationConfirmWidget extends StatelessWidget{
  final String?destinationAddress;
  final Function()?onConfirmTapped;
  final Function ()?onResetDistenationTapped;
  const MapDestinationConfirmWidget({
    Key?key ,
    this.destinationAddress,
    this.onConfirmTapped,
    this.onResetDistenationTapped
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
     const SizedBox(height: 5,),
      Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            border:Border.all(color: Colors.grey,width: .5),
            borderRadius:const BorderRadius.all(Radius.circular(20))
        )
        ,child: Text.rich(TextSpan(
          text: 'destination is :\n',
          style:const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 20
          ),children: [
        TextSpan(
            text:destinationAddress,
            style:const TextStyle(
                fontSize: 18,
                color:Colors.black,
                fontWeight: FontWeight.w400
            )
        )
      ]
      ),),
      ),
     const SizedBox(height: 50,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomBottomSheetButton(
          width: MediaQuery.of(context).size.width*.40,
          text: 'Confirm',
          textColor: Colors.blue,
          borderColor: Colors.blue,
            shadowDarkColor: Colors.white,
            function: onConfirmTapped,
          ),
          const SizedBox(width: 5,),
          Expanded(
            child: CustomBottomSheetButton(
              width: MediaQuery.of(context).size.width*.40,
              text: 'Select new destination',
              textColor: Colors.blue,
              borderColor: Colors.blue,
              shadowDarkColor: Colors.white,
              function: onResetDistenationTapped,
            ),
          ),

        ],
      )
    ],
  );
  }

}