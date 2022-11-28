import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    
    @State var codigo = ""
    @State var nombre = ""
    @State var precio = ""
    @State var existencia = ""
    @State var categoria = ""
    @State var newcodigo = ""
    @State var newnombre = ""
    @State var newprecio = ""
    @State var newexistencia = ""
    @State var newcategoria = ""
    @State var seleccionado: Mobiliario?
    @State var prodArray = [Mobiliario]()
    @State var tapFlag = false
    
    


    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("ID", text: self.$newcodigo).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Nombre", text: self.$newnombre).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("precio", text: self.$newprecio).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Existencia", text: self.$newexistencia).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Categoria", text: self.$newcategoria).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Guardar"){
                        coreDM.guardarMobiliario(idMobiliario: newcodigo, nombre: newnombre, precio: newprecio, existencia: newexistencia, categoria: newcategoria)
                        newnombre = ""
                        newcodigo = ""
                        newprecio = ""
                        newexistencia = ""
                        newcategoria = ""
                        mostrarProductos()
                    }
                    }){
                    Text("Agregar")
                }

                List{
                    ForEach(prodArray, id: \.self){
                        prod in
                        VStack{
                            Text(prod.nombre ?? "")
                        }
                        .onTapGesture{
                            seleccionado = prod
                            codigo = prod.idMobiliario ?? ""
                            nombre = prod.nombre ?? ""
                            precio = prod.precio ?? ""
                            existencia = prod.existencia ?? ""
                            categoria = prod.categoria ?? ""
                            tapFlag.toggle()
                        }
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach({ index in
                        let producto = prodArray[index]
                            coreDM.borrarMobiliario(mobiliario: producto)
                        mostrarProductos()
                        })
                    })
                }.padding()
                    .onAppear(perform: {mostrarProductos()})
                NavigationLink("",destination: VStack{
                                    TextField("ID", text: self.$codigo).textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Nombre", text: self.$nombre).textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("precio", text: self.$precio).textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Existencia", text: self.$existencia).textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Categoria", text: self.$categoria).textFieldStyle(RoundedBorderTextFieldStyle())

                                    Button("Actualizar"){
                                        seleccionado?.idMobiliario = codigo
                                        seleccionado?.nombre = nombre
                                        seleccionado?.precio = precio
                                        seleccionado?.existencia = existencia
                                        seleccionado?.categoria = categoria
                                        coreDM.actualizarProducto(mobiliario: seleccionado!)
                                        nombre = ""
                                        precio = ""
                                        existencia = ""
                                        categoria = ""
                                        mostrarProductos()
                                    }
                                },isActive: $tapFlag)
                
            }
        }
    }
    func mostrarProductos(){
            prodArray = coreDM.leerTodosLosProductos()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
