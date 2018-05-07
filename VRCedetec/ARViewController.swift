//
//  ARViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 29/03/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit
import SceneKit
import SceneKit.ModelIO
import ARKit
import Vision

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()

    var classroom : Classroom? = nil;
    var leftWall : Data? = nil, rightWall : Data? = nil, ceiling : Data? = nil,
    floor : Data? = nil, frontWall : Data? = nil, backWall : Data? = nil;
    
    var classObjects = [ClassObject]()
    
    var serverHost : String = "http://199.233.252.86/201811/zenith/cubemaps/";
    
    var scene : SCNScene? = nil;
    var object3D = SCNNode();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objs = classroom?.objects.split(separator: "|")
        for eachObj in objs! {
            let data = eachObj.split(separator: ":")
            let classObj = ClassObject(name: String(data[0]), url: String(data[1]))

            classObjects.append(classObj)
        }
        
        var url = URL(string: "http://199.233.252.86/201811/zenith/scns/" + classObjects[0].url + ".scn")
        objectOne = try? SCNScene(url: url!, options: nil)
        url = URL(string: "http://199.233.252.86/201811/zenith/scns/" + classObjects[1].url + ".scn")
        objectTwo = try? SCNScene(url: url!, options: nil)
        url = URL(string: "http://199.233.252.86/201811/zenith/scns/" + classObjects[2].url + ".scn")
        objectThree = try? SCNScene(url: url!, options: nil)

        addObjectOne.setTitle("Agregar " + classObjects[0].name, for: .normal)
        addObjectTwo.setTitle("Agregar " + classObjects[1].name, for: .normal)
        addObjectThree.setTitle("Agregar " + classObjects[2].name, for: .normal)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //         Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        //         Create a new scene
//        scene = SCNScene(named: "art.scnassets/vending.scn")!
//        let node = scene?.rootNode.childNode(withName: "Vending", recursively: false)
//        object3D = (node?.childNode(withName: "mesh1848869498", recursively: false))!
        
