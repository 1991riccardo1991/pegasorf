package it.infolabs.hibernate;

// Generated 23-lug-2009 0.07.34 by Hibernate Tools 3.2.4.GA

/**
 * DettaglioOrdini generated by hbm2java
 */
public class DettaglioScarico implements java.io.Serializable {

	private DettaglioScaricoId id;
	private Scarico ordini;
	private Articolo articoli;
	private double qta;
	private Long sconto;
	private Double prezzoAcquisto;
	private Double prezzoVendita;
	private Integer iva;

	public DettaglioScarico() {
	}

	public DettaglioScarico(DettaglioScaricoId id, Scarico ordini,
			Articolo articoli, double qta) {
		this.id = id;
		this.ordini = ordini;
		this.articoli = articoli;
		this.qta = qta;
	}

	public DettaglioScarico(DettaglioScaricoId id, Scarico ordini,
			Articolo articoli, double qta, Long sconto, Double prezzoAcquisto,
			Double prezzoVendita, Integer iva) {
		this.id = id;
		this.ordini = ordini;
		this.articoli = articoli;
		this.qta = qta;
		this.sconto = sconto;
		this.prezzoAcquisto = prezzoAcquisto;
		this.prezzoVendita = prezzoVendita;
		this.iva = iva;
	}

	public DettaglioScaricoId getId() {
		return this.id;
	}

	public void setId(DettaglioScaricoId id) {
		this.id = id;
	}

	public Scarico getOrdini() {
		return this.ordini;
	}

	public void setOrdini(Scarico ordini) {
		this.ordini = ordini;
	}

	public Articolo getArticoli() {
		return this.articoli;
	}

	public void setArticoli(Articolo articoli) {
		this.articoli = articoli;
	}

	public double getQta() {
		return this.qta;
	}

	public void setQta(double qta) {
		this.qta = qta;
	}

	public Long getSconto() {
		return this.sconto;
	}

	public void setSconto(Long sconto) {
		this.sconto = sconto;
	}

	public Double getPrezzoAcquisto() {
		return this.prezzoAcquisto;
	}

	public void setPrezzoAcquisto(Double prezzoAcquisto) {
		this.prezzoAcquisto = prezzoAcquisto;
	}

	public Double getPrezzoVendita() {
		return this.prezzoVendita;
	}

	public void setPrezzoVendita(Double prezzoVendita) {
		this.prezzoVendita = prezzoVendita;
	}

	public Integer getIva() {
		return this.iva;
	}

	public void setIva(Integer iva) {
		this.iva = iva;
	}

}
