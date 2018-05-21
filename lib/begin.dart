import 'package:flutter/material.dart';

import 'registry.dart';
import 'city.dart';
import 'weed.dart';

import 'dart:async';
import 'package:intl/intl.dart';

class BeginScreen extends StatefulWidget {
  BeginScreen({Key key}) : super(key: key);

  @override
  _BeginScreenState createState() => new _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<String> _allCountries = <String>['United States', 'England', 'Australia', 'Guatemala'];
  String _country ;
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = new DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);

  @override
  initState()  {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new AppBarX(_scaffoldKey),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            //padding: const EdgeInsets.all(16.0),
            children: <Widget>[

              new TextCont('The beginning', 36.0, 30.0, 30.0),
              new TextCont('They say wisdom comes with the years.', 20.0, 0.0, 40.0),
              new TextCont('Let\'s start by knowing when and where you were born?',
                  20.0, 0.0, 40.0),

              new Container(
                child: new ListTile(

                  title: new _DateTimePicker(
                    labelText: 'Date of birth',
                    selectedDate: _fromDate,
                    selectedTime: _fromTime,
                    selectDate: (DateTime date) {
                      setState(() {
                        _fromDate = date;
                      });
                    },
                  ),

                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),



              new TextCont('I was born in', 20.0, 0.0, 20.0, TextAlign.left, FontWeight.w700),

              new Container(
              child: new ListTile(
                title: new InputDecorator(
                  decoration: new InputDecoration(
                    labelText: 'Select Country',
                    hintText: 'Choose a country',
                    isDense: true,
                    border: null,

                    suffixIcon: new Icon(Icons.arrow_drop_down, size: 24.0,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
                      ),
                      contentPadding: new EdgeInsets.all(0.0),
   //labelStyle: new TextStyle(inherit: false, fontSize: 14.0, textBaseline: TextBaseline.alphabetic),

                    ),
//baseStyle: new TextStyle(inherit: false, fontSize: 14.0, textBaseline: TextBaseline.alphabetic),
                  isEmpty: _country == null,

                  child: new DropdownButton<String>(
//style: new TextStyle(inherit: false, fontSize: 14.0, textBaseline: TextBaseline.alphabetic),
                      value: _country,
                      isDense: true,
                      iconSize: 0.0,
                      onChanged: (String newValue) {
                        setState(() {
                          _country = newValue;
                        });
                      },
                      items: _allCountries.map((String value) {
                        return new DropdownMenuItem<String>(

                          value: value,
                          child: new Text(value),

                        );
                      }).toList(),

                    ),
                  ),

                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 20.0),

              ),

              new Container(
                child: new ListTile(
                  title: new InputDecorator(
                    decoration: new InputDecoration(
                      labelText: 'Select City',
                      hintText: 'Choose a city',
                      isDense: true,
                      border: null,

                      suffixIcon: new Icon(Icons.arrow_drop_down, size: 24.0,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
                      ),
                      contentPadding: new EdgeInsets.all(0.0),
                    ),
                    isEmpty: _country == null,

                    child: new DropdownButton<String>(
                      value: _country,
                      isDense: true,
                      iconSize: 0.0,
                      onChanged: (String newValue) {
                        setState(() {
                          _country = newValue;
                        });
                      },
                      items: _allCountries.map((String value) {
                        return new DropdownMenuItem<String>(

                          value: value,
                          child: new Text(value),

                        );
                      }).toList(),

                    ),
                  ),

                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 30.0),

              ),

              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new CityScreen()),
                  );
                },
                child: new Text('Continue'),
              ),
              ]),

      ),
    );
  }
}



class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(1900, 1),
        lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }


  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
        //twee
        // const SizedBox(width: 12.0),

      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
            ),
          ],
        ),
      ),
    );
  }
}


