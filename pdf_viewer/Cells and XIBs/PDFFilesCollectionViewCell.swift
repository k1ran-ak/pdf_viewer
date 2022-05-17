//
//  PDFFilesCollectionViewCell.swift
//  pdf_viewer
//
//  Created by Kiran on 17/05/22.
//

import UIKit

class PDFFilesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var pdfFileLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(view: holderView)
      
    }
    
    func addShadow(view : UIView) {
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            view.layer.shadowRadius = 3.0
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.masksToBounds = false
    }
}
