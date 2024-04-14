import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window?.makeSecure()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension UIWindow {
    func makeSecure() {
        let viewController = SecureTextInputViewController()
        viewController.modalPresentationStyle = .overFullScreen
        self.rootViewController?.present(viewController, animated: false, completion: nil)
    }
}

class SecureTextInputViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UITextField for secure text input
        let field = UITextField()
        field.isSecureTextEntry = true // Use isSecureTextEntry to hide the entered text
        view.addSubview(field)

        // Configure constraints to center the text field
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            field.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
