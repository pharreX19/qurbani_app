class RequestModel{
  String serviceType;
  DateTime serviceDate;
  String childName;
  String contactNo;
  int serviceQuantity;
  String receiptPath;
  double totalPrice;
  double unitPrice;
  int serviceDay;

RequestModel({
  this.serviceType,
  this.serviceDate,
  this.childName,
  this.contactNo,
  this.serviceQuantity,
  this.receiptPath,
  this.totalPrice,
  this.unitPrice,
  this.serviceDay,
});

}