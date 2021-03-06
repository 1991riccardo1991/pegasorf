package erreeffe.entity;

// Generated 20-nov-2008 2.05.44 by Hibernate Tools 3.2.2.GA

/**
 * DettaglioOrdiniId generated by hbm2java
 */
public class DettaglioOrdiniId implements java.io.Serializable {

	private long idordine;
	private long idarticolo;

	public DettaglioOrdiniId() {
	}

	public DettaglioOrdiniId(long idordine, long idarticolo) {
		this.idordine = idordine;
		this.idarticolo = idarticolo;
	}

	public long getIdordine() {
		return this.idordine;
	}

	public void setIdordine(long idordine) {
		this.idordine = idordine;
	}

	public long getIdarticolo() {
		return this.idarticolo;
	}

	public void setIdarticolo(long idarticolo) {
		this.idarticolo = idarticolo;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof DettaglioOrdiniId))
			return false;
		DettaglioOrdiniId castOther = (DettaglioOrdiniId) other;

		return (this.getIdordine() == castOther.getIdordine())
				&& (this.getIdarticolo() == castOther.getIdarticolo());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + (int) this.getIdordine();
		result = 37 * result + (int) this.getIdarticolo();
		return result;
	}

}
