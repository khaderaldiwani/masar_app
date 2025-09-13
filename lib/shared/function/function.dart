String? valid(String val, int max, int min) {
  if (val.isEmpty) {
    return "لا يمكن أن تكون قيمة هذا الحقل فارغة";
  }
  if (val.length<min) {
    return "لا يمكن أن تكون قيمة هذا الحقل أقل من $min محارف";
  }
  if (val.length>max) {
    return "لا يمكن أن تكون قيمة هذا الحقل أكثر من $max محارف";
  }
  return null;
}

String formatDate(String dateTimeString) {
  DateTime dt = DateTime.parse(dateTimeString);
  return dt.toIso8601String().split("T")[0]; 
}
