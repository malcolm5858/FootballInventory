//
//  QRReaderViewController.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 2/3/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import AVFoundation

class QRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    var qrCodeMessage: String?
    var backView: String?
    
    override func viewDidLoad() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        }
        catch{
            print(error)
            return
        }
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0{
            return
        }
        
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                qrCodeMessage? = metadataObj.stringValue
                performSegue(withIdentifier: "Back", sender: self)
            }
        }
        
    }
    //TODO: implement
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (backView){
        case "Small"?:
            let destination:AddInventoryViewController = segue.destination as! AddInventoryViewController
            destination.smallQrCode = qrCodeMessage
        case "Medium"?:
            let destination:AddInventoryViewController = segue.destination as! AddInventoryViewController
            destination.mediumQrCode = qrCodeMessage
        case "Large"?:
            let destination:AddInventoryViewController = segue.destination as! AddInventoryViewController
            destination.largeQrCode = qrCodeMessage
        case "XtraLarge"?:
            let destination:AddInventoryViewController = segue.destination as! AddInventoryViewController
            destination.xtraLargeQrCode = qrCodeMessage
        case "XtraXtraLarge"?:
            let destination:AddInventoryViewController = segue.destination as! AddInventoryViewController
            destination.xtraXtraLargeQrCode = qrCodeMessage
        case "XtraXtraXtraLarge"?:
            let destination:AddInventoryViewController = segue.destination as! AddInventoryViewController
            destination.xtraXtraXtraLargeQrCode = qrCodeMessage
        default: break
        }
    }
    

}
