import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CPU.dart';

class SimulationPage extends StatefulWidget {
  SimulationPage({Key? key, required CPU cpu}) : super(key: key){
    this.cpu = cpu;
  }

  late CPU cpu;

  @override
  _SimulationPageState createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage>{

  int interval = 10;

  bool code1 = false;
  bool code2 = false;
  bool code3 = false;
  bool cache = false;
  String msg = "";
  List<Color> cacheColors = [];
  List<String> cmyk = ["c", "m", "y", "k"];
  int hits = 0;
  int misses = 0;
  int total = 0;

  late List<String> cacheItems = widget.cpu.cache.cacheItems;

  int codeLine = -1;
  double fontSize = 24;

  TextStyle textStyle = TextStyle(fontSize: 24);

  @override
  void initState() {

    for(int i = 0; i < widget.cpu.cache.cacheItems.length; i++){
      cacheColors.add(Colors.white);
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(!code1 && !code2 && !code3 && !cache) ... [
              ElevatedButton(onPressed: (){
                animation();
              }, child: Text("Animate"),)
            ],

          if(code1) ... [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("for(int i = 0; i < " + widget.cpu.memory.N.toString() + "; i++){", style: textStyle,),
                Row(children: [
                  SizedBox(width: 20),
                  Text("for(int j = 0; j < " + widget.cpu.memory.M.toString() + "; j++){", style: textStyle,)
                ]),
                Row(
                  children: [
                    SizedBox(width: 40,),
                    Text("memory[i][j].c = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 1 ? Colors.amber: Colors.white))),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 40,),
                    Text("memory[i][j].m = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 2 ? Colors.amber: Colors.white))),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 40,),
                    Text("memory[i][j].y = 1;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 3 ? Colors.amber: Colors.white))),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 40,),
                    Text("memory[i][j].k = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 4 ? Colors.amber: Colors.white))),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("}", style: textStyle,),
                  ],
                ),
                Text("}", style: textStyle,)
              ],
            )
          ],
          if(code2) ... [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("for(int i = 0; i < " + widget.cpu.memory.M.toString() + "; i++){", style: textStyle),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("for(int j = 0; j < " + widget.cpu.memory.N.toString() + "; j++){", style: textStyle,),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 40),
                  Text("memory[j][i].c = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 1 ? Colors.amber: Colors.white))),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 40),
                  Text("memory[j][i].m = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 2 ? Colors.amber: Colors.white))),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 40),
                  Text("memory[j][i].y = 1;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 3 ? Colors.amber: Colors.white))),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 40),
                  Text("memory[j][i].k = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 4 ? Colors.amber: Colors.white))),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("}", style: textStyle,),
                ],
              ),
              Text("}", style: textStyle,)
            ],)
          ],
          if(code3) ... [
            Column(
              children: [
                Text("for(int i = 0; i < " + widget.cpu.memory.N.toString() + "; i++){", style: textStyle,),
                Text("for(int j = 0; j < " + widget.cpu.memory.M.toString() + "; j++){", style: textStyle,),
                Text("memory[i][j].y = 1;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 1 ? Colors.amber: Colors.white))),
                Text("}", style: textStyle,),
                Text("}", style: textStyle,),

                Text("for(int i = 0; i < " + widget.cpu.memory.N.toString() + "; i++){", style: textStyle,),
                Text("for(int j = 0; j < " + widget.cpu.memory.M.toString() + "; j++){", style: textStyle,),
                Text("memory[i][j].c = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 2 ? Colors.amber: Colors.white))),
                Text("memory[i][j].m = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 3 ? Colors.amber: Colors.white))),
                Text("memory[i][j].k = 0;", style: TextStyle(fontSize: fontSize, backgroundColor: (codeLine == 4 ? Colors.amber: Colors.white))),
                Text("}", style: textStyle,),
                Text("}", style: textStyle,)
              ],
            )
          ],
          if(cache) ... [
            Row(children: [
              Expanded(child: Text("Hits: " + hits.toString(), style: textStyle,)),
              Expanded(child: Text("Misses: " + misses.toString(),style: textStyle,)),
              Expanded(child: Text("Total: " + total.toString(), style: textStyle,))
            ],),
            Row(
              children: [
                Text("Ratio: "  + (hits.toDouble() / total.toDouble()).toString())
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: cacheItems.length,
                  itemBuilder: (context, index){
                    return Container(

                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1), color: cacheColors[index]),
                      child: Row(

                        children: [
                          Text(cacheItems[index], style: textStyle,),
                        ],
                      ),
                    );
                  }),
            )
          ]
        ],),
      ),
    ));
  }

  Future pause() async {
    return Future.delayed(Duration(milliseconds: interval));
  }

  void clearCacheColors() {
    for(int i  =0; i < cacheColors.length; i++){
      cacheColors[i] = Colors.white;
    }
  }

  void animation() async {
    CPU cpu = widget.cpu;

    setState(() {
      code1 = true;
      cache = true;
    });

    await pause();

    await algo1();

    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      code1 = false;
      code2 = true;
      cpu.cache.clear();
      cacheItems = cpu.cache.cacheItems;
      clearCacheColors();
      hits = 0;
      misses = 0;
      total = 0;
    });
    await Future.delayed(Duration(milliseconds: 2000));


    await algo2();

    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      code2 = false;
      code3 = true;
      cpu.cache.clear();
      cacheItems = cpu.cache.cacheItems;
      clearCacheColors();
      hits = 0;
      misses = 0;
      total = 0;
    });
    await Future.delayed(Duration(milliseconds: 2000));

    await algo3();

  }

  Future algo1() async{
    CPU cpu = widget.cpu;

    for(int i = 0; i < cpu.memory.N; i++){
      for(int j = 0; j < cpu.memory.M; j++){
        for(int l = 0; l < cmyk.length; l++) {
          setState(() {
            codeLine = l + 1;
          });
          await pause();
          await pause();
          await pause();
          await pause();
          clearCacheColors();

          String currentIndex = i.toString() + j.toString() + cmyk[l];
          bool hit = false;
          for (int k = 0; k < cacheItems.length; k++) {
            setState(() {
              cacheColors[k] = Colors.amber;
            });

            await pause();
            if (cacheItems[k] == currentIndex) {
              setState(() {
                cacheColors[k] = Colors.green;
              });
              await pause();
              await pause();
              await pause();
              hit = true;
              break;
            }
            else {
              setState(() {
                cacheColors[k] = Colors.red;
              });
            }
            await pause();
          }

          if(hit){
            setState(() {
              hits++;
              total++;
            });
          }
          else {
            setState(() {
              misses++;
              total++;
            });
          }

          cpu.operation(currentIndex, 0);

          setState(() {
            cacheItems = cpu.cache.cacheItems;
          });
          await pause();
        }

        debugPrint(cacheItems.toString());
        await pause();

      }
    }

    return pause();
  }

  Future algo2() async{
    CPU cpu = widget.cpu;

    for(int i = 0; i < cpu.memory.M; i++){
      for(int j = 0; j < cpu.memory.N; j++){
        for(int l = 0; l < cmyk.length; l++) {
          setState(() {
            codeLine = l + 1;
          });
          await pause();
          await pause();
          await pause();
          await pause();
          clearCacheColors();

          String currentIndex = j.toString() + i.toString() + cmyk[l];
          bool hit = false;
          for (int k = 0; k < cacheItems.length; k++) {
            setState(() {
              cacheColors[k] = Colors.amber;
            });

            await pause();
            if (cacheItems[k] == currentIndex) {
              setState(() {
                cacheColors[k] = Colors.green;
              });
              await pause();
              await pause();
              await pause();
              hit = true;
              break;
            }
            else {
              setState(() {
                cacheColors[k] = Colors.red;
              });
            }
            await pause();
          }

          if(hit){
            setState(() {
              hits++;
              total++;
            });
          }
          else {
            setState(() {
              misses++;
              total++;
            });
          }

          cpu.operation(currentIndex, 0);

          setState(() {
            cacheItems = cpu.cache.cacheItems;
          });
          await pause();
        }

        debugPrint(cacheItems.toString());
        await pause();

      }
    }

    return pause();
  }

  Future algo3() async{
    CPU cpu = widget.cpu;

    for(int i = 0; i < cpu.memory.N; i++){
      for(int j = 0; j < cpu.memory.M; j++){
        setState(() {
          codeLine = 1;
        });
        await pause();
        await pause();
        await pause();
        await pause();
        clearCacheColors();

        String currentIndex = i.toString() + j.toString() + "y";
        bool hit = false;
        for (int k = 0; k < cacheItems.length; k++) {
          setState(() {
            cacheColors[k] = Colors.amber;
          });

          await pause();
          if (cacheItems[k] == currentIndex) {
            setState(() {
              cacheColors[k] = Colors.green;
            });
            await pause();
            await pause();
            await pause();
            hit = true;
            break;
          }
          else {
            setState(() {
              cacheColors[k] = Colors.red;
            });
          }
      }

        if(hit){
          setState(() {
            hits++;
            total++;
          });
        }
        else {
          setState(() {
            misses++;
            total++;
          });
        }

        cpu.operation(currentIndex, 0);

        setState(() {
          cacheItems = cpu.cache.cacheItems;
        });
        setState(() {
          codeLine = -1;
        });
        await pause();
        await pause();
        await pause();
    }
  }

    for(int i = 0; i < cpu.memory.N; i++){
      for(int j = 0; j < cpu.memory.M; j++) {
        for(int l = 0; l < cmyk.length; l++){

          if(cmyk[l] == "y"){
            continue;
          }

          setState(() {
            codeLine = (l + 2 > 4 ? l + 1 : l + 2);
          });
          await pause();
          await pause();
          await pause();
          await pause();
          clearCacheColors();

          String currentIndex = i.toString() + j.toString() + cmyk[l];
          bool hit = false;
          for (int k = 0; k < cacheItems.length; k++) {
            setState(() {
              cacheColors[k] = Colors.amber;
            });

            await pause();
            if (cacheItems[k] == currentIndex) {
              setState(() {
                cacheColors[k] = Colors.green;
              });
              await pause();
              await pause();
              await pause();
              hit = true;
              break;
            }
            else {
              setState(() {
                cacheColors[k] = Colors.red;
              });
            }
            await pause();
          }

          if(hit){
            setState(() {
              hits++;
              total++;
            });
          }
          else {
            setState(() {
              misses++;
              total++;
            });
          }

          cpu.operation(currentIndex, 0);

          setState(() {
            cacheItems = cpu.cache.cacheItems;
          });

          await pause();

        }
      }
    }
    return pause();
  }
}
