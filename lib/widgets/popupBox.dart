part of 'expenses.dart';

final formatter = DateFormat.yMd();

class PopupBox extends StatefulWidget {
  PopupBox({super.key, required this.writer});

  final Function(Expense newexpense) writer;

  @override
  State<StatefulWidget> createState() {
    return _PopupBoxState();
  }
}

class _PopupBoxState extends State<PopupBox> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  late Categories? pickedCategory;

  DateTime? selectedTime;

  void datePicker() async {
    final now = DateTime.now();
    if (mounted) {
      var pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 1, now.month),
          lastDate: DateTime.now());
      setState(() {
        {
          selectedTime = pickedDate;
        }
      });
    }
  }

  var savedExpenseLength = _registeredExpenses.length;

  void infoCheck() {
    if (_title.text.trim().isEmpty || double.parse(_amount.text) == 0) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input"),
                content:
                    const Text("please make sure valid details are entered"),
                actions: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        icon: const Icon(Icons.close_rounded)),
                  )
                ],
              ));
      return;
    }
    Expense newExpense = Expense(
        title: _title.text,
        amount: double.parse(_amount.text),
        date: selectedTime!,
        category: pickedCategory!);
    widget.writer(newExpense);
    if (savedExpenseLength < _registeredExpenses.length) {
      Navigator.pop(context);
      savedExpenseLength++;
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return ListView.builder(
      padding: EdgeInsets.only(top: h / 2 - 350),
      itemCount: 1,
      itemBuilder: (ctx, index) {
        return Center(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            title: const Text(
              "Add new expense",
            ),
            content: SizedBox(
                height: h / 3.2619,
                width: 350,
                child: Column(children: [
                  TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 4,
                            style: BorderStyle.solid,
                            color: Colors.black),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _amount,
                    decoration: InputDecoration(
                      prefixText: '\$',
                      hintText: 'Amount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownMenu(
                      menuStyle: const MenuStyle(
                        alignment: Alignment.bottomLeft,
                      ),
                      hintText: "Category",
                      initialSelection: "default",
                      dropdownMenuEntries: Categories.values
                          .map((category) => DropdownMenuEntry(
                              value: category,
                              label: category.name.toUpperCase()))
                          .toList(),
                      onSelected: (value) {
                        pickedCategory = value as Categories?;
                      },
                      width: 350),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        style: const TextStyle(fontSize: 20),
                        "selected time : ${selectedTime == null ? formatter.format(selectedTime = DateTime.now()) : formatter.format(selectedTime!)}",
                      ),
                      IconButton(
                          onPressed: datePicker,
                          icon: Icon(
                            Icons.calendar_month_sharp,
                            size: h / 40,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                    const Spacer(),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        onPressed: () {
                          infoCheck();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        )),
                  ])
                ])),
          ),
        );
      },
    );
  }
}
