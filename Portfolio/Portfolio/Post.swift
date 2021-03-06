import UIKit
import Firebase

class Post: CustomStringConvertible {
    
    var description: String {
        return "\(created.dateValue()) - \(caption!)"
    }
    
    var posts = [Post]()
    
    var caption: String!
    var imageDownloadURL: String?
    var image: UIImage!
    var created: Timestamp!
    var username: String!
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
    init() { }
    
    init(document: DocumentSnapshot) {
        let data = document.data()!
        caption = data["caption"] as? String
        imageDownloadURL = data["imageDownloadURL"] as? String
        created = data["created"] as? Timestamp
        username = data["username"] as? String
    }
    //metadata for the document snapshot
    
    func toDict() -> [String: Any] {
        return [
            "caption": caption,
            "imageDownloadURL": imageDownloadURL!,
            "created": Timestamp(),
            "username": username
        ]
    }
    
}
