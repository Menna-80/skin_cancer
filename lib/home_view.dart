import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_cancer_app/settings/settings_view.dart';

import 'components/components.dart';

class ClassificationScreen extends StatefulWidget {
  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen> {
  File? image;
  var response;

  @override
  Widget build(BuildContext context) {

            return Scaffold(
              appBar: AppBar(
                title: Text('Classification'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.segment,color: Colors.white,),
                    onPressed: () {
                      NavigateTo(context, SettingsScreen());
                      },

                  ),
                ],

              ),
              body: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 440,
                        width: double.infinity,
                        child: image == null
                            ? Center(
                                child: Text(
                                  'No Selected Images',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Image.file(
                          image!,
                          fit: BoxFit.fill,
                        ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),

                     ConditionalBuilder(
                         condition: response != null,
                         builder: (context)=>Text(
                       '$response',
                       style: TextStyle(
                        fontSize: 20.0,
                         fontWeight: FontWeight.bold
                     ),),
                         fallback: (context)=>Center(child: CircularProgressIndicator())),
                     SizedBox(
                      height: 20.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: pickImage,
                          child: Text(
                            'Pick image',
                          ),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              uploadImage();
                            },
                            child: Text(
                              'Classification',
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );


  }

  Future pickImage() async {
    final Pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(Pickedimage!.path);
    });
  }


 static Dio dio=Dio();
  uploadImage() async{
    var formData=FormData.fromMap(
      {
        'my_image': await MultipartFile.fromFile(image!.path),
      },

    );
    response = await dio.post('http://cf00-35-188-227-104.ngrok.io/predict', data:formData);
     print(response.toString());
    setState(()  {
    });


  }
}
