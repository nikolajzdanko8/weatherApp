import Foundation

final class NetworkService {

    func getRequest(url: String, comletion: @escaping (Model) -> Void) {
        sendRequest(urlString: url) { (data) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
               let json = try decoder.decode(Model.self, from: data)
                DispatchQueue.main.async {
                    comletion(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func modelCityesGetRequest(url: String, comletion: @escaping ([ModelCityes]) -> Void) {
        sendRequest(urlString: url) { (data) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
               let json = try decoder.decode([ModelCityes].self, from: data)
                DispatchQueue.main.async {
                    comletion(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    private func sendRequest( urlString: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil, let data = data {
            completion(data)
            } else {
                print(error?.localizedDescription)
            }
        }.resume()
    }

}

