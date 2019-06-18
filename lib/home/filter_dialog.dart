import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final List<String> dropdownValuesGroup;
  final List<String> dropdownValuesType;
  FilterDialog({this.dropdownValuesGroup,this.dropdownValuesType});
  @override
  State<StatefulWidget> createState() =>
      FilterDialogState(dropdownValuesGroup,dropdownValuesType);
}

class FilterDialogState extends State<FilterDialog> {
  final List<String> dropdownValuesGroup;
  final List<String> dropdownValuesType;
  String selectedGroup = "";
  String selectedType = "";

  FilterDialogState(this.dropdownValuesGroup,this.dropdownValuesType) {
    selectedGroup = dropdownValuesGroup.first;
    selectedType = dropdownValuesType.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            new Text(
              "Groups",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: Theme.of(context).primaryColor),
                child: DropdownButton(
                  iconEnabledColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  items: dropdownValuesGroup
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String value) {
                    setState(() {
                      selectedGroup = value;
                    });
                  },
                  value: selectedGroup,
                  isExpanded: false,
                  hint: Text(selectedGroup),
                )),
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            new Text(
              "Types",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: Theme.of(context).primaryColor),
                child: DropdownButton(
                  iconEnabledColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  items: dropdownValuesType
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  value: selectedType,
                  isExpanded: false,
                  hint: Text(selectedType),
                )),
          ],
        ));
  }
}
