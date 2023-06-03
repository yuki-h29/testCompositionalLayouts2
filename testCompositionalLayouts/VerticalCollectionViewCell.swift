//
//  VerticalCollectionViewCell.swift
//  testCompositionalLayouts
//
//  Created by 平野裕貴 on 2023/05/28.
//

import UIKit

// UICollectionViewCellを継承したカスタムセルクラスです。
//さらにUICollectionViewのDelegateとDataSourceも実装しています。
class VerticalCollectionViewCell: UICollectionViewCell,
                                  UICollectionViewDelegate,
                                    UICollectionViewDataSource {
    
    // このセル内部に配置されたCollectionViewとLabelへの参照
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    // 写真のデータを格納する配列
    var photoArray = [String]()
    
    // セルがインスタンス化された後に呼ばれるメソッド
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // CollectionViewのレイアウトを設定するためのインスタンスを作成
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 横スクロールの設定
        layout.itemSize = CGSize(width: collectionView.frame.width,
                         height: collectionView.frame.height) // セルの大きさを設定
        layout.minimumLineSpacing = 20 // セル間のスペーシングを設定
        layout.minimumInteritemSpacing = 0 // セル間のスペーシングを設定
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        // Test1CollectionViewCellという名前のカスタムセルを登録
        collectionView.register(UINib(nibName: "Test1CollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "MyCustomCell")
    }
    
    // 画像データを設定してCollectionViewを更新するメソッド
    func configure(photo: [String]) {
        photoArray = photo
        collectionView.reloadData()
    }
    
    // CollectionViewのセクション内のアイテム数を返すメソッド
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photoArray.count  // 各人物に対する5つの写真
    }
    
    // CollectionViewのセルを返すメソッド
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeueReusableCellを使って、再利用可能なセルを取得します。
        //もし再利用可能なセルがなければ、新しいセルが作成されます。
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell",
                                   for: indexPath) as? Test1CollectionViewCell else {
            
            fatalError("Cell is not of type Test1CollectionViewCell")
        }
        
        // セルの見た目を設定します。
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 8, height: 8)
        cell.layer.masksToBounds = false
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        
        // 画像名として使用するインデックスを計算し、UIImageの初期化子にそれを渡します。
        cell.imageView.image = UIImage(named: photoArray[indexPath.row])
        // 各セルのラベルに対して、現在のセルの位置と全体の数を表示します。
        cell.label.text = "\(indexPath.row + 1) / \(photoArray.count)"
        
        // 設定されたセルを返します。
        return cell
    }
}

// UICollectionViewCell内のUICollectionViewに関する追加の設定を行うための拡張です。
extension VerticalCollectionViewCell: UICollectionViewDelegateFlowLayout {
    // このメソッドはセルのサイズを設定します。
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // ここではcollectionViewの幅と高さをそのままセルのサイズとして返しています。
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
        
    }
}


