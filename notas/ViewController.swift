//
//  ViewController.swift
//  notas
//
//  Created by Mac11 on 17/04/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource	 {
    var Pos: Int?
    
    var EditarNota: String?
    
    var Notas = [String?]()
    
    var Fechas = [String?]()
    @IBOutlet weak var tabla: UITableView!
    let Db = UserDefaults.standard
    //cuantos renglones tendra la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notas.count
        
    }
    //crea el obj tipo celda utilizando una celda reutilizable y no gastar mucho codigo haciendo celda por celda.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  objCelda = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        objCelda.textLabel?.text = Notas[indexPath.row]
        objCelda.detailTextLabel?.text = Fechas[indexPath.row]
        return objCelda
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Notas.remove(at: indexPath.row)
            Fechas.remove(at: indexPath.row)
            self.Db.set(self.Notas, forKey: "notas")
            self.Db.set(self.Fechas, forKey: "Fechas")
            tabla.reloadData()
        }
    }
    //este metodo se activa al seleccionar un elemento de la tabla
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Pos = indexPath.row
        EditarNota = Notas[indexPath.row]
        performSegue(withIdentifier: "editar", sender: self)
    }    //let notas = ["nota 1","nota 2","nota 3"]
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notas"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            let objectEdit = segue.destination as! EditarNotaViewController
            objectEdit.obtenerNota = EditarNota
            objectEdit.Notas = Notas
            objectEdit.Fechas = Fechas
            objectEdit.Pos = Pos
        }
    }
    // MARK: - agregar nota
    @IBAction func agregarNota(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alerta = UIAlertController(title: "Agregar", message: nil, preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Crear", style: .default) { (_) in
            //Codigo para agregar una nueva nota
            self.Notas.append(textField.text ?? "Empty note")
            self.Db.set(self.Notas, forKey: "Notas")
            
            let fecha = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy 'a las' hh:mm:ss"
            let fecha2 = formatter.string(from: fecha)
            self.Fechas.append(fecha2)
            self.Db.set(self.Fechas, forKey: "Fechas")
           
            self.tabla.reloadData()
        }
        
        let cancelar = UIAlertAction(title: "Candelar", style: .destructive) { (_) in
        }
        
        alerta.addAction(aceptar)
        alerta.addAction(cancelar)
        
        alerta.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Ingresa la nueva notaa"
            textField = textFieldAlert
        }
        present(alerta, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //implementar 2 metodos siempre que uses una tabla
        tabla.delegate = self
        tabla.dataSource = self
        // Do any additional setup after loading the view.
        if let notesArray = Db.array(forKey: "Notas") as? [String] {
            Notas = notesArray
        }
        
        if let datesArray = Db.array(forKey: "Fechas") as? [String] {
            Fechas = datesArray
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let Notass = Db.array(forKey: "Notas") as? [String] {
            Notas = Notass
        }
        
        if let Fechass = Db.array(forKey: "Fechas") as? [String] {
            Fechas = Fechass
        }
        
        tabla.reloadData()
    }


}

