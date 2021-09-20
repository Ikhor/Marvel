// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let characterData = try? newJSONDecoder().decode(CharacterData.self, from: jsonData)

import Foundation

// MARK: - CharacterData
struct APIResult: Codable {
    let data: APICharacterData
}

// MARK: - DataClass
struct APICharacterData: Codable {
    let offset, limit, total, count: Int?
    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case results = "results"
    }
}

// MARK: - Result
struct Results: Identifiable, Codable {
    let id: Int
    let name, resultDescription: String
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }

    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail,
              let path = thumbnail.path,
              let ext = thumbnail.thumbnailExtension
        else {
            return URL(string: "")
        }
        // Replacing to have a security http request
        let pathSecure = path.replacingOccurrences(of: "http://", with: "https://")

        return URL(string: pathSecure + "/portrait_medium." + ext)
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String
    let type: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let url: String?
}
