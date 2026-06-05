import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}

public class Lysave{
    private let api = "https://lysave.com/api"
    private var headers: [String: String]
    
    public init() {
        self.headers = [
        "Connection":"keep-alive",
        "Accept-Encoding":"deflate, zstd",
        "Accept-Language":"en-US,en;q=0.9",
        "User-Agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36"
        ]

    }

    public func getYoutubeDownloadUrlData(videoUrl: String) async throws -> Any {
        let urlString = "\(api)/youtube-service/youtube/getYoutubeDownloadUrlData?videoUrl=\(videoUrl)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }
    
    public func getVideoInfoSearchKeys(searchKey: String, pageSize: Int = 6) async throws -> Any {
        let urlString = "\(api)/youtube-service/youtube/getVideoInfoSearchKeys"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
        "searchKey": searchKey,
        "nextToken": "",
        "pageSize": pageSize,
        "needToLoadVideoIds": []
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (responseData, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: responseData)
    }
}
