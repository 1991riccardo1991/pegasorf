package it.infolabs.hibernate;

// Generated 6-mag-2010 0.12.00 by Hibernate Tools 3.2.4.GA

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Documento generated by hbm2java
 */
public class Documento implements java.io.Serializable {

	private long id;
	private Cliente cliente;
	private Date dataEmissione;
	private Short tipoDocumento;
	private String note;
	private Long numeroDocumento;
	private Fattura fattura;
	private Ordine ordine;
	private Set<DettaglioDocumento> dettaglioDocumentos = new HashSet<DettaglioDocumento>(
			0);
	private Bolla bolla;
	private Set<DettaglioDocumento> dettaglioDocumentos_1 = new HashSet<DettaglioDocumento>(
			0);
	private Ricevuta ricevuta;

	public Documento() {
	}

	public Documento(long id) {
		this.id = id;
	}

	public Documento(long id, Cliente cliente, Date dataEmissione,
			Short tipoDocumento, String note, Long numeroDocumento,
			Fattura fattura, Ordine ordine,
			Set<DettaglioDocumento> dettaglioDocumentos, Bolla bolla,
			Set<DettaglioDocumento> dettaglioDocumentos_1, Ricevuta ricevuta) {
		this.id = id;
		this.cliente = cliente;
		this.dataEmissione = dataEmissione;
		this.tipoDocumento = tipoDocumento;
		this.note = note;
		this.numeroDocumento = numeroDocumento;
		this.fattura = fattura;
		this.ordine = ordine;
		this.dettaglioDocumentos = dettaglioDocumentos;
		this.bolla = bolla;
		this.dettaglioDocumentos_1 = dettaglioDocumentos_1;
		this.ricevuta = ricevuta;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Cliente getCliente() {
		return this.cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public Date getDataEmissione() {
		return this.dataEmissione;
	}

	public void setDataEmissione(Date dataEmissione) {
		this.dataEmissione = dataEmissione;
	}

	public Short getTipoDocumento() {
		return this.tipoDocumento;
	}

	public void setTipoDocumento(Short tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Long getNumeroDocumento() {
		return this.numeroDocumento;
	}

	public void setNumeroDocumento(Long numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}

	public Fattura getFattura() {
		return this.fattura;
	}

	public void setFattura(Fattura fattura) {
		this.fattura = fattura;
	}

	public Ordine getOrdine() {
		return this.ordine;
	}

	public void setOrdine(Ordine ordine) {
		this.ordine = ordine;
	}

	public Set<DettaglioDocumento> getDettaglioDocumentos() {
		return this.dettaglioDocumentos;
	}

	public void setDettaglioDocumentos(
			Set<DettaglioDocumento> dettaglioDocumentos) {
		this.dettaglioDocumentos = dettaglioDocumentos;
	}

	public Bolla getBolla() {
		return this.bolla;
	}

	public void setBolla(Bolla bolla) {
		this.bolla = bolla;
	}

	public Set<DettaglioDocumento> getDettaglioDocumentos_1() {
		return this.dettaglioDocumentos_1;
	}

	public void setDettaglioDocumentos_1(
			Set<DettaglioDocumento> dettaglioDocumentos_1) {
		this.dettaglioDocumentos_1 = dettaglioDocumentos_1;
	}

	public Ricevuta getRicevuta() {
		return this.ricevuta;
	}

	public void setRicevuta(Ricevuta ricevuta) {
		this.ricevuta = ricevuta;
	}

}
