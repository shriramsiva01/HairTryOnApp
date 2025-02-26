//
//  ARViewContainer.swift
//  ARHairTryOn
//
//  Created by shriram siva on 22/02/25.
//

import SwiftUI
import ARKit
import RealityKit

// UIViewControllerRepresentable to integrate ARView into SwiftUI
struct ARViewContainer: UIViewControllerRepresentable {
    @Binding var selectedHairstyle: String
    
    func makeUIViewController(context: Context) -> ARViewController {
        let arViewController = ARViewController()
        arViewController.selectedHairstyle = selectedHairstyle  // Set initial hairstyle
        return arViewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        uiViewController.loadHairstyle(named: selectedHairstyle)  // Update hairstyle when changed
    }
}

class ARViewController: UIViewController, ARSessionDelegate {
    var arView: ARView!
    var faceAnchor: AnchorEntity!
    var currentHairModel: ModelEntity?
    var selectedHairstyle: String = "hairstyle1"  // Default hairstyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARView
        arView = ARView(frame: view.bounds)
        view.addSubview(arView)
        
        // Setup AR Face Tracking
        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)
        arView.session.delegate = self
        
        // Create an anchor for face tracking
        faceAnchor = AnchorEntity(.face)
        arView.scene.addAnchor(faceAnchor)
        
        // Load initial hairstyle model
        loadHairstyle(named: selectedHairstyle)
    }
    
    func loadHairstyle(named modelName: String) {
        // Remove existing hair model
        currentHairModel?.removeFromParent()
        
        // Load new hairstyle model
        if let parentEntity = try? Entity.load(named: modelName),
           let modelEntity = parentEntity.findEntity(named: modelName) as? ModelEntity {
            currentHairModel?.removeFromParent()
            modelEntity.setScale(SIMD3(repeating: 0.002), relativeTo: nil)
            modelEntity.position = SIMD3(0, 0.1, 0)
            faceAnchor.addChild(modelEntity)
            currentHairModel = modelEntity
        }
    }
}
