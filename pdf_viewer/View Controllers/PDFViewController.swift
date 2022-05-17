//
//  PDFViewController.swift
//  pdf_viewer
//
//  Created by Kiran on 17/05/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    //MARK: - Oultets
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var pdfView: PDFView!
    var pdfURL : URL?
    var iter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pdfURL == nil {
            openPDF()
        } else {
            openPDFWithURL(url: pdfURL!)
        }
        
    }
    
    @IBAction func saveBtnActn(_ sender: Any) {
        savePDF()
    }
    func openPDF() {
        if let path = Bundle.main.path(forResource: "sample_1", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
    func openPDFWithURL(url : URL) {
        self.saveBtn.isHidden = true
        if let pdfDocument = PDFDocument(url: url) {
            pdfView.displayMode = .singlePageContinuous
            pdfView.autoScales = true
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDocument
        }
    }
    func savePDF() {
        var fileName = "\(iter)"
        guard let document = pdfView.document else {
            return
        }
        guard let documentURL = document.documentURL else {
            return
        }
        print(documentURL)
        let pdfData = try? Data.init(contentsOf: documentURL)
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        fileName = checkPdfFileAlreadySaved(iter: iter)
        let pdfNameFromUrl = "PDF-\(fileName).pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        print(actualPath)
        do {
            
            try pdfData?.write(to: actualPath, options: .atomic)
            
            
            self.showAlert(desc: "PDF successfully saved!")
            iter += 1
        } catch {
            self.showAlert(desc: "PDF could not be saved")
        }
    }
    
    func checkPdfFileAlreadySaved(iter:Int)-> String {
        var status = false
        var iter = iter
        
        
        var fileName = "\(iter)"
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            for url in contents {
                iter += 1
                fileName = "\(iter)"
                if url.description.contains("PDF-\(fileName).pdf") {
                    status = false
                } else {
                    status = true
                }
            }
        } catch {
            print("could not locate pdf file !")
        }
        
        if status {
            return fileName
        } else {
            iter -= 1
            fileName = "\(iter)"
            return fileName
        }
        
    }
    
    func showAlert(desc : String) {
        let alert = UIAlertController(title: "PDF App", message: desc, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.dismiss(animated: true)
        })
    }
}
