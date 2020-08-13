//
//  ViewController.swift
//  AR Ruler
//
//  Created by omrobbie on 13/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    var dotNodes = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: sceneView) {
            let hitTestResult = sceneView.hitTest(touchLocation, types: .featurePoint)

            if let hitResult = hitTestResult.first {
                addDot(at: hitResult)
            }
        }
    }

    private func addDot(at hitResult: ARHitTestResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red

        dotGeometry.materials = [material]

        let dotNode = SCNNode(geometry: dotGeometry)
        let pos = hitResult.worldTransform.columns.3
        dotNode.position = SCNVector3(x: pos.x, y: pos.y, z: pos.z)

        sceneView.scene.rootNode.addChildNode(dotNode)
        dotNodes.append(dotNode)

        if dotNodes.count >= 2 {
            calculate()
        }
    }

    private func calculate() {
        let start = dotNodes[0]
        let end = dotNodes[1]

        print(start.position, end.position)

        let distance = sqrt(
            pow(end.position.x - start.position.x, 2) +
            pow(end.position.y - start.position.y, 2) +
            pow(end.position.z - start.position.z, 2)
        )

        updateText(text: "\(abs(distance))", atPosition: end.position)
    }

    private func updateText(text: String, atPosition: SCNVector3) {
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.red

        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(x: atPosition.x, y: atPosition.y + 0.01, z: atPosition.z)
        textNode.scale = SCNVector3(x: 0.01, y: 0.01, z: -0.01)

        sceneView.scene.rootNode.addChildNode(textNode)
    }
}
