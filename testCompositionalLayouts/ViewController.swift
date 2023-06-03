//
//  ViewController.swift
//  testCompositionalLayouts
//
//  Created by 平野裕貴 on 2023/05/28.
//

import UIKit

class ViewController: UIViewController,
                      UICollectionViewDataSource,
                        UICollectionViewDelegate {
    
    // StoryboardからCollectionViewへの参照を保持します。
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 5つのセットの画像名を保持する配列です。
    var photoArray = [["tokyo1","tokyo2","tokyo3","tokyo4","tokyo5"],
                      ["tokyo1","tokyo2","tokyo3","tokyo4","tokyo5"],
                      ["tokyo1","tokyo2","tokyo3","tokyo4","tokyo5"],
                      ["tokyo1","tokyo2","tokyo3","tokyo4","tokyo5"],
                      ["tokyo1","tokyo2","tokyo3","tokyo4","tokyo5"]]
    
    // viewがメモリにロードされた後に呼び出されます。
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionViewのレイアウトを設定します。
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // CollectionViewを縦方向にスクロールするように設定します。
        let cellWidth = view.frame.size.width - 20 // セルの幅を計算します。
        layout.itemSize = CGSize(width: cellWidth,
                                 height: view.frame.size.height / 2) // セルの大きさを設定します。
        layout.minimumInteritemSpacing = 10 // 各行内のアイテム間の最小スペースを設定します。
        layout.minimumLineSpacing = 10 // 行間の最小スペースを設定します。
        
        let inset = (view.frame.size.width - cellWidth) / 2
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: inset,
                                           bottom: 0,
                                           right: inset) // 各セクションの余白を設定します。
        
        collectionView.collectionViewLayout = layout // CollectionViewにレイアウトを適用します。
        collectionView.dataSource = self // CollectionViewのデータソースを設定します。
        collectionView.delegate = self // CollectionViewのデリゲートを設定します。
        collectionView.register(UINib(nibName: "VerticalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VerticalCell") // Nibファイルからセルを登録します。
    }
    
    // このメソッドは、特定のセクション内のアイテム数を返します。
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photoArray.count // 各セクションのアイテム数はphotoArrayのカウントになります。
    }
    
    // このメソッドは、特定のIndexPathのアイテムに対するセルを返します。
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // ここでセルを取得
        // dequeueReusableCellを使って、再利用可能なセルを取得します。
        //もし再利用可能なセルがなければ、新しいセルが作成されます。
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell",
                                              for: indexPath) as! VerticalCollectionViewCell
        // セルに対応するphotoArrayの配列を渡します。
        cell.configure(photo: photoArray[indexPath.row])
        
        // 以下でセルの見た目を設定します。
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 8, height: 8)
        cell.layer.masksToBounds = false
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        // ラベルのフォントをGeorgia-Boldに設定します。
        cell.label.font = UIFont(name: "Georgia-Bold", size: 25)
        // 最後にセルを返します。
        return cell
    }
    
    // このメソッドは、CollectionViewのセクション数を返します。ここでは、常に1が返されます。
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // 縦スクロールのCollectionViewでは、通常セクションは1つです。
    }
}

