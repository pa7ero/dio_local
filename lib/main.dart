import 'package:dio_local/model/products_model.dart';
import 'package:dio_local/service/service.dart';
import 'package:flutter/material.dart';
import 'package:dio_local/screen/widget/product_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'API with DIO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Product',
            ),
            const SizedBox(height: 5),
            FutureBuilder<List<Product>?>(
                future: ApiService().getProductsOffline(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> listProducts = snapshot.data!;
                    // tampilkan data
                    return Expanded(
                      child: ListView.builder(
                          itemCount: listProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: listProducts[index],
                            );
                          }),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}
