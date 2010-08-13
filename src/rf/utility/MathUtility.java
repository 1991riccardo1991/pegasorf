package rf.utility;

public class MathUtility {

	/**
	 * ritorna l'ammontare di sconto che viene effettuato sul valore passato in base alla
	 * percentuale indicata
	 * @param valore dal quale si calcola la percentuale di sconto
	 * @param percentuale e la quantità di percentuale che dobbiamo applicare
	 * @return il valore di sconto che dobbiamo applicar
	 */
	public static double scontoPercentuale(double valore, int percentuale) {
		return (valore/100)*percentuale;
	}

	public static double percentualeDaAggiungere(double valore, int percentuale){
		return scontoPercentuale(valore, percentuale);
	}
	
	public static double percentualeDaAggiungere(double valore, long percentuale){
		return scontoPercentuale(valore, percentuale);
	}
	
	public static double scontoPercentuale(double valore, double percentuale){
		return (valore/100)*percentuale;
	}

}
