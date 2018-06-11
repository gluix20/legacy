import 'package:flutter/material.dart';
import 'translations.dart';
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
  //DateTime _fromDate = new DateTime.utc(1900,1,1);
  DateTime _fromDate = new DateTime.now();

  @override
  initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new MyAppBar(T(context, k: 'main_title1'), scaffoldKey: _scaffoldKey, context: context,),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[
              new TextContainer(T(context, k: 'beginning_lbl1'),
                  fontSize: 36.0, top: 30.0, bottom: 30.0,),
              new TextContainer(T(context, k: 'wisdom_lbl1'),
                  fontSize: 20.0, top: 0.0, bottom: 40.0,),
              new TextContainer(T(context, k: 'born_lbl1'),
                  fontSize: 20.0, top: 0.0, bottom: 40.0,),

              new Container(
                child: new ListTile(

                  title: new _DateTimePicker(
                    labelText: 'Date of birth',
                    selectedDate: _fromDate,
                    selectDate: (DateTime date) {
                      setState(() {
                        _fromDate = date;
                      });
                    },
                  ),

                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),

              new TextContainer(T(context, k: 'was_born_lbl1'),
                  fontSize: 20.0, top: 0.0, bottom: 20.0, fontW: FontWeight.w700,
              align: TextAlign.left,),

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
                    new MaterialPageRoute(builder: (context) => new CityPage(scaffoldKey: _scaffoldKey,)),
                  );
                },
                child: new TextContainer(T(context, k: 'continue_lbl1'),),

              ),
              ]),

      ),
    );
  }
}



class _DateTimePicker extends StatelessWidget {
  /// Constructor:
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;

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


