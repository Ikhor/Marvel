//
//  MarvelManager.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 07/09/21.
//

import Foundation
import Alamofire

class CharactersRemoteDataSource : CharactersDataSource {

    // Default Path for Marvel API
    private let path = "https://gateway.marvel.com:443/v1/public/characters?"

    private let PUBLIC_KEY = "e6cd9b6126a6bd558b89ff925f3b9a36"
    private let PRIVATE_KEY = "3fcbadd3cad860dd278533c4965cc1e35749b115"

    func saveCharacter(character: Results, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        onSuccess()
    }

    func loadCharacters(nameStartsWith: String? = nil, offSet: Int, onSuccess: @escaping ([Results]) -> Void, onError: @escaping () -> Void) {

        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + PRIVATE_KEY + PUBLIC_KEY).md5

        var URL = path + "limit=20&offset=\(offSet)&ts=\(ts)&apikey=\(PUBLIC_KEY)&hash=\(hash)"

        if let nameStartsWith = nameStartsWith {
            let query = nameStartsWith.replacingOccurrences(of: " ", with: "%20") + "&"
            URL = path + "nameStartsWith=\(query)limit=5&offset=\(offSet)&ts=\(ts)&apikey=\(PUBLIC_KEY)&hash=\(hash)"
        }

        return performRequestCharacters(URL: URL, onSuccess: onSuccess, onError: onError)
    }

    private func performRequestCharacters(URL: String, onSuccess: @escaping ([Results]) -> Void, onError: @escaping () -> Void) {

        AF.request(URL).responseDecodable(
            of: APIResult.self,
            queue: .main,
            decoder: JSONDecoder()) { (response) in
            switch response.result {
            case .success(let CharacterData):
                onSuccess(CharacterData.data.results)
            case .failure(let error):
                print("Error: \(error)")
                onError()
            }
        }
    }
}
