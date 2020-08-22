//
//  BasketViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!
    var items: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cells: [ProductTableViewCell.self])
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductTableViewCell.self, for: indexPath)
        let item = items[indexPath.row]
        cell.set(
            title: item.title <~ Style.TextAttributes.regular,
            subtitle: item.price <~ Style.TextAttributes.regular,
            imageUrl: item.imageUrl
        )
        return cell
    }
}
