import UIKit
@IBDesignable

class DesignableButton: UIButton {
    @IBInspectable var leftImage: UIImage? {
        didSet {
            UpdateView()
        }
    }
    
    func UpdateView()
    {
        if let image = leftImage
        {
//            leftViewMode = .always
//            leftView
        }
        else
        {
//            leftViewMode = .never
        }
    }
}
