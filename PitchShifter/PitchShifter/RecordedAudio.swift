//
//  RecordedAudio.swift
//  PitchShifter
//
//  Created by allan bittan on 3/29/15.
//  Copyright (c) 2015 ab. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}