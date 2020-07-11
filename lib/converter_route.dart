import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.

class ConverterRoute extends StatefulWidget {
  final Color color;

  /// Units for this [Category]
  final List<Unit> units;

  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;

  @override
  void initState(){
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  /// Creates fresh list of [DropdownMenuItem] widgets, given a list of [Unit]s.
  void _createDropdownMenuItems(){
    var newItems=<DropdownMenuItem>[];
    for(var unit in widget.units){
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        )
      ));
    }
    setState(() {
      _unitMenuItems=newItems;
    });
  }

  //Set the default values for the 'from and 'to'
  void _setDefaults(){
    setState(() {
      _fromValue=widget.units[0];
      _toValue=widget.units[1];
    });
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  void _updateConversion(){
    setState(() {
      _convertedValue=_format(_inputValue*(_toValue.conversion/_fromValue.conversion));
    });
  }

  void _updateInputValue(String input){
    setState(() {
      if(input == null|| input.isEmpty){
        _convertedValue='';
      }
      else{
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
      try {
        final inputDouble = double.parse(input);
        _showValidationError = false;
        _inputValue = inputDouble;
        _updateConversion();
      } on Exception catch(e){
        print('Error: $e');
        _showValidationError=true;
      }
      }
    });
  }

  Unit _getUnit(String unitName){
    return widget.units.firstWhere(
        (Unit unit) {
          return unit.name == unitName;
        },
        orElse: null,
        
    );
  }









  @override
  Widget build(BuildContext context) {
    // Here is just a placeholder for a list of mock units
    final unitWidgets = widget.units.map((Unit unit) {
      return Container(
        color: widget.color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text('Conversion: ${unit.conversion}',
                style: Theme.of(context).textTheme.subhead)
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }
}
