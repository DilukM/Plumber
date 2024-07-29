class DropDownValueModel {
  final String name;
  final String value;
  final String? toolTipMsg;

  const DropDownValueModel({
    required this.name,
    required this.value,
    this.toolTipMsg,
  });
}

List<DropDownValueModel> dropDownList = [
  DropDownValueModel(name: 'name1', value: "value1"),
  DropDownValueModel(
    name: 'name2',
    value: "value2",
    toolTipMsg:
        "DropDownButton is a widget that we can use to select one unique value from a set of values",
  ),
  DropDownValueModel(name: 'name3', value: "value3"),
  DropDownValueModel(
    name: 'name4',
    value: "value4",
    toolTipMsg:
        "DropDownButton is a widget that we can use to select one unique value from a set of values",
  ),
  DropDownValueModel(name: 'name5', value: "value5"),
  DropDownValueModel(name: 'name6', value: "value6"),
  DropDownValueModel(name: 'name7', value: "value7"),
  DropDownValueModel(name: 'name8', value: "value8"),
];
