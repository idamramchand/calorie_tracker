class StateModel {
  late String Id;
  late String Value;

  StateModel({required this.Id,required this.Value});

  factory StateModel.fromJson(Map<String, dynamic> item) {
    return StateModel(Id:item['Id'], Value: item['Value']);
  }
  factory StateModel.fromJsn(Map<dynamic,dynamic>item){
    return StateModel(Id: item['Text'],Value: item['Value'].toString());
  }
  factory StateModel.fromJsn1(Map<dynamic,dynamic>item){
    return StateModel(Id: item['Value'].toString(),Value: item['Text'].toString());
  }

  factory StateModel.stateJson(Map<String, dynamic> item) {
    return StateModel(Id:item['StateId'], Value: item['StateName']);
  }

  factory StateModel.regJsn(Map<dynamic,dynamic>item){
    return StateModel(Id: item['Value'].toString(),Value: item['Text'].toString());
  }



  factory StateModel.stateJson1(Map<String, dynamic> item) {
    return StateModel(Id:item['Text'], Value: item['Value']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Text'] = Id;
    data['Value'] = Value;
    return data;
  }

  factory StateModel.schemeJson(Map<String, dynamic> item) {
    return StateModel(Id:item['Text'], Value: item['Value']);
  }


}