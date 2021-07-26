import 'package:template/module/cubit_demo/models/post_entity.dart';

postEntityFromJson(PostEntity data, Map<String, dynamic> json) {
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['body'] != null) {
		data.body = json['body'].toString();
	}
	return data;
}

Map<String, dynamic> postEntityToJson(PostEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userId'] = entity.userId;
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['body'] = entity.body;
	return data;
}