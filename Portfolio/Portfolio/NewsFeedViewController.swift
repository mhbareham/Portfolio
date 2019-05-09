import UIKit
import Firebase

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timestampField: UILabel!
    
    @IBAction func signOutButton(_ sender: Any) {
            AppManager.shared.logout()
    }
    
    var posts = [Post]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
//        
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
//        
//        view.addGestureRecognizer(rightSwipe)
//        view.addGestureRecognizer(leftSwipe)
    }
    
<<<<<<< HEAD
=======
//    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
//        if sender.state == .ended {
//            switch sender.direction {
//            case .left:
//                count += 1
//                showNextPost()
//            case .right:
//                count -= 1
//                showNextPost()
//            default:
//                break
//            }
//        }
//    }
    
>>>>>>> de371ea25bc40c66831ee57b55ee1b89221f89dd
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
//        timestampField.text = "\(post.created.dateValue())"
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
