//
//  PiViewController.swift
//  TestSwift
//
//  Created by forty Lin on 2017/10/31.
//  Copyright © 2017年 forty. All rights reserved.
//

import Foundation
import AVFoundation
import QuartzCore


class PIViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate
{
    var dcUtil: DeviceCameraUtil?
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var startStopPreviewBtn: UIButton!
    @IBOutlet var changeViewModeBtn: UIButton!
    @IBOutlet var changeFilterModeBtn: UIButton!
    @IBOutlet var changeTransitionBtn: UIButton!
    
    @IBOutlet var playPhotoBtn: UIButton!
    @IBOutlet var playTwoEyeBtn: UIButton!
    @IBOutlet var playOneEyeBtn: UIButton!
    @IBOutlet var playFull21Btn: UIButton!
    @IBOutlet var playVideoBtn: UIButton!
    @IBOutlet var stopPlayVideoBtn: UIButton!
    @IBOutlet var pauseOrResumeVideoBtn: UIButton!
    @IBOutlet var seekVideoVideoBtn: UIButton!
    
    @IBOutlet var superPICameraView: UIView!
    var piCameraView: UIView?
    
    var mDocumentDirectory: String? = nil
    var mDateFormat: DateFormatter? = nil
    var mIsOpen = false
    
    var mProgress: Float = 0
    var pauseOrResume = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var versionStr = "Ver:"
        versionStr = versionStr + (PiPano.getVersion())
        versionLabel.text = versionStr
        //设置相机相关数据
        dcUtil = DeviceCameraUtil()
        dcUtil?.setupCaptureSession(self)
        
        piCameraView = PiPano.getCameraView()
        piCameraView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        superPICameraView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        superPICameraView.addSubview(piCameraView!)
        
        playOneEyeBtn.isHidden = true
        playTwoEyeBtn.isHidden = true
        playFull21Btn.isHidden = true
        stopPlayVideoBtn.isHidden = true
        pauseOrResumeVideoBtn.isHidden = true
        seekVideoVideoBtn.isHidden = true
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        mDocumentDirectory = paths[0]
        
//        //添加屏幕旋转的通知
//        NotificationCenter.default.addObserver(self, selector: #selector(self.statusBarOrientationChange), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    //屏幕旋转通知：VR模式会切换到横屏
    func statusBarOrientationChange(_ notification: Notification) {
        let orientation = UIApplication.shared.statusBarOrientation
        if(orientation == UIInterfaceOrientation.landscapeLeft || orientation == UIInterfaceOrientation.landscapeRight){
            //屏幕旋转后刷新页面frame
            superPICameraView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            piCameraView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }
    }
    
    
    // Delegate routine that is called when a sample buffer was written
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
    {
        let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        //把摄像头的数据给PiPano渲染
        PiPano.setVideoStreamFrame(imageBuffer)
    }
    
    //返回
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //PiPano窗口大小
    @IBAction func setUnitySizeMax(_ sender: Any) {
        piCameraView?.bounds = UIScreen.main.bounds
    }
    
    @IBAction func setUnitySizeMiddle(_ sender: Any) {
        piCameraView?.bounds = CGRect(x: 0, y: 0, width: 350, height: 350)
    }
    
    @IBAction func setUnitySizeSmall(_ sender: Any) {
        piCameraView?.bounds = CGRect(x: 0, y: 0, width: 250, height: 250)
    }
    
    
    //控制预览
    @IBAction func startStopSwitch(_ sender: Any) {
        if !mIsOpen {
            PiPano.startPreview(PiSourceMode.PISM_OneEye)
            //开始预览
            startStopPreviewBtn.setTitle("关闭预览", for: .normal)
            let modeName: String = PiPano.viewModeName(PiPano.getViewMode())
            changeViewModeBtn.setTitle(modeName, for: .normal)
        }
        else {
            PiPano.stopPreview()
            startStopPreviewBtn.setTitle("开始预览", for: .normal)
        }
        mIsOpen = !mIsOpen
    }
    
    var mCurViewMode: PiViewMode = PiViewMode.PIVM_Immerse
    
    @IBAction func changeViewMode(_ sender: Any) {
        //按顺序逐个显示
        mCurViewMode = PiViewMode.init(rawValue: mCurViewMode.rawValue + 1)!
        if mCurViewMode.rawValue >= PiViewMode.PIVM_Max.rawValue {
            mCurViewMode = PiViewMode.PIVM_Immerse
        }
        PiPano.setViewMode(mCurViewMode)
        let viewModeName: String = PiPano.viewModeName(mCurViewMode)
        changeViewModeBtn.setTitle(viewModeName, for: .normal)
    }
    
