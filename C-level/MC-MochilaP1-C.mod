/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Donzok
 * Creation Date: 29/03/2016 at 16:35:21
 *********************************************/

 int MaxCapacity = ...;
 int NbElements = ...;
 range RgElements = 1..NbElements;
 int Elements[RgElements] = ...;
 
 dvar boolean take[RgElements];
 
 maximize sum(i in RgElements) take[i] * Elements[i];
 
 subject to {
 	notExceedVolume:
 		sum(i in RgElements) take[i] * Elements[i] <= MaxCapacity; 	  	 
 }
 
 main{
	thisOplModel.generate();
	
	var mochilaModel = thisOplModel;
	
	var taken = mochilaModel.take;
	
	var Elements = mochilaModel.Elements;
	
	var notExceedVolume = mochilaModel.notExceedVolume;
	
	var MaxCapacity = mochilaModel.MaxCapacity;
	
	cplex.solve();
	
	var curr = cplex.getObjValue();
	
	var nbTaken = 0
	writeln("El\tV")
	for(var el in mochilaModel.RgElements){
		if(taken[el] == 1) {
			nbTaken++;
			writeln(el + "\t" + Elements[el])		
		}
	}
	
	writeln("Capacidad ocupada: " + curr + "/" + MaxCapacity);
	writeln("Elementos incluídos: " + nbTaken + "/" + Elements.size)
	
	// writeln(Opl.dual(notExceedVolume));
}