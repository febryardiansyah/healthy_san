import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/get_profile/get_profile_cubit.dart';
import 'package:healthy_san/bloc/save_image_profile/save_image_profile_cubit.dart';
import 'package:healthy_san/models/user_model.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/my_form.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({Key? key,required this.user}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel get user => widget.user;
  String? profileUrl;
  final nameEdc = TextEditingController();
  final oldPasswordEdc = TextEditingController();
  final newPasswordEdc = TextEditingController();

  final picker = ImagePicker();
  XFile? pickedImage;
  void pickImage()async{
    XFile? _pickImage = await picker.pickImage(source: ImageSource.gallery);
    if (_pickImage != null) {
      setState(() {
        pickedImage = _pickImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    profileUrl = user.profilePic ?? null;
    nameEdc.text = user.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BaseColor.base,
        title: Text('Edit profil'),
      ),
      body: BlocListener<SaveImageProfileCubit, SaveImageProfileState>(
        listener: (context, state) {
          if (state is SaveImageProfileLoading) {
            loadingSnackBar(context);
          }
          if (state is SaveImageProfileFailure) {
            failureSnackBar(context, state.msg);
          }
          if (state is SaveImageProfileSuccess) {
            successSnackBar(context, state.msg);
            context.read<GetProfileCubit>().fetchProfile();
            Navigator.pop(context);
          }
        },
        child: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: pickedImage != null? DecorationImage(
                          image: FileImage(File(pickedImage!.path),),
                          fit: BoxFit.cover,
                        ): DecorationImage(
                          image: NetworkImage(user.profilePic!,),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Visibility(
                      visible: pickedImage != null,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                pickedImage = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              child: Text('Hapus foto',style: TextStyle(color: BaseColor.base,fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: pickedImage == null,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: pickImage,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              child: Text('Ubah foto profil',style: TextStyle(color: BaseColor.base,fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: BaseColor.base.withOpacity(0.2),
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: pickedImage != null,
                      child: InkWell(
                        onTap: (){
                          context.read<SaveImageProfileCubit>().saveImage(pickedImage!);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                          child: Text('Simpan foto',style: TextStyle(color: BaseColor.base,fontWeight: FontWeight.bold)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Text('Nama'),
              SizedBox(height: 8,),
              MyForm(
                hintText: 'nama kamu',
                controller: nameEdc,
              ),
              Text('Kata Sandi Lama'),
              SizedBox(height: 8,),
              MyForm(
                hintText: 'kata sandi lama',
                controller: oldPasswordEdc,
                // secureText: passwordInvisible,
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    setState(() {
                      // passwordInvisible = !passwordInvisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 8,),
              Text('Kata Sandi Baru'),
              SizedBox(height: 8,),
              MyForm(
                hintText: 'kata sandi baru',
                controller: newPasswordEdc,
                // secureText: passwordInvisible,
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    setState(() {
                      // passwordInvisible = !passwordInvisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  primary: BaseColor.base,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
),
    );
  }
}
