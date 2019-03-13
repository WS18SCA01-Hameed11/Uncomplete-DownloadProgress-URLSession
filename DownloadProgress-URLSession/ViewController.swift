//
//  ViewController.swift
//  DownloadProgress-URLSession
//
//  Created by Hameed Abdullah on 3/13/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//



//****   URLSessionDelegate and URLSessionDownloadDelegate   *****\\
//1. urlSessionDidFinishEvent: allows us to run networking calls on a background session.
//2. didWriteData:totalBytesExpectedToWrite: gives us the data we need to monitor the progress of our download.

import UIKit

//https://www.ralfebert.de/ios-examples/networking/urlsession-background-downloads/

class ViewController: UIViewController, URLSessionDelegate {
    

    //create a URLSessionConfiguration for background processing. The identifier will identify the URLSession: if the process is terminated and later restarted,
    let config = URLSessionConfiguration.background(withIdentifier: "com.example.DownloadTaskExample.background")

    //create a URLSession object. This can be observed using a URLSessionTaskDelegate
    
   // let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
    
    //let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
    }
    
    
    
    
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees")!
        //let task = session.downloadTask(with: url)
        
        let task = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue()).downloadTask(with: url)
        task.resume()
    }
    
    
    func calculateProgress(session : URLSession, completionHandler : @escaping (Float) -> ()) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let bytesReceived = downloads.map{ $0.countOfBytesReceived }.reduce(0, +)
            let bytesExpectedToReceive = downloads.map{ $0.countOfBytesExpectedToReceive }.reduce(0, +)
            let progress = bytesExpectedToReceive > 0 ? Float(bytesReceived) / Float(bytesExpectedToReceive) : 0.0
            self.progressView.progress = progress
            completionHandler(progress)
        }
    }


}

