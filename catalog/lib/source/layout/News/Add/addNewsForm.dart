import 'dart:io';
import 'package:catalog/source/service/News/bloc/addnews_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddNewsForm extends StatefulWidget {
  const AddNewsForm({super.key});

  @override
  State<AddNewsForm> createState() => _AddNewsFormState();
}

class _AddNewsFormState extends State<AddNewsForm> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDesc = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  File? pickedImage;
  void showDate() async {
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999, 1, 1),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (result != null) {
      print(result.toString());
      setState(() {
        controllerDate.text = DateFormat('yyyy-MM-dd hh:mm:ss').format(result).toString();
      });
    }
  }

  void pilihGambar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pickedImage = File(result.files.single.path!);
      });
    } else {
      print('Batal pilih gambar');
    }
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      context.read<AddnewsBloc>().add(AddnewsInitial(title: controllerTitle.text, desc: controllerDesc.text, date: controllerDate.text, image: pickedImage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News Catalog Form'),
      ),
      body: ListView(
        children: [
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: pilihGambar,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.6), width: 2), borderRadius: BorderRadius.circular(6.0)),
                      alignment: Alignment.center,
                      child: pickedImage == null
                          ? Icon(Icons.image_outlined, color: Colors.grey.withOpacity(0.7), size: 100)
                          : Image.file(
                              pickedImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controllerTitle,
                    decoration: InputDecoration(
                      labelText: "Please fill Title",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert this Title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controllerDate,
                    readOnly: true,
                    onTap: showDate,
                    decoration: InputDecoration(
                      labelText: "Pick Date",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert this Date";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controllerDesc,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Please fill Description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert this Description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),
                      child: Text(
                        'ADD NEWS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
