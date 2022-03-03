import 'package:flutter/cupertino.dart';

class Memory {

  late int N;
  late int M;
  late Map memory;
  late List<String> indexes;

  Memory (int N, int M){
    this.N = N;
    this.M = M;

    memory = {};
    indexes = [];
    for (int i = 0; i < N; i++){
      memory[i] = {};

      for (int j = 0; j < M; j++){
        memory[i][j] = {};
        memory[i][j]['c'] = 0;
        memory[i][j]['m'] = 0;
        memory[i][j]['y'] = 0;
        memory[i][j]['k'] = 0;
        indexes.add(i.toString() + j.toString() + "c");
        indexes.add(i.toString() + j.toString() + "m");
        indexes.add(i.toString() + j.toString() + "y");
        indexes.add(i.toString() + j.toString() + "k");
      }
    }
  }

  Map operator [](int index){
    return memory[index];
  }

  String getNextKey(String index){
    if(index == ""){
      return "";
    }

    int i = indexes.indexOf(index);

    i++;

    if(i >= indexes.length){
      return "";
    }

    return indexes[i];
  }

  String toString(){
    return memory.toString();
  }
}