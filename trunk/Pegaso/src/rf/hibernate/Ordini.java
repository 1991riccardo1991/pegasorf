package rf.hibernate;

// Generated 18-dic-2007 17.22.08 by Hibernate Tools 3.2.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Ordini generated by hbm2java
 */
public class Ordini implements java.io.Serializable {

	private long idordine;
	private TipoDocumento tipoDocumento;
	private Clienti clienti;
	private Date dataOrdine;
	private Date oraOrdine;
	private String note;
	private String numDocumento;
	private Date dataDocumento;
	private Integer docFiscale;
	private Integer docEmesso;
	private Set<DettaglioOrdini> dettaglioOrdinis = new HashSet<DettaglioOrdini>(
			0);
	private Set<Fattura> fatturas = new HashSet<Fattura>(0);
	private Set<Ddt> ddts = new HashSet<Ddt>(0);

	public Ordini() {
	}

	public Ordini(long idordine) {
		this.idordine = idordine;
	}

	public Ordini(long idordine, TipoDocumento tipoDocumento, Clienti clienti,
			Date dataOrdine, Date oraOrdine, String note, String numDocumento,
			Date dataDocumento, Integer docFiscale, Integer docEmesso,
			Set<DettaglioOrdini> dettaglioOrdinis, Set<Fattura> fatturas,
			Set<Ddt> ddts) {
		this.idordine = idordine;
		this.tipoDocumento = tipoDocumento;
		this.clienti = clienti;
		this.dataOrdine = dataOrdine;
		this.oraOrdine = oraOrdine;
		this.note = note;
		this.numDocumento = numDocumento;
		this.dataDocumento = dataDocumento;
		this.docFiscale = docFiscale;
		this.docEmesso = docEmesso;
		this.dettaglioOrdinis = dettaglioOrdinis;
		this.fatturas = fatturas;
		this.ddts = ddts;
	}

	public long getIdordine() {
		return this.idordine;
	}

	public void setIdordine(long idordine) {
		this.idordine = idordine;
	}

	public TipoDocumento getTipoDocumento() {
		return this.tipoDocumento;
	}

	public void setTipoDocumento(TipoDocumento tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public Clienti getClienti() {
		return this.clienti;
	}

	public void setClienti(Clienti clienti) {
		this.clienti = clienti;
	}

	public Date getDataOrdine() {
		return this.dataOrdine;
	}

	public void setDataOrdine(Date dataOrdine) {
		this.dataOrdine = dataOrdine;
	}

	public Date getOraOrdine() {
		return this.oraOrdine;
	}

	public void setOraOrdine(Date oraOrdine) {
		this.oraOrdine = oraOrdine;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getNumDocumento() {
		return this.numDocumento;
	}

	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}

	public Date getDataDocumento() {
		return this.dataDocumento;
	}

	public void setDataDocumento(Date dataDocumento) {
		this.dataDocumento = dataDocumento;
	}

	public Integer getDocFiscale() {
		return this.docFiscale;
	}

	public void setDocFiscale(Integer docFiscale) {
		this.docFiscale = docFiscale;
	}

	public Integer getDocEmesso() {
		return this.docEmesso;
	}

	public void setDocEmesso(Integer docEmesso) {
		this.docEmesso = docEmesso;
	}

	public Set<DettaglioOrdini> getDettaglioOrdinis() {
		return this.dettaglioOrdinis;
	}

	public void setDettaglioOrdinis(Set<DettaglioOrdini> dettaglioOrdinis) {
		this.dettaglioOrdinis = dettaglioOrdinis;
	}

	public Set<Fattura> getFatturas() {
		return this.fatturas;
	}

	public void setFatturas(Set<Fattura> fatturas) {
		this.fatturas = fatturas;
	}

	public Set<Ddt> getDdts() {
		return this.ddts;
	}

	public void setDdts(Set<Ddt> ddts) {
		this.ddts = ddts;
	}

}