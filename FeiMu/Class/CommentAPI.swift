//
//  CommentAPI.swift
//  FeiMu
//
//  Created by 金悦悦 on 2018/11/2.
//  Copyright © 2018年 金悦悦. All rights reserved.
//

import Foundation
import Moya

let CommentProvider = MoyaProvider<CommentAPI>()

enum CommentAPI {
    case recommendList
    case recommendList2
}

extension CommentAPI : TargetType {
    var baseURL: URL {
        return URL(string: "http://pic33.photophoto.cn")!
    }
    
    var path: String {
        return "/20141022/0019032438899352_b.jpg"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: ["":""], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

