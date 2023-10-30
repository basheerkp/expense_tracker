part of 'expenses.dart';

class PopupBox extends StatefulWidget {
  const PopupBox(
      {super.key,
      required this.writer,
      this.rotated = false,
      required this.height,
      required this.width});

  final double height, width;
  final bool rotated;
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
    return ListView.builder(
      padding:
          EdgeInsets.only(top: widget.rotated ? 0 : widget.height / 2 - 350),
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
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return DropdownMenu(
                      width: constraints.maxWidth,
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
                        FocusManager.instance.primaryFocus?.unfocus();
                        pickedCategory = value as Categories?;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        style: const TextStyle(fontSize: 19),
                        "selected time : ${selectedTime == null ? formatter.format(selectedTime = DateTime.now()) : formatter.format(selectedTime!)}",
                      ),
                      const Spacer(),
                      Container(
                        width: widget.rotated
                            ? widget.width / 10
                            : widget.height / 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(7)),
                        child: IconButton(
                            onPressed: datePicker,
                            icon: Icon(
                              Icons.calendar_month_sharp,
                              size: widget.width / 25,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        )),
                    const Spacer(),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          infoCheck();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.black),
                        )),
                  ])
                ])),
          ),
        );
      },
    );
  }
}
