import UIKit
import Firebase

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var posts = [Post]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count = 0
        loadPosts {
            self.showNextPost()
        }
    }
    
    func loadPosts(completion: @escaping () -> Void) {
        let ref = Firestore.firestore().collection("posts")
        ref.getDocuments { snapshot, error in
            self.posts.removeAll()
            for document in snapshot!.documents {
                let post = Post(document: document)
                self.posts.append(post)
            }
            completion()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showNextPost()
    }
    
    func showNextPost() {
        count += 1
        if count == posts.count {
            count = 0
        }
        let post = posts[count]
        textField.text = post.imageDownloadURL
        loadImage(for: post)
        
    }
    
    func loadImage(for post: Post) {
        let storageRef = Storage.storage().reference(withPath: post.imageDownloadURL!)
        storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.imageView.image = image
        }
    }
    
}
