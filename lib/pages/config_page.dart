import 'dart:io';

import 'package:business_card_creator/form_builder_library/form_builder_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//todo move inside mvc?
final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final MaskedTextController phoneNumber = MaskedTextController(mask: '(000)000-0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Personal Info'),
      ),
      backgroundColor: Colors.grey[200],
      body: FormBuilder(
        key: _formKey,
        initialValue: const <String, dynamic>{
          'photo': null,
          'name': '',
          'profession': '',
          'phone': '',
          'email': '',
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderImagePicker(
                  name: 'photo',
                  maxImages: 1,
                  decoration: const InputDecoration(border: InputBorder.none),
                  validator: FormBuilderValidators.required(context),
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      File finalValue = value.first;
                      ConfigPageController.setPhoto(finalValue);
                    } else {
                      ConfigPageController.setPhoto(File(''));
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    label: Text('Name *'),
                  ),
                  validator: FormBuilderValidators.required(context),
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      ConfigPageController.setName(value);
                    } else {
                      ConfigPageController.setName('');
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'profession',
                  decoration: const InputDecoration(
                    label: Text('Profession *'),
                  ),
                  validator: FormBuilderValidators.required(context),
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      ConfigPageController.setProfession(value);
                    } else {
                      ConfigPageController.setProfession('');
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'phone',
                  decoration: const InputDecoration(
                    label: Text('Phone *'),
                  ),
                  validator: FormBuilderValidators.required(context),
                  keyboardType: TextInputType.phone,
                  controller: phoneNumber,
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      ConfigPageController.setPhone(value);
                    } else {
                      ConfigPageController.setPhone('');
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    label: Text('Email *'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      ConfigPageController.setEmail(value);
                    } else {
                      ConfigPageController.setEmail('');
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {
                    if (ConfigPageController.validateFields()) {
                      Navigator.of(context).pushNamed('ColorsPage');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfigPageController extends ControllerMVC {
  factory ConfigPageController([StateMVC? state]) =>
      _this ??= ConfigPageController._(state);
  ConfigPageController._(StateMVC? state) : super(state);
  static ConfigPageController? _this;

  static File _photo = File('');
  static File get photo => _photo;
  static File setPhoto(File newPhoto) => _photo = newPhoto;

  static String _name = '';
  static String get name => _name;
  static String setName(String newName) => _name = newName;

  static String _company = '';
  static String get company => _company;
  static String setCompany(String newCompany) => _company = newCompany;

  static String _profession = '';
  static String get profession => _profession;
  static String setProfession(String newProfession) => _profession = newProfession;

  static String _phone = '';
  static String get phone => _phone;
  static String setPhone(String newPhone) => _phone = newPhone;

  static String _email = '';
  static String get email => _email;
  static String setEmail(String newEmail) => _email = newEmail;

  static bool validateFields() {
    if (_formKey.currentState != null && _formKey.currentState!.saveAndValidate()) {
      return true;
    }
    return false;
  }
}
