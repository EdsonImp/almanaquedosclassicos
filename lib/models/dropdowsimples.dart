import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class JosKeys {
  static final josKeys1 = GlobalKey();
  static final josKeys2 = GlobalKey();
  static final josKeys3 = GlobalKey();
}
const List<String> listPaulista = <String>[
  'Palmeiras',
  'Corintians',
  'São Paulo',
  'Santos'
];
const List<String> listCarioca = <String>[
  'Flamengo',
  'Vasco',
  'Fluminense',
  'Botafogo'
];
List<String> lista = ['', ' '];

const List<String> listCampeonato = <String>['nenhum', 'Paulista', 'Carioca'];

String? dropdownValue;
String? dropdownValue2;
String dropdownValue3 = listCampeonato.first;

class DropdowSimples extends StatefulWidget {
  const DropdowSimples({Key? key}) : super(key: key);

  @override
  State<DropdowSimples> createState() => _DropdowSimplesState();
}

class _DropdowSimplesState extends State<DropdowSimples> {
  String nomeTimeA = "";
  String nomeTimeB = "";

  String nomeArquivoTimes = "";
  List result = [];
  List total = [];
  var countTimeA = 0;
  var countTimeB = 0;
  var empates = 0;
  var primeiroConfronto = "";
  var ultimoConfronto = "";

  void escolheNomeArquivoTimes() {
    nomeArquivoTimes = "";
    var timeA = dropdownValue.toString().toLowerCase();
    nomeTimeA = timeA;

    var timeB = dropdownValue2.toString().toLowerCase();
    nomeTimeB = timeB;

    if ((timeA == "palmeiras" && timeB == "corintians") ||
        (timeA == "corintians" && timeB == "palmeiras")) {
      nomeArquivoTimes = "palmeirasXcorintians";
    }
    if ((timeA == "palmeiras" && timeB == "santos") ||
        (timeA == "santos" && timeB == "palmeiras")) {
      nomeArquivoTimes = "santosXpalmeiras";
    }
  }

  void trocaLista() {
    if (dropdownValue3 == 'Paulista') {
      dropdownValue = null;
      dropdownValue2 = null;
      setState(() {
        lista = listPaulista;
      });
       } else if (dropdownValue3 == 'Carioca') {
      dropdownValue = null;
      dropdownValue2 = null;
      setState(() {
        lista = listCarioca;
      });
      // print(dropdownValue3);

    }
  }

  void zeraDados() {
    total = [];
    countTimeA = 0;
    countTimeB = 0;
    empates = 0;
  }

  Future<String> listaResultados() async {
    if ((dropdownValue == null) || (dropdownValue2 == null))
    { showDialog(
      context:  context,
      builder:  (BuildContext context) {
        return AlertDialog(
          title: new Text("Escolha os times"),
          content: new Text("Você precisa escolher os dois times"),
          actions: <Widget>[
            // define os botões na base do dialogo
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    }else
    {

      zeraDados();
      escolheNomeArquivoTimes();
      var dados = await rootBundle.loadString("assets/$nomeArquivoTimes.json");

      result = json.decode(dados);
      setState(() {
        total = result;
      });
      total = result;
      result = [];

      total.forEach((re) {
        if (re[nomeTimeA] > re[nomeTimeB]) {
          setState(() {
            countTimeA++;
          });
        }
        if (re[nomeTimeA] < re[nomeTimeB]) {
          setState(() {
            countTimeB++;
          });
        }
        if (re[nomeTimeA] == re[nomeTimeB]) {
          setState(() {
            empates++;
          });
        }
      });}
      return 'sucesso';

    }

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 35.0, bottom: 20.0, left: 25.0, right: 25.0),
          child: Column(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.sports_baseball,
                    color: Colors.orangeAccent,
                  ),
                  const Text(
                    "Almanaque dos Clássicos",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(

                    padding: const EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange,
                    ),
                    child: const Text(
                      "Selecione o Estado",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    child: Form(
                     key: JosKeys.josKeys1,
                      autovalidateMode: AutovalidateMode.always,
                      child: DropdownButtonFormField<String>(
                        value: dropdownValue3,
                        icon: const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.white,
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? value) {
                               setState(() {
                            dropdownValue3 = value!;
                          });
                          trocaLista();
                          zeraDados();
                        },
                        items: listCampeonato
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    top: 2.0, bottom: 2.0, left: 20.0, right: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold,),
                                )),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == 'nenhum') {
                            return 'Precisa selecionar Estado';
                          }
                        },

                      ),

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Form(
                key: JosKeys.josKeys2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: DropdownButtonFormField<String>(
                            value: dropdownValue,
                            hint: const Text('Time A'),
                            icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.orange,),
                            style: const TextStyle(color: Colors.orange,fontWeight:FontWeight.bold, fontSize: 15),

                            onChanged: (String? value) {
                              zeraDados();

                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: lista.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Escolha um time.';
                              }
                            },

                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: listaResultados,
                          iconSize: 30,
                          alignment: Alignment.bottomCenter,
                          icon: const Icon(
                            Icons.play_circle,
                            color: Colors.orange,
                          )),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: DropdownButtonFormField<String>(
                            value: dropdownValue2,
                            hint: const Text('Time B'),
                            icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.orange,),
                            style: const TextStyle(color: Colors.orange,fontWeight:FontWeight.bold, fontSize: 15),

                            onChanged: (String? value) {
                              zeraDados();
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue2 = value!;
                              });
                            },
                            items: lista.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null){
                                return 'Escolhha um time';
                              }else if (value == dropdownValue ){
                                return "Time idêntico";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

//Resumo dos jogos

              if (total.length > 1)
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange.shade700),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Container(
                      decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color:Colors.orange.shade700, width: 15),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(

                          title: Text("Resumo de $dropdownValue x $dropdownValue2",
                              style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold )),
                          subtitle: const Text("Incluem amistosos"),
                                                ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 15, right: 10),
                          child: Text("O primeiro jogo foi em ${total[0]['data']}, "
                              "no ${total[0]['local']}, com o placar"
                              " de $dropdownValue  ${total[0][dropdownValue.toString().toLowerCase()]}"
                              " X ${total[0][dropdownValue2.toString().toLowerCase()]}  $dropdownValue2. "),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10, left:15, bottom: 10, right:10),
                          child: Text("E o último"
                              " foi em ${total.last['data']} no ${total.last['local']} com o placar de"
                              " $dropdownValue ${total.last[dropdownValue.toString().toLowerCase()]} X"
                              " ${total.last[dropdownValue2.toString().toLowerCase()]} $dropdownValue2."),
                        ),
                      ],
                    ),
                  ),
                ),
              if (total.length > 1)
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange.shade700),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color:Colors.orange.shade700, width: 15),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Números oficiais até ${total.last['data']}",style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold ),),
                        subtitle: const Text("Incluem amistosos"),
                      ),
                      Text("Total de jogos: ${total.length.toString()}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("Vitórias do $dropdownValue : ${countTimeA.toString()}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("Vitórias do $dropdownValue2 : ${countTimeB.toString()}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("Empates : ${empates.toString()}"),
                      const SizedBox(
                        height: 3,
                      ),

                    ],
                  ),
                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