//        let urlO = URL(string: "http://199.233.252.86/201811/zenith/scns/R2D22.scn")
//        scene = try? SCNScene(url: urlO!, options: nil)
////        scene = SCNScene(named: "art.scnassets/oldComputer.scn")!
//        let node = scene?.rootNode.childNode(withName: "container", recursively: false)
//        object3D = (node?.childNode(withName: "Comp", recursively: false))!
        
        //        let urlFor = Bundle.main.url(forResource: "art.scnassets/Computer", withExtension: "obj");
        //        let boxAsset = MDLAsset(url: urlFor!);
        //        scene = SCNScene(mdlAsset: boxAsset);
        
        
        //        scene = SCNScene(named: "art.scnassets/tortuga.scn")!
        //        object3D = (scene?.rootNode.childNode(withName: "tortuga", recursively: false))!
        
        //        scene = SCNScene();
        //        let urlTortuga = NSURL(string: "art.scnassets/turtle.obj");
        //        let asset = MDLAsset(url: urlTortuga! as URL);
        //        let object = asset.object(at: 0);
        //        object3D = SCNNode(mdlObject: object)
        //        scene?.rootNode.addChildNode(object3D);
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer (target: self, action: #selector(escalado))
        
        sceneView.addGestureRecognizer(pinchGestureRecognizer)
        scene = SCNScene()
        //         Set the scene to the view
        sceneView.scene = scene!
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        //indicar la detección del plano
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.sceneView.addGestureRecognizer(tap)
        //administrador de gestos para identificar el tap sobre el plano horizontal
        // Do any additional setup after loading the view.
        
        url = URL(string: serverHost + (classroom?.num)! + "/nx.png")
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
    
    @objc func escalado(recognizer:UIPinchGestureRecognizer) {
        print("escalado");
        object3D.scale = SCNVector3(recognizer.scale, recognizer.scale, recognizer.scale)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        // Create a session configuration
//        let configuration = ARWorldTrackingConfiguration()
//
//        // Run the view's session
//        sceneView.session.run(configuration)
//    }
////
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
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
    
    @IBOutlet weak var addObjectOne: UIButton!
    
    var objectOne : SCNScene? = nil
    var objectTwo : SCNScene? = nil
    var objectThree : SCNScene? = nil
    
    @IBAction func addObjectOneClick(_ sender: Any) {
        if (addObjectOne.tag == 0) {
            let node = objectOne?.rootNode.childNode(withName: "container", recursively: false)
            let newNode = node?.clone()
            newNode?.name = "obj1"
            object3D = (newNode?.childNode(withName: "Comp", recursively: false))!
            sceneView.scene.rootNode.addChildNode(newNode!)
            addObjectOne.tag = 1
            addObjectOne.setTitle("Quitar " + classObjects[0].name, for: .normal)
        }
        else {
            sceneView.scene.rootNode.childNode(withName: "obj1", recursively: false)?.removeFromParentNode()
            addObjectOne.tag = 0
            addObjectOne.setTitle("Agregar " + classObjects[0].name, for: .normal)
        }
    }
    
    @IBOutlet weak var addObjectTwo: UIButton!
    
    @IBAction func addObjectTwoClick(_ sender: Any) {
        if (addObjectTwo.tag == 0) {
            let node = objectTwo?.rootNode.childNode(withName: "container", recursively: false)
            object3D = (node?.childNode(withName: "Comp", recursively: false))!
            let newNode = node?.clone()
            newNode?.name = "obj2"
            object3D = (newNode?.childNode(withName: "Comp", recursively: false))!
            sceneView.scene.rootNode.addChildNode(newNode!)
            addObjectTwo.tag = 1
            addObjectTwo.setTitle("Quitar " + classObjects[1].name, for: .normal)
        }
        else {
            sceneView.scene.rootNode.childNode(withName: "obj2", recursively: false)?.removeFromParentNode()
            addObjectTwo.tag = 0
            addObjectTwo.setTitle("Agregar " + classObjects[1].name, for: .normal)
        }
    }
    
    @IBOutlet weak var addObjectThree: UIButton!
    
    @IBAction func addObjectThreeClick(_ sender: Any) {
        if (addObjectThree.tag == 0) {
            let node = objectThree?.rootNode.childNode(withName: "container", recursively: false)
            object3D = (node?.childNode(withName: "Comp", recursively: false))!
            let newNode = node?.clone()
            newNode?.name = "obj3"
            object3D = (newNode?.childNode(withName: "Comp", recursively: false))!
            sceneView.scene.rootNode.addChildNode(newNode!)
            addObjectThree.tag = 1
            addObjectThree.setTitle("Quitar " + classObjects[2].name, for: .normal)
        }
        else {
            sceneView.scene.rootNode.childNode(withName: "obj3", recursively: false)?.removeFromParentNode()
            addObjectThree.tag = 0
            addObjectThree.setTitle("Agregar " + classObjects[2].name, for: .normal)
        }
    }
    
    
    func addPortal(hitTestResult:ARHitTestResult) {
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
    Here we will try to add a video on the scene, if the proyects stops working, please delete all form below
    */
    
    var videoNode : SKVideoNode? = nil;
    
    @IBOutlet weak var addVideoBtn: UIButton!
    
    
    @IBAction func addVideo(_ sender: Any) {
        if (addVideoBtn.tag == 1) {
            sceneView.scene.rootNode.childNode(withName: "VIDEO", recursively: false)?.removeFromParentNode()
            addVideoBtn.tag = 0;
            videoNode?.pause()
            addVideoBtn.setTitle("Agregar video", for: .normal)
        }
        else {
            guard let currentFrame = self.sceneView.session.currentFrame else {return}
            
            //let path = Bundle.main.path(forResource: "CheeziPuffs", ofType: "mov")
            //let url = URL(fileURLWithPath: path!)
            
            let moviePath = "http://199.233.252.86/201811/zenith/media/" + (classroom?.num)! + ".mp4"
            let url = URL(string: moviePath)
            let player = AVPlayer(url: url!)
            player.volume = 0.5
            print(player.isMuted)
            
            // crear un nodo capaz de reporducir un video
            videoNode = SKVideoNode(url: url!)
            //let videoNodo = SKVideoNode(fileNamed: "CheeziPuffs.mov")
            //let videoNodo = SKVideoNode(avPlayer: player)
            videoNode?.play() //ejecutar play al momento de presentarse
            
            //crear una escena sprite kit, los parametros estan en pixeles
            let spriteKitEscene =  SKScene(size: CGSize(width: 640, height: 480))
            spriteKitEscene.addChild((videoNode)!)
            
            //colocar el videoNodo en el centro de la escena tipo SpriteKit
            videoNode?.position = CGPoint(x: spriteKitEscene.size.width/2, y: spriteKitEscene.size.height/2)
            videoNode?.size = spriteKitEscene.size
            
            //crear una pantalla 4/3, los parametros son metros
            let pantalla = SCNPlane(width: 1.0, height: 0.75)
            
            //pantalla.firstMaterial?.diffuse.contents = UIColor.blue
            //modificar el material del plano
            pantalla.firstMaterial?.diffuse.contents = spriteKitEscene
            //permitir ver el video por ambos lados
            pantalla.firstMaterial?.isDoubleSided = true
            
            let pantallaPlanaNodo = SCNNode(geometry: pantalla)
            //identificar en donde se ha tocado el currentFrame
            var traduccion = matrix_identity_float4x4
            //definir un metro alejado del dispositivo
            traduccion.columns.3.z = -1.0
            pantallaPlanaNodo.simdTransform = matrix_multiply(currentFrame.camera.transform, traduccion)
            
            pantallaPlanaNodo.eulerAngles = SCNVector3(Double.pi, 0, 0)
            pantallaPlanaNodo.name = "VIDEO"
            self.sceneView.scene.rootNode.addChildNode(pantallaPlanaNodo)
            
            addVideoBtn.tag = 1;
            addVideoBtn.setTitle("Quitar video", for: .normal)
        }
    }
    
    //Until here
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
