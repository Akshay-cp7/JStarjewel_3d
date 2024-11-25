// lib/Screens/favorites_manager.dart

List<Map<String, String>> favoritesList = [];

// Function to compare two maps based on their content
bool areMapsEqual(Map<String, String> map1, Map<String, String> map2) {
  return map1['imagePath'] == map2['imagePath'] &&
      map1['price'] == map2['price'] &&
      map1['category'] == map2['category'];
}

// Adds an item to the favorites list if it's not already added
void addFavorite(Map<String, String> item) {
  if (!favoritesList.any((favoriteItem) => areMapsEqual(favoriteItem, item))) {
    favoritesList.add(item);
  }
}

// Removes an item from the favorites list
void removeFavorite(Map<String, String> item) {
  favoritesList.removeWhere((favoriteItem) => areMapsEqual(favoriteItem, item));
}

// Checks if an item is already in the favorites list
bool isFavorite(Map<String, String> item) {
  return favoritesList.any((favoriteItem) => areMapsEqual(favoriteItem, item));
}
