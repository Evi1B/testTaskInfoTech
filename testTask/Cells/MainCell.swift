//
//  MainCell.swift
//  testTask
//
//  Created by evilb on 30.07.2022.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    var dataProvider = DataProvider()
    
    private var image: UIImage? {
        didSet {
            cellImage.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
        cellImage.image = nil
    }
    
    func setCells(city: String, index: IndexPath) {
        self.cellLabel.text = city
        self.getImage(index: index)
    }
    
    private func getImage(index: IndexPath) {
        let urlFirst = "https://infotech.gov.ua/storage/img/Temp1.png"
        let urlSecond = "https://infotech.gov.ua/storage/img/Temp3.png"
        var urlString = ""
        
        if index.row % 2 == 0 {
            urlString = urlFirst
        } else {
            urlString = urlSecond
        }
        
        let url = URL(string: urlString) ?? URL(string: "")
        dataProvider.downloadImage(url: url!) { image in
            self.image = image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
