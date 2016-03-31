/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Alejandro Sánchez
 * Creation Date: 29/03/2016 at 16:35:21
 *********************************************/

 int MaxCapacity = ...;
 int NbClients = ...;
 range RgClients = 1..NbClients;
 range RgList = 0..1;
 int Elements[RgClients][RgList] = ...;
 
 dvar boolean take[RgClients];
 
 maximize sum(c in RgClients) take[c] * Elements[c][1];
 
 subject to {
 	notExceedVolume:
 		sum(c in RgClients) take[c] * Elements[c][1] <= MaxCapacity;
 }
 
 main{
	thisOplModel.generate();
	
	var mochilaModel = thisOplModel;
	
	var taken = mochilaModel.take;

	var Elements = mochilaModel.Elements;
	
	var MaxCapacity = mochilaModel.MaxCapacity;
	
	cplex.solve();
	
	var curr = cplex.getObjValue();
	
	var nbTaken = 0;
	var totalItems = 0;
	write("Clientes escogidos: ")
	for (var c in mochilaModel.RgClients) {
		totalItems += Elements[c][0]
		if(taken[c] == 1) {		
			nbTaken += Elements[c][0]
			write(c + ", ")
		}
	}	

	writeln("\nCapacidad ocupada: " + curr + "/" + MaxCapacity);
	writeln("Elementos incluídos: " + nbTaken + "/" + totalItems)
}