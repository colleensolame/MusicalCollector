//
//  MusicalViewController.swift
//  MusicalCollector
//
//  Created by Colleen Ng on 9/14/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit

class MusicalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var musicalImageView: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var imagePicker = UIImagePickerController()
    var musical: Musical? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if musical != nil {
            musicalImageView.image = UIImage(data: musical!.image as Data!)
            txtTitle.text = musical!.title
            
            btnUpdate.setTitle("Update", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        musicalImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCamera(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnPhotos(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        if musical != nil {
            musical!.title = txtTitle.text
            musical!.image = UIImagePNGRepresentation(musicalImageView.image!) as NSData?
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let musical = Musical(context: context)
            musical.title = txtTitle.text
            musical.image = UIImagePNGRepresentation(musicalImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    }
