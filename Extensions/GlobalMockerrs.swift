//
//  GlobalMockers.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 07/09/21.
//

import Foundation

private let dateFormatter = DateFormatter()

let exampleThumbnail1 = Thumbnail(
    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
    thumbnailExtension: "jpg"
)

let exampleThumbnail2 = Thumbnail(
    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
    thumbnailExtension: "jpg"
)

let exampleThumbnail3 = Thumbnail(
    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
    thumbnailExtension: "jpg"
)

let exampleComicsItem1 = ComicsItem(
    resourceURI: "http://gateway.marvel.com/v1/public/comics/21366",
    name: "Avengers: The Initiative (2007) #14"
)

let exampleComic1 = Comics(
    available: 1,
    collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/comics",
    items: [exampleComicsItem1],
    returned: 1
)

let exampleStoriesItem1 = StoriesItem(
    resourceURI: "http://gateway.marvel.com/v1/public/stories/19947",
    name: "Cover #19947",
    type: "Cover"
)

let exampleStories1 = Stories(
    available: 1,
    collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/stories",
    items: [exampleStoriesItem1],
    returned: 1
)

let URLExample1 = URLElement(
    type: "wiki",
    url: "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=e6cd9b6126a6bd558b89ff925f3b9a36"
)

let exampleCharacter1 = Results(
    id: 1011334,
    name: "3-D Man",
    resultDescription: "",
    //modified: dateFormatter.date(from: "2014-04-29T14:18:17-0400"),
    thumbnail: exampleThumbnail2,
    resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
    comics: exampleComic1,
    series: exampleComic1,
    stories: exampleStories1,
    events: exampleComic1,
    urls: [URLExample1]
)

let exampleCharacter2 = Results(
    id: 1011334,
    name: "3-D Man 2",
    resultDescription: "",
    //modified: dateFormatter.date(from: "2014-04-29T14:18:17-0400"),
    thumbnail: exampleThumbnail1,
    resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
    comics: exampleComic1,
    series: exampleComic1,
    stories: exampleStories1,
    events: exampleComic1,
    urls: [URLExample1]
)

let exampleCharacter3 = Results(
    id: 1011334,
    name: "3-D Man 3",
    resultDescription: "",
    //modified: dateFormatter.date(from: "2014-04-29T14:18:17-0400"),
    thumbnail: exampleThumbnail3,
    resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
    comics: exampleComic1,
    series: exampleComic1,
    stories: exampleStories1,
    events: exampleComic1,
    urls: [URLExample1]
)


var exampleCharacters: [Results] {
    return [exampleCharacter1, exampleCharacter2, exampleCharacter3].shuffled()
}
