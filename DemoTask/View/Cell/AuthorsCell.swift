//
//  AuthorsCell.swift
//  DemoTask
//
//  Created by MacMini-dev on 26/05/23.
//

import UIKit

class AuthorsCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorID: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var btnCheckUncheck: UIButton!
    
    var checkboxTappedCompletion : (() -> ())? // closure
    var authorModel: AuthorModel? {       // author model variable
        didSet {
            authorDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
// MARK: - set up ui methods
    func authorDetailConfiguration() {
        guard let authorModel else { return }
        authorID.text = authorModel.id
        authorName.text = authorModel.author
        profileImageView.setImage(with: authorModel.downloadURL)
        authorID.font = UIFont.boldSystemFont(ofSize: 20.0)
        authorName.font = UIFont.systemFont(ofSize: 20.0)
    }
    
// MARK: - Button Actions
    @IBAction func checkUncheckButtonAction(_ sender: UIButton) {
        checkboxTappedCompletion?()  // calling of closure
    }
}
