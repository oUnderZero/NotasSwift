//
//  EditarNotaViewController.swift
//  notas
//
//  Created by Mac11 on 19/04/21.
//

import UIKit

class EditarNotaViewController: UIViewController {
    var Notas: [String?] = []
    
    var Fechas: [String?] = []
    
    var Pos: Int?
    
    var obtenerNota: String?
    
    let Db = UserDefaults.standard
    
    @IBOutlet weak var editNoteTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        editNoteTextField.text = obtenerNota
        // Do any additional setup after loading the view.
    }
    // MARK: - Boton agregar

    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        Fechas.remove(at: Pos!)
        Notas.remove(at: Pos!)
        
        if let editedNote = editNoteTextField.text {
            Notas.append(editedNote)
            let fecha = Date()
            let fecha2 = DateFormatter()
            fecha2.dateFormat = "MMMM dd, yyyy 'a las' hh:mm:ss"
            let result = fecha2.string(from: fecha)
            Fechas.append(result)
        }
        
        Db.set(Fechas, forKey: "Fechas")
        Db.set(Notas, forKey: "Notas")
        navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
