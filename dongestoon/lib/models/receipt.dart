import 'package:dongestoon/models/receipt_type.dart';

class Receipt {
  String id;
  ReceiptType receiptType;
  String content;
  Receipt({required this.id, required this.receiptType, required this.content});
}
