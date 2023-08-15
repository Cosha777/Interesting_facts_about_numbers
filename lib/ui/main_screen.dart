import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:interesting_facts_about_numbers/ui/info_screen.dart';
import 'package:interesting_facts_about_numbers/ui/main_screen_model.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(modelProvider.notifier);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        primary: false,
        appBar: AppBar(
          title: const Text(
            'Interesting facts about numbers',
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              _SearchContainer(),
              SizedBox(height: 16),
              _ResultContainer(),
            ],
          ),
        ),
        persistentFooterButtons: [
          TextButton(
            onPressed: () => model.clearData(),
            child: Text(
              'Clear data',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchContainer extends ConsumerWidget {
  const _SearchContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(modelProvider.notifier);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white30,
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: _TextField(model: model),
                ),
                const SizedBox(width: 25),
                TextButton(
                  onPressed: () {
                    if (model.getInputNumber != '') {
                      model.getFact(model.getInputNumber);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Enter the number',
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text("Enter the number"),
                      //   duration: Duration(seconds: 1),
                      // ));
                    }
                  },
                  child: Text(
                    'Get fact',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                model.getRandomFact();
              },
              child: Text(
                'Random number',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultContainer extends ConsumerWidget {
  const _ResultContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(modelProvider);
    // final model2 = ref.read(modelProvider.notifier);
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white30,
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InfoScreen(model.list[position].text),
                  ),
                ),
                child: Card(
                  color: position % 2 == 0
                      ? const Color.fromRGBO(99, 99, 99, 0.7)
                      : const Color.fromRGBO(86, 86, 66, 0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            model.list[position].text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white60,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({super.key, required this.model});

  final UserNotifier model;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) => model.setInputNumber(value),
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        fillColor: Colors.black12,
        filled: true,
        label: Icon(Icons.search),
        contentPadding: EdgeInsets.all(5),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
