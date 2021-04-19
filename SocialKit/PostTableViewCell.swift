//
//  PostTableViewCell.swift
//  SocialKit
//
//  Created by Marlon Machado on 19/04/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var lblSubtitulo: UILabel!
    
    var post: Post? {
        didSet {
            if let post = post {
                lblTitulo.text = post.title
                lblSubtitulo.text = post.body
            }
        }
    }

}
