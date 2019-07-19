//
//  TableViewCell.swift
//  multithreading
//
//  Created by Алексей Перов on 7/18/19.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoActivityIndicator: UIActivityIndicatorView!
    
    private var path: String?
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    func configure(path: String) {
        self.path = path
        photoActivityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: path), let data = try? Data(contentsOf: url), let image = UIImage(data: data), path == self?.path {
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                    self?.photoActivityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
