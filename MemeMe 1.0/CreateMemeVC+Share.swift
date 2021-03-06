//
//  ViewController+Image.swift
//  MemeMe 1.0
//
//  Created by Alexandre Bianchi on 08/11/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension CreateMemeVC {
    
    // Save meme
    func save(image: UIImage) {
        // Create the meme for future use. In Meme 1.0, a variable with no title is used not to have a warning that it is never being used.
        let _ = Meme(topText: textTop.text!, bottomText: textBottom.text!, originalImage: imageMeme.image!, memedImage: image)
    }
    
    // Change hidden state for toolbars
    func changeToolbarsHiddenState(_ hidden: Bool) {
        topToolbar.isHidden = hidden
        bottomToolbar.isHidden = hidden
    }
    
    // Generate meme without top and bottom bar
    func generateMemedImage() -> UIImage {
        changeToolbarsHiddenState(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        changeToolbarsHiddenState(false)
        
        return memedImage
    }
    
    // Share generated memed image, and after complete the task, save it and dismiss view controller
    func shareImage() {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error -> () in
            if (completed) {
                self.save(image: memedImage)
                activityViewController.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
