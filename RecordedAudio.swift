//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Neha Agarwal on 6/17/15.
//  Copyright (c) 2015 Neha Agarwal. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(fromFilePathUrl url:NSURL, fromTitle title:String) {
        self.filePathUrl = url
        self.title = title
    }
}
