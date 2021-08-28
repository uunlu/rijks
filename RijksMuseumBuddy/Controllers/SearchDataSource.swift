//
//  SearchDataSource.swift
//  SearchDataSource
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import UIKit

class SearchDataSource: NSObject, UICollectionViewDataSource {
    var model: [String] = [] //StaticDataFactory.artists
    
    override init() {
        super.init()
       // update(StaticDataFactory.artists)
    }
    
    func update(_ data: [String]) {
        model.append(contentsOf: data)
    }
    
    typealias DataModel = String
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  StaticDataFactory.artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        let data =  StaticDataFactory.artists[indexPath.row]
        cell.viewModel = SearchCellViewModel(title: data)
        return cell
    }
    
    
}

extension SearchDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = UIScreen.main.bounds.width/2
        if UIScreen.main.bounds.width > 500 {
            cellWidth = UIScreen.main.bounds.width/4
        }
        return CGSize(width: cellWidth - 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    
}

protocol DataSourcable {
    associatedtype DataModel: Hashable
    var model: [DataModel] { get }
    func update(_ data: [DataModel])
}

//
class TopCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.viewModel = SearchCellViewModel(title: data[indexPath.row])
        return cell
    }
    
    init(data: [String]){
        self.data.append(contentsOf: artists)
    }
    
    func updateData(_ data: [String]){
        self.data.append(contentsOf: artists)
    }
    
    var data: [String] = ["Gerrit Schouten"]
    var artists = ["Gerrit Schouten", "Gerrit Thomas Rietveld", "Jan Adam Kruseman", "Alger Mensma", "Chitqua", "Abraham van der Hart", "Gerrit Hutte", "Jan Havicksz. Steen", "Karel Appel", "Caesar Boëtius van Everdingen", "André-Charles Boulle", "Carel Visser", "De Metaale Pot", "Koninklijke Tichelaar Makkum", "Meissener Porzellan Manufaktur", "Jan van Mekeren", "Rembrandt van Rijn", "Jan Toorop", "Nicolaes Eliasz. Pickenoy", "Hendrick Goltzius", "Jacob Jordaens (I)", "Roelant Roghman", "William Low", "Pieter Zöllner", "Gerard de Lairesse", "Hessel Gerritsz", "Adriaen Matham", "Jan van der Heyden", "Simon de Vlieger", "Thomas Wijck", "Anthony van Dyck", "Carl Emanuel Friedrich Lang", "Jan Brandes", "Michael Sweerts", "Adriaen Pietersz. van de Venne", "Gerard Bilders", "Johannes Torrentius", "Esaias van de Velde", "Gerard ter Borch (II)", "Ferdinand Bol", "Hendrik Cornelisz. Vroom", "Pieter Aertsen", "Dirck Barendsz."]
}


extension TopCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
    }
}

extension TopCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = UIScreen.main.bounds.width/2
        if UIScreen.main.bounds.width > 500 {
            cellWidth = UIScreen.main.bounds.width/4
        }
        return CGSize(width: cellWidth - 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}
