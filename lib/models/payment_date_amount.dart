List<Map<String, dynamic>> subArr = [
  {"Date": "01/01/2023", "icon": "assets/images/logo.png", "price": "1500"},
  {"Date": "01/02/2023", "icon": "assets/images/logo.png", "price": "1350"},
  {"Date": "01/03/2023", "icon": "assets/images/logo.png", "price": "1200"},
  {"Date": "01/04/2023", "icon": "assets/images/logo.png", "price": "1050"},
  {"Date": "01/05/2023", "icon": "assets/images/logo.png", "price": "900"},
  {"Date": "01/06/2023", "icon": "assets/images/logo.png", "price": "750"},
  {"Date": "01/07/2023", "icon": "assets/images/logo.png", "price": "600"},
  {"Date": "01/08/2023", "icon": "assets/images/logo.png", "price": "400"},
  {"Date": "01/09/2023", "icon": "assets/images/logo.png", "price": "300"},
  {"Date": "01/10/2023", "icon": "assets/images/logo.png", "price": "150"}
];

List<Map<String, dynamic>> makeit() {
  final now = DateTime.now();
  final currentDate = now;

  final filteredData = subArr.where((data) {
    final dateParts = data['Date'].split('/');
    final dataDay = int.parse(dateParts[0]);
    final dataMonth = int.parse(dateParts[1]);
    final dataYear = int.parse(dateParts[2]);
    final dataDate = DateTime(dataYear, dataMonth, dataDay);
    return dataDate.isBefore(currentDate) ||
        dataDate.isAtSameMomentAs(currentDate);
  }).toList();

  // Sort the filtered data in descending order based on date
  filteredData.sort((a, b) {
    final datePartsA = a['Date'].split('/');
    final datePartsB = b['Date'].split('/');
    final dateA = DateTime(int.parse(datePartsA[2]), int.parse(datePartsA[1]),
        int.parse(datePartsA[0]));
    final dateB = DateTime(int.parse(datePartsB[2]), int.parse(datePartsB[1]),
        int.parse(datePartsB[0]));
    return dateB.compareTo(dateA);
  });

  return filteredData;
}
