import Foundation
struct Search : Codable {
    var title : String?
	var year : String?
    var imdbID : String?
	var type : String?
	var poster : String?

	enum CodingKeys: String, CodingKey {

		case title = "Title"
		case year = "Year"
		case imdbID = "imdbID"
		case type = "Type"
		case poster = "Poster"
	}

	

}
