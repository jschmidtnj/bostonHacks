//
//  ViewController.swift
//  bostonhack_flash
//
//  Created by Forrest on 10/28/17.
//  Copyright © 2017 Forrest. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class pumpkin_ViewController: UIViewController, ARSCNViewDelegate {
    
   
  
    @IBOutlet weak var previouse: UIButton!
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "2to1", sender: self)
    }
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var vocab: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/pumpkin/Pumpkin.scn")!
        //let scene = SCNScene(named: "art.scnassets/pumpkin/Pumpkin.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        //configuration.planeDetection = .horizontal
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // This visualization covers only detected planes.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Create a SceneKit plane to visualize the node using its position and extent.
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        
        // SCNPlanes are vertically oriented in their local coordinate space.
        // Rotate it to match the horizontal orientation of the ARPlaneAnchor.
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        // ARKit owns the node corresponding to the anchor, so make the plane a child node.
        node.addChildNode(planeNode)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let location = touch.location(in: sceneView)
    
                let hitList = sceneView.hitTest(location, options: nil)
    
                if let hitObject = hitList.first {
                    let node = hitObject.node
    
                    if node.name == "pumpkin" {
    
                       let source = SCNAudioSource(fileNamed: "art.scnassets/pumpkin/Pumpkin_f_sound.m4a")
                        let action = SCNAction.playAudio(source!, waitForCompletion: true)
                        node.runAction(action)
    
                    }
                }
    
            }
        }
}

