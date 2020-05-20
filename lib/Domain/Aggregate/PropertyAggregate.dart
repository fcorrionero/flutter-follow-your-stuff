class PropertyAggregate {

  final int _id;
  final String _name;
  final int _thingId;
  final String _createdAt;

  PropertyAggregate(this._id, this._name, this._thingId, this._createdAt);

  String get createdAt => _createdAt;

  int get thingId => _thingId;

  String get name => _name;

  int get id => _id;

}