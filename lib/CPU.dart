import 'Cache.dart';
import "Memory.dart";

class CPU{
  late Memory memory;
  late Cache cache;

  CPU(Memory memory, Cache cache){
      this.memory = memory;
      this.cache = cache;
  }

  bool operation(String index, int value){
    bool hit = false;

    if(cache.check(index)){
      hit = true;
    }
    else {
      cache.clear();
      cache.fill(index, memory);
    }

    List<String> temp = index.split("");

    memory[int.parse(temp[0])][int.parse(temp[1])][temp[2]] = value;
    
    return hit;
  }
}