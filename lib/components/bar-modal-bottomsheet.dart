
// ignore_for_file: file_names

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../ui-widgets/custom-barmodal-top-controll.dart';
import 'neu-button.dart';
import 'neu-text.dart';
int? _value = 1;
Future showWeekdaysModalBottomSheet({
  required BuildContext context,
 TextEditingController? weekDayMissionController,
 String? expansionTitle,
 String? headerText,
 TimeOfDay? timeButtonText,
 String? locationName,
 String ?missionRecordUri,
  bool?isMissionNoteIsEmpty,
 Widget ?audioPlayerWidget,
 Function()? onSetTimeButtonTapped,
 Function()? onAddLocationTapped,
 Function()? onAddNotesButtonTapped,
 Function()? onAddAttachmentsTapped,
 Function()? onDeleteButtonTapped,
 Function()? onDoneBottomTapped,
}){
  return showBarModalBottomSheet(
      expand: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      context: context,
      builder: (context) {
        return Column(
            key: ObjectKey(headerText),
            mainAxisSize: MainAxisSize.max,

            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.839,
                  width: MediaQuery.of(context).size.width * 0.99,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 10,),
                            Container(
                              child: const Center(child: CustomBarModalControl()),
                              width: double.infinity,
                              height: 60,
                              margin: const EdgeInsets.only(top: 20, bottom: 10),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Text.rich(TextSpan(
                                text: 'Add missions for  ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: headerText,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.redAccent),
                                  )
                                ],
                              )),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 20,
                                    wordSpacing: 5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                controller: weekDayMissionController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                    hintText: ' I Want to .....',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 22)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: const Text(
                                'Remind me about this ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomNewMissionButton(
                                          key: ObjectKey(headerText),
                                          text:timeButtonText
                                              ?.format(context)
                                              .toString() ??
                                              'Set Time',
                                          iconData: Icons.watch_later_outlined,
                                          function: onSetTimeButtonTapped,
                                        )
                                ),
                                Expanded(
                                  child: CustomNewMissionButton(
                                    text: locationName ?? 'At Location',
                                    iconData: Icons.location_on,
                                    function: onAddLocationTapped,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const PublicNeumoText(
                                    text: 'In which list ?',
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  DropdownButton(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      value: _value,
                                      items: const [
                                        DropdownMenuItem(
                                          child: PublicNeumoText(
                                            text: "personal",
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: PublicNeumoText(
                                            text: "work",
                                            size: 14,
                                            color: Colors.black,
                                          ),
                                          value: 2,
                                        )
                                      ],
                                      onChanged: (int? value) {
                                        _value = value;
                                      },
                                      hint: const Text("Select item")),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                                  if (isMissionNoteIsEmpty!)
                                     CustomBottomSheetButton(
                                      width: MediaQuery.of(context).size.width * .95,
                                      textColor: Colors.black,
                                      borderColor: Colors.black,
                                      text: 'Add Notes',
                                      shadowDarkColor: Colors.black,
                                      function: onAddNotesButtonTapped,
                                    ),
                                     Column(
                                      children: [
                                        CustomBottomSheetButton(
                                          width:
                                          MediaQuery.of(context).size.width * .95,
                                          textColor: Colors.black,
                                          borderColor: Colors.black,
                                          text: 'Add Notes',
                                          shadowDarkColor: Colors.black,
                                          function: onAddNotesButtonTapped,
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          width: double.infinity
                                          ,padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              border:Border.all(color: Colors.grey,width: .5),
                                              borderRadius:const BorderRadius.all(Radius.circular(20))
                                          )
                                          ,child:const Text.rich(TextSpan(
                                            text: 'mission description :\n',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20
                                            ),children: [
                                          TextSpan(
                                              text: 'description',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color:Colors.black,
                                                  fontWeight: FontWeight.w400
                                              )
                                          )
                                        ]
                                        ),),
                                        )
                                      ],
                                    ),


                            const SizedBox(
                              height: 20,
                            ),

                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const PublicNeumoText(
                                text: 'Add Attachments',
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            CustomBottomSheetButton(
                              width: MediaQuery.of(context).size.width * .95,
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              text: 'Add Attachments',
                              shadowDarkColor: Colors.black,
                              function: onAddAttachmentsTapped,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (missionRecordUri!.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 20,
                                width: double.infinity,
                                child: audioPlayerWidget,
                              ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const PublicNeumoText(
                                text: 'Delete this mission ',
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            CustomBottomSheetButton(
                              width: MediaQuery.of(context).size.width * .95,
                              textColor: Colors.red,
                              borderColor: Colors.red,
                              text: 'Delete Mission',
                              shadowDarkColor: Colors.red,
                              function:onDeleteButtonTapped,
                            ),
                          ]))),
              const Spacer(),

              SizedBox(
                height: 60,
                child: CustomNewMissionButton(
                  width: double.infinity,
                  text: 'Done',
                  iconData: Icons.check_circle_outline_rounded,
                  function: onDoneBottomTapped,
                ),
              )
            ]);
      });
}