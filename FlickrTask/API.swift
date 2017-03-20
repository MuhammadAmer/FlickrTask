//
//  API.swift
//  FlickrTask
//
//  Created by MacPro on 3/12/17.
//  Copyright © 2017 MacPro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class API: NSObject {
    
    class func search(searchText: String , completion : @escaping ( _ error: Error? , _ photos: [Photo]?) -> Void){
        
        let URL = "https://api.flickr.com/services/rest/"
        let Search_Method = "flickr.photos.search"
        let API_KEY = "4dab291ef812586b031ac3ddf479ff1a"
        let FORMAT_TYPE:String = "json"
        let JSON_CALLBACK:Int = 1
        let PRIVACY_FILTER:Int = 1
        
        let parameters = [
            "method": Search_Method,
            "api_key": API_KEY,
            "tags":searchText,
            "privacy_filter":PRIVACY_FILTER,
            "format":FORMAT_TYPE,
            "nojsoncallback": JSON_CALLBACK] as [String : Any]
        
        Alamofire.request(URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil )
            .responseJSON{ response in
                switch response.result
                {
                case .success(let value):
                    print(value)
                    let json = JSON(value)
                    let photosDict = json["photos"]
                    let photoArray = photosDict["photo"]
                    var photos = [Photo]()
                    
                    for item in photoArray  {
                        let id = item.1["id"].stringValue
                        let farm = item.1["farm"].stringValue
                        let server = item.1["server"].stringValue
                        let secret = item.1["secret"].stringValue
                        let title = item.1["title"].stringValue
                        let photo = Photo(id:id, title:title, farm:farm, secret: secret, server: server)
                        photos.append(photo)
                    }
                    
                    completion(nil, photos)
                    
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                }
                
        }
    }
}
