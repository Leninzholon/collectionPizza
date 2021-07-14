//
//  SideMenu.swift
//  MySideMenu
//
//  Created by Afraz Siddiqui on 7/2/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable {
    case home = "Shop pizza"
    case info = "About us"
    case settings = "User room"
}

class MenuController: UITableViewController {

    public var delegate: MenuControllerDelegate?

    private let menuItems: [SideMenuItem]
    private let color = UIColor(red: 33/255.0,
                                green: 33/255.0,
                                blue: 33/255.0,
                                alpha: 1)

    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = #colorLiteral(red: 0.9441747069, green: 0.5805539489, blue: 0.2003090978, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.9441747069, green: 0.5805539489, blue: 0.2003090978, alpha: 1)
    }

    // Table

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = #colorLiteral(red: 0.1468463242, green: 0.2587963939, blue: 0.27839306, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.9441747069, green: 0.5805539489, blue: 0.2003090978, alpha: 1)
        cell.contentView.backgroundColor = #colorLiteral(red: 0.9441747069, green: 0.5805539489, blue: 0.2003090978, alpha: 1)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Relay to delegate about menu item selection
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }

}
