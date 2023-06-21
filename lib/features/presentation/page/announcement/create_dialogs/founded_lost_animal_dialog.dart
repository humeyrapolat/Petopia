import 'dart:io';
import 'dart:math';

import 'package:petopia/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/animal_widget.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';
import 'package:petopia/util/consts.dart';

class LostAnimalDialog extends StatefulWidget {
  final AnimalEntity currentUser;

  const LostAnimalDialog({super.key, required this.currentUser});

  @override
  _LostAnimalDialogState createState() => _LostAnimalDialogState();
}

class _LostAnimalDialogState extends State<LostAnimalDialog> {
  String city = "";
  String? district = "";
  String? description = "";
  bool isMine = false;
  bool isWithMe = false;
  bool isInjured = false;

  File? _image;
  List<String> selectedDistricts = [];

  final TextEditingController _descriptionController = TextEditingController();

  final List<String> cityItems = ["Istanbul", "Izmır", "Antalya", "Other"];
  final List<String> istanbulDistrict = ["Kadıköy", "Sisli", "Maltepe", "Bebek", "Other"];
  final List<String> izmirDistrict = ["Konak", "Bornova", "Buca", "Cesme", "Other"];
  final List<String> antalyaDistrict = ["Muratpasa", "Konyaalti", "Kepez", "Dosemealti", "Other"];

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  updateDisctrictList(String type) {
    setState(() {
      if (type == "Istanbul") {
        selectedDistricts = ListConst().istanbulDistrict;
      } else if (type == "Antalya") {
        selectedDistricts = ListConst().antalyaDistrict;
      } else if (type == "Izmır") {
        selectedDistricts = ListConst().izmirDistrict;
      } else {
        selectedDistricts = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    city = widget.currentUser.city!;
    district = widget.currentUser.district!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Create Lost Animal Announcement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                          onTap: selectImage,
                          child:
                              ClipRRect(borderRadius: BorderRadius.circular(10), child: animalWidget(image: _image)))),
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: darkPinkColor,
                  value: isMine,
                  onChanged: (value) {
                    setState(
                      () {
                        isMine = value!;
                      },
                    );
                  },
                ),
                const Text("Did you lost your animal?"),
              ],
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              expands: false,
              minLines: 1,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: "please explain the situation of the animal",
              ),
            ),
            DropdownButtonFormField<String>(
              value: city,
              decoration: const InputDecoration(
                labelText: 'City',
              ),
              items: cityItems.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  city = value!;
                  district = null;
                  updateDisctrictList(city);
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select city.';
                }
                return null;
              },
            ),
            if (city != null)
              DropdownButtonFormField<String>(
                value: district,
                decoration: const InputDecoration(
                  labelText: 'District',
                ),
                items: selectedDistricts.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    district = newValue!;
                  });
                },
              ),
            isMine != true
                ? Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: darkYellowColor,
                            value: isWithMe,
                            onChanged: (value) {
                              setState(() {
                                isWithMe = value!;
                              });
                            },
                          ),
                          const Text("Is with me"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: darkYellowColor,
                            value: isInjured,
                            onChanged: (value) {
                              setState(
                                () {
                                  isInjured = value!;
                                },
                              );
                            },
                          ),
                          const Text("Is injured"),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(darkBlueGreenColor),
            ),
            onPressed: () {
              _submitLost();
            },
            child: const Text('Gönder'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal', style: TextStyle(color: darkBlueGreenColor))),
        ],
      ),
    );
  }

  _submitLost() {
    di.sl<UploadImageToStorageUseCase>().call(_image!, true, "losts").then((value) {
      _createLost(image: value);
    });
  }

  _createLost({required String image}) {
    BlocProvider.of<LostCubit>(context)
        .createLost(
      lost: LostEntity(
        city: city,
        description: description,
        creatorUid: widget.currentUser.uid,
        date: DateTime.now(),
        lostAnimalId: widget.currentUser.uid! + Random().nextInt(100).toString(),
        imageUrl: image,
        isWithMe: isWithMe,
        district: district,
        isMine: isMine,
        isinjured: isInjured,
      ),
    )
        .then((value) {
      _clear();
      Navigator.of(context).pop();
    });
  }

  _clear() {
    setState(() {
      city = "";
      district = "";
      description = "";
      isWithMe = false;
      isInjured = false;
      isMine = false;
      _image = null;
    });
  }
}
