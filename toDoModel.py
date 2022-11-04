from PySide2.QtCore import QAbstractListModel, Qt, Slot, QModelIndex, QUrl

class ToDoModel(QAbstractListModel):
    ToDoName = Qt.UserRole + 1
    ToDoDate = Qt.UserRole + 2
    ToDoDescription = Qt.UserRole + 3
    ToDoIsDone = Qt.UserRole + 4
    ToDoID = Qt.UserRole + 5

    id_text = 'Id'
    name_text = 'Name'
    date_text = 'Date'
    description_text = 'Description'
    is_done_text = 'IsDone'
        
    def __init__(self, parent=None):
        super().__init__(parent)
        
        self._todo_list = [
            {
                self.id_text: 0,
                self.name_text: 'Homework',
                self.date_text: '11.03.2022',
                self.description_text: 'Do the homework',
                self.is_done_text: False
            },
            {
                self.id_text: 1,
                self.name_text: 'Feed the dog',
                self.date_text: '11.02.2022',
                self.description_text: 'Go feed our buddy',
                self.is_done_text: True
            },
            {
                self.id_text: 2,
                self.name_text: 'Call Soul',
                self.date_text: '11.10.2022',
                self.description_text: 'Better call him',
                self.is_done_text: False
            }
        ]

    def data(self, QModelIndex, role):
        row = QModelIndex.row()
        if role == self.ToDoName:
            return self._todo_list[row][self.name_text]
        if role == self.ToDoDate:
            return self._todo_list[row][self.date_text]
        if role == self.ToDoDescription:
            return self._todo_list[row][self.description_text]
        if role == self.ToDoIsDone: 
            return self._todo_list[row][self.is_done_text]
        if role == self.ToDoID:
            return self._todo_list[row][self.id_text]

    def rowCount(self, parent=None):
        return len(self._todo_list)

    def roleNames(self):
        return {self.ToDoName: str.encode(self.name_text),
                self.ToDoDate: str.encode(self.date_text),
                self.ToDoDescription: str.encode(self.description_text),
                self.ToDoIsDone: str.encode(self.is_done_text),
                self.ToDoID: str.encode(self.id_text)}

    @Slot(int, bool)
    def setDone(self, row, status):
        self._todo_list[row][self.is_done_text] = status

    @Slot(str, str, str)
    def addTask(self, name, date, description):
        lastId = self._todo_list[-1][self.id_text]
        self.beginResetModel()
        self._todo_list.append({
            self.id_text: lastId+1,
            self.name_text: name,
            self.date_text: date,
            self.description_text: description,
            self.is_done_text: False})
        self.endResetModel()

    @Slot(int, str, str, str)
    def editTask(self, row, name, date, description):
        self.beginResetModel()
        self._todo_list[row][self.name_text] = name
        self._todo_list[row][self.date_text] = date
        self._todo_list[row][self.description_text] = description
        self.endResetModel()
