//
//  DeviceCameraUtil.swift
//  TestSwift
//
//  Created by forty Lin on 2017/10/31.
//  Copyright © 2017年 forty. All rights reserved.
//

import Foundation
import AVFoundation

class DeviceCameraUtil: AVCaptureVideoPreviewLayer
{
    func setupCaptureSession(_ delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        // Create the session
        let session = AVCaptureSession()
        // Configure the session to produce lower resolution video frames, if your
        // processing algorithm can cope. We'll specify medium quality for the
        // chosen device.
        session.sessionPreset = AVCaptureSessionPresetHigh
        // Find a suitable AVCaptureDevice
        var device: AVCaptureDevice? = nil
        let devices: NSArray = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)! as NSArray
        for d in devices {
            if (d as! AVCaptureDevice).position == .front {
                device = d as? AVCaptureDevice
            }
        }
        if device == nil {
            device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        }
        // Create a device input with the device and add it to the session.
        let input = try? AVCaptureDeviceInput(device: device!)
        if input == nil {
            // Handling the error appropriately.
        }
        session.addInput(input!)
        // Create a VideoDataOutput and add it to the session
        let output = AVCaptureVideoDataOutput()
        session.addOutput(output)
        // Configure your output.
        let queue = DispatchQueue(label: "myQueue")
        output.setSampleBufferDelegate(delegate, queue: queue)
        //    dispatch_release(queue);
        // Specify the pixel format
        
        output.videoSettings = [ kCVPixelBufferPixelFormatTypeKey as NSString : kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
        // Start the session running to start the flow of data
        session.startRunning()
        // Assign session to an ivar.
        self.session = session
    }
    
}
