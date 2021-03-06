package erreeffe.entity;

// Generated 19-nov-2008 20.32.14 by Hibernate Tools 3.2.2.GA

/**
 * ProgressiviId generated by hbm2java
 */
public class ProgressiviId implements java.io.Serializable {

	private int progFattura;
	private int progRicevuta;
	private int progScontrino;
	private int anno;

	public ProgressiviId() {
	}

	public ProgressiviId(int progFattura, int progRicevuta, int progScontrino,
			int anno) {
		this.progFattura = progFattura;
		this.progRicevuta = progRicevuta;
		this.progScontrino = progScontrino;
		this.anno = anno;
	}

	public int getProgFattura() {
		return this.progFattura;
	}

	public void setProgFattura(int progFattura) {
		this.progFattura = progFattura;
	}

	public int getProgRicevuta() {
		return this.progRicevuta;
	}

	public void setProgRicevuta(int progRicevuta) {
		this.progRicevuta = progRicevuta;
	}

	public int getProgScontrino() {
		return this.progScontrino;
	}

	public void setProgScontrino(int progScontrino) {
		this.progScontrino = progScontrino;
	}

	public int getAnno() {
		return this.anno;
	}

	public void setAnno(int anno) {
		this.anno = anno;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof ProgressiviId))
			return false;
		ProgressiviId castOther = (ProgressiviId) other;

		return (this.getProgFattura() == castOther.getProgFattura())
				&& (this.getProgRicevuta() == castOther.getProgRicevuta())
				&& (this.getProgScontrino() == castOther.getProgScontrino())
				&& (this.getAnno() == castOther.getAnno());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getProgFattura();
		result = 37 * result + this.getProgRicevuta();
		result = 37 * result + this.getProgScontrino();
		result = 37 * result + this.getAnno();
		return result;
	}

}
