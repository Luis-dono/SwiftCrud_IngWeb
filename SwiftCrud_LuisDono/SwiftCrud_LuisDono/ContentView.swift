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


    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("ID", text: self.$newcodigo).multilineTextAlignment(.center)
                    TextField("Nombre", text: self.$newnombre).multilineTextAlignment(.center)
                    TextField("precio", text: self.$newprecio).multilineTextAlignment(.center)
                    TextField("Existencia", text: self.$newexistencia).multilineTextAlignment(.center)
                    TextField("Categoria", text: self.$newcategoria).multilineTextAlignment(.center)

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
