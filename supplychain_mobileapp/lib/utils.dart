import 'dart:convert';

class Stock{
  String id;
  List<String> historyNames;
  List<String> historyWallets;

  Stock({
    required this.id,
    required this.historyNames,
    required this.historyWallets
  });

  factory Stock.fromJson(Map<String,dynamic> json){
    return Stock(
      id: json["id"],
      historyNames: List<String>.from(json['historyNames']),
      historyWallets: List<String>.from(json['historyWallets'])
    );
  }

  
}

Stock stockFromJson(String str){
  print(str);
  var decodedJson = json.decode(str);
  print(decodedJson);
  return Stock.fromJson(decodedJson);
}

// write the conversion from JSON

/*

JSON Format:

 stock_uuid : id,
 history: [Tuple(walletAddress,Name), ... ,Tuple(walletAddress,Name)]

*/