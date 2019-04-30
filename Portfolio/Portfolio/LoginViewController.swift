import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { [unowned self] result, error in
            
            guard let user = result?.user else {
                
                self.handleError(error)
                if error != nil{
                    print("Error Signing Up")
                }
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:String?)->())){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
    }
    
    func handleError(_ error: Error?) {
        guard let error = error else {
            print("Big Error")
            return
        }
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        emailTextField.textColor = .red
    }
    
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            guard let _ = user else {
                self.handleError(error)
                return
            }
            self.dismiss(animated: true, completion: nil )
        }
    }

}
