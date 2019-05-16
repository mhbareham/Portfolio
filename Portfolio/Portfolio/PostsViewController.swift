import UIKit
import Firebase
import MobileCoreServices

class PostsViewController: UIViewController {
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var captionText: UITextField!
    
    var post = Post()
    
    @IBAction func getPhotoButton(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        save(post)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func save(_ post: Post) {
        guard let caption = captionText.text, let postImage = post.image else {
            captionText.backgroundColor = .red
            return
        }
        post.caption = caption
        upload(postImage) { storageMeta, error in
            let ref = Firestore.firestore().collection("posts").document()
            post.imageDownloadURL = storageMeta?.name
            ref.setData(post.toDict()) { err in }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func upload(_ image: UIImage, completion: @escaping (StorageMetadata?, Error?) -> Void) {
        
        let uuid = UUID().uuidString
        let imageStorageRef = Storage.storage().reference().child(uuid)
        let data = image.jpegData(compressionQuality: 0.7)!
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        imageStorageRef.putData(data, metadata: meta) { storageMeta, error in
            completion(storageMeta, error)
        }
    }
   
}

    
extension PostsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        post.image = image
            self.imagePreview.image = image
        dismiss(animated:true, completion: nil)
    }
}


