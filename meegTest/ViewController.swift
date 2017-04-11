//
//  ViewController.swift
//  meegTest
//
//  Created by admin on 4/7/17.
//  Copyright © 2017 frank. All rights reserved.
//

import UIKit
import RSKImageCropper
import AVFoundation

class ViewController: UIViewController, RSKImageCropViewControllerDelegate {

    
    @IBOutlet weak var mask: UIView!
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var stillImageOutput : AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        deleteSession()
        prepareCamera()
        if captureDevice != nil {
            
            
            beginSession()
            
        }
        putMask()
        
        
        
    }
    
    func deleteSession(){
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        
    }
    
    func beginSession(){
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.mask.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.mask.layer.bounds
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        captureSession.startRunning()
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        
        if captureSession.canAddOutput(stillImageOutput){
            
            captureSession.addOutput(stillImageOutput)
            
        }
        
    }

    func prepareCamera(){
        
        let devices = AVCaptureDevice.devices()
        
        do {
            try captureSession.removeInput(AVCaptureDeviceInput(device: captureDevice))
        } catch  {
            print(error.localizedDescription)
        }
        
        for device in devices!{
            
            if((device as AnyObject).position == AVCaptureDevicePosition.front){
                
                captureDevice = device as? AVCaptureDevice
                
                do {
                    try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                } catch  {
                    print(error.localizedDescription)
                }
                break
            }
            
        }
        
        
        
    }
    
    func stopCaptureSession(){
        
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput]{
            
            for input in inputs{
                
                self.captureSession.removeInput(input)
                
            }
            
        }
        
    }
    
    func putMask(){
        
        let radius = 104.0
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), cornerRadius: 0)
        let circlePath = UIBezierPath(roundedRect: CGRect(x: (Double(self.view.center.x) - radius), y: (Double(self.view.center.y) - radius), width: 2 * radius, height: 2 * radius), cornerRadius: CGFloat(radius))
        path.append(circlePath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.fillColor = UIColor(red:0.02, green:0.44, blue:0.49, alpha:1.0).cgColor
        fillLayer.opacity = 0.5
        mask.layer.addSublayer(fillLayer)
        
    }

}

