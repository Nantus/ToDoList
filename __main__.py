import sys
from toDoModel import ToDoModel
from proxyModel import FilterModel
from PySide2.QtGui import QResizeEvent
from PySide2.QtCore import QUrl, Signal, Slot, QModelIndex, QSize
from PySide2.QtWidgets import QApplication
from PySide2.QtQuick import QQuickView


class MyView(QQuickView):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setMinimumSize(QSize(600,650))
        self.model = ToDoModel()
        self.filter_model = FilterModel()
        self.filter_model.setSourceModel(self.model)

        self.rootContext().setContextProperty('ToDoModel', self.filter_model)
        self.rootContext().setContextProperty('myView', self)
        self.setSource(QUrl('qml/MainPage.qml'))

    def resizeEvent(self, event):
        root = self.rootObject()
        root.setWidth(self.width())
        root.setHeight(self.height())


if __name__ == '__main__':
    app = QApplication()

    mw = MyView()
    mw.show()

    sys.exit(app.exec_())
