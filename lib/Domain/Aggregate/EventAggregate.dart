
class EventAggregate {

  final int _id;
  final String _description;
  final String _createdAt;
  final String _elementName;
  final int _elementId;
  final String _propertyName;
  final int _propertyId;


  EventAggregate(
      this._id,
      this._description,
      this._createdAt,
      this._elementName,
      this._elementId,
      this._propertyName,
      this._propertyId
  );

  int get elementId => _elementId;

  String get elementName => _elementName;

  String get createdAt => _createdAt;

  String get description => _description;

  int get id => _id;

  int get propertyId => _propertyId;

  String get propertyName => _propertyName;

}