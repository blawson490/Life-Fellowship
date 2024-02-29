//
//  VideoFeedLoader.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import Foundation
import SwiftUI
import Combine

class VideoFeedLoader: NSObject, XMLParserDelegate {
    var videos: [VideoItem] = []
    private var currentElement = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentDuration: String = ""
    private var currentVideoURL: String = ""
    private var currentThumbnailURL: String = ""
    private var currentPubDate: String = ""
    private var currentMediaID: String = ""
    private var completionHandler: (([VideoItem]) -> Void)?

    func loadVideos(completion: @escaping ([VideoItem]) -> Void) {
        // Define whether the environment is for preview or not
        let isPreview = true

        self.completionHandler = completion

        if isPreview {
            // Load mock XML data from the bundle
            guard let mockDataURL = Bundle.main.url(forResource: "MockVideoData", withExtension: "xml"),
                  let mockData = try? Data(contentsOf: mockDataURL) else {
                print("Error loading mock data")
                return
            }
            
            // Parse the mock XML data
            let parser = XMLParser(data: mockData)
            parser.delegate = self
            parser.parse()
        } else {
            // Load data from the network in non-preview mode
            guard let url = URL(string: "https://c.themediacdn.com/feed/Wys39U/iaB0KDPs2xi/ObRDIRlsiaI?format=mrss") else { return }
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data")
                    return
                }
                
                // Parse the XML data from the network
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
            task.resume()
        }
    }

    func refreshVideos(completion: @escaping ([VideoItem]) -> Void) {
        // Define whether the environment is for preview or not
        let isPreview = true

        self.completionHandler = completion

        if isPreview {
            // Load mock XML data from the bundle
            guard let mockDataURL = Bundle.main.url(forResource: "MockVideoData", withExtension: "xml"),
                  let mockData = try? Data(contentsOf: mockDataURL) else {
                print("Error loading mock data")
                return
            }
            
            // Parse the mock XML data
            let parser = XMLParser(data: mockData)
            parser.delegate = self
            parser.parse()
        } else {
            // Load data from the network in non-preview mode
            guard let url = URL(string: "https://c.themediacdn.com/feed/Wys39U/iaB0KDPs2xi/ObRDIRlsiaI?format=mrss") else { return }
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data")
                    return
                }
                
                // Parse the XML data from the network
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
            task.resume()
        }
    }

    // MARK: - XMLParserDelegate Methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            // Reset values for new item
            currentTitle = ""
            currentDescription = ""
            currentDuration = ""
            currentVideoURL = ""
            currentThumbnailURL = ""
            currentPubDate = ""
            currentMediaID = ""
        } else if elementName == "media:content", let url = attributeDict["url"] {
            currentVideoURL = url
            
            if let duration = attributeDict["duration"] {
                currentDuration = duration
            }
            
        } else if elementName == "media:thumbnail", let url = attributeDict["url"] {
            currentThumbnailURL = url
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            switch currentElement {
            case "title":
                currentTitle += data
            case "description":
                currentDescription += data
            case "pubDate":
                currentPubDate += data
            case "guid", "sh:mediaId", "sh:mediaContentId", "sh:streamMediaId":
                if currentMediaID.isEmpty { // Choose the first one encountered as the mediaID
                    currentMediaID = data
                }
            default:
                break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let videoURL = URL(string: currentVideoURL), let thumbnailURL = URL(string: currentThumbnailURL) {
                let videoItem = VideoItem(mediaID: currentMediaID, title: currentTitle, description: currentDescription, duration: currentDuration ,pubDate: currentPubDate, videoURL: videoURL, thumbnailURL: thumbnailURL)
                videos.append(videoItem)
            }
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.completionHandler?(self.videos)
        }
    }
}
