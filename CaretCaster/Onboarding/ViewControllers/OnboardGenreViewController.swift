//
//  OnboardGenreViewController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 4/26/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class OnboardGenreViewController: UIViewController {
  
  var allGenres = [Genre]()
  var selectedGenres = [Genre]() {
    willSet {
      barButton?.isEnabled = newValue.count >= 3
    }
  }
  
  var tableView = UITableView()
  let selectedCellID = "SelectedCell"
  let genreCellID = "GenreCell"
  
  var barButton: UIBarButtonItem?
  
  var skipButton: UIButton = {
    let btn = UIButton()
    return btn
  }()
  
  var nextButton: UIButton = {
    let btn = UIButton()
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureNextButton()
    setUpTableView()
    layoutComponents()
    fetchAllGenres()
  }
  
  private func configureNextButton() {
    barButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
    barButton?.isEnabled = false
    navigationItem.rightBarButtonItem = barButton
  }
  
  private func fetchAllGenres() {
    showSpinnerView()
    let cdGenres = loadedAllGenresFromCD()
    if cdGenres.count > 0 {
      DispatchQueue.main.async {
        self.hideSpinnerView()
        self.allGenres = cdGenres
        self.tableView.reloadData()
      }
    } else {
      guard let request = NetworkManager.shared.generateGenresURL() else { return }
      NetworkManager.shared.fire(request: request) { [weak self] data, error in
        if let d = data {
          guard let genres: Genres = NetworkManager.shared.parse(data: d, modelType: ParsingType.genres) else { return }
          DispatchQueue.main.async {
            for genre in genres.genres {
              PersistanceManager.shared.saveGenreToCD(genre)
            }
            self?.allGenres = genres.genres.sorted()
            self?.hideSpinnerView()
            self?.tableView.reloadData()
          }
        }
      }
    }
  }
  
  private func loadedAllGenresFromCD() -> [Genre] {
    var allGenres = [Genre]()
    let cdGenres = PersistanceManager.shared.fetchAll(CDGenre.self)
    if cdGenres.count > 0 {
      allGenres = cdGenres.compactMap({Genre(cdGenre: $0)}).sorted()
    }
    return allGenres
  }
  
  private func setUpTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: selectedCellID)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: genreCellID)
  }
  
  private func layoutComponents() {
    layoutTableView()
  }
  
  @objc func nextTapped() {
    let subVC = OnboardSubscribeViewController()
    subVC.selectedGenres = selectedGenres
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationController?.show(subVC, sender: self)
  }
  
}

extension OnboardGenreViewController: UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Delegate functions
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedItem = indexPath.section == 0 ? selectedGenres[indexPath.row] : allGenres[indexPath.row]
    tableView.beginUpdates()
    if indexPath.section == 0 {
      selectedGenres = selectedGenres.filter { $0 != selectedItem }
      tableView.deleteRows(at: [indexPath], with: .automatic)
      for (i, genre) in allGenres.enumerated() where genre == selectedItem {
        tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
      }
    } else {
      if selectedGenres.contains(selectedItem) {
        for (i, genre) in selectedGenres.enumerated() where genre == selectedItem {
          selectedGenres = selectedGenres.filter { $0 != selectedItem }
          tableView.deleteRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
          break
        }
      } else {
        selectedGenres.append(selectedItem)
        tableView.insertRows(at: [IndexPath(row: selectedGenres.count - 1, section: 0)], with: .automatic)
      }
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: "Header Cell")
    cell.textLabel?.text = section == 0 ? "Selections" : "Genres"
    cell.textLabel?.textColor = .white
    cell.backgroundColor = .gray
    let containerView = UIView()
    containerView.addSubview(cell)
    cell.setAnchors(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor)
    return containerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 20
  }
  
  // MARK: - Datasource functions
  func numberOfSections(in tableView: UITableView) -> Int { return 2 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? selectedGenres.count : allGenres.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: selectedCellID, for: indexPath)
      cell.textLabel?.text = selectedGenres[indexPath.row].name
      cell.textLabel?.textColor = ThemeColor.mainText
      return cell
    }
    if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: genreCellID, for: indexPath)
      cell.textLabel?.text = allGenres[indexPath.row].name
      cell.textLabel?.textColor = ThemeColor.mainText
      if selectedGenres.contains(allGenres[indexPath.row]) {
        cell.textLabel?.textColor = ThemeColor.subText
        cell.accessoryType = .checkmark
      } else {
        cell.textLabel?.textColor = ThemeColor.mainText
        cell.accessoryType = .none
      }
      return cell
    }
    return UITableViewCell()
  }
  
}

// MARK: - layout component views
private extension OnboardGenreViewController {
  
  private func layoutTableView() {
    view.addSubview(tableView)
    tableView.setAnchors(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
  }
}

