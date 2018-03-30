//
//  ARViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 29/03/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    var classroom : Classroom? = nil;
    var leftWall : Data? = nil, rightWall : Data? = nil, ceiling : Data? = nil,
        floor : Data? = nil, frontWall : Data? = nil, backWall : Data? = nil;
    
    var serverHost : String = "http://199.233.252.86/201811/zenith/cube-maps/";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        //indicar la detección del plano
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.sceneView.addGestureRecognizer(tap)
        //administrador de gestos para identificar el tap sobre el plano horizontal
        // Do any additional setup after loading the view.
        
        var url = URL(string: serverHost + (classroom?.num)! + "/nx.png")
        backWall = try? Data(contentsOf: url!)
        url = URL(string: serverHost + (classroom?.num)! + "/px.png")
        frontWall = try? Data(contentsOf: url!)
        url = URL(string: serverHost + (classroom?.num)! + "/py.png")
        ceiling = try? Data(contentsOf: url!)
        url = URL(string: serverHost + (classroom?.num)! + "/ny.png")
        floor = try? Data(contentsOf: url!)
        url = URL(string: serverHost + (classroom?.num)! + "/pz.png")
        leftWall = try? Data(contentsOf: url!)
        url = URL(string: serverHost + (classroom?.num)! + "/nz.png")
        rightWall = try? Data(contentsOf: url!)
        
    }
    
    @objc func tapHandler(sender: UITapGestureRecognizer){
        guard let sceneView = sender.view as? ARSCNView else {return}
        let touchLocation = sender.location(in: sceneView)
        //obtener los resultados del tap sobre el plano horizontal
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        if !hitTestResult.isEmpty{
            //cargar la escena
            self.addPortal(hitTestResult: hitTestResult.first!)
        }
        else{
            // no hubo resultado
        }
    }
    
    func addPortal(hitTestResult:ARHitTestResult)
    {
        let portalScene = SCNScene(named:"escenes.sncassets/Portal.scn")
        let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
        //convertir las coordenadas del rayo del tap a coordenadas del mundo real
        let box = portalNode?.childNode(withName: "box", recursively: false)

        box?.geometry?.material(named: "back-wall")?.diffuse.contents = UIImage(data: backWall!)
        box?.geometry?.material(named: "green-wall")?.diffuse.contents = UIImage(data: frontWall!)
        box?.geometry?.material(named: "ceiling-wall")?.diffuse.contents = UIImage(data: ceiling!)
        box?.geometry?.material(named: "floor-wall")?.diffuse.contents = UIImage(data: floor!)
        box?.geometry?.material(named: "left-wall")?.diffuse.contents = UIImage(data: leftWall!)
        box?.geometry?.material(named: "right-wall")?.diffuse.contents = UIImage(data: rightWall!)
        
        let transform = hitTestResult.worldTransform
        let planeXposition = transform.columns.3.x
        let planeYposition = transform.columns.3.y
        let planeZposition = transform.columns.3.z
        portalNode?.position = SCNVector3(planeXposition,planeYposition,planeZposition)
        self.sceneView.scene.rootNode.addChildNode(portalNode!)
        
        self.sceneView.debugOptions = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return} //se agrego un plano
        //ejecución asincrona en donde se modifica la etiqueta de plano detectado
        DispatchQueue.main.async {
//            self.planeDetected.isHidden = false
            print("Plano detectado")
        }
        //espera 3 segundos antes de desaparecer
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            self.planeDetected.isHidden = true
            
        }
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
