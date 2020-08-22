//
//  ProductViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit
import Spring

class ProductViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!

    var comments: [Comment] = []
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentTextView: DesignableTextView!

    struct Input {
        let item: Product
    }

    var input: Input!

    struct Output {
        var sendComment: (String) -> Void
        var addToCart: (Product) -> Void
    }
    var output: Output!

    @IBAction func sendCommentTap(_ sender: Any) {
        output.sendComment(commentTextView.text)
    }
    @IBAction func addToCartTap(_ sender: Any) {
        output.addToCart(input.item)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.sizeToFitTableHeaderView()
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cells: [CommentTableViewCell.self])
    }

}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: CommentTableViewCell.self, for: indexPath)
        let item = comments[indexPath.row]
        cell.set(comment: item.text, author: item.user)
        return cell
    }
}
