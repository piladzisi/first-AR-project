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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        sceneView.debugOptions = [.showFeaturePoints] // .showWorldOrigin
        sceneView.autoenablesDefaultLighting = true
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
        sceneView.scene.rootNode.addChildNode(sphereNode)
        
        
        
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
        let cube = SCNBox(width: 0.25, height: 0.25, length: 0.25, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.purple
        cube.materials = [material]
        
        let cubeNode = SCNNode()
        cubeNode.geometry = cube
        cubeNode.position = SCNVector3(0.0, 0.0, -2.0) // 2m in front of the camera at eye level
        
        let rotation = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 4)
        let repeatRotation = SCNAction.repeatForever(rotation)
        cubeNode.runAction(repeatRotation)
        
        return cubeNode
    }()
    
    
    let sphereNode: SCNNode = {
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        sphere.materials = [material]
        sphere.isGeodesic = true
        
        let sphereNode = SCNNode()
        sphereNode.geometry = sphere
        sphereNode.position = SCNVector3(0.5, 0.2, -1.8)
        
        
        let rotation = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 5)
        let repeatRotation = SCNAction.repeatForever(rotation)
        sphereNode.runAction(repeatRotation)
        
        return sphereNode
    }()
}
