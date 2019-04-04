import UIKit

class MainViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        AppManager.shared.logout()
    }
}
