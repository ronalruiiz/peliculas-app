import 'package:flutter/material.dart';
import 'package:peliculas_app/models/pelicula_model.dart';
import 'package:peliculas_app/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
	final peliculas = [
		'Batman',
		'Aquaman',
		'Anabelle',
		'Ironman',
		'Shazam'
			'Hombres de negro'
	];
	final peliculasRecientes = [
		'Spiderman',
		'Capitan America'
	];
	String seleccion = '';
	final peliculasProvider = new PeliculasProvider();

	@override
	List<Widget> buildActions(BuildContext context) {
		// TODO: implement buildActions
		return [
			IconButton(
				icon: Icon(Icons.clear),
				onPressed: () {
					query = '';
				},
			)
		];
	}

	@override
	Widget buildLeading(BuildContext context) {
		// TODO: implement buildLeading
		return IconButton(
			icon: AnimatedIcon(
				icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
			onPressed: () {
				close(context, null);
			},
		);
	}

	@override
	Widget buildResults(BuildContext context) {
		// TODO: implement buildResults
		return Center(
			child: Container(
				height: 100.0,
				width: 100.0,
				color: Colors.blueAccent,
				child: Text(seleccion),
			),
		);
	}

	@override
	Widget buildSuggestions(BuildContext context) {
		if (query.isEmpty) {
			return Container();
		}
		return FutureBuilder(
			future: peliculasProvider.buscarPeliculas(query),
			initialData: null,
			builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> e) {
				if (e.hasData) {
					final peliculas = e.data;
					return ListView(
						children: peliculas.map((pelicula) {
							return ListTile(
								leading: FadeInImage(placeholder: AssetImage(
									'assets/img/no-image.jpg'),
									width: 70.0,
									fit: BoxFit.contain,
									image: NetworkImage(
										pelicula.getPosterImg())),
								title: Text(pelicula.title),
								onTap: (){
									close(context, null);
									pelicula.uniqueId = '';
									Navigator.pushNamed(context, '/detalle',arguments: pelicula);
								},
							);
						}).toList(),
					);
				} else {
					return Center(
						child: CircularProgressIndicator(),
					);
				}
			}
		);
	}
/*@override
	Widget buildSuggestions(BuildContext context) {
		// Son las sugerencias que aparecen cuando la persona escribe
		final listaSugerida = (query.isEmpty)?peliculasRecientes:peliculas.where((p)=>p.toLowerCase().startsWith(query.toLowerCase())).toList();
		return ListView.builder(
		itemCount: listaSugerida.length,
		itemBuilder: (context,int i){
		return ListTile(
		leading: Icon(Icons.movie),
		title: Text(listaSugerida[i]),
		onTap: (){
			seleccion = listaSugerida[i];
			showResults(context);
		},
		);
		}
		);
	}*/

}