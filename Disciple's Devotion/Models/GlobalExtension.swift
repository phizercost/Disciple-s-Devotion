//
//  GlobalExtension.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation

extension Global {
    
    func globalGETMethod(request:URLRequest, getCompletionHandler: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil  else {
                getCompletionHandler(nil, error! as NSError)
                return
            }
            getCompletionHandler(data, nil)
        }
        task.resume()
        return task
    }
    
    
    func getDailyVerse(completionHandler: @escaping (_ data: DailyVerseParser?, _ errorString: String?) -> Void) {
        
        let url = Constants.OurManna.url + "\(Constants.OurManna.method)" + "\(Constants.OurManna.separator)" + "?format=" + "\(Constants.OurManna.format)" + "&order=" + "\(Constants.OurManna.order)"
         let request = URLRequest(url: URL(string: url)!)
        _ = globalGETMethod(request: request, getCompletionHandler: {(data, error) in
            guard (error == nil) else {
                completionHandler(nil, error!.localizedDescription)
                return
            }
            DispatchQueue.main.sync {
                do {
                    let jsonDecoder = JSONDecoder()
                    let parsedDataJSON = try jsonDecoder.decode( DailyVerseParser.self, from: data!)
                    
                    guard (!parsedDataJSON.verse.details.text.isEmpty) else {
                        completionHandler(nil, "No daily Verse Available")
                        return
                    }
                    completionHandler(parsedDataJSON, nil)
                } catch {
                    completionHandler(nil, "A problem occured while getting the daily verse")
                }
            }
        })
    }
    
    
    func getDailyReading(references: String, completionHandler: @escaping (_ data: String?, _ errorString: String?) -> Void) {
        let url = Constants.YearPlan.url + "?passage=" + references
        let request = URLRequest(url: URL(string: url)!)
        _ = globalGETMethod(request: request, getCompletionHandler: {(data, error) in
            guard (error == nil) else {
                completionHandler(nil, error!.localizedDescription)
                return
            }
            DispatchQueue.main.sync {
                    
                let reading = String(decoding: data!, as: UTF8.self)
                
                guard (!reading.isEmpty) else {
                    completionHandler(nil, "Scriptures are not available")
                    return
                }
                completionHandler(reading, nil)
                
            }
        })
    }
    
    func quickSearch(text:String, completionHandler: @escaping (_ data: SearchParser?, _ errorString: String?) -> Void) {
        let txtToSearch = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = Constants.Scripture.url + "\(Constants.Scripture.bibleId)" + "\(Constants.OurManna.separator)"  + "\(Constants.Scripture.method)" + "?limit=" + "\(Constants.Scripture.limit)"
        let finalUrl = url + "&query=" + txtToSearch!
        var request = URLRequest(url: URL(string: finalUrl)!)
        request.setValue(Constants.Scripture.apiKey, forHTTPHeaderField: "api-key")
        _ = globalGETMethod(request: request, getCompletionHandler: {(data, error) in
            guard (error == nil) else {
                completionHandler(nil, error!.localizedDescription)
                return
            }
            DispatchQueue.main.sync {
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let parsedDataJSON = try jsonDecoder.decode( SearchParser.self, from: data!)
                    guard (parsedDataJSON.data.verses.count != 0) else {
                        completionHandler(nil, "Nothing found")
                        return
                    }
                    completionHandler(parsedDataJSON, nil)
                } catch {
                    completionHandler(nil, "A problem occured while doing search")
                }
            }
        })
    }
    
    func downloadBibleStudies(completionHandler: @escaping (_ data: BibleStudiesParser?, _ errorString: String?) -> Void) {
        let url = Constants.BibleStudies.url + Constants.BibleStudies.series + "." + Constants.BibleStudies.format
        let request = URLRequest(url: URL(string: url)!)
        _ = globalGETMethod(request: request, getCompletionHandler: {(data, error) in
            guard (error == nil) else {
                completionHandler(nil, error!.localizedDescription)
                return
            }
            DispatchQueue.main.sync {
                do {
                    let jsonDecoder = JSONDecoder()
                    let parsedDataJSON = try jsonDecoder.decode( BibleStudiesParser.self, from: data!)
                    guard (parsedDataJSON.items.count != 0) else {
                        completionHandler(nil, "No bible studies found")
                        return
                    }
                    completionHandler(parsedDataJSON, nil)
                } catch {
                    completionHandler(nil, error.localizedDescription)
                }
            }
        })
    }
    
    func imageDownload(imageUrl: String, completionHandler: @escaping (_ result: Data?, _ error: NSError?) -> Void) {
        let request = URLRequest(url: URL(string: imageUrl)!)
        _ = globalGETMethod(request: request, getCompletionHandler: {(data, error) in
            guard (error == nil) else {
                completionHandler(nil, error!)
                return
            }
            DispatchQueue.main.sync {
                completionHandler(data, nil)
            }
        })
    }
    
    
    func downloadLessons(serie: ItemElements, completionHandler: @escaping (_ data: LessonsParser?, _ errorString: String?) -> Void) {
        let url = Constants.BibleStudies.url + serie.slug + "." + Constants.BibleStudies.format
        let request = URLRequest(url: URL(string: url)!)
        _ = globalGETMethod(request: request, getCompletionHandler: {(data, error) in
            guard (error == nil) else {
                completionHandler(nil, error!.localizedDescription)
                return
            }
            DispatchQueue.main.sync {
                do {
                    let jsonDecoder = JSONDecoder()
                    let parsedDataJSON = try jsonDecoder.decode( LessonsParser.self, from: data!)
                    guard (parsedDataJSON.items.count != 0) else {
                        completionHandler(nil, "No lessons found for this bible study")
                        return
                    }
                    completionHandler(parsedDataJSON, nil)
                } catch {
                    completionHandler(nil, error.localizedDescription)
                }
            }
        })
    }
    
}
