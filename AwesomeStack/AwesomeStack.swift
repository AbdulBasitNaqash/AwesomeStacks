//
//  AwesomeStack.swift
//  AwesomeStack
//
//  Created by Abdul Basit on 05/09/20.
//  Copyright © 2020 Abdul Basit. All rights reserved.
//

import UIKit

public class AwesomeStack: UIView {
    
    //MARK: - Variables and Constants
    let nibName: String = "AwesomeStack"
    var contentView: UIView!
    var cornerRadius: Int = 8
    let heightConstraintIdenfitier = "heightAnchor"
    
    // MARK: Set Up View
    public override init(frame: CGRect) {
     // For use in code
      super.init(frame: frame)
      setUpView()
    }

    public required init?(coder aDecoder: NSCoder) {
       // For use in Interface Builder
       super.init(coder: aDecoder)
      setUpView()
    }
    
    public func setCornerRadius(cornerRadius: Int) {
        self.cornerRadius = cornerRadius
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
    }
    
    public func addView(view: UIView) {
        if subviews.count > 4 {return}
        view.frame.size.height = frame.height
        view.tag = subviews.count
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        addDropdownButtonTo(view: view)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        view.backgroundColor = UIColor.random
        
        addCTAButtonTo(view: view)
        adjust(view: view)
    }
    
    private func adjust(view: UIView) {
        //Keep all the views height zero except first one
        if subviews.count == 2 {
            view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        }
        else {
           setHeightConstraint(view: view, value: 0)
        }
    }
    
    private func addDropdownButtonTo(view: UIView) {
        if subviews.count == 2 {//Dont add button to first view
            return
        }
        let button = UIButton(type: .custom)
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        let bundle = Bundle(for: type(of: self))
        button.setImage(UIImage(named: "arrow_down", in: bundle, compatibleWith: nil), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.tag = view.tag
        button.addTarget(self, action: #selector(dropDownButtonTapped(button:)), for: .touchUpInside)
    }
    
    //Add CTA button at the bottom of 2 default views
    private func addCTAButtonTo(view: UIView) {
        if subviews.count > 4 {return}
        let ctaButton = UIButton()
        ctaButton.tag = view.tag
        view.addSubview(ctaButton)

        ctaButton.translatesAutoresizingMaskIntoConstraints = false

        ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        ctaButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ctaButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        ctaButton.backgroundColor = .purple
        ctaButton.tintColor = .white
        ctaButton.layer.cornerRadius = 20
        ctaButton.setTitle("Tap here to open next", for: .normal)
        ctaButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        ctaButton.addTarget(self, action: #selector(ctaButtonTapped(button:)), for: .touchUpInside)
    }
    
    func setHeightConstraint(view: UIView, value: CGFloat) {
        let constraint = view.heightAnchor.constraint(equalToConstant: value)
        constraint.identifier = heightConstraintIdenfitier
        constraint.isActive = true
    }
    
    @objc func dropDownButtonTapped(button: UIButton) {
        for (index, view) in subviews.enumerated() where index >= button.tag {
            collapse(view: view)
        }
    }
    
    @objc func ctaButtonTapped(button: UIButton) {
        if subviews.count > button.tag + 1 {
            let view = subviews[button.tag + 1]
            expand(view: view)
        }
    }
    
    private func expand(view: UIView) {
        let topView = subviews[view.tag - 1]
        view.constraints.forEach { (constraint) in
            if constraint.identifier == heightConstraintIdenfitier {
                constraint.isActive = false
            }
        }
        addShadowTo(view: view)
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        setHeightConstraint(view: view, value: topView.frame.height - 50)
        animate(springDamping: 3, springVelocity: 10)
    }
    
    private func collapse(view: UIView) {
        view.constraints.forEach { (constraint) in
            if constraint.identifier == heightConstraintIdenfitier {
                constraint.isActive = false
            }
        }
        removeShadowFrom(view: view)
        setHeightConstraint(view: view, value: 0)
        animate(springDamping: 5, springVelocity: 4)
    }
    
    private func animate(springDamping: CGFloat, springVelocity: CGFloat) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: .transitionCurlUp, animations: {
                self.layoutIfNeeded()
            }) { (_) in
        }
    }
    
    private func addShadowTo(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0 , height: -3)
    }
    
    private func removeShadowFrom(view: UIView) {
        view.layer.masksToBounds = true
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 0
    }
}

extension UIColor {
   static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
