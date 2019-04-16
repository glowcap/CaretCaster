//
//  HomeViewController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/02.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationItem.title = "Caret Caster"
    
    let local = Locale.current
    print(local)
    
    let networking = Networking()
    
//    if let request = networking.generateBestOfURL(genreId: 138, region: "us", isSafeMode: false) {
//      networking.fire(request: request) { data, error in
//        guard error == nil else { return }
//        guard let data = data,
//              let bestOf: BestOfGenre = networking.parse(data: data, modelType: ParsingType.bestOf)
//         else { return }
//        print(bestOf.name)
//        print(bestOf.total)
//        guard bestOf.podcasts.count > 0 else { return }
//        print(bestOf.podcasts[0].title)
//      }
//    }
    
  }

}

