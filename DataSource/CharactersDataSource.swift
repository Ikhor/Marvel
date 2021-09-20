//
//  CharactersDataSource.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 19/09/21.
//

protocol CharactersDataSource {

    func saveCharacter(character: Results, onSuccess: @escaping () -> Void, onError: @escaping () -> Void)

    func loadCharacters(nameStartsWith: String?, offSet: Int, onSuccess: @escaping ([Results]) -> Void, onError: @escaping () -> Void)
}
