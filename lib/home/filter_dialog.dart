import 'package:flutter/material.dart';
import 'package:vote_app/networking/providers/types_api_provider.dart';
import 'package:vote_app/repository/group_repository.dart';

class FilterDialog extends StatefulWidget {
  final Function(String,String) filter;
  FilterDialog(this.filter);
  @override
  State<StatefulWidget> createState() => FilterDialogState(filter);
}

class FilterDialogState extends State<FilterDialog> {
  List<String> dropdownValuesGroup = List<String>();
  List<String> dropdownValuesType = List<String>();
  String selectedGroup = "";
  String selectedType = "";
  TypesApiProvider _typesApiProvider = TypesApiProvider();
  GroupRepository _groupRepository = GroupRepository();
  final Function(String,String) filter;

  FilterDialogState(this.filter);

  @override
  void initState() {
    super.initState();
    _groupRepository.getAll().then((response) {
      List<String> tmp = List<String>();
      for (var i = 0; i < response.length; i++) {
        tmp.add(response[i].name);
      }
      setState(() {
        dropdownValuesGroup = tmp;
        selectedGroup = dropdownValuesGroup.first;
      });
    });
    _typesApiProvider.getTypes().then((response) {
      setState(() {
        dropdownValuesType = response;
        selectedType = dropdownValuesType.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
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
            Container(
                padding: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width - 96,
                child: Center(
                  child: new FlatButton(
                    child: new Text(
                      "Apply",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    onPressed: () {
                      filter(selectedGroup,selectedType);
                      Navigator.of(context).pop();
                    },
                  ),
                )),
          ],
        ));
  }
}
