//
//  ItunesSearchResult.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-02-16.
//  Copyright © 2019 will. All rights reserved.
//

import Foundation





struct ItuneSearchResultItem{
    let artworkUrl60: String;
    let artworkUrl100: String;
    let artworkUrl600: String;

    let feedUrl: String;
    let trackName: String;
}

struct ItuneSearchResult{
    let resultCount: Int;
    let results: [ItuneSearchResultItem];
}

