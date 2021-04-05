import 'dart:io';
import 'dart:math';

import 'package:aldera/cells/MessageCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/Banners.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/models/home/Images.dart';
import 'package:aldera/singleton/AppSharedPreference.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Homepage extends StatefulWidget {
  bool fromNotification;

  Homepage({this.fromNotification = false});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  String messageControllerValue;
  ScrollController scrollController = ScrollController();
  DateTime dateTime = DateTime.now();
  Locale locale = Locale('en');
  String languageCode = Platform.localeName.split('_')[0];
  String countryCode = Platform.localeName.split('_')[1];

  // Recording _recording = new Recording();
  bool _isRecording = false;
  bool _isUploaded = false;
  Random random = new Random();
  String imageURL = '';
  String fileName;
  var timerProvider;
  String minutes = "0", second = "0";
  int uploadProgress = 0;
  File imageFile;
  String imageToSave = '';

  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true, navBarColor: white, navBrightness: Brightness.dark);
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gray1,
          body: Column(
            children: [
              Banners(
                images: [
                  Images(
                      "https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg"),
                  Images(
                      "https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg"),
                  Images(
                      "https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg"),
                ],
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection("ChatRooms")
                          .doc('MainChat')
                          .collection("Messages")
                          .orderBy("timestamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            ),
                          );
                        List<DocumentSnapshot> docs = snapshot.data.docs;
                      return ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          // shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: /*docs != null ? docs.length : 0,*/ 10,
                          itemBuilder: (context, i) {
                            return MessageCell(
                              userImage: docs[i].data()['user_image'],
                              content: docs[i].data()['content'],
                              type: docs[i].data()['type'],
                              // audioTime: docs[i].data()['audioTime'],
                              timestamp: docs[i].data()['timestamp'],
                              // audioPlayer: audioPlayer,
                              mine: docs[i].data()['user_id'] == 1,
                            );
                          });
                    }
                  ),
                ),
              ),
              Container(
                width: 1.0.sw,
                height: 50.h,
                color: Colors.transparent,
                child: IntrinsicHeight(
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    style: TextStyle(
                      fontFamily: PRIMARY_FONT_REGULAR,
                      fontSize: 15.ssp,
                    ),
                    onSubmitted: (value) => sendChat('text'),
                    controller: messageController,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.only(
                          top: 0, bottom: 0, start: 20.w, end: 10.w),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: containerTFMessage, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: containerTFMessage, width: 0),
                      ),
                      suffixIcon: Container(
                        width: 80.w,
                        height: 50.h,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                //todo enter code here
                                _showPhotoLibrary(ImageSource.gallery);
                              },
                              child: Container(
                                  width: 24.w,
                                  height: 50.h,
                                  child: SvgPicture.asset(
                                    ASSETS_NAME_HOME + 'image_gallery.svg',
                                    color: obscureColor1,
                                  )),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            InkWell(
                              onTap: messageController.text.isEmpty
                                  ? null
                                  : () {
                                      //todo enter code here
                                      sendChat('text');
                                    },
                              child: Container(
                                  width: 24.w,
                                  height: 50.h,
                                  child: SvgPicture.asset(
                                    ASSETS_NAME_HOME + 'send.svg',
                                    color: obscureColor1,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      filled: true,
                      fillColor: gray1,
                      hintText: getTranslated(context, "typeMessage"),
                      hintStyle: TextStyle(
                          fontFamily: PRIMARY_FONT_REGULAR, fontSize: 12.ssp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendChat(String type) async {
    print("minutes second = " + minutes + " : " + second);
    if (messageController.text.length > 0 || imageURL.length > 0) {
      await _firestore
          .collection("ChatRooms")
          .doc('MainChat')
          .collection("Messages")
          .add({
        'user_id':
            /*widget.myData["senderUserId"] ==
            getIt<AppSharedPreferences>().getLogin().id?
        widget.myData["senderUserId"]: widget.otherData["senderUserId"]*/
            1,
        'user_image': 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg',
        'content': type == IMAGE ? imageURL : messageController.text,
        'type': type,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        /*sendNotification(type == IMAGE ? getTranslated(context, "sentYouImage"):
        messageController.text, widget.myData["fullName"],"user_"+(widget.myData['senderUserId'] ==
            getIt<AppSharedPreferences>().getLogin().id?
        widget.myData['receiverUserId'].toString(): widget.otherData['receiverUserId'].toString()));*/
        print("parent parent document id = " +
            value.parent.parent.id +
            " documnet id = " +
            value.id);
      });
      messageController.clear();
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void _showPhotoLibrary(ImageSource source) {
    getImageCrop().then((_imageFile) async {
      print("getImageCrop");
      setState(() {
        imageToSave = _imageFile.path;
        imageFile = _imageFile;
        uploadImageToFirebase(context, imageFile);
      });
      print("uploadImage successfully >> " + _imageFile.path.toString());
    });
  }

  Future uploadImageToFirebase(BuildContext context, File imageFile) async {
    /*String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );*/
    fileName = "imageFile_" +
        DateTime.now()
            .toString()
            .replaceAll(":", "")
            .replaceAll("-", "")
            .replaceAll(".", "")
            .replaceAll(" ", "")
            .trim();
    try {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploaded_images/' + fileName)
          .putFile(
            imageFile,
            /*SettableMetadata(
            contentType: 'audio/mp3',
            customMetadata: <String, String>{'file': 'audio'},
          )*/
          );

      task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        print('Task state: ${snapshot.state}');
        print(
            'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
        setState(() {
          uploadProgress = int.parse(
              ((snapshot.bytesTransferred / snapshot.totalBytes) * 100)
                  .toString()
                  .split(".")[0]);
        });
      }, onError: (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print("onError = " +
            e.toString() +
            ", |task.snapshot| " +
            task.snapshot.toString());

        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
      });

      // We can still optionally use the Future alongside the stream.
      try {
        await task;
        print('Upload complete.');
        setState(() {
          _isUploaded = false;
        });
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('uploaded_images/' + fileName)
            .getDownloadURL();
        print("downloadURL = " + imageURL);
        sendChat(IMAGE);
      } on firebase_core.FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          Scaffold.of(context).showSnackBar(new SnackBar(
              content: CustomText(
            'User does not have permission to upload to this reference.',
            translate: false,
            textColor: gray,
            primaryFont: PRIMARY_FONT_REGULAR,
            fontSize: 14,
          )));
          print('User does not have permission to upload to this reference.');
        }
        // ...
      }
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(e.code + " >> canceled")));
    }
  }
}
