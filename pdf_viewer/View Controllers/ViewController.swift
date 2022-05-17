//
//  ViewController.swift
//  pdf_viewer
//
//  Created by Kiran on 17/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PDF App"
    }
    
    //MARK: - Button Actions
    
    @IBAction func generatePDFAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PDFViewController")
        self.present(vc, animated: true)
        
    }
    
    @IBAction func generatedPDFAction(_ sender: Any) {
        
        let fileName = "PDF-"
        var files = [URL]()
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            for url in contents {
                
                if url.description.contains("\(fileName)") {
                    files.append(url)
                    
                }
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PDFFilesViewController") as! PDFFilesViewController
            vc.files = files
            self.present(vc, animated: true)
            
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
        
    }
    
    
}

