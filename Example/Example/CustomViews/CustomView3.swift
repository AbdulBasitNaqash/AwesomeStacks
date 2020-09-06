//
//  CustomView3.swift
//  Example
//
//  Created by Abdul Basit on 07/09/20.
//  Copyright © 2020 Abdul Basit. All rights reserved.
//

import UIKit

class CustomView3: UIView {
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
           "CustomView3", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = bounds
      }
}
