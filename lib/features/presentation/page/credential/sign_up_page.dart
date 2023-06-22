import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:petopia/features/presentation/page/main_screen/main_screen.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/profile_widget.dart';

import '../../../../util/consts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String selectedType = "";
  String selectedCity = "";
  String? selectedDistrict;
  String? selectedBreed;
  String? selectedGender;
  List<String> selectedBreeds = [];
  List<String> selectedDistricts = [];
  bool _isSigningUp = false;
  bool isLoading = false;

  updateBreedsList(String type) {
    setState(() {
      if (type == "Cat") {
        selectedBreeds = ListConst().catBreeds;
      } else if (type == "Dog") {
        selectedBreeds = ListConst().dogBreeds;
      } else if (type == "Rabbit") {
        selectedBreeds = ListConst().rabbitBreeds;
      } else {
        selectedBreeds = [];
      }
    });
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
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPinkColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            toast("Invalid Email and Password");
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return _bodyWidget();
                }
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sizeVertical(75),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: profileWidget(image: _image),
                    ),
                  ),
                  Positioned(
                    right: -10,
                    bottom: -15,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 55),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: FormContainerWidget(
                    controller: _nameController,
                    hintText: 'Name',
                    inputType: TextInputType.name,
                  ),
                ),
                sizeHorizontal(15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: FormContainerWidget(
                    controller: _usernameController,
                    hintText: 'Username',
                    inputType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
            sizeVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Type',
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
                      updateBreedsList(value!);
                      selectedType = value;
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
                sizeHorizontal(15),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Breeds',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: selectedBreeds
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
                        return 'Please select breed.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedBreed = value;
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
            sizeVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'City',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: ListConst()
                        .cityItems
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
                        return 'Please select city.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      updateDisctrictList(value!);
                      selectedCity = value;
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
                sizeHorizontal(15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'District',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: selectedDistricts
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
                        return 'Please select district.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedDistrict = value;
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
            sizeVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Gender',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: ListConst()
                        .genderItems
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
                        return 'Please select gender.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _genderController.text = value!;
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
                sizeHorizontal(15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: FormContainerWidget(
                    controller: _phoneNumberController,
                    hintText: 'Phone Number',
                    inputType: TextInputType.name,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: FormContainerWidget(
                    controller: _emailController,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                ),
                sizeHorizontal(15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: FormContainerWidget(
                    controller: _passwordController,
                    hintText: 'Password',
                    inputType: TextInputType.visiblePassword,
                    isPasswordField: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _signUpUser();
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5),
                backgroundColor:
                    MaterialStateProperty.all<Color>(darkPinkColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            sizeVertical(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConsts.signInPage, (route) => false);
                  },
                  child: const Text(
                    "Sign In.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: darkPinkColor),
                  ),
                ),
              ],
            ),
            _isSigningUp == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Please wait",
                        style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      sizeHorizontal(10),
                      const CircularProgressIndicator()
                    ],
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
          AnimalEntity(
            email: _emailController.text,
            password: _passwordController.text,
            bio: "",
            username: _usernameController.text,
            totalPosts: 0,
            birthdate: _dateController.text,
            type: selectedType,
            city: selectedCity,
            district: selectedDistrict,
            phoneNumber: _phoneNumberController.text,
            gender: _genderController.text,
            breed: selectedBreed,
            totalFollowing: 0,
            likedPosts: [],
            followers: [],
            totalFollowers: 0,
            website: "",
            following: [],
            favorites: [],
            lostPosts: [],
            adoptionPosts: [],
            name: _nameController.text,
            imageFile: _image,
          ),
        )
        .then((value) => _clearControllers());
  }

  _clearControllers() {
    setState(() {
      selectedCity = "";
      selectedBreed = "";
      selectedDistrict = "";
      selectedGender = "";
      selectedType = "";
      _image = null;
      selectedBreeds = [];
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      _dateController.clear();
      _genderController.clear();
      _isSigningUp = false;
    });
  }
}
