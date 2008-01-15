package rf.hibernate;

// Generated 18-dic-2007 17.22.08 by Hibernate Tools 3.2.0.CR1

import java.util.Date;

/**
 * Fattura generated by hbm2java
 */
public class Fattura implements java.io.Serializable {

	private long idfattura;
	private Ordini ordini;
	private Aspetto aspetto;
	private Causale causale;
	private Pagamento pagamento;
	private Double speseIncasso;
	private Double speseTrasporto;
	private Date dataTr;
	private Date oraTr;
	private Long colli;
	private Double peso;
	private String consegna;
	private String porto;
	private String diversaDest;
	private Long sconto;
	private String note;

	public Fattura() {
	}

	public Fattura(long idfattura, Ordini ordini) {
		this.idfattura = idfattura;
		this.ordini = ordini;
	}

	public Fattura(long idfattura, Ordini ordini, Aspetto aspetto,
			Causale causale, Pagamento pagamento, Double speseIncasso,
			Double speseTrasporto, Date dataTr, Date oraTr, Long colli,
			Double peso, String consegna, String porto, String diversaDest,
			Long sconto, String note) {
		this.idfattura = idfattura;
		this.ordini = ordini;
		this.aspetto = aspetto;
		this.causale = causale;
		this.pagamento = pagamento;
		this.speseIncasso = speseIncasso;
		this.speseTrasporto = speseTrasporto;
		this.dataTr = dataTr;
		this.oraTr = oraTr;
		this.colli = colli;
		this.peso = peso;
		this.consegna = consegna;
		this.porto = porto;
		this.diversaDest = diversaDest;
		this.sconto = sconto;
		this.note = note;
	}

	public long getIdfattura() {
		return this.idfattura;
	}

	public void setIdfattura(long idfattura) {
		this.idfattura = idfattura;
	}

	public Ordini getOrdini() {
		return this.ordini;
	}

	public void setOrdini(Ordini ordini) {
		this.ordini = ordini;
	}

	public Aspetto getAspetto() {
		return this.aspetto;
	}

	public void setAspetto(Aspetto aspetto) {
		this.aspetto = aspetto;
	}

	public Causale getCausale() {
		return this.causale;
	}

	public void setCausale(Causale causale) {
		this.causale = causale;
	}

	public Pagamento getPagamento() {
		return this.pagamento;
	}

	public void setPagamento(Pagamento pagamento) {
		this.pagamento = pagamento;
	}

	public Double getSpeseIncasso() {
		return this.speseIncasso;
	}

	public void setSpeseIncasso(Double speseIncasso) {
		this.speseIncasso = speseIncasso;
	}

	public Double getSpeseTrasporto() {
		return this.speseTrasporto;
	}

	public void setSpeseTrasporto(Double speseTrasporto) {
		this.speseTrasporto = speseTrasporto;
	}

	public Date getDataTr() {
		return this.dataTr;
	}

	public void setDataTr(Date dataTr) {
		this.dataTr = dataTr;
	}

	public Date getOraTr() {
		return this.oraTr;
	}

	public void setOraTr(Date oraTr) {
		this.oraTr = oraTr;
	}

	public Long getColli() {
		return this.colli;
	}

	public void setColli(Long colli) {
		this.colli = colli;
	}

	public Double getPeso() {
		return this.peso;
	}

	public void setPeso(Double peso) {
		this.peso = peso;
	}

	public String getConsegna() {
		return this.consegna;
	}

	public void setConsegna(String consegna) {
		this.consegna = consegna;
	}

	public String getPorto() {
		return this.porto;
	}

	public void setPorto(String porto) {
		this.porto = porto;
	}

	public String getDiversaDest() {
		return this.diversaDest;
	}

	public void setDiversaDest(String diversaDest) {
		this.diversaDest = diversaDest;
	}

	public Long getSconto() {
		return this.sconto;
	}

	public void setSconto(Long sconto) {
		this.sconto = sconto;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}