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
    }
}
