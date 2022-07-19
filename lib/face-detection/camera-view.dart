import 'dart:io';

import 'package:camera/camera.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/face-detection/utils/screen-mode.dart';

import '../constants/constants.dart';

List<CameraDescription> cameras = [];
List<Map<String,dynamic>>facesrecog=
[
  {
    'person':'Ali Adel',
    'relationship':'it is you '

  },

];
class FDCameraView extends StatefulWidget {
  final String? title;
  final CustomPaint? customPaint;
  final String? text;
  final Function(InputImage inputImage)? onImage;
  final CameraLensDirection? initialDirection;
   bool facedetected =false;
   FDCameraView(
      {Key? key,
      this.title,
      this.customPaint,
      this.text,
      this.initialDirection,
      this.onImage,
     required this.facedetected
      })
      : super(key: key);
  @override
  State<StatefulWidget> createState() => FDCameraViewState();
}

class FDCameraViewState extends State<FDCameraView> {


  ScreenMode screenMode = ScreenMode.live;
  CameraController? cameraController;
  File? image;
  String? imagePath;
  ImagePicker? imagePicker;
  int? cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLeve = 0.0;
  final bool allowPicker = true;
  bool allowChangingCameraLens = false;

  @override
  void initState() {
    imagePicker = ImagePicker();

    if (cameras.any((element) =>
        element.lensDirection == widget.initialDirection &&
        element.sensorOrientation == 90)) {
      cameraIndex = cameras.indexOf(cameras.firstWhere((element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90));
    } else {
      cameraIndex = cameras.indexOf(cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection));
    }
    startLive();
    super.initState();
  }

