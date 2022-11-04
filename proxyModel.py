from PySide2.QtCore import QSortFilterProxyModel
from PySide2.QtCore import QModelIndex, Slot

class FilterModel(QSortFilterProxyModel):
    mode_show_all = 'All'
    mode_show_in_progress = 'In progress'
    mode_show_done = 'Done'

    def __init__(self, parent=None):
        super().__init__(parent)
        self.filter_mode = self.mode_show_all


    def filterAcceptsRow(self, source_row: int, source_parent: QModelIndex) -> bool:
        model = self.sourceModel()

        if self.filter_mode == self.mode_show_all:
            return True
        elif self.filter_mode == self.mode_show_done:
            return model.createIndex(source_row, 0).data(model.ToDoIsDone)
        elif self.filter_mode == self.mode_show_in_progress:
            return not model.createIndex(source_row, 0).data(model.ToDoIsDone)

    @Slot(str)
    def changeFilterMode(self, new_mode):
        self.filter_mode = new_mode
        self.invalidateFilter()

    @Slot(int, bool)
    def setDone(self, row, status):
        self.sourceModel().setDone(row, status)

    @Slot(str, str, str)
    def addTask(self, name, date, description):
        self.beginResetModel()
        self.sourceModel().addTask(name, date, description)
        self.endResetModel()

    @Slot(int, str, str, str)
    def editTask(self, row, name, date, description):
        self.sourceModel().editTask(row, name, date, description)