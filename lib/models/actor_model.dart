class Cast {
	List<Actor> actores = new List();

	Cast({
		this.actores,
	});

	Cast.fromJsonList(List<dynamic> jsonList){
		if(jsonList == null){
			return;
		}
		jsonList.forEach((f){
			final actor = Actor.fromJsonMap(f);
			this.actores.add(actor);
		});
	}
}

class Actor {
	int castId;
	String character;
	String creditId;
	int gender;
	int id;
	String name;
	int order;
	String profilePath;

	Actor({
		this.castId,
		this.character,
		this.creditId,
		this.gender,
		this.id,
		this.name,
		this.order,
		this.profilePath,
	});

	Actor.fromJsonMap(Map<String,dynamic> json){
		castId 			= 		json['cast_id'];
		character 		= 		json['character'];
		creditId 		= 		json['credit_id'];
		gender 			= 		json['gender'];
		id 				= 		json['id'];
		name 			= 		json['name'];
		order 			= 		json['order'];
		profilePath 	= 		json['profile_path'];
	}
	getFoto(){
		if(profilePath == null){
			return "http://via.placeholder.com/350x150";
		}
		return 'https://image.tmdb.org/t/p/w500/$profilePath';
	}
}

enum Department { DIRECTING, WRITING, PRODUCTION, ART, CAMERA, CREW, SOUND, COSTUME_MAKE_UP, EDITING, VISUAL_EFFECTS, LIGHTING }