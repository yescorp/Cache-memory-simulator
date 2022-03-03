import 'Memory.dart';

class Cache {
  Cache(int size){
    this.size = size;
    cacheItems.clear();

    for(int i = 0; i < size; i++){
      cacheItems.add("");
    }
  }

  int size = 8;

  late List<String> cacheItems = [];

  bool check(String index){
    for (int i = 0; i < cacheItems.length; i++){
      if(cacheItems[i] == index){
        return true;
      }
    }

    return false;
  }

  void clear() {
    for(int i = 0; i < size; i++){
      cacheItems[i] = "";
    }
  }

  void fill(String index, Memory memory){
    String i = index;
    cacheItems[0] = index;
    for(int ci = 1; ci < size; ci++){
      cacheItems[ci] = memory.getNextKey(i);
      i = cacheItems[ci];
    }
  }
}