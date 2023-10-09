import 'package:omega_employee_management/Helper/String.dart';
import 'package:intl/intl.dart';
// "id": "103",
// "transaction_type": "transaction",
// "user_id": "17",
// "order_id": "33",
// "type": "wallet",
// "txn_id": "",
// "payu_txn_id": null,
// "amount": "0",
// "status": "success",
// "currency_code": null,
// "payer_email": null,
// "message": "Order Placed Successfully",
// "transaction_date": "2022-02-12 13:45:40",
// "date_created": "2022-02-12 13:45:40"
class TransactionModel {
  String? id, amt, status, msg, date, type,txnID,orderId;

  TransactionModel(
      {this.id,
      this.amt,
      this.status,
      this.msg,
      this.date,
      this.type,
      this.txnID,
      this.orderId});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    String date = json[TRN_DATE];

   date = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(date));
    return new TransactionModel(
        orderId: json[ORDER_ID],
        amt: json[AMOUNT],
        status: json[STATUS],
        msg: json[MESSAGE],
        type: json[TYPE],
        txnID: json[TXNID],
       id: json[ID],
        date: date);
  }

  factory TransactionModel.fromReqJson(Map<String, dynamic> json) {
    String date = json[DATE];

    date = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    String? st = json[STATUS];
    /*if (st == "0") {
      st = PENDING;
    } else if (st == "1") {
      st = ACCEPTED;
    } else if (st == "2") {
      st = REJECTED;
    }*/

    return new TransactionModel(
        id: json[ID],
        amt: json["amount_requested"],
        status: st,
        msg: json[MSG],
        date: date);
  }
}
