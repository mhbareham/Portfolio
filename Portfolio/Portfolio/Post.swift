import UIKit
import Firebase

class Post {
    
    var posts = [Post]()
    
    var caption: String!
    var imageDownloadURL: String?
    var image: UIImage!
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
    init() { }
    
    init(document: DocumentSnapshot) {
        let data = document.data()!
        caption = data["caption"] as? String
        imageDownloadURL = data["imageDownloadURL"] as? String
    }
    
    func toDict() -> [String: Any] {
        return [
            "caption": caption,
            "imageDownloadURL": imageDownloadURL!
        ]
    }
    
}
