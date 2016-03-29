/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Donzok
 * Creation Date: 29/03/2016 at 16:35:21
 *********************************************/

 int MaxCapacity = ...;
 int NbElements = ...;
 range RgElements = 1..NbElements;
 {string} Clients = ...;
 int Elements[Clients][RgElements] = ...;
 
 dvar boolean take[Clients][RgElements];
 
 maximize sum(c in Clients)sum(e in RgElements) take[c][e];
 
 subject to {
 	notExceedVolume:
 		sum(c in Clients) sum(e in RgElements) take[c][e] * Elements[c][e] <= MaxCapacity;
 		
 	forall(c in Clients)
 		allFromSameClient:
 		sum(e in RgElements) take[c][e] == 0 || sum(e in RgElements) take[c][e] == NbElements;
 }
 
 main{
	thisOplModel.generate();
	
	var mochilaModel = thisOplModel;
	
	var taken = mochilaModel.take;
	
	var Elements = mochilaModel.Elements;
	
	var clients = mochilaModel.Clients;
	
	var MaxCapacity = mochilaModel.MaxCapacity;
	
	cplex.solve();
	
	var curr = cplex.getObjValue();
	
	var nbTaken = 0
	for (var c in mochilaModel.Clients) {
		write("\nCliente " + c + ": ")
		for(var el in mochilaModel.RgElements){
			if(taken[c][el] == 1) {
				if(Elements[c][el] != 0) {
					nbTaken++;
   				}
				write(Elements[c][el] + " ")		
			}
		}
	}	
	
	writeln()
	writeln("Capacidad ocupada: " + curr + "/" + MaxCapacity);
	writeln("Elementos incluídos: " + nbTaken + "/" + Elements.size)
}