    //change filters
    var mCurFilterMode: PiFilterMode = PiFilterMode.PIFM_None
    @IBAction func changeFilterMode(_ sender: Any) {
        //按顺序逐个显示
        mCurFilterMode = PiFilterMode.init(rawValue: mCurFilterMode.rawValue + 1)!
        if mCurFilterMode.rawValue >= PiFilterMode.PIFM_Max.rawValue {
            mCurFilterMode = PiFilterMode.PIFM_None
        }
        PiPano.setFilterMode(mCurFilterMode)
        
        let filterName: String = PiPano.filterName(mCurFilterMode)
        changeFilterModeBtn.setTitle(filterName, for: .normal)
    }
    
    //change transitions
    var mCurTransitionMode: PiTransitionEffect = PiTransitionEffect.PITE_None
    @IBAction func changeTransitionMode(_ sender: Any) {
        //按顺序逐个显示
        mCurTransitionMode = PiTransitionEffect.init(rawValue: mCurTransitionMode.rawValue + 1)!
        if mCurTransitionMode.rawValue >= PiTransitionEffect.PITE_Max.rawValue {
            mCurTransitionMode = PiTransitionEffect.PITE_None
        }
        PiPano.setTransitionEffect(mCurTransitionMode)
        
        let effectName: String = PiPano.transitionEffectName(mCurTransitionMode)
        changeTransitionBtn.setTitle(effectName, for: .normal)
    }
    
    //播放图片或视频
    @IBAction func playPhoto(_ sender: Any) {
        playFull21Btn.isHidden = false
        playOneEyeBtn.isHidden = false
        playTwoEyeBtn.isHidden = false
    }
    
    @IBAction func playOneEyePhoto(_ sender: Any) {
        let photoPath: String? = Bundle.main.path(forResource: "testRes/one_eye_image", ofType: "jpg")
        PiPano.openPhoto(photoPath, sourceMode: PiSourceMode.PISM_OneEye)
        
        playOneEyeBtn.isHidden = true
        playFull21Btn.isHidden = true
        playTwoEyeBtn.isHidden = true
    }
    
    @IBAction func playTwoEyePhoto(_ sender: Any) {
        let photoPath: String? = Bundle.main.path(forResource: "testRes/two_eye_image", ofType: "jpg")
        PiPano.openPhoto(photoPath, sourceMode: PiSourceMode.PISM_TwoEye)
        
        playOneEyeBtn.isHidden = true
        playFull21Btn.isHidden = true
        playTwoEyeBtn.isHidden = true
    }
    
    @IBAction func playFull21Photo(_ sender: Any) {
        let photoPath: String? = Bundle.main.path(forResource: "testRes/full21_image", ofType: "jpg")
        PiPano.openPhoto(photoPath, sourceMode: PiSourceMode.PISM_Full21)
        
        playOneEyeBtn.isHidden = true
        playFull21Btn.isHidden = true
        playTwoEyeBtn.isHidden = true
    }
    
    @IBAction func playVideo(_ sender: Any) {
        let videoPath: String? = Bundle.main.path(forResource: "testRes/two_eye_video", ofType: "mp4")
        PiPano.openVideo(videoPath, sourceMode: PiSourceMode.PISM_TwoEye)
        
        stopPlayVideoBtn.isHidden = false
        seekVideoVideoBtn.isHidden = false
        pauseOrResumeVideoBtn.isHidden = false
    }
    
    @IBAction func stopPlayVideo(_ sender: Any) {
        PiPano.stopVideo()
        //mProgress = 1;
        stopPlayVideoBtn.isHidden = true
        seekVideoVideoBtn.isHidden = true
        pauseOrResumeVideoBtn.isHidden = true
    }
    
    @IBAction func seekVideo(_ sender: Any) {
        mProgress += 0.1
        if mProgress > 1 {
            mProgress = 0
        }
        PiPano.seekVideo(mProgress)
    }
    
    @IBAction func pauseOrResumeVideo(_ sender: Any) {
        PiPano.getVideoProgress({(_ progress: Float) -> Void in
            print("process: \(progress)")
        })
        if pauseOrResume {
            PiPano.pauseVideo()
            pauseOrResumeVideoBtn.setTitle("继续", for: .normal)
        }
        else {
            PiPano.resumeVideo()
            pauseOrResumeVideoBtn.setTitle("暂停", for: .normal)
        }
        pauseOrResume = !pauseOrResume
    }
    
}
