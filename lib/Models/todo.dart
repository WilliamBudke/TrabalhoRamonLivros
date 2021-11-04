class Todo {
  int _id;
  String _title = 'title';
  String _desc = 'desc';
  String _date = 'date';
  String _autor = 'autor';
  String _editora = 'editora';

  Todo(this._title, this._date,this._autor,this._editora, [this._desc]);// construtor do objeto
  Todo.comId(this._id, this._title, this._date,this._autor,this._editora, [this._desc]);//construtor nomeado

  int get id => _id;

  String get title => _title;

  String get desc => _desc;

  String get autor => _autor;

  String get editora => _editora;

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDesc) {
    if (newDesc.length <= 255) {
      this._desc = newDesc;
    }
  }

  set editora(String newEditora) {
    if (newEditora.length <= 255) {
      this._editora = newEditora;
    }
  }

  set autor(String newAutor) {
    if (newAutor.length <= 255) {
      this._autor = newAutor;
    }
  }


  set date(String newDate) {
    this._date = newDate;
  }


  Map<String, dynamic> toMap() {
    //convete um obj para um mapa
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['desc'] = _desc;
    map['autor'] = _autor;
    map['editora'] = _editora;
    map['date'] = _date;
    return map;
  }

  Todo.fromMapObject(Map<String, dynamic> map) {
    //Pega um mapa e convente para um obj.
    this._id = map['id'];
    this._title = map['title'];
    this._desc = map['desc'];
    this._editora = map['editora'];
    this._autor = map['autor'];
    this._date = map['date'];
  }
}