const String table= 'items';
class Fields{

  static final List<String>values= [id,title,content,isDone,number,created];

  static const String id= '_id';
  static const String title= 'title';
  static const String content= 'content';
  static const String isDone= 'isDone';
  static const String number= 'number';
  static const String created= 'created';
}

class Item{
  final int? id;
  final String title;
  final String content;
  final int isDone;
  final int number;
  final DateTime created;

  const Item({
    this.id,
    required this.title,
    required this.content,
    required this.isDone,
    required this.number,
    required this.created
  });

  Item copy ({int? id, String? title,String? content, int? isDone,int? number, DateTime? created}) =>
      Item(title: title?? this.title, content: content?? this.content, isDone: isDone?? this.isDone, number: number?? this.number, created: created?? this.created);

  Map<String, Object?> toJson()=>{
    Fields.id : id,
    Fields.title : title,
    Fields.content : content,
    Fields.isDone : isDone,
    Fields.number : number,
    Fields.created : created.toIso8601String(),
  };

  static Item fromJson(Map<String, Object?> json)=> Item(
      id: json[Fields.id] as int?,
      title: json[Fields.title] as String,
      content: json[Fields.content] as String,
    isDone: json[Fields.isDone] as int,
      number: json[Fields.number] as int,
      created: DateTime.parse(json[Fields.created] as String),);

}