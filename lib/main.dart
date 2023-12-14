import 'package:flutter/material.dart';
import 'package:flutter_paypal_sdk/core.dart';
import 'package:flutter_paypal_sdk/orders.dart';
import 'package:flutter_paypal_sdk/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final env = const PayPalEnvironment.sandbox(
    clientId: 'AfnYsOx5lNpUd34Y_EZzvPF1f_kJN7byqyiL-sGxTs0_8IkFr_zz32G4qmu8OuepyqKJlSGQqICK4OiB',
    clientSecret:
        'EETvl8Bhr0aqdqVByMerDnOM3-jQkppyPK8CMGEN7cRQGIJbFFbk7OBolIvTjeLOynrwaDxyXrJSEjnx',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments Demo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final route = MaterialPageRoute(
                  builder: (_) => const PaypalPayment(),
                  fullscreenDialog: true,
                );
                Navigator.of(context).push(route);
              },
              child: const Text('Paypal Payment'),
            )
          ],
        ),
      ),
    );
  }
}

class PaypalPayment extends StatelessWidget {
  const PaypalPayment({super.key});

  final env = const PayPalEnvironment.sandbox(
    clientId: 'AfnYsOx5lNpUd34Y_EZzvPF1f_kJN7byqyiL-sGxTs0_8IkFr_zz32G4qmu8OuepyqKJlSGQqICK4OiB',
    clientSecret:
        'EETvl8Bhr0aqdqVByMerDnOM3-jQkppyPK8CMGEN7cRQGIJbFFbk7OBolIvTjeLOynrwaDxyXrJSEjnx',
  );

  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      environment: env,
      isExpress: true,
      purchaseUnits: const [
        PurchaseUnitRequest(
            referenceId: 'XXXXYYYYZZZZ123987',
            amount: AmountWithBreakdown(currencyCode: 'EUR', value: '130'))
      ],
      cancelUrl: 'https://www.paymentsdemo.it/returnUrl',
      returnUrl: 'https://www.paymentsdemo.it/cancelUrl',
      onSuccess: (order) {
        print('Success order: $order');
        Navigator.of(context).pop();
      },
      onCancel: (params) {
        print('CANCEL PARAMS: $params');
        Navigator.of(context).pop();
      },
      onError: (e) {
        print('ERROR PARAM: $e');
        Navigator.of(context).pop();
      },
    );
  }
}
