package erreeffe.entity;

// Generated 20-nov-2008 2.05.44 by Hibernate Tools 3.2.2.GA

/**
 * TmpSceltiId generated by hbm2java
 */
public class TmpSceltiId implements java.io.Serializable {

	private String descrizione;
	private int qta;
	private double prezzo;
	private double totale;

	public TmpSceltiId() {
	}

	public TmpSceltiId(String descrizione, int qta, double prezzo, double totale) {
		this.descrizione = descrizione;
		this.qta = qta;
		this.prezzo = prezzo;
		this.totale = totale;
	}

	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public int getQta() {
		return this.qta;
	}

	public void setQta(int qta) {
		this.qta = qta;
	}

	public double getPrezzo() {
		return this.prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public double getTotale() {
		return this.totale;
	}

	public void setTotale(double totale) {
		this.totale = totale;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof TmpSceltiId))
			return false;
		TmpSceltiId castOther = (TmpSceltiId) other;

		return ((this.getDescrizione() == castOther.getDescrizione()) || (this
				.getDescrizione() != null
				&& castOther.getDescrizione() != null && this.getDescrizione()
				.equals(castOther.getDescrizione())))
				&& (this.getQta() == castOther.getQta())
				&& (this.getPrezzo() == castOther.getPrezzo())
				&& (this.getTotale() == castOther.getTotale());
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getDescrizione() == null ? 0 : this.getDescrizione()
						.hashCode());
		result = 37 * result + this.getQta();
		result = 37 * result + (int) this.getPrezzo();
		result = 37 * result + (int) this.getTotale();
		return result;
	}

}
