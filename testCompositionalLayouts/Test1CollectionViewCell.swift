//
//  Test1CollectionViewCell.swift
//  testCompositionalLayouts
//
//  Created by 平野裕貴 on 2023/05/28.
//

import UIKit

class Test1CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.frame = self.bounds // 画像をセル全体に表示
        imageView.contentMode = .scaleAspectFill // アスペクト比を保ちつつ画像を拡大
        imageView.clipsToBounds = true // 画像がimageViewの範囲を超えた部分をクリップ
        
        label.layer.cornerRadius = 12
        label.clipsToBounds = true // ラベルの境界を超えた内容をクリップします。
    }
}

