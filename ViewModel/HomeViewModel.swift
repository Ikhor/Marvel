//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 07/09/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    private var searchCancellable: AnyCancellable? = nil

    private var remoteDataSource = CharactersRemoteDataSource()
    private var localDataSource = PersistenceController()

    @Published var searchQuery = ""
    @Published var fetchedCharacter: [Results]? = nil
    @Published var characterDetailToShow: Results? = nil
    @Published var offset: Int = 0

    @Published var fetchedFavoriteCharacter: [Results]? = nil

    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.searchCharactersAPIList()
                }
                else {
                    self.offset = 0
                    self.searchCharactersAPI()
                }
            })
        searchFavorites()
    }

    func searchCharactersAPI() {

        remoteDataSource.loadCharacters(nameStartsWith: searchQuery, offSet: offset) { results in
            print("Fetched")
            DispatchQueue.main.async {
                if self.offset == 0 {
                    self.fetchedCharacter?.removeAll()
                    self.fetchedCharacter = results
                }
                else {
                    self.fetchedCharacter?.append(contentsOf: results)
                }
            }
        } onError: {
            // Todo error treat
        }
    }

    func searchCharactersAPIList() {

        remoteDataSource.loadCharacters(nameStartsWith: nil, offSet: offset) { results in
            print("Fetched")
            DispatchQueue.main.async {
                if self.offset == 0 {
                    self.fetchedCharacter?.removeAll()
                    self.fetchedCharacter = results
                }
                else {
                    self.fetchedCharacter?.append(contentsOf: results)
                }
            }
        } onError: {
            // Todo error API treat
        }
    }

    func searchFavorites() {

        localDataSource.loadCharacters(nameStartsWith: nil, offSet: offset) { results in
            print("Fetched")
            DispatchQueue.main.async {
                self.fetchedFavoriteCharacter?.removeAll()
                self.fetchedFavoriteCharacter = results
            }
        } onError: {
            // Todo error favorites treat
            print("Error favorites")
        }
    }

    func addFavorite(character: Results) {

        localDataSource.saveCharacter(character: character) {
            // Todo success
            print("Saved... reloading favorites")
            self.searchFavorites()
        } onError: {
            print("Error")
        }
    }


    func deleteFavorite(character: Results) {

        localDataSource.deleteCharacter(character: character) {
            // Todo success
            print("Removed... reloading favorites")
            self.searchFavorites()
        } onError: {
            print("Error")
        }
    }

    func isFavorite(character: Results) -> Bool {
        return localDataSource.searchCharacterById(character: character)
    }

}
