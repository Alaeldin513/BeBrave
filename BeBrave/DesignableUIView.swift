//
//  DesignableUIView.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 8/17/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit

@IBDesignable class DesignableUIView: UIView {

    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }

    override class var layerClass: AnyClass {
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor ,secondColor.cgColor]
        layer.locations = [0.50]
    }
}
