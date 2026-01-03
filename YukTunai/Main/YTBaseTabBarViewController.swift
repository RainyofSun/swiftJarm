//
//  YTBaseTabBarViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit

class YTBaseTabBarViewController: UITabBarController,UITabBarControllerDelegate {

        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIColor.white
            tabBarAppearance.shadowColor =  UIColor.white
            tabBar.standardAppearance = tabBarAppearance
           
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = tabBarAppearance
            }
            
            self.delegate = self
        }
   
        func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            let index = tabBarController.viewControllers?.firstIndex(of: viewController) ?? 0
            if index == 1 || index == 2 {
                if YTUserDefaults.shared.transport.count == 0 {
                    let loginVC = YTBaseNavigationController.init(rootViewController: YTLoginViewController())
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                    return false
                }
            }

            return true
        }

    }
