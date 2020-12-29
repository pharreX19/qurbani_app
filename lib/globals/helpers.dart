Map<String, dynamic> toFireStoreJson(Map<String, dynamic> json){
  json.removeWhere((key, value) => value == null || value =="" || key == 'id');
  return json;
}