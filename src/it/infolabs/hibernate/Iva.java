package it.infolabs.hibernate;

// Generated 6-mag-2010 0.12.00 by Hibernate Tools 3.2.4.GA

import java.util.HashSet;
import java.util.Set;

/**
 * Iva generated by hbm2java
 */
public class Iva implements java.io.Serializable {

	private long id;
	private Integer codiceIva;
	private Integer iva;
	private String descrizione;
	private Set<DettaglioDocumento> dettaglioDocumentos = new HashSet<DettaglioDocumento>(
			0);
	private Set<DettaglioDocumento> dettaglioDocumentos_1 = new HashSet<DettaglioDocumento>(
			0);

	public Iva() {
	}

	public Iva(long id) {
		this.id = id;
	}

	public Iva(long id, Integer codiceIva, Integer iva, String descrizione,
			Set<DettaglioDocumento> dettaglioDocumentos,
			Set<DettaglioDocumento> dettaglioDocumentos_1) {
		this.id = id;
		this.codiceIva = codiceIva;
		this.iva = iva;
		this.descrizione = descrizione;
		this.dettaglioDocumentos = dettaglioDocumentos;
		this.dettaglioDocumentos_1 = dettaglioDocumentos_1;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Integer getCodiceIva() {
		return this.codiceIva;
	}

	public void setCodiceIva(Integer codiceIva) {
		this.codiceIva = codiceIva;
	}

	public Integer getIva() {
		return this.iva;
	}

	public void setIva(Integer iva) {
		this.iva = iva;
	}

	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public Set<DettaglioDocumento> getDettaglioDocumentos() {
		return this.dettaglioDocumentos;
	}

	public void setDettaglioDocumentos(
			Set<DettaglioDocumento> dettaglioDocumentos) {
		this.dettaglioDocumentos = dettaglioDocumentos;
	}

	public Set<DettaglioDocumento> getDettaglioDocumentos_1() {
		return this.dettaglioDocumentos_1;
	}

	public void setDettaglioDocumentos_1(
			Set<DettaglioDocumento> dettaglioDocumentos_1) {
		this.dettaglioDocumentos_1 = dettaglioDocumentos_1;
	}

}