  Future startLive() async {
    final camera = cameras[cameraIndex!];
    cameraController =
        CameraController(camera, ResolutionPreset.high, enableAudio: true);
    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        cameraController?.getMaxZoomLevel().then((value) {
          maxZoomLeve = value;
        });
        cameraController?.getMinZoomLevel().then((value) {
          zoomLevel = value;
          minZoomLevel = value;
        });
        cameraController?.startImageStream((processCameraImage));
        setState(() {});
      }
    });
  }

  Future processCameraImage(CameraImage cameraImage) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
    final camera = cameras[cameraIndex!];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.nv21;
    final planeData = cameraImage.planes.map((final Plane plane) {
      return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width);
    }).toList();

    final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData);

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    widget.onImage!(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recognize Faces',
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          if (allowPicker)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: switchMode,
                  child: Icon(screenMode == ScreenMode.live
                      ? Icons.camera
                      : Icons.camera_alt)),
            )
        ],
      ),
      body: body(),
      // floatingActionButton: floatingActionButton(),
      // floatingActionButtonLocation:FloatingActionButtonLocation.miniCenterFloat ,
    );
  }

  // Widget?floatingActionButton(){
  //   if(screenMode==ScreenMode.gallery)return null;
  //   if(cameras.length== 1)return null;
  //   return SizedBox(
  //     height: 70,
  //     width: 70,
  //     child: FloatingActionButton(
  //       onPressed: (){},
  //       child:const Icon(
  //         Icons.flip_camera_android_outlined,
  //         size: 40,
  //       ),
  //     ),
  //   );
  //
  // }
  Future switcherCamera()async{
    setState((){
      allowChangingCameraLens=true;

    });
    cameraIndex=(cameraIndex! + 1)%cameras.length;
    await stopLive();
    await startLive();
    setState((){
      allowChangingCameraLens=false;
    });
  }

  Widget body() {
    Widget body;
    if (screenMode == ScreenMode.live) {
      body = liveBody();
    } else {
      body = galleryBody();
    }
    return body;
  }

   personName()async{
    return await Future.delayed(const Duration(seconds: 4)).then((value) {
      return 'mohamed';
    });

  }
  bool isForAdding=false;
  bool isForRecog=true;
  var personController =TextEditingController();
  var relashionshipController=TextEditingController();

  Widget liveBody() {
    if (cameraController?.value.isInitialized == false) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * cameraController!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Stack(
      fit: StackFit.expand,
      children: [
      Transform.scale(
        scale:  scale,
        child: allowChangingCameraLens?
        const Center(
          child: Text('changing camera lens'),
        ):
            CameraPreview(cameraController!)
      ),
        if(widget.customPaint!=null)widget.customPaint!,
        // if(widget.facedetected)
        // Positioned(
        //     top: 10,
        //     left: -120,
        //     right: 50,
        //     child:Container(
        //       height: 60,
        //       width: double.infinity,
        //       child: Row(
        //         children: [
        //           Expanded(flex: 1, child: ClayContainer(height:30,width: 120,surfaceColor: scaffoldMainColor,depth: 40,spread: 2 ,child: InkWell(
        //             child:const  Text('recognition face',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,),textAlign: TextAlign.center,),onTap: (){
        //
        //           },),)),
        //           Expanded(flex: 1, child: ClayContainer(height:30,width: 120,surfaceColor: scaffoldMainColor,depth: 40,spread: 2 ,child: InkWell(child:const Text('add new face',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),onTap: (){},),)),
        //
        //         ],
        //       ),
        //     ) ),
        Align(
          alignment: Alignment.bottomCenter,
          child: DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))
                ),
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const  SizedBox(
                        height: 20,
                      ),
                     Row(
                       children: [
                        const Expanded(flex: 1, child: Text( '   this person is : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),)),
                         Expanded(flex: 3, child:
                         isForRecog?
                         Text('${facesrecog.last['person']}',
                         style:const TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),):
                         TextFormField(
                           controller: personController,
                           decoration:const InputDecoration(
                             hintText: 'Add the name of this person'
                           ),
                         )
                         )
                       ],
                     ),
                     const SizedBox(height: 10,),
                      Row(
                        children: [
                           const Expanded(flex: 1, child:

                          Text('   Relationship : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),)),
                          Expanded(flex: 3, child:
                          isForRecog?
                          Text(' ${facesrecog.last['relationship']}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),):
                          TextFormField(
                            controller: relashionshipController,
                            decoration:const InputDecoration(
                                hintText: 'Add the name of this person'
                            ),
                          )
                          ),
                        ],
                      ),
                      isForRecog==false?
                          Center(child: Container(height: 30,width: 60,child: InkWell(child: Text('Ok',style:TextStyle(fontSize: 14,color: Colors.blue),textAlign: TextAlign.center,),onTap: (){
                            setState((){
                              facesrecog.last.addAll({
                                'person':personController.text,
                                'relationship':relashionshipController.text
                              });
                              isForRecog=true;
                            });
                          },),),):
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(flex: 1, child: ClayContainer(height:30,surfaceColor: scaffoldMainColor,depth: 40,spread: 2 ,child: InkWell(
                            child:const  Text('recognition face',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,),textAlign: TextAlign.center,),onTap: (){
                              setState((){
                                isForRecog=true;
                              });
                          },),)),
                          Expanded(flex: 1, child: ClayContainer(height:30,surfaceColor: scaffoldMainColor,depth: 40,spread: 2 ,child: InkWell(child:const Text('add new face',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),onTap: (){
                            setState((){
                              isForRecog=false;
                            });
                          },),)),

                        ],
                      ),

                    ],
                  ),
                ) ,
              );

            },),
        )
      ],
    );
  }

  Widget galleryBody() {
    return ListView(
      shrinkWrap:  true,
      children: [
        image!=null?SizedBox(
          height: 400,
          width: 400,
          child:  Stack(
            fit: StackFit.expand,
            children: [
              Image.file(image!),
              if(widget.customPaint!=null)widget.customPaint!,
            ],
          ),
        ):const Icon(
          Icons.image,
          size: 200,
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child:
          ElevatedButton(
            onPressed: ()=>getImage(ImageSource.camera),
            child: const Text('from camera'),
          ),),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child:
        ElevatedButton(
          onPressed: ()=>getImage(ImageSource.gallery),
          child: const Text('from gallery'),
        ),),
        if(image!=null)
          Padding(padding: const EdgeInsets.all(16),child:
            Text('${imagePath==null ? '':'image path: $imagePath'}\n\n${widget.text??''}')
            ,)
      ],
    );

  }

  Future getImage(ImageSource source)async{
    setState((){
      imagePath=null;
      image=null;

    });
    final pickedFile=await imagePicker?.pickImage(source: source);
    if(pickedFile!=null){
      processPickedFile(pickedFile);
    }
    setState((){});
   }

  Future processPickedFile(XFile ?pickedFile)async{
    final path =pickedFile?.path;
    if(path==null){
      return;
    }
    setState((){
      image=File(path);
    });
    imagePath=path;
    final inputImage=InputImage.fromFilePath(path);
    widget.onImage!(inputImage);
   }

  void switchMode() {
    image = null;
    if (screenMode == ScreenMode.live) {
      screenMode = ScreenMode.gallery;
      stopLive();
    } else {
      screenMode = ScreenMode.live;
      startLive();
    }
    setState(() {});
  }

  Future stopLive() async {
    cameraController?.stopImageStream();
    cameraController?.dispose();
    cameraController = null;
  }
}
