
// ignore_for_file: file_names

import 'package:camera/camera.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/face-detection/camera-view.dart';
import 'package:untitled/face-detection/face-detector-printer.dart';
import 'package:untitled/models/database-model.dart';
import 'package:untitled/tflite/ui/camera_view.dart';

import '../components/neu-text.dart';

class FaceDetectorPage extends StatefulWidget{
  const FaceDetectorPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState()=>FaceDetectorState();

}

class FaceDetectorState extends State<FaceDetectorPage>{
  final FaceDetector faceDetector=FaceDetector(options:FaceDetectorOptions(
    enableTracking: true,
    enableContours: true,
    enableClassification: true,
  ));

  @override
  initState(){
    getDataFromFaceData();
    super.initState();
  }
  bool canProcess=true;
  bool isBusy=false;
  CustomPaint?customPaint;
  String text='';
  @override
  void dispose() {
    canProcess=false;
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [

        FDCameraView(
          title: 'face detector',
          customPaint: customPaint,
          text: 'text',
          initialDirection: CameraLensDirection.front,
          onImage: (inputImage){
            processImage(inputImage);
          },
          facedetected:detected,
        ),
      ],
    );
  }
  bool detected=true;
  Future<void> processImage(final InputImage inputImage)async{
  if(!canProcess)return ;
  if(isBusy) return;
  isBusy=true;
  setState((){
    text="can't recognize this face ";
  });
  final faces=await faceDetector.processImage(inputImage);
        if(faces.isNotEmpty){
           detected==true;
        }else{
           detected==false;
        }



  if(inputImage.inputImageData?.size !=null&&inputImage .inputImageData?.imageRotation!=null){
     final painter=FaceDetectorPrinter(
       faces,
       inputImage.inputImageData!.size,
       inputImage.inputImageData!.imageRotation
     );
     customPaint=CustomPaint(painter: painter,);
  }else{
    String txt='faces found :${faces.length}\n\n';
    for(final face in faces){
      txt +='face${face.boundingBox}\n\n';
    }
    text=txt;
    customPaint=null;
  }
  isBusy=false;
  if(mounted){
    setState((){});
  }

  print('face data is55555555555555555556666666666666666666666655555555555555555555555666666666666666  ${faces[0].headEulerAngleX}');
  print('face data is55555555555555555556666666666666666666666655555555555555555555555666666666666666  ${faces[0].headEulerAngleZ}');
  print('face data is55555555555555555556666666666666666666666655555555555555555555555666666666666666  ${faces[0].headEulerAngleY}');
  print('face data is55555555555555555556666666666666666666666655555555555555555555555666666666666666  ${faces[0].contours[FaceContourType.leftEyebrowTop]!.points.toList()}');
    String eyeData =faces[0].contours[FaceContourType.leftEyebrowTop.name]!.points.toList().toString();
  print('face data is55555555555555555556666666666666666666666655555555555555555555555666666666666666String   $eyeData');
 print('new data is ${faces[0].contours[FaceContourType.face]!.points}');
  print ('comparision 1 is %%%%%%%%%%${faces[0].contours[FaceContourType.face]!.points.toList().toString()}');
  // addFaceDataToDatabase(
  //   facePoints:faces[0].contours[FaceContourType.face]!.points.toList().toString(),
  //   leftEyebrowTop: faces[0].contours[FaceContourType.leftEyebrowTop]!.points.toList().toString(),
  //   leftEyebrowBottom: faces[0].contours[FaceContourType.leftEyebrowBottom]!.points.toList().toString(),
  //   rightEyebrowTop: faces[0].contours[FaceContourType.rightEyebrowTop]!.points.toList().toString(),
  //   rightEyebrowBottom: faces[0].contours[FaceContourType.rightEyebrowBottom]!.points.toList().toString(),
  //   leftEye: faces[0].contours[FaceContourType.leftEye]!.points.toList().toString(),
  //   rightEye: faces[0].contours[FaceContourType.rightEye]!.points.toList().toString(),
  //   // upperLipBottom: faces[0].contours[FaceContourType.upperLipBottom]!.points.toList().toString(),
  //   lowerLipTop: faces[0].contours[FaceContourType.lowerLipTop]!.points.toList().toString()
  //
  // );

    if(faces[0].contours[FaceContourType.leftEyebrowTop]!.points.toList().isNotEmpty){
      await faceDataTable.select().toList().then((value) {
        for(int i=0;i<value.length;i++){
          if(value[0].facePoints==faces[faces.length].contours[FaceContourType.face]!.points.toList().toString()){

            print('right ^^^^^^^{}{}{}{}{}{}{}{}{}{}^^^^^^^^^^^^^^^^^^^^^^^^^^^^{}{}{}{}{}{}{}{}{}^^^^^^^^^^^^^^^^{}{}{}{}{}{}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          }else{
            print ('comparision 2 is %%%%%%%%%%${value[0].facePoints}');

            print('false ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          }
        }
      });
    }

  }
  FaceDataTable faceDataTable=FaceDataTable();
  Future addFaceDataToDatabase({
     String?facePoints,
     String?leftEyebrowTop,
     String?leftEyebrowBottom,
     String?rightEyebrowTop,
     String?rightEyebrowBottom,
     String?leftEye,
     String?rightEye,
     String?upperLipTop,
     // String?upperLipBottom,
     String?lowerLipTop,
     // String?lowerLipBottom,
})async{
faceDataTable.facePoints=facePoints;
faceDataTable.leftEyebrowTop=leftEyebrowTop;
faceDataTable.leftEyebrowBottom=leftEyebrowBottom;
faceDataTable.rightEyebrowTop=rightEyebrowTop;
faceDataTable.rightEyebrowBottom=rightEyebrowBottom;
faceDataTable.leftEye=leftEye;
faceDataTable.rightEye=rightEye;
faceDataTable.upperLipTop=upperLipTop;
faceDataTable.lowerLipTop=lowerLipTop;
await faceDataTable.save().then((va){
  print ('face data added successfully to data base{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} ');
}).catchError((error){
  throw(Exception('error on adding face data '));
});
  }

  Future getDataFromFaceData()async{
    await faceDataTable.select().toList().then((value){
      for (int i=0;i<value.length;i++){
        print('face data&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& is${ value[i].toMap()}');
      }
    }).catchError((error){
      print ('error${error.toString()}');
    });

  }


  Widget chosseWidget({Function ()?onTap1}){
    return Container(
      color: scaffoldMainColor,
      child: Center(
        child: Column(
          children: [
            Expanded(flex: 1, child: ClayContainer(
              color: Colors.white,
              spread: 2,
              depth: 60,
              borderRadius: 25,
              curveType: CurveType.convex,
              child: InkWell(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      PublicNeumoIcon(iconData: Icons.add,size: 18,iconColor: Colors.grey,),
                      SizedBox(width: 20,),
                      PublicNeumoText(text: 'Add New Face',color: Colors.grey,size: 20,align: TextAlign.center,)
                    ],
                  ),
                ),
                onTap: onTap1,
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Expanded(flex: 1, child: ClayContainer(
              color: Colors.white,
              spread: 2,
              depth: 60,
              borderRadius: 25,
              curveType: CurveType.concave,
              child: InkWell(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      PublicNeumoIcon(iconData: Icons.remove_red_eye_outlined,size: 18,iconColor: Colors.grey,),
                      SizedBox(width: 20,),
                      PublicNeumoText(text: 'recognize face',color: Colors.grey,size: 20,align: TextAlign.center,)
                    ],
                  ),
                ),
                onTap: (){},
              ),
            ))
          ],
        ),
    ),
    );
  }

}