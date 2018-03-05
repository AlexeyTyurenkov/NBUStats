//
//  RefreshController.swift
//  FinStat Ukraine
//
//  Created by Oleksii Tiurenkov on 3/5/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class RefreshController: UIView {

    
    @IBOutlet weak var image: UIImageView!
    private(set) var isAnimating = false
    private var shouldContinueAnimation: ()->(Bool) = { return false }
    func animation(_ when:@escaping ()->(Bool))
    {
        shouldContinueAnimation = when
        animate()
    }
    
    
    
    private func animate(direction: Bool = true)
    {
        isAnimating = true
        var perspectiveTransform = CATransform3DIdentity
        let sign: CGFloat = direction ? -1.0 : 1.0
        perspectiveTransform.m34 = sign/200.0
        let rot = CATransform3DMakeRotation(direction ? CGFloat.pi : 0.0, 0, 1, 0);
        UIView.animate(withDuration: 1.0, animations: {
            self.image.layer.transform = CATransform3DConcat(rot, perspectiveTransform)
        }) { (finished) in
            if finished
            {
                DispatchQueue.main.async {
                    if self.shouldContinueAnimation()
                    {
                        self.animate(direction: !direction)
                    }
                    else
                    {
                        self.isAnimating = false
                        self.shouldContinueAnimation = { return false }
                        self.image.transform = CGAffineTransform.identity
                    }
                }
            }
        }
    }

    
    
    static func defaultRefresh(frame: CGRect) -> RefreshController
    {
        let control = Bundle.main.loadNibNamed("RefreshController", owner: self, options: nil)?.first as? RefreshController
        control?.frame = frame
        return control ?? RefreshController()
    }
}
