//
//  ContactViewController.swift
//  Homework7
//
//  Created by Robert Mukhtarov on 24.10.2020.
//

import UIKit

class ContactViewController: UIViewController {
    var contact: Contact!
    @IBOutlet private var initialsLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var numberLabel: UILabel!
    
    override func viewDidLoad() {
        let name = contact.name
        let surname = contact.surname
        initialsLabel.font = .rounded(ofSize: 36)
        nameLabel.text = "\(name) \(surname)"
        initialsLabel.text = "\(name.first!)\(surname.first!)"
        numberLabel.text = contact.number
    }
}

extension UIFont {
    class func rounded(ofSize size: CGFloat) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: .medium)
        var font = systemFont
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        }
        return font
    }
}
