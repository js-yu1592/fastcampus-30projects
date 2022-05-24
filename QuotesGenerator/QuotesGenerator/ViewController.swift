//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 유준상 on 2022/01/10.
//

import UIKit
import Foundation

struct Quote {
    var content: String
    var author: String
}

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var createQuoteButton: UIButton!
    
    let quotes: [Quote] = [
        Quote(content: "꿈을 이루고자 하는 용기만 있다면 모든 꿈을 이룰 수 있다.", author: "월트 디즈니"),
        Quote(content: "비록 해가 진다고 해도, 나에게는 전기불이 있다.", author: "로커 커트 코베인"),
        Quote(content: "웃음이 없는 하루는 버린 하루다.", author: "찰리 채플린"),
        Quote(content: "우리는 한 번도 존재하지 않았던 것을 꿈꿀 수 있는 사람들이 필요하다.", author: "존 F.케네디"),
        Quote(content: "변화는 우리가 누군가나 무엇, 혹은 후일을 기다린다고 찾아오지 않는다. 우리 자신이 우리가 기다리던 사람이고 우리가 바로 우리가 추구하는 변화이다.", author: "버락 오바마"),
        Quote(content: "무슨 일을 하기 전에는 그 일에 대해 기대를 가져야 한다.", author: "마이클 조던"),
        Quote(content: "조금도 도전하지 않으려고 하는 것이 인생에서 가장 위험한 일이다", author: "오프라 윈프리"),
        Quote(content: "남들이 할 수 있거나 하려는 일을 하지 말고 남들이 할 수 없거나 하지 않으려는 일을 하라", author: "아멜리아 에어하트")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initData()
        createQuoteButton.addTarget(self, action: #selector(didTapCreateQuoteButton(_:)), for: .touchUpInside)
    }
    
    func initData() {
        quoteLabel.text = quotes[0].content
        authorLabel.text = quotes[0].author
    }

    @objc func didTapCreateQuoteButton(_ sender: UIButton) {
        let randomQuote = quotes.randomElement()
        quoteLabel.text = randomQuote?.content
        authorLabel.text = randomQuote?.author
    }

}

