class ChatModel {
  final String id;
  final String currentUserId;
  final String? currentUserName;
  final String chatPartnerId;
  final String? chatPartnerName;
  final String? chatPartnerImage;
  final String? currentUserImage;

  ChatModel({
    required this.id,
    required this.chatPartnerId,
    required this.currentUserId,
    this.currentUserName,
    this.chatPartnerName,
    this.chatPartnerImage,
    this.currentUserImage,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      currentUserId: json['user_id'],
      chatPartnerId: json['customer_id'],
      chatPartnerName:
          json['customer_name'] == null ? null : json['customer_name'],
      currentUserName: json['user_name'] == null ? null : json['user_name'],
      chatPartnerImage:
          json['customer_image'] == null ? null : json['customer_image'],
      currentUserImage: json['user_image'] == null ? null : json['user_image'],
    );
  }
  toJson() => {
        'id': id,
        'user_id': currentUserId,
        'customer_id': chatPartnerId,
        'customer_name': chatPartnerName,
        'user_name': currentUserName,
        'customer_image': chatPartnerImage,
        'user_image': currentUserImage,
      };
}
