import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
class CustomNeumoroTabBarContainer extends StatelessWidget {
  Widget?child;
  double?height;
  double?width;
   CustomNeumoroTabBarContainer({Key? key,this.child,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClayContainer(
      height: height,
      width: width,
      color: Colors.white,
      borderRadius: 2,
      depth: 4,
      spread: 4,
      curveType: CurveType.convex,
      child: child,
    );
  }
}
class CustomSearchContainer extends StatelessWidget {
  Widget?child;
  double?height;
  double?width;
  EdgeInsetsGeometry?margin;
  CustomSearchContainer({Key? key,this.child,this.height,this.width,this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: margin,
      child: ClayContainer(
        height: height,
        width: width,
        color: Colors.white.withOpacity(1),
        borderRadius: 20,
        depth: 80,
        spread: 4,
        curveType: CurveType.concave,
        child: child,
      ),
    );
  }
}
class PublicNeumorContainer extends StatelessWidget {
  Widget?child;
  double?height;
  double?width;
  EdgeInsetsGeometry?margin;
  PublicNeumorContainer({Key? key,this.child,this.height,this.width,this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: margin,
      child: ClayContainer(
        height: height,
        width: width,
        color: Colors.white,
        borderRadius: 12.5,
        depth: 10,
        spread: 0,
        curveType: CurveType.convex,
        child: child,
      ),
    );
  }
}