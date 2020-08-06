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

    var diceArray = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true

        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        sceneView.scene = scene
        
// create moon from sphere geometry
//        let object = sphereGeometry()
//        addNode(geometry: object)

//        diceNode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)

            if let hitResult = results.first {
                diceNode(hitResult)
            } else {
                print("Touch somewhere else")
            }
        }
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

    private func diceNode(_ hitResult: ARHitTestResult) {
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true)!
        let pos = hitResult.worldTransform.columns.3
        diceNode.position = SCNVector3(
            x: pos.x,
            y: pos.y + diceNode.boundingSphere.radius,
            z: pos.z
        )
        sceneView.scene.rootNode.addChildNode(diceNode)

        diceArray.append(diceNode)
        roll(dice: diceNode)
    }

    private func rollAll() {
        if !diceArray.isEmpty {
            for dice in diceArray {
                roll(dice: dice)
            }
        }
    }

    private func roll(dice: SCNNode) {
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)

        dice.runAction(
            SCNAction.rotateBy(
                x: CGFloat(randomX * 5),
                y: 0,
                z: CGFloat(randomZ * 5),
                duration: 0.5
            )
        )
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))

            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)

            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            planeNode.geometry = plane

            node.addChildNode(planeNode)
        } else {
            return
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }

    @IBAction func btnRollAgainTapped(_ sender: Any) {
        rollAll()
    }
}
