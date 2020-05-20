
class ElementAggregate {

  final int _id;
  final String _name;
  final String _createdAt;
  final int _thingId;

  ElementAggregate(this._id, this._name, this._createdAt, this._thingId);

  int get thingId => _thingId;

  String get createdAt => _createdAt;

  String get name => _name;

  int get id => _id;

}