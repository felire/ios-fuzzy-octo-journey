struct Image: Decodable {
    var id: String
    var croppedPicture: String
    enum CodingKeys: String, CodingKey {
      case id
      case croppedPicture = "cropped_picture"
    }
}

struct Images: Decodable {
    var pictures: [Image]
    var page: Int
    var pageCount: Int
    enum CodingKeys: String, CodingKey {
      case pictures
      case page
      case pageCount
    }
}

struct ImageDetail: Decodable {
    var id: String
    var author: String
    var camera: String
    var croppedPicture: String
    var fullPicture: String
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case camera
        case croppedPicture = "cropped_picture"
        case fullPicture = "full_picture"
    }
}


