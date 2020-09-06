//
//  CustomView4.swift
//  Example
//
//  Created by Abdul Basit on 07/09/20.
//  Copyright © 2020 Abdul Basit. All rights reserved.
//

import UIKit

class CustomView4: UIView {
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            let bundle = Bundle(for: type(of: self))
            imageView.image = UIImage(named: "arrow_right", in: bundle, compatibleWith: nil)
        }
    }
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
           "CustomView4", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = bounds
      }
}
