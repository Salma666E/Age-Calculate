import 'package:age/age.dart' as Ag;
import 'package:age_cal/utilts.dart';
import 'package:flutter/material.dart';

import 'age_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Age userAge = Age();
  late DateTime dataTime;
  late Duration _nextBirthDay = Duration();
  final TextEditingController _dateOfBirthController =
      TextEditingController(text: "01-01-2000");
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeading("Date of Birth"),
              TextField(
                showCursor: false,
                readOnly: true,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1940),
                          lastDate: DateTime.now())
                      .then((date) {
                    dataTime = date!;
                    _dateOfBirthController.text =
                        '${date.year} /${date.month} /${date.day}';
                  });
                },
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  suffixIcon: Icon(
                    Icons.date_range,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: '2017-04-10',
                ),
              ),
              emptyBox,
              buildHeading("Today Date"),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                    text: '${today.year} /${today.month} /${today.day}'),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  suffixIcon: Icon(
                    Icons.date_range,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              emptyBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: buildButton(context, () {
                      clearAge();
                    }, 'CLEAR'),
                  ),
                  Flexible(
                    flex: 2,
                    child: buildButton(context, () {
                      calculateAge();
                    }, 'CALCULATE'),
                  ),
                ],
              ),
              emptyBox,
              buildHeading("Age is"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildOutputField(context, "Years", userAge.years.toString()),
                  buildOutputField(
                      context, "Months", userAge.months.toString()),
                  buildOutputField(context, "Days", userAge.days.toString()),
                ],
              ),
              emptyBox,
              buildHeading("Next Birth Day in"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildOutputField(context, "Years", "-"),
                  buildOutputField(
                      context, "Months", _nextBirthDay.months.toString()),
                  buildOutputField(
                      context, "Days", _nextBirthDay.days.toString()),
                ],
              ),
            ],
          ),
        ));
  }

  clearAge() {
    setState(() {
      _dateOfBirthController.text = 'Choose your birthday!!';
      userAge.years = 0;
      userAge.months = 0;
      userAge.days = 0;
      _nextBirthDay.months = 0;
      _nextBirthDay.days = 0;
    });
  }

  calculateAge() {
    setState(() {
      // Find out your age
      Ag.AgeDuration age;
      age = Ag.Age.dateDifference(
          fromDate: dataTime, toDate: today, includeToDate: false);
      userAge.years = age.years;
      userAge.months = age.months;
      userAge.days = age.days;
      // Find out when your next birthday will be.
      DateTime tempDate = DateTime(today.year, dataTime.month, dataTime.day);
      DateTime nextBirthdayDate = tempDate.isBefore(today)
          ? Ag.Age.add(date: tempDate, duration: Ag.AgeDuration(years: 1))
          : tempDate;
      Ag.AgeDuration nextBirthdayDuration =
          Ag.Age.dateDifference(fromDate: today, toDate: nextBirthdayDate);
      _nextBirthDay.months = nextBirthdayDuration.months;
      _nextBirthDay.days = nextBirthdayDuration.days;
    });
  }
}
