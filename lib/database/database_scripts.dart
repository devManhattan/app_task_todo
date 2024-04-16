class DatabaseScripts {
  //int versão com array de scripts
  static Map<int, List<String>> update = {1: []};

  //Array com todos os create table da criação do banco
  static List<String> create = [
    """CREATE TABLE todo ( id INTEGER PRIMARY KEY, description TEXT, done INTEGER, task_date TEXT,
     creation_date TEXT, updated_date TEXT,
     deleted_date TEXT, priority INTEGER );""",
  ];
}
