import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DataVisualization extends StatefulWidget {

  List<String> historyNames;
  List<String> historyWallets;

  DataVisualization(this.historyNames,this.historyWallets,{super.key});

  @override
  State<DataVisualization> createState() => _DataVisualizationState();
}

class _DataVisualizationState extends State<DataVisualization> {
  
  List<bool> isNameShowed = []; 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text("Ownership history", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        const SizedBox(height: 40),
        //Lista di nomi e affianco il wallet associato
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            scrollDirection: Axis.vertical,
            itemCount: widget.historyNames.length,
            itemBuilder: (context, index) {
              isNameShowed.add(true);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 2),
                  Text(
                    isNameShowed[index] == true ? widget.historyNames[index] : widget.historyWallets[index], style: TextStyle(
                    color: Colors.black,
                    fontSize: isNameShowed[index] == true ? 20 : 8
                  ),),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isNameShowed[index] = !isNameShowed[index];
                      });
                    },
                    icon: Icon(isNameShowed[index] == false ? Icons.abc : Icons.wallet)
                  )
                ],
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse("https://testnet.algoexplorer.io/application/264415535");
             if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            height: 40,
            width: 200,
            child: const Center(
              child: Text("CHECK FOR YOURSELF!", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
        ),
        const SizedBox(height:30),
        //LINK AL SERVIZIO ONLINE
      ],
    );
  }
}