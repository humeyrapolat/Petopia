import 'dart:io';

import 'package:petopia/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:petopia/injection_container.dart' as di;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/animal_widget.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/cubit/adoption/adoption_cubit.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:uuid/uuid.dart';

class AdoptionAnimalDialog extends StatefulWidget {
  final AnimalEntity currentUser;

  const AdoptionAnimalDialog({super.key, required this.currentUser});

  @override
  State<AdoptionAnimalDialog> createState() => _AdoptionAnimalDialogState();
}

class _AdoptionAnimalDialogState extends State<AdoptionAnimalDialog> {
  String city = "";
  String type = "";
  String age = "";
  List<String> selectedBreeds = [];

  File? _image;

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

  final List<String> animalAge = ["new born", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Do you want to adopt an animal?',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Stack(
              children: [
                SizedBox(
                    width: 200,
                    height: 200,
                    child: GestureDetector(
                        onTap: selectImage,
                        child: ClipRRect(borderRadius: BorderRadius.circular(10), child: animalWidget(image: _image)))),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.currentUser.city!, textAlign: TextAlign.center),
                  sizeHorizontal(5),
                  Icon(Iconsax.location, size: 20, color: black)
                ],
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.07,
            child: DropdownButtonFormField2(
              isExpanded: true,
              hint: const Text(
                'age of animal',
                style: TextStyle(fontSize: 14),
              ),
              items: animalAge
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select age.';
                }
                return null;
              },
              onChanged: (value) {
                age = value!;
              },
              onSaved: (value) {},
              buttonStyleData: const ButtonStyleData(
                height: 60,
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.07,
            child: DropdownButtonFormField2(
              isExpanded: true,
              hint: const Text(
                'Type of animal',
                style: TextStyle(fontSize: 14),
              ),
              items: ListConst()
                  .typeItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select type.';
                }
                return null;
              },
              onChanged: (value) {
                type = value!;
              },
              onSaved: (value) {},
              buttonStyleData: const ButtonStyleData(
                height: 60,
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(darkBlueGreenColor),
          ),
          onPressed: () {
            _submitAdoption();
          },
          child: const Text('Gönder'),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('İptal', style: TextStyle(color: darkBlueGreenColor))),
      ],
    );
  }

  _submitAdoption() {
    di.sl<UploadImageToStorageUseCase>().call(_image!, true, "adoptions").then((value) {
      _createAdoption(image: value);
    });
  }

  _createAdoption({required String image}) {
    BlocProvider.of<AdoptionCubit>(context)
        .createAdoption(AdoptionEntity(
            city: widget.currentUser.city!,
            type: type,
            age: age,
            adoptionPostId: const Uuid().v1(),
            creatorUid: widget.currentUser.uid,
            profileUrl: image))
        .then((value) {
      _clear();
      Navigator.of(context).pop();
    });
  }

  _clear() {
    setState(() {
      city = "";
      type = "";
      age = "";
    });
  }
}
