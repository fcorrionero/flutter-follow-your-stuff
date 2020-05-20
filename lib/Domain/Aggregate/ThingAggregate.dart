
class ThingAggregate {

  final int _id;
  final String _name;
  final String _createdAt;

  ThingAggregate(this._id, this._name, this._createdAt);

  String get createdAt => _createdAt;

  String get name => _name;

  int get id => _id;


}