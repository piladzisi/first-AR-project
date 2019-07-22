//
//  ViewController.swift
//  FirstARProject
//
//  Created by anna.sibirtseva on 11/07/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var addCubeButton: UIButton!
    
    var minHeight : CGFloat = 0.3
    var maxHeight : CGFloat = 0.7
    var minDispersal : CGFloat = -4
    var maxDispersal : CGFloat = 4
    
    func generateRandomVector() -> SCNVector3 {
        return SCNVector3(CGFloat.random(in: minDispersal...maxDispersal),
                          CGFloat.random(in: minDispersal...maxDispersal),
                          CGFloat.random(in: minDispersal...maxDispersal))
    }
    
    func generateRandomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0 ...  1),
                       green: CGFloat.random(in: 0 ... 1),
                       blue: CGFloat.random(in: 0 ... 1),
                       alpha: CGFloat.random(in: 0.8 ... 1))
    }
    
    func generateRandomSize() -> CGFloat{
        return CGFloat.random(in: minHeight...maxHeight)
    }
    
    func generateCube() {
        let size = generateRandomSize()
        let cube = SCNBox(width: size, height: size, length: size, chamferRadius: 0.03)
        cube.materials.first?.diffuse.contents = generateRandomColor()
        
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = generateRandomVector()
        let rotateAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        cubeNode.runAction(repeatAction)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints] // .showWorldOrigin
        sceneView.autoenablesDefaultLighting = true
        
        //sceneView.scene.rootNode.addChildNode(cubeNode)
        addCubeButton.layer.cornerRadius = 10
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        generateCube()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    
    let cubeNode: SCNNode = {
        let cube                    = SCNBox(width: 0.25, height: 0.25, length: 0.25, chamferRadius: 0)
        let material                = SCNMaterial()
        material.diffuse.contents   = UIColor.purple
        cube.materials              = [material]
        
        let cubeNode = SCNNode()
        cubeNode.geometry           = cube
        cubeNode.position           = SCNVector3(0.0, 0.0, -2.0) // 2m in front of the camera at eye level
        
        let rotation                = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 4)
        let repeatRotation          = SCNAction.repeatForever(rotation)
        cubeNode.runAction(repeatRotation)
        
        return cubeNode
    }()
    
    
    
}
