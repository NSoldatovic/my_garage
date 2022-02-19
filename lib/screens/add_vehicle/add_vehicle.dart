import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:intl/intl.dart';
import 'package:my_garage/models/vehicle.dart';

import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/list_of_vehicles.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final generatedDescription = TextEditingController(text: '');
  var _isInit = true;
  late Vehicle _editedVehicle;
  final _imageUrlFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _modelFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  late bool _isNew;
  bool opt = false;
  String? transmissionValue = 'null';
  String? tiresValue = 'null';
  String? fuelTypeValue = 'null';
  String cameraValue = 'camera';
  DateTime? _selectedDate;
  File? _pickedImage;
  File? _storedImage;

  Future<void> _takePicture(String x) async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: x == 'gallery' ? ImageSource.gallery : ImageSource.camera,
      maxHeight: 1000,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage?.copy('${appDir.path}/$fileName');

    _pickedImage = savedImage;
    print(_pickedImage);
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _yearFocusNode.dispose();
    _modelFocusNode.dispose();

    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Vehicle? tempVehicle =
          ModalRoute.of(context)?.settings.arguments as Vehicle;
      if (tempVehicle.id != 'temp') {
        cameraValue = tempVehicle.imgUrl != null ? 'netImg' : 'camera';
        _editedVehicle = tempVehicle;
        _storedImage = _editedVehicle.image;
        transmissionValue = _editedVehicle.transmission ?? 'null';
        tiresValue = _editedVehicle.tires ?? 'null';
        fuelTypeValue = _editedVehicle.fuelType ?? 'null';
      } else {
        _editedVehicle = Vehicle(
            id: 'tempId',
            model: 'tempModel',
            brand: 'tempBrand',
            year: 'tempYear',
            description: 'tempDescription');
      }

      _isNew = _editedVehicle.id == 'tempId';
      generatedDescription.text = _isNew ? '' : _editedVehicle.description;
      opt = _isNew ? false : true;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _generateDescription() {
    setState(() {
      generatedDescription.text =
          'I really like to drive this vehicle around the city because it is very comfortable and I enjoy it in case of traffic jam. In addition, it has a very nice color that attracts the attention of passers-by and tinted windows so that no one would see my face.';
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  void _saveForm() {
    final bool? isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState!.save();
    _editedVehicle.image = cameraValue != 'netImg' ? _pickedImage : null;
    _editedVehicle.transmission =
        transmissionValue == 'null' ? null : transmissionValue;

    _editedVehicle.tires = tiresValue == 'null' ? null : tiresValue;
    _editedVehicle.fuelType = fuelTypeValue == 'null' ? null : fuelTypeValue;
    print(_selectedDate);
    _editedVehicle.regDate = _selectedDate;

    if (_editedVehicle.id != 'tempId') {
      context.read<VehicleList>().update(_editedVehicle);
      final temp = context.read<VehicleList>().findById(_editedVehicle.id);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamed('/vehicle_details', arguments: {'vehicle': temp});
    } else {
      //final _newVehiclemap={pickedYear}
      Provider.of<VehicleList>(context, listen: false)
          .addVehicle(_editedVehicle);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    /* if(_editedVehicle==null) {
      print('nesto ne valja');
      Navigator.of(context).pop();
    } */
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          /* appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: _isNew ? Text('Add vehicle') : Text('Edit vehicle'),
            actions: <Widget>[
              IconButton(
                icon: _isNew ? Icon(Icons.add) : Icon(Icons.save),
                onPressed: _saveForm,
              ),
            ],
          ), */
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        iconSize: 30,
                        icon: Icon(Icons.arrow_back_rounded)),
                    _isNew
                        ? Text('Add Vehicle',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25))
                        : Text('Edit Vehicle',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                    IconButton(
                      icon: _isNew ? Icon(Icons.add) : Icon(Icons.save),
                      iconSize: 33,
                      onPressed: _saveForm,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Required',
                              style: TextStyle(
                                  fontFamily: 'SGotham', fontSize: 18)),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  initialValue:
                                      _isNew ? '' : _editedVehicle.brand,
                                  decoration:
                                      InputDecoration(labelText: 'Brand'),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_yearFocusNode);
                                  },
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please provide a brand.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedVehicle = Vehicle(
                                        brand: value!.toUpperCase(),
                                        year: _editedVehicle.year,
                                        model: _editedVehicle.model,
                                        description: _editedVehicle.description,
                                        id: _editedVehicle.id);
                                  },
                                ),
                              ),
                              addHorizontalSpace(30),
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                    initialValue:
                                        _isNew ? '' : _editedVehicle.year,
                                    decoration: const InputDecoration(
                                        labelText: 'Year'),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    focusNode: _yearFocusNode,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_modelFocusNode);
                                    },
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Please enter a year.';
                                      }
                                      if (double.tryParse(value!) == null) {
                                        return 'Please enter a valid number.';
                                      }
                                      if (double.parse(value) >
                                              DateTime.now().year ||
                                          1950 > double.parse(value)) {
                                        return 'Please enter a valid number.';
                                      }
                                      if (double.parse(value) <= 0) {
                                        return 'Please enter a number greater than zero.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _editedVehicle = Vehicle(
                                          brand: _editedVehicle.brand,
                                          year: value!,
                                          model: _editedVehicle.model,
                                          description:
                                              _editedVehicle.description,
                                          id: _editedVehicle.id);
                                    }),
                              ),
                            ],
                          ),
                          addVerticalSpace(20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    TextFormField(
                                        initialValue:
                                            _isNew ? '' : _editedVehicle.model,
                                        decoration:
                                            InputDecoration(labelText: 'Model'),
                                        textInputAction: TextInputAction.next,
                                        focusNode: _modelFocusNode,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _descriptionFocusNode);
                                        },
                                        validator: (value) {
                                          if (value == '') {
                                            return 'Please provide a model.';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _editedVehicle = Vehicle(
                                              brand: _editedVehicle.brand,
                                              year: _editedVehicle.year,
                                              model: value!.toUpperCase(),
                                              description:
                                                  _editedVehicle.description,
                                              id: _editedVehicle.id);
                                        }),
                                    addVerticalSpace(10),
                                  ],
                                ),
                              ),
                              addHorizontalSpace(25),
                              Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Column(
                                          children: [
                                            Text('Generate'),
                                            Text('Description'),
                                          ],
                                        )),
                                    onPressed: _generateDescription,
                                  ))
                            ],
                          ),
                          TextFormField(
                            controller: generatedDescription,
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                            focusNode: _descriptionFocusNode,
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter a description.';
                              }
                              if (value!.length < 5) {
                                return 'Should be at least 5 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedVehicle = Vehicle(
                                  brand: _editedVehicle.brand,
                                  year: _editedVehicle.year,
                                  model: _editedVehicle.model,
                                  description: value!,
                                  id: _editedVehicle.id);
                            },
                          ),
                          addVerticalSpace(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Optional Informations',
                                  style: TextStyle(
                                      fontFamily: 'SGotham', fontSize: 18)),
                              addVerticalSpace(20),
                              Container(
                                  child: Switch(
                                value: opt,
                                onChanged: (value) {
                                  setState(() {
                                    opt = value;
                                  });
                                },
                              )),
                            ],
                          ),
                          if (opt)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                cameraValue == 'netImg'
                                    ? Container(
                                        width: 100,
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                          top: 8,
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: _imageUrlController.text.isEmpty
                                            ? _editedVehicle.imgUrl != null
                                                ? FittedBox(
                                                    child: Image.network(
                                                      _editedVehicle.imgUrl!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(
                                                    child: const Text(
                                                        'Enter a URL'),
                                                    alignment: Alignment.center,
                                                  )
                                            : FittedBox(
                                                child: Image.network(
                                                  _imageUrlController.text,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: _storedImage != null
                                            ? Image.file(
                                                _storedImage!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              )
                                            : const Text(
                                                'No Image Taken',
                                                textAlign: TextAlign.center,
                                              ),
                                        alignment: Alignment.center,
                                      ),
                                addHorizontalSpace(20),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropdownButton(
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('Camera'),
                                          value: 'camera',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Gallery'),
                                          value: 'gallery',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Network Image'),
                                          value: 'netImg',
                                        ),
                                      ],
                                      value: cameraValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          cameraValue = newValue.toString();
                                          _imageUrlController.clear();
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                    cameraValue == 'camera'
                                        ? Container(
                                            width: size.width * 0.5,
                                            child: ElevatedButton.icon(
                                              icon: Icon(Icons.camera),
                                              label: Text('Take Picture'),
                                              onPressed: () =>
                                                  _takePicture('camera'),
                                            ),
                                          )
                                        : cameraValue == 'gallery'
                                            ? Container(
                                                width: size.width * 0.5,
                                                child: ElevatedButton.icon(
                                                  icon: Icon(Icons.file_copy),
                                                  label:
                                                      Text('Pick From Gallery'),
                                                  onPressed: () =>
                                                      _takePicture('gallery'),
                                                ),
                                              )
                                            : Container(
                                                width: size.width * 0.5,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Image URL'),
                                                  keyboardType:
                                                      TextInputType.url,
                                                  //textInputAction: TextInputAction.done,
                                                  controller:
                                                      _imageUrlController,
                                                  focusNode: _imageUrlFocusNode,

                                                  validator: (value) {
                                                    if (!value!.startsWith(
                                                            'http') &&
                                                        !value.startsWith(
                                                            'https') &&
                                                        value.isNotEmpty) {
                                                      return 'Please enter a valid URL.';
                                                    }
                                                    if (!value
                                                            .endsWith('.png') &&
                                                        !value
                                                            .endsWith('.jpg') &&
                                                        !value.endsWith(
                                                            '.jpeg') &&
                                                        value.isNotEmpty) {
                                                      return 'Please enter a valid image URL.';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    print('sace');
                                                    print(value);
                                                    if (value != '') {
                                                      _editedVehicle.imgUrl =
                                                          value;
                                                    } else {
                                                      _editedVehicle.imgUrl =
                                                          null;
                                                    }
                                                  },
                                                ),
                                              ),
                                  ],
                                ),
                              ],
                            ),
                          addVerticalSpace(25),
                          if (opt)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Transmission'),
                                    DropdownButton(
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('None'),
                                          value: 'null',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Manual'),
                                          value: 'Manual',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Automatic'),
                                          value: 'Automatic',
                                        )
                                      ],
                                      value: transmissionValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          transmissionValue =
                                              newValue.toString();

                                          print(transmissionValue);
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                    )
                                  ],
                                ),
                                addHorizontalSpace(20),
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: TextFormField(
                                      initialValue:
                                          _isNew ? '' : _editedVehicle.engine,
                                      decoration: const InputDecoration(
                                          labelText: 'Engine Power'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value != '' &&
                                            double.parse(value!) <= 0) {
                                          return 'Please enter a number greater than zero.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _editedVehicle.engine =
                                            value == '' ? null : value;
                                      }),
                                )
                              ],
                            ),
                          addVerticalSpace(25),
                          if (opt)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: size.width * 0.4,
                                  child: TextFormField(
                                      initialValue:
                                          _isNew ? '' : _editedVehicle.mileage,
                                      decoration: const InputDecoration(
                                          labelText: 'Mileage'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value != '' &&
                                            double.parse(value!) <= 1) {
                                          return 'Please enter a number greater than zero.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _editedVehicle.mileage =
                                            value == '' ? null : value;
                                      }),
                                ),
                                addHorizontalSpace(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Tires'),
                                    DropdownButton(
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('None'),
                                          value: 'null',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('All-season'),
                                          value: 'All-season',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Summer'),
                                          value: 'Summer',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Winter'),
                                          value: 'Winter',
                                        )
                                      ],
                                      value: tiresValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          tiresValue = newValue.toString();

                                          //print(tiresValue);
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          addVerticalSpace(25),
                          if (opt)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Fuel Type'),
                                    DropdownButton(
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('None'),
                                          value: 'null',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Gasoline'),
                                          value: 'Gasoline',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Diesel'),
                                          value: 'Diesel',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Bio-Diesel'),
                                          value: 'Bio-Diesel',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Electricity'),
                                          value: 'Electricity',
                                        )
                                      ],
                                      value: fuelTypeValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          fuelTypeValue = newValue.toString();

                                          //print(tiresValue);
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                    )
                                  ],
                                ),
                                addHorizontalSpace(20),
                                Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          //alignment: Alignment.topLeft,
                                          child: Text('Registration Date')),
                                      OutlinedButton(
                                        child: const Text(
                                          'Choose Date',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: _presentDatePicker,
                                      ),
                                      Text(
                                        _selectedDate == null
                                            ? 'No Date Chosen!'
                                            : 'Picked Date:\n ${DateFormat.yMd().format(_selectedDate!)}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
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
}
