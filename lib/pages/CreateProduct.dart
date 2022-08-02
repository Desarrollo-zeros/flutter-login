import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/data/services/RequestProduct.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  var _image;
  ImagePicker picker = ImagePicker();
  TextEditingController controlId = TextEditingController();
  TextEditingController controlDetailt = TextEditingController();
  TextEditingController controlBrand = TextEditingController();
  TextEditingController controlSize = TextEditingController();
  TextEditingController controlLength = TextEditingController();



  _camGaleria(bool op) async {
    XFile? image;
    image = op
        ? await picker.pickImage(source: ImageSource.camera, imageQuality: 50)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Articulos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  _opcioncamara(context);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.file(
                      _image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    width: 100,
                    height: 100,
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: controlId,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ingrese el Codigo'),
            ),
            TextField(
              controller: controlDetailt,
              decoration:
              const InputDecoration(labelText: 'Ingrese el Detalle'),
            ),
            TextField(
              controller: controlBrand,
              decoration: const InputDecoration(labelText: 'Ingrese la Marca'),
            ),
            TextField(
              controller: controlSize,
              decoration: const InputDecoration(
                  labelText: 'Ingrese la Unidad de Medida'),
            ),
            TextField(
              controller: controlLength,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Ingrese la Cantidad en Bodega'),
            ),
            ElevatedButton(
                onPressed: () {
                  var product = <String, dynamic>{
                    'Id': controlId.text,
                    'Detailt': controlDetailt.text,
                    'Brand': controlBrand.text,
                    'Size': controlSize.text,
                    'Length': controlLength.text,
                    'File': ''
                  };
                  RequestProduct.create(product, _image);
                },
                child: const Text("Guardar Articulo"))
          ],
        ),
      ),
    );
  }

//Seleccionar la camara o la galeria

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Imagen de Galeria'),
                    onTap: () {
                      _camGaleria(false);
                      Get.back();
                      // Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Capturar Imagen'),
                  onTap: () {
                    _camGaleria(true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
