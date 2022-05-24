class AddAudioToSelectionService {
  AddAudioToSelectionService();
  List<String> checkedList = [];

  void checkEvent(bool isChecked, String id) {
    if (isChecked) {
      checkedList.remove(id);
    } else {
      checkedList.add(id);
    }
  }
}
