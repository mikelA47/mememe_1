//
//  ViewController.swift
//  MemeMe
//
//  Created by Mikel Lizarralde Cabrejas on 23/3/15.
//  Copyright (c) 2015 TheUnit. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSStrokeWidthAttributeName : -4.0,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
        ]
        
        //Still does not work UIApplication.sharedApplication().statusBarHidden=true;
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        println("\(topTextField.textColor)")
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        self.shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable    (UIImagePickerControllerSourceType.Camera)
        UIApplication.sharedApplication().statusBarHidden=true; // find out why does not work
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func save() {
        //call the Meme constructor with our parameters
        var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memeImage: generateMemedImage())
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        self.navigationBar.hidden = true
        self.toolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        self.navigationBar.hidden = false
        self.toolBar.hidden = false
        return memedImage
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //Erase only the default text when an user edit any of the textfields
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        //Subscribe only if the bottom textfield is edited, no need for the top textfield
        if textField.isEqual(self.bottomTextField) {
            self.subscribeToKeyboardNotifications()
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.isEqual(self.bottomTextField) {
            self.unsubscribeFromKeyboardNotifications()
        }
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
        self.shareButton.enabled = true
        //I don´t check if the text is the same or not than default, you never know when an user
        //actually wants to set a meme with TOP and BOTTOM
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        //To-do in future: option to crop an image - imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        //To-do in future: option to crop an image - imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        //create the activity view controller
        let activityViewController = UIActivityViewController(activityItems: [self.generateMemedImage()], applicationActivities: nil)
        //create the action to perform after task complete
        activityViewController.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        //call the activity view controller
        self.presentViewController(activityViewController, animated: true, completion: nil)

    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
}

