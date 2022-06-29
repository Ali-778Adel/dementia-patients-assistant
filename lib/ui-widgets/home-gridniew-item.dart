import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class GridviewItem extends StatelessWidget{
  final String?imagePath;
  final String?widgetText;
  final Function()?onItemTapped;
  const GridviewItem({Key? key,this.imagePath,this.widgetText,this.onItemTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
     margin: const EdgeInsets.all(10),
     child: ClayContainer(
       curveType: CurveType.concave,
       surfaceColor: Colors.white,
       borderRadius: 15,
       depth: 15,
       spread: 10,
       child: InkWell(
         child: Column(
           children: [
             Expanded(flex: 4, child: Image.asset(imagePath!,fit: BoxFit.fill,)),
             const SizedBox(height: 5,),
             Expanded(flex: 1, child:Text('$widgetText',style:const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),)),
           ],
         ),
         onTap:onItemTapped,
       ),
     ),
   );
  }
}