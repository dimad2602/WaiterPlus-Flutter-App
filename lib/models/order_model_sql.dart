class OrderModel {
  int? id;
  int? uid;
  int? restid;
  String? status;
  String? createdAt;
  String? completedAt;

  OrderModel(
      {this.id,
        this.uid,
        this.restid,
        this.status,
        this.createdAt,
        this.completedAt
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    restid = json['restid'];
    status = json['status'];
    createdAt = json['created_at'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['restid'] = this.restid;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['completed_at'] = this.completedAt;
    return data;
  }
}