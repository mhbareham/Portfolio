import UIKit
import Firebase
import MobileCoreServices

class MainViewController: UIViewController {
    
    @IBAction func signOut(_ sender: Any) {
        AppManager.shared.logout()
    }

