//
//  ViewController.swift
//  TableViewTest
//
//  Created by Teacher on 19.10.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: ImageCell.identifier
        )
        loadData()
    }
    
    private enum Section: Int {
        case mainInfo
        case allKeyboards
        case certificateTrustSettings
        case images
    }
    
    private enum Cell {
        case rightDetail(title: String, detail: String)
        case basic(title: String)
        case image(title: String, image: UIImage)
    }
    
    private struct SectionData {
        let cells: [Cell]
    }
    
    private var sectionsData: [SectionData]?
    
    private func loadData() {
        sectionsData = [
            SectionData(cells: [
                .rightDetail(title: "Name", detail: "iPhone"),
                .rightDetail(title: "Name", detail: "iPhone"),
                .rightDetail(title: "Name", detail: "iPhone"),
                .rightDetail(title: "Name", detail: "iPhone"),
                .rightDetail(title: "Name", detail: "iPhone")
            ]),
            SectionData(cells: [
                .rightDetail(title: "Songs", detail: "0"),
                .rightDetail(title: "Songs", detail: "525"),
                .rightDetail(title: "Songs", detail: "2340"),
                .rightDetail(title: "Songs", detail: "6450"),
                .rightDetail(title: "Songs", detail: "560"),
                .rightDetail(title: "Songs", detail: "234")
            ]),
            SectionData(cells: [
                .basic(title: "Certificate Trust Settings")
            ]),
            SectionData(cells: imageCells())
        ]
    }
    
    private func imageCells() -> [Cell] {
        (1...7).map { index in
            guard let image = UIImage(named: "\(index)") else { fatalError("Could not find image") }
            
            return Cell.image(title: "Image \(index)", image: image)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = sectionsData?[section] else { return 0 }
        
        return sectionData.cells.count
    }
    
    enum CellIdentifier: String {
        case rightDetail = "RightDetail"
        case basic = "Basic"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = sectionsData?[indexPath.section]
        else { fatalError("Attempt to get data while it is not loaded") }
        
        switch cellData.cells[indexPath.row] {
        case .basic(let title):
            return basicCell(for: indexPath, from: tableView, title: title)
        case .image(let title, let image):
            return imageCell(for: indexPath, from: tableView, title: title, image: image)
        case .rightDetail(let title, let detail):
            return rightDetailCell(for: indexPath, from: tableView, title: title, detail: detail)
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 1 {
//            return "all keyboards"
//        }
//
//        return nil
//    }
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        if section == 1 {
//            return "Lorem ipsum dolor"
//        }
//
//        return nil
//    }
    
    // MARK: - UITableViewDelegate
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        40
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//            label.text = "main info"
//            return label
//        }
//
//        return nil
//    }
    
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        switch indexPath.section {
//        case 2, 3:
//            return true
//        default:
//            return false
//        }
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        switch indexPath.section {
//        case 3:
//            selectImage(at: indexPath.row)
//        default:
//            break
//        }
//    }
    
    // MARK: - Helpers
    
    private func selectImage(at index: Int) {
        guard let imageViewController: ImageViewController
                = storyboard?.instantiateViewController(identifier: "ImageViewController")
        else { return }
        
        imageViewController.loadViewIfNeeded()
        imageViewController.image = UIImage(named: "\(index + 1)")
        show(imageViewController, sender: nil)
    }
    
    private func rightDetailCell(
        for indexPath: IndexPath, from tableView: UITableView, title: String, detail: String
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifier.rightDetail.rawValue,
            for: indexPath
        )
        cell.detailTextLabel?.textColor = UIColor.systemGray
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = detail
        return cell
    }
    
    private func basicCell(for indexPath: IndexPath, from tableView: UITableView, title: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifier.basic.rawValue,
            for: indexPath
        )
        cell.textLabel?.text = title
        return cell
    }
    
    private func imageCell(
        for indexPath: IndexPath, from tableView: UITableView, title: String, image: UIImage
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell
        else { fatalError("Could not deque cell")}
        cell.titleLabel.text = title
        cell.largeImageView.image = image
        return cell
    }
}

