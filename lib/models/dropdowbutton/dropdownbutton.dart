import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class DropDownButtonPerson extends StatefulWidget {
  const DropDownButtonPerson({Key? key}) : super(key: key);

  @override
  State<DropDownButtonPerson> createState() => _DropDownButtonPersonState();
}

class _DropDownButtonPersonState extends State<DropDownButtonPerson> {
  List result = [];
  List total = [];
  var countTimeA = 0;
  var countTimeB = 0;
  var empates = 0;
  String nomeTimeA = "";
  String nomeTimeB = "";
  String nomeArquivoTimes = "";
  List goleadasTimeA = [];
  List goleadasTimeB = [];

  //funcao com a lógica dos resutados
  Future<String> listaResultados() async {
    var dados = await rootBundle.loadString("assets/$nomeArquivoTimes.json");

    result = json.decode(dados);
    total = result;
    result = [];

    countTimeA = 0;
    countTimeB = 0;
    empates = 0;
    goleadasTimeA = [];
    goleadasTimeB = [];


    total.forEach((re) {
      if (re['$nomeTimeA'] > re['$nomeTimeB']) {
        setState(() {
          countTimeA++;
        });
      }
      if (re['$nomeTimeA'] == re['$nomeTimeB']) {
        setState(() {
          empates++;
        });
      }if (re['$nomeTimeA'] < re['$nomeTimeB']) {
        setState(() {
          countTimeB++;
        });
      }if (re['$nomeTimeA'] == 4 ){
        setState(() {
          goleadasTimeA.add(re);
        });

         }if (re['$nomeTimeB'] == 4 ){
        setState(() {
          goleadasTimeB.add(re);
        });

      }
      });

    return 'sucesso';

  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Palmeiras',
      'Corintians',
      'São Paulo',
      'Santos'
    ];
    String? selectedValue;
    String? selectedValue1;

    //função para escolhehr o nome do arquivo json a ser carregado
    void escolheNomeArquivoTimes() {
      nomeArquivoTimes = "";
      var timeA = selectedValue.toString().toLowerCase();
      var timeB = selectedValue1.toString().toLowerCase();

      if ((timeA == "palmeiras" && timeB == "corintians") ||
          (timeA == "corintians" && timeB == "palmeiras")) {
        nomeArquivoTimes = "palmeirasXcorintians";
      }
      if ((timeA == "palmeiras" && timeB == "santos") ||
          (timeA == "santos" && timeB == "palmeiras")) {
        nomeArquivoTimes = "santosXpalmeiras";
      }
    }

    //função para pegar os nomes dos times escolhidos
    void nameTimeA() {
      setState(() {
        nomeTimeA = selectedValue.toString().toLowerCase();
      });
    }

    void nameTimeB() {
      setState(() {
        nomeTimeB = selectedValue1.toString().toLowerCase();
      });
    }

    final _formKey = GlobalKey<FormState>();

    return Scaffold(

      body: Form(

        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(

            children: [
              const SizedBox(height: 10,),
              AppBar(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                toolbarHeight: 30,
                centerTitle: true,
                backgroundColor: Colors.lightGreen,
                title: const Text("Almanaque Bolão 24H",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600),

                ),
              ),
              const SizedBox(height: 10,),

              DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Escolha um time',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.lightGreen),
                ),
                icon: const Icon(
                  Icons.sports_baseball,
                  color: Colors.lightGreen,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Precisa selecionar um time.';
                  }
                },
                onChanged: (value) {},
                onSaved: (value) {
                  selectedValue = value.toString();
                  nameTimeA();
                },
              ),
              DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Escolha um time',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.lightGreen),
                ),
                icon: const Icon(
                  Icons.sports_baseball,
                  color: Colors.lightGreen,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Precisa selecionar um time.';
                  }
                },
                onChanged: (value) {},
                onSaved: (value) {
                  selectedValue1 = value.toString();
                  nameTimeB();
                },
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    escolheNomeArquivoTimes();
                    listaResultados();
                  }
                },
                child: const Icon(
                  Icons.play_circle,
                  size: 40,
                  color: Colors.lightGreen,
                ),
              ),
              const SizedBox(height: 15),
             AppBar(
               backgroundColor: Colors.lightGreen,
               toolbarHeight: 22,
               title: Text("Resummo de $nomeTimeA e $nomeTimeB", style: const TextStyle(
                 fontSize: 17,
               ),),
             ),
              Row(
                children: [
                  Text('Total de jogos :'),
                  Text(total.length.toString()),
                ],
              ),

              Row(
                children: [
                  Text('Vitórias do $nomeTimeA :'),
                  Text(countTimeA.toString()),
                ],
              ),
              Row(
                children: [
                  Text('Vitória do $nomeTimeB :'),
                  Text(countTimeB.toString()),
                ],
              ),
              Row(
                children: [
                  Text('Empates: '),
                  Text(empates.toString()),
                ],
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                   children: [
                     AppBar(
                       backgroundColor: Colors.lightGreen,
                       toolbarHeight: 32,
                       title: Text("Goleadas do $nomeTimeA", style: const TextStyle(
                         fontSize: 17,
                       ),),
                     ),
                    for(int i=0; i < goleadasTimeA.length; i++ )
                      ListTile(
                           title: Row(

                           children: [
                             Text(("$nomeTimeA ").toUpperCase(),style: const TextStyle(fontSize: 12,)),
                             Text(goleadasTimeA[i][nomeTimeA].toString(),style: const TextStyle(fontSize: 12),),
                             const Text(" X ",style: TextStyle(fontSize: 10),),
                             Text(goleadasTimeA[i][nomeTimeB].toString(),style: const TextStyle(fontSize: 12),),
                             Text((" $nomeTimeB - Dia ").toUpperCase(),style: const TextStyle(fontSize: 12),),
                             Text(goleadasTimeA[i]["data"],style: const TextStyle(fontSize: 12),),
                           ],
                         ),
                      ),
                 AppBar(
                   backgroundColor: Colors.lightGreen,
                   toolbarHeight: 22,
                   title: Text("Goleadas do $nomeTimeB", style: const TextStyle(
                     fontSize: 17,
                   ),),
                 ),


                 for(int i=0; i < goleadasTimeB.length; i++ )
                     ListTile(
                       title: Row(
                         children: [
                           Text(("$nomeTimeB ").toUpperCase(),style: const TextStyle(fontSize: 12),),
                           Text(goleadasTimeB[i][nomeTimeB].toString(),style: const TextStyle(fontSize: 12),),
                           const Text(" X ",style: TextStyle(fontSize: 10),),
                           Text(goleadasTimeB[i][nomeTimeA].toString(),style: const TextStyle(fontSize: 12),),
                           Text((" $nomeTimeA - Dia ").toUpperCase(),style: const TextStyle(fontSize: 12),),
                           Text(goleadasTimeB[i]["data"],style: const TextStyle(fontSize: 12),),
                         ],
                       ),

                 ),
                   ],
                ),

              )
            ],

          ),
        ),

      ),
    );

  }
}
