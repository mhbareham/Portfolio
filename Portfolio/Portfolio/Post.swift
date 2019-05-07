import UIKit
import Firebase

class Post {
    
    var posts = [Post]()
    
    var caption: String!
    var imageDownloadURL: String?
    var image: UIImage!
    
    init() { }
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
//    init(document: DocumentSnapshot){
//    }
    
    func toDict() -> [String: Any] {
        return [
            "caption": caption,
            "imageDownloadURL": imageDownloadURL!
        ]
    }
    
}
