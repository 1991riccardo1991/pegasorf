package erreeffe.entity;

// Generated 20-nov-2008 2.05.44 by Hibernate Tools 3.2.2.GA

/**
 * Stranieri generated by hbm2java
 */
public class Stranieri implements java.io.Serializable {

	private long idstranieri;
	private Modistatc59 modistatc59;
	private String nazionalita;
	private Long arrivati;
	private Long partiti;
	private Long presenti;

	public Stranieri() {
	}

	public Stranieri(long idstranieri, String nazionalita) {
		this.idstranieri = idstranieri;
		this.nazionalita = nazionalita;
	}

	public Stranieri(long idstranieri, Modistatc59 modistatc59,
			String nazionalita, Long arrivati, Long partiti, Long presenti) {
		this.idstranieri = idstranieri;
		this.modistatc59 = modistatc59;
		this.nazionalita = nazionalita;
		this.arrivati = arrivati;
		this.partiti = partiti;
		this.presenti = presenti;
	}

	public long getIdstranieri() {
		return this.idstranieri;
	}

	public void setIdstranieri(long idstranieri) {
		this.idstranieri = idstranieri;
	}

	public Modistatc59 getModistatc59() {
		return this.modistatc59;
	}

	public void setModistatc59(Modistatc59 modistatc59) {
		this.modistatc59 = modistatc59;
	}

	public String getNazionalita() {
		return this.nazionalita;
	}

	public void setNazionalita(String nazionalita) {
		this.nazionalita = nazionalita;
	}

	public Long getArrivati() {
		return this.arrivati;
	}

	public void setArrivati(Long arrivati) {
		this.arrivati = arrivati;
	}

	public Long getPartiti() {
		return this.partiti;
	}

	public void setPartiti(Long partiti) {
		this.partiti = partiti;
	}

	public Long getPresenti() {
		return this.presenti;
	}

	public void setPresenti(Long presenti) {
		this.presenti = presenti;
	}

}
