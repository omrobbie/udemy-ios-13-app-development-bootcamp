//
//  ViewController.swift
//  ARDicee
//
//  Created by omrobbie on 06/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true

//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        sceneView.scene = scene

        let object = sphereGeometry()
        addNode(geometry: object)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)

        checkSupportedConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    private func checkSupportedConfiguration() {
        print("Session is supported: \(ARConfiguration.isSupported)")
        print("World Traking is supported: \(ARWorldTrackingConfiguration.isSupported)")
        print("Body Tracking is supported: \(ARBodyTrackingConfiguration.isSupported)")
        print("Face Tracking is supported: \(ARFaceTrackingConfiguration.isSupported)")
        print("Image Tracking is supported: \(ARImageTrackingConfiguration.isSupported)")
        print("Object Scanning is supported: \(ARObjectScanningConfiguration.isSupported)")
        print("Positional Tracking is supported: \(ARPositionalTrackingConfiguration.isSupported)")
    }

    private func configMaterials(contents: Any) -> [SCNMaterial] {
        let material = SCNMaterial()
        material.diffuse.contents = contents
        return [material]
    }

    private func cubeGeometry() -> SCNGeometry {
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        let material = configMaterials(contents: UIColor.red)
        cube.materials = material
        return cube
    }

    private func sphereGeometry() -> SCNGeometry {
        let sphere = SCNSphere(radius: 0.2)
        let material = configMaterials(contents: UIImage(named: "art.scnassets/moon.jpg")!)
        sphere.materials = material
        return sphere
    }

    private func addNode(geometry: SCNGeometry) {
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        node.geometry = geometry

        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
    }
}
