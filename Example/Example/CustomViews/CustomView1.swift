//
//  CustomView1.swift
//  Example
//
//  Created by Abdul Basit on 06/09/20.
//  Copyright © 2020 Abdul Basit. All rights reserved.
//

import UIKit

class CustomView1: UIView {
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.text = "Custom View One"
        }
    }
    
    @IBOutlet var contentView: UIView!
       
       override init(frame: CGRect) {
              super.init(frame: frame)
              commonInit()
          }
          
          required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
              commonInit()
          }
          
          private func commonInit() {
              Bundle.main.loadNibNamed(
               "CustomView1", owner: self, options: nil)
              addSubview(contentView)
              contentView.frame = bounds
          }
    
}
