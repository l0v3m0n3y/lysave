# lysave
api for lysave.com Start from a keyword, title, creator, or direct video link. Lysave helps you move from discovery to download without switching tools. Video and Audio Options
# main
```swift
import Foundation
import lysave
let save = Lysave()

do {
    let info = try await save.getYoutubeDownloadUrlData(videoUrl: "https://youtu.be/l4SZQchs-Mk?si=H4pcko3EY-K5AZWV")
    print(info)
} catch {
    print("Error: \(error)")
}
```

# Launch (your script)
```
swift run
```
