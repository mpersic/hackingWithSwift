//
//  GradientView.swift
//  Project37
//
//  Created by COBE on 29/06/2021.
//

import UIKit

class GradientView: UIView {

    @IBDesignable class GradientView: UIView {
        @IBInspectable var topColor: UIColor = UIColor.white
        @IBInspectable var bottomColor: UIColor = UIColor.black

        override class var layerClass: AnyClass {
            return CAGradientLayer.self
        }

        override func layoutSubviews() {
            (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
        }
    }
}
