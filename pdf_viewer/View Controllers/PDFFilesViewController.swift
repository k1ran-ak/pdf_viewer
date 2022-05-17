//
//  PDFFilesViewController.swift
//  pdf_viewer
//
//  Created by Kiran on 17/05/22.
//

import UIKit
import PDFKit

class PDFFilesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - Local Variables
    var files = [URL]()
    //MARK: - Outlets
    @IBOutlet weak var filesCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filesCV.delegate = self
        self.filesCV.dataSource = self
        self.filesCV.register(UINib(nibName: "PDFFilesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDFFilesCollectionViewCell")
    }
    
    
    //If document fetch fails
    //url:String = "file:///Users/Kiran/Library/Developer/CoreSimulator/Devices/C138A941-B53A-4BD0-8AB0-57EC80746267/data/Containers/Data/Application/DBB27B6E-A1D8-4F8D-ACD6-487308FC8D27/Documents/"
    
    func showSavedPdf(fileName:String = "PDF-") {
     
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    defer {
                        self.filesCV.delegate = self
                        self.filesCV.dataSource = self
                    }
                    if url.description.contains("\(fileName).pdf") {
                     
                        files.append(url)

                }
            }
                filesCV.reloadData()
                
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
   
}
    
    //MARK: - Collection view functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDFFilesCollectionViewCell", for: indexPath) as! PDFFilesCollectionViewCell
        var label = files[indexPath.row].description.trimmingCharacters(in: CharacterSet(charactersIn: "file:///Users/Kiran/Library/Developer/CoreSimulator/Devices/C138A941-B53A-4BD0-8AB0-57EC80746267/data/Containers/Data/Application/A298F6A0-6266-4B04-B22B-4BC63ED4C4CD/Documents/"))
        label.removeLast()
        cell.pdfFileLbl.text = label
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width/3) - 20
        let height : CGFloat = 100
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
        vc.pdfURL = files[indexPath.row]
        self.present(vc, animated: true)
    }
}
