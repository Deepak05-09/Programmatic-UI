//
//  CombineFramework.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 24/05/23.
//

import UIKit
import Combine


struct User : Codable{
    let id : Int
    let email : String
    let name : String
}

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}


class CombineFramework: UIViewController {
    
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        start()
        subscriber()
    }
    
    
    func fetchUserData()->AnyPublisher<[User],Error>{
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let task = URLSession.shared.dataTaskPublisher(for: url).map(\.data).decode(type: [User].self, decoder: JSONDecoder())
        return task.eraseToAnyPublisher()
    }
    
    func subscriber(){
        fetchUserData()
            .sink{ completion in
            switch completion {
            case .finished : print("Finished")
            case .failure(let error) : print(error)
            }
        } receiveValue: { users in
            for user in users {
                print("ID: \(user.id), Name: \(user.name), Email: \(user.email)")
            }
        }.store(in: &cancellables)
    }
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func subscriberTwo(){
        fetchPosts()
            .map { posts in
                    posts.filter { $0.id > 5 }
                }
                .map { filteredPosts in
                    filteredPosts.map { $0.title }
                }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching and transforming posts completed.")
                case .failure(let error):
                    print("Fetching and transforming posts failed with error: \(error)")
                }
            }, receiveValue: { titles in
                for title in titles {
                    print("Post Title: \(title)")
                }
            })
            .store(in: &cancellables)
    }
    
    func start(){
        let publisher = Just(5)
            .map{ value -> String in
            "The value is \(value)"
        }
            .sink{ value in
                print(value)
            }
    }

}
