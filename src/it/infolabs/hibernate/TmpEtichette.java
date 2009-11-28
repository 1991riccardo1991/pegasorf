package it.infolabs.hibernate;

// Generated 22-nov-2009 2.09.36 by Hibernate Tools 3.2.4.GA

/**
 * TmpEtichette generated by hbm2java
 */
public class TmpEtichette implements java.io.Serializable {

	private long id;
	private String codice;
	private String descrizione;
	private Double prezzo;
	private String note;

	public TmpEtichette() {
	}

	public TmpEtichette(long id) {
		this.id = id;
	}

	public TmpEtichette(long id, String codice, String descrizione,
			Double prezzo, String note) {
		this.id = id;
		this.codice = codice;
		this.descrizione = descrizione;
		this.prezzo = prezzo;
		this.note = note;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCodice() {
		return this.codice;
	}

	public void setCodice(String codice) {
		this.codice = codice;
	}

	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public Double getPrezzo() {
		return this.prezzo;
	}

	public void setPrezzo(Double prezzo) {
		this.prezzo = prezzo;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
