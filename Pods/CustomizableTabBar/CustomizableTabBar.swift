//
//  CustomizableTabBar.swift
//  GamingList
//
//  Created by jonathan.gomes<jonathangomes.ti@gmail.com> on 08/12/20.
//

import UIKit

@IBDesignable
class CustomizableTabBar: UITabBar {
    
    @IBInspectable var customBackgroundColor: UIColor? {
        didSet {
            configTabBar()
        }
    }
    
    @IBInspectable var buttonsOnly: Bool = false {
        didSet {
            configTabBar()
        }
    }
    
    @IBInspectable var buttonsPaddingX: CGFloat = 0 {
        didSet {
            configTabBar()
        }
    }
    @IBInspectable var buttonsPaddingY: CGFloat = 0 {
        didSet {
            configTabBar()
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            configTabBar()
        }
    }
    @IBOutlet var contentView: UIView?
    
    private let bgView: UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        self.configTabBar()
    }
    
    func configTabBar() {
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        self.backgroundColor = .clear
        self.bgView.backgroundColor = customBackgroundColor
        
        addDefaultBackgroundView()
        if let contentView = contentView{
            contentView.removeFromSuperview()
            bgView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            bgView.addConstraints([
                NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: bgView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: bgView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: bgView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: bgView, attribute: .trailing, multiplier: 1, constant: 0)
            ])
        }
        self.setNeedsDisplay()
    }
    
    
    
    fileprivate func addDefaultBackgroundView() {
        bgView.removeFromSuperview()
        bgView.layer.cornerRadius = radius
        bgView.layer.masksToBounds = true
        self.addSubview(bgView)
        if let containerView = self.superview {
            if buttonsOnly {
                var buttonsWidth:CGFloat = 0
                var minX: CGFloat = CGFloat.greatestFiniteMagnitude
                var maxX: CGFloat = 0
                
                var buttonsHeight = self.frame.height
                
                for itemView in self.subviews {
                    if String(describing: type(of: itemView)) == "UITabBarButton" {
                        buttonsHeight = itemView.frame.height
                        if itemView.frame.maxX > maxX {
                            maxX = itemView.frame.maxX
                        }
                        if itemView.frame.minX < minX {
                            minX = itemView.frame.minX
                        }
                        buttonsWidth = maxX-minX
                    }
                }
                
                containerView.addConstraints([
                    NSLayoutConstraint(item: bgView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: bgView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: bgView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: buttonsHeight + buttonsPaddingY),
                    NSLayoutConstraint(item: bgView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: buttonsWidth + buttonsPaddingX)
                ])
            } else {
                containerView.addConstraints([
                    NSLayoutConstraint(item: bgView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: bgView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: bgView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: bgView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
                ])
            }
            
        }
        self.sendSubviewToBack(bgView)
    }
}
