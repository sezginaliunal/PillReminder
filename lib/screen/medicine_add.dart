import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medication/components/customize_appBar.dart';
import 'package:medication/constant/buttonStyles.dart';
import 'package:medication/services/notifications.dart';
import '../constant/TextStyles.dart';
import '../constant/colors.dart';
import '../constant/height.dart';
import '../data/dbHelper.dart';
import '../models/medicine.dart';

class MedicineAdd extends StatefulWidget {
  const MedicineAdd({super.key});

  @override
  State<MedicineAdd> createState() => _MedicineAddState();
}

class _MedicineAddState extends State<MedicineAdd> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDosage = TextEditingController();
  String? _selectedValue;
  String? _selectedDosageType;
  String? _selectedImage;
  TimeOfDay? _selectedTime;
  Timer? _timer;
  NotificationServices notificationServices = NotificationServices();
  DateTime _startDate = DateTime.now();
  void _selectStartDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (selectedDate != null) {
      setState(() {
        _startDate = selectedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _setTimer() {
    print("BAŞLADI");
    print(_selectedTime!.hour);
    print(_selectedTime!.minute);
    int hour = _selectedTime!.hour;
    int minute = _selectedTime!.minute;
    int second = 0;
    var now = DateTime.now();
    var selectedTime =
        DateTime(now.year, now.month, now.day, hour, minute, second);

    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      var now = DateTime.now();
      if (now.hour == selectedTime.hour &&
          now.minute == selectedTime.minute &&
          now.second == selectedTime.second) {
        notificationServices.schedule(
            txtName.text, txtDosage.text, selectedTime);
      }
    });
  }

  @override
  void initState() {
    _selectedValue = 'Syringe';
    _selectedDosageType = "MG";
    _selectedImage = "assets/icons/syringe.png";
    _selectedTime = TimeOfDay.now();
  }

  @override
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Medicine",
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                buildNameField(),
                buildDosageField(),
                Height.otuz,
                Column(
                  children: [
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.deepPurple.shade50,
                      value: _selectedDosageType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Dosage type',
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.deepPurple,
                      ),
                      onChanged: (String? newValue) {},
                      items: <String>[
                        "MG",
                        "ML",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                    Height.otuz,
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Image type',
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.deepPurple,
                      ),
                      dropdownColor: Colors.deepPurple.shade50,
                      value: _selectedValue,
                      items: [
                        DropdownMenuItem(
                          child: Text('Syringe'),
                          value: 'Syringe',
                        ),
                        DropdownMenuItem(
                          child: Text('Spoon'),
                          value: 'Spoon',
                        ),
                        DropdownMenuItem(
                          child: Text('Spray'),
                          value: 'Spray',
                        ),
                        DropdownMenuItem(
                          child: Text('Bottle'),
                          value: 'Bottle',
                        ),
                        DropdownMenuItem(
                          child: Text('Pieces'),
                          value: 'Pieces',
                        ),
                        DropdownMenuItem(
                          child: Text('Pill'),
                          value: 'Pill',
                        ),
                        DropdownMenuItem(
                          child: Text('Serum'),
                          value: 'Serum',
                        ),
                        DropdownMenuItem(
                          child: Text('Tablet'),
                          value: 'Tablet',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          if (value == 'Syringe')
                            _selectedImage = "assets/icons/syringe.png";
                          if (value == 'Spoon')
                            _selectedImage = "assets/icons/spoon.png";
                          if (value == 'Spray')
                            _selectedImage = "assets/icons/spray.png";
                          if (value == 'Bottle')
                            _selectedImage = "assets/icons/bottle.png";
                          if (value == 'Pieces')
                            _selectedImage = "assets/icons/pieces.png";
                          if (value == 'Pill')
                            _selectedImage = "assets/icons/pill.png";
                          if (value == 'Serum')
                            _selectedImage = "assets/icons/serum.png";
                          if (value == 'Tablet')
                            _selectedImage = "assets/icons/tablet.png";
                        });
                      },
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.watch_later_outlined,
                          color: ColorItems.mor,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Add Time",
                            style: Styles.info,
                          ),
                        ),
                        Text(
                          '${_selectedTime?.format(context)}',
                          style: Styles.TextWidgets,
                        ),
                      ],
                    ),
                  ),
                ),
                Height.bes,
                GestureDetector(
                  onTap: _selectStartDate,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_month_outlined,
                          color: ColorItems.mor,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Start Time",
                            style: Styles.info,
                          ),
                        ),
                        Text(
                          "${_startDate.day}/${_startDate.month}/${_startDate.year}",
                          style: Styles.TextWidgets,
                        ),
                      ],
                    ),
                  ),
                ),
                Height.bes,
                buildSaveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildNameField() {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: txtName,
        decoration: InputDecoration(
          icon: Icon(Icons.healing),
          labelText: "Medicine Name",
        ),
        onSaved: (String? value) {},
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Name Required";
          }
        },
      ),
    );
  }

  buildDosageField() {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: txtDosage,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.healing),
          labelText: "Dosage",
        ),
        onSaved: (String? value) {},
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Dosage Required";
          }
        },
      ),
    );
  }

  buildSaveButton() {
    return TextButton(
      style: ButtonStyles.confirmButton,
      onPressed: () {
        setState(() {});
        if (_formKey.currentState!.validate()) {
          addMedicine();
        }
      },
      child: Text("Confirm", style: Styles.confirmText),
    );
  }

  void addMedicine() async {
    var result = await dbHelper.insert(
      Medicine(
          name: txtName.text,
          dosage: txtDosage.text,
          hour: _selectedTime!.format(context).toString(),
          dosageType: _selectedDosageType,
          date: "${_startDate.day}/${_startDate.month}/${_startDate.year}",
          image: _selectedImage.toString()),
    );
    _setTimer();
    Navigator.pop(context, true);
  }
}
