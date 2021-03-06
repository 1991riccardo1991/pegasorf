package erreeffe.entity;

// Generated 20-nov-2008 2.05.44 by Hibernate Tools 3.2.2.GA

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Documenti generated by hbm2java
 */
public class Documenti implements java.io.Serializable {

	private int id;
	private Prenotazione prenotazione;
	private int numDocumento;
	private Date dataDocumento;
	private String tipo;
	private String stato;
	private Double imponibileNetto;
	private Double sconto;
	private Double imponibileScontato;
	private Double imposta;
	private Double totaleDocumento;
	private Set<DettagliDocumenti> dettagliDocumentis = new HashSet<DettagliDocumenti>(
			0);

	public Documenti() {
	}

	public Documenti(int id, Prenotazione prenotazione, int numDocumento) {
		this.id = id;
		this.prenotazione = prenotazione;
		this.numDocumento = numDocumento;
	}

	public Documenti(int id, Prenotazione prenotazione, int numDocumento,
			Date dataDocumento, String tipo, String stato,
			Double imponibileNetto, Double sconto, Double imponibileScontato,
			Double imposta, Double totaleDocumento,
			Set<DettagliDocumenti> dettagliDocumentis) {
		this.id = id;
		this.prenotazione = prenotazione;
		this.numDocumento = numDocumento;
		this.dataDocumento = dataDocumento;
		this.tipo = tipo;
		this.stato = stato;
		this.imponibileNetto = imponibileNetto;
		this.sconto = sconto;
		this.imponibileScontato = imponibileScontato;
		this.imposta = imposta;
		this.totaleDocumento = totaleDocumento;
		this.dettagliDocumentis = dettagliDocumentis;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Prenotazione getPrenotazione() {
		return this.prenotazione;
	}

	public void setPrenotazione(Prenotazione prenotazione) {
		this.prenotazione = prenotazione;
	}

	public int getNumDocumento() {
		return this.numDocumento;
	}

	public void setNumDocumento(int numDocumento) {
		this.numDocumento = numDocumento;
	}

	public Date getDataDocumento() {
		return this.dataDocumento;
	}

	public void setDataDocumento(Date dataDocumento) {
		this.dataDocumento = dataDocumento;
	}

	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getStato() {
		return this.stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	public Double getImponibileNetto() {
		return this.imponibileNetto;
	}

	public void setImponibileNetto(Double imponibileNetto) {
		this.imponibileNetto = imponibileNetto;
	}

	public Double getSconto() {
		return this.sconto;
	}

	public void setSconto(Double sconto) {
		this.sconto = sconto;
	}

	public Double getImponibileScontato() {
		return this.imponibileScontato;
	}

	public void setImponibileScontato(Double imponibileScontato) {
		this.imponibileScontato = imponibileScontato;
	}

	public Double getImposta() {
		return this.imposta;
	}

	public void setImposta(Double imposta) {
		this.imposta = imposta;
	}

	public Double getTotaleDocumento() {
		return this.totaleDocumento;
	}

	public void setTotaleDocumento(Double totaleDocumento) {
		this.totaleDocumento = totaleDocumento;
	}

	public Set<DettagliDocumenti> getDettagliDocumentis() {
		return this.dettagliDocumentis;
	}

	public void setDettagliDocumentis(Set<DettagliDocumenti> dettagliDocumentis) {
		this.dettagliDocumentis = dettagliDocumentis;
	}

}
