import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class PaymentsModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Payment";

  PaymentsModel() : super(keyTableName);
  PaymentsModel.clone() : this();

  @override
  PaymentsModel clone(Map<String, dynamic> map) => PaymentsModel.clone()..fromJson(map);

  static final String paymentTypeConsumible = "consumable";
  static final String paymentTypeSubscription = "subscription";

  static final String paymentStatusPending = "pending";
  static final String paymentStatusCompleted = "completed";
  static final String paymentStatusRefunded = "refunded";

  static final String keyCreatedAt = "createdAt";

  static final String keyAuthor = "Author";
  static final String keyAuthorId = "AuthorId";
  static final String keyFullName = "full_name";

  static final String keyPaymentMethod = "method";
  static final String keyPaymentStatus = "status";
  static final String keyTransactionType = "transactionType";

  static final String keyTransactionTypeWithdraw = "Withdraw";
  static final String keyTransactionTypePurchase = "Buy Coin";

  static final String keyTransactionTypePurchaseMethod = "Store";

  static final String keyPaymentTypePayPal="Paypal";
  static final String keyPaymentTypeQiwiWallet="Qiwi wallet";

  static final String keyAmount = "withdrawAmount";
  static final String keyCoins = "coins";
  static final String keyPaypalEmail = "paypalEmail";
  static final String keyQiwiWalletNo = "QiwiWalletNo";

  static final String keyReferenceNumber = "referenceNumber";

  static final String keyItemId = "sku";
  static final String  keyItemName = "name";
  static final String  keyItemPrice = "price";
  static final String  keyItemCurrency = "currency";
  static final String  keyItemTransactionId = "transactionId";

  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  String? get getAuthorId => get<String>(keyAuthorId);
  set setAuthorId(String authorId) => set<String>(keyAuthorId, authorId);

  dynamic? get getAmount => get<dynamic>(keyAmount);
  set setAmount(double amount) => set<double>(keyAmount, amount);

  int? get getCoinsAmount => get<int>(keyCoins);
  set setCoinsAmount(num amount) => set<num>(keyCoins, amount);

  String? get getTransactionType => get<String>(keyTransactionType);
  set setTransactionType(String type) => set<String>(keyTransactionType, type);

  String? get getFullName => get<String>(keyFullName);
  set setFullName(String name) => set<String>(keyFullName, name);

  String? get getPayPalEmail => get<String>(keyPaypalEmail);
  set setPayPalEmail(String email) => set<String>(keyPaypalEmail, email);

  String? get getQiwiWalletNo => get<String>(keyQiwiWalletNo);
  set setQiwiWalletNo(String walletNo) => set<String>(keyQiwiWalletNo, walletNo);

  String? get getReferenceNumber=> get<String>(keyReferenceNumber);
  set setReferenceNumber(String referenceNumber) => set<String>(keyReferenceNumber, referenceNumber);

  String? get getStatus => get<String>(keyPaymentStatus);
  set setStatus(String status) => set<String>(keyPaymentStatus, status);

  String? get getMethod => get<String>(keyPaymentMethod);
  set setMethod(String method) => set<String>(keyPaymentMethod, method);

  String? get getPrice => get<String>(keyItemPrice);
  set setPrice(String email) => set<String>(keyItemPrice, email);

  String? get getCurrency => get<String>(keyItemCurrency);
  set setCurrency(String currency) => set<String>(keyItemCurrency, currency);

  String? get getId => get<String>(keyItemId);
  set setId(String id) => set<String>(keyItemId, id);

  String? get getTitle => get<String>(keyItemName);
  set setTitle(String title) => set<String>(keyItemName, title);

  String? get getTransactionId => get<String>(keyItemTransactionId);
  set setTransactionId(String title) => set<String>(keyItemTransactionId, title);

}