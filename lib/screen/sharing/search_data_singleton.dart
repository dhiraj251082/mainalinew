class SearchDataSingleton {
  static final SearchDataSingleton _instance = SearchDataSingleton._internal();
  
  factory SearchDataSingleton() {
    return _instance;
  }
  
  SearchDataSingleton._internal();

  // Map to hold searchData
  Map<String, dynamic> _searchData = {};

  // Setter to update searchData
  void setSearchData(Map<String, dynamic> newData) {
    _searchData = newData;
  }

  // Getter to retrieve searchData
 Map<String, dynamic> getSearchData() {
    return _searchData;
  }
}