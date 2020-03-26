abstract class BaseModel {
  static String table;

  Map<String, dynamic> toMap();

  String getTable();

  int getPrimaryKey();

}