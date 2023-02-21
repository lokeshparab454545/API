import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

Map mapResponse = {};
List? listResponse;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = (mapResponse['data']);
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(listResponse![index]['avatar']),
              ),
              Text(listResponse![index]["id"].toString()),
              Text(listResponse![index]["email"].toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(listResponse![index]["first_name"].toString()),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(listResponse![index]["last_name"].toString()),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          );
        },
        itemCount: listResponse == null ? 0 : listResponse!.length,
      ),
    );
  }
}
