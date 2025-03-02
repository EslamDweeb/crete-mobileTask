//
//  UIviewController_Ext.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit

@available(iOS 12.0, *)
extension UIViewController {

    func createAlert(title: String? = nil,erroMessage: String,createButton:Bool? = true,completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? "", message: erroMessage, preferredStyle: UIAlertController.Style.alert)
//        alert.setBackgroundColor(color: .darkGray)
//        alert.setMessage(font: nil, color: .white)
        if createButton == true{
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
                if let completion = completion {
                    completion()
                }else{
                    alert.dismiss(animated: true)
                }
            }
        alert.addAction(okButton)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    

    class func loadController() -> Self {
             Self.init(nibName: String(describing: self), bundle: nil)
        }
    func presentInFullScreen(_ viewController: UIViewController,transition:UIModalTransitionStyle = .coverVertical,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = transition
        present(viewController, animated: animated, completion: completion)
    }
    func presentPopScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: animated, completion: completion)
    }
    func presentMenu(_ vc:UIViewController,delegate:UIViewControllerTransitioningDelegate,animated: Bool,completion: (() -> Void)? = nil){
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = delegate
        present(vc, animated: animated, completion: completion)
    }
    func navigateToNewVC(_ VC:UIViewController){
        navigationController?.pushViewController(VC, animated: true)
    }
    func PopToOldPage(){
        navigationController?.popViewController(animated: true)
    }
    func cleanNavStackWithNewVC(_ VC:UIViewController){
        navigationController?.setViewControllers([VC], animated: true)
    }

    func saveDictionaryToUserDefaults(dictionary: [String: Any], forKey key: String) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: dictionary, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error saving dictionary to UserDefaults: \(error)")
        }
    }
    func loadDictionaryFromUserDefaults(forKey key: String) -> [String: Any]? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                if let dictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: Any] {
                    return dictionary
                }
            } catch {
                print("Error loading dictionary from UserDefaults: \(error)")
            }
        }
        return nil
    }
}

import MBProgressHUD
//import CleanyModal

extension UIViewController {
    func showIndicator(withTitle title: String, and description: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }


}
