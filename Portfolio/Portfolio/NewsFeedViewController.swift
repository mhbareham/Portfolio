import UIKit
import Firebase

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func signOutButton(_ sender: Any) {
            AppManager.shared.logout()
    }
    
    var posts = [Post]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            self.posts.sort(by: { $0.created.dateValue() > $1.created.dateValue() })
            completion()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        count += 1
        showNextPost()
    }
    
    func showNextPost() {
        
        if count == posts.count {
            count = 0
        }
        let post = posts[count]
        print(post)
        textField.text = post.caption
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
