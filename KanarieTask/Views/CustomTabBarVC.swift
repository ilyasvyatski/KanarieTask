//
//  CustomTabBarVC.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/26/22.
//

import UIKit

class CustomTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        self.ChangeRadiusOfTabbar()
        self.changeUnSelectedColor()
    }
    
    func ChangeRadiusOfTabbar() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 50
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func changeUnSelectedColor() {
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabBar.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        self.ChangeHeightOfTabbar()
    }
    
    func ChangeHeightOfTabbar() {
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame = tabBar.frame
            tabFrame.size.height = 100
            tabFrame.origin.y = view.frame.size.height - 100
            tabBar.frame = tabFrame
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.SimpleAnnimationWhenSelectItem(item)
    }
    
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
     guard let barItemView = item.value(forKey: "view") as? UIView else { return }

     let timeInterval: TimeInterval = 0.2
     let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
     barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
     }
     propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
     propertyAnimator.startAnimation()
    }
}
