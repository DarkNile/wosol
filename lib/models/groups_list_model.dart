class Group {
  final String groupId;
  final String groupName;
  final String groupNameEn;
  final String groupDescAr;
  final String groupDescEn;

  Group({required this.groupId, required this.groupName, required this.groupNameEn, required this.groupDescAr, required this.groupDescEn});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    groupId: json['group_id'] as String,
    groupName: json['group_name'] as String,
    groupNameEn: json['group_name_en'] as String,
    groupDescAr: json['group_desc_ar'] as String,
    groupDescEn: json['group_desc_en'] as String,
  );
}

class GroupsList {
  final String status;
  final List<Group> data;

  GroupsList({required this.status, required this.data});

  factory GroupsList.fromJson(Map<String, dynamic> json) => GroupsList(
    status: json['status'] as String,
    data: List<Group>.from(
      json['data'].map((x) => Group.fromJson(x)),
    ),
  );
}
