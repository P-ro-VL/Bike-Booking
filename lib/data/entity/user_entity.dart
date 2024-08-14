class UserEntity {
  final String? accountId;
  final String? userId;
  final String? password;
  final String? displayName;
  final String? phone;
  final String? email;

  int? money;

  UserEntity({
    this.accountId,
    this.userId,
    this.password,
    this.displayName,
    this.phone,
    this.email,
    this.money,
  });
}
