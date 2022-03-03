import 'dart:io';

import 'package:cache_memory_simulator/CPU.dart';
import 'package:cache_memory_simulator/Memory.dart';
import 'package:cache_memory_simulator/Cache.dart';
import 'package:cache_memory_simulator/SimulationPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController N = TextEditingController();
  TextEditingController M = TextEditingController();
  TextEditingController cacheSize = TextEditingController();

  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            children: [

              if(errorMsg != "") ... [
                Text(errorMsg, style: TextStyle(fontSize: 16, color: Colors.red),),
                SizedBox(height: 20,)
              ],

              Text("The memory size: ", textAlign: TextAlign.start, style: TextStyle(fontSize: 18),),
              Row(
                children: [
                  Expanded(child: TextFormField(controller: N, )),
                  SizedBox(width: 20,),
                  Expanded(child: TextFormField(controller: M,))
                ]),
              SizedBox(height: 10,),
              Row(children: [
                Expanded(child: Text("N", textAlign: TextAlign.center,)),
                Expanded(child: Text("M", textAlign: TextAlign.center,))
              ],),
              SizedBox(height: 20,),
              Text("The cache size: ", textAlign: TextAlign.start ,style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              Row(children: [
                Expanded(child: TextFormField(controller: cacheSize,))
              ]),
              SizedBox(height: 20),
              Row(
                children: [Expanded(child: ElevatedButton(
                  onPressed: (){
                    if(N.text == "" || M.text == "" || cacheSize.text == ""){
                      setState(() {
                        errorMsg = "Fill all of the fields!";
                      });
                      return;
                    }

                    int intN = int.parse(N.text);
                    int intM = int.parse(M.text);
                    int intCacheSize = int.parse(cacheSize.text);

                    if(intN & (intN - 1) != 0){
                      setState(() {
                        errorMsg = "N is not a power of 2";
                      });
                      return;
                    }
                    if(intM & (intM - 1) != 0 ){
                      setState(() {
                        errorMsg = "M is not a power of 2";
                      });
                      return;
                    }
                    if(intCacheSize &(intCacheSize - 1) != 0){
                      setState(() {
                        errorMsg = "Cache size is not a power of 2";
                      });
                      return;
                    }

                    if(intCacheSize > (intN * intM) / 4){
                      setState(() {
                        errorMsg = "Inappropriate Cache size (should be less than M * N / 4)";
                      });

                      return;
                    }

                    setState(() {
                      errorMsg = "";
                    });

                    Memory memory = Memory(intN, intM);
                    Cache cache = Cache(intCacheSize);
                    CPU cpu = CPU(memory, cache);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SimulationPage(cpu: cpu)),
                    );
                  }, child: Text("Start simulation", style: TextStyle(fontSize: 18),),
                ),)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
