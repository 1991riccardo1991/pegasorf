package erreeffe.entity;

// Generated 20-nov-2008 2.05.44 by Hibernate Tools 3.2.2.GA

import java.math.BigDecimal;

/**
 * ItalianiTotId generated by hbm2java
 */
public class ItalianiTotId implements java.io.Serializable {

	private String provincia;
	private BigDecimal arrivati;
	private BigDecimal partiti;
	private Long istat;

	public ItalianiTotId() {
	}

	public ItalianiTotId(String provincia, BigDecimal arrivati,
			BigDecimal partiti, Long istat) {
		this.provincia = provincia;
		this.arrivati = arrivati;
		this.partiti = partiti;
		this.istat = istat;
	}

	public String getProvincia() {
		return this.provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public BigDecimal getArrivati() {
		return this.arrivati;
	}

	public void setArrivati(BigDecimal arrivati) {
		this.arrivati = arrivati;
	}

	public BigDecimal getPartiti() {
		return this.partiti;
	}

	public void setPartiti(BigDecimal partiti) {
		this.partiti = partiti;
	}

	public Long getIstat() {
		return this.istat;
	}

	public void setIstat(Long istat) {
		this.istat = istat;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof ItalianiTotId))
			return false;
		ItalianiTotId castOther = (ItalianiTotId) other;

		return ((this.getProvincia() == castOther.getProvincia()) || (this
				.getProvincia() != null
				&& castOther.getProvincia() != null && this.getProvincia()
				.equals(castOther.getProvincia())))
				&& ((this.getArrivati() == castOther.getArrivati()) || (this
						.getArrivati() != null
						&& castOther.getArrivati() != null && this
						.getArrivati().equals(castOther.getArrivati())))
				&& ((this.getPartiti() == castOther.getPartiti()) || (this
						.getPartiti() != null
						&& castOther.getPartiti() != null && this.getPartiti()
						.equals(castOther.getPartiti())))
				&& ((this.getIstat() == castOther.getIstat()) || (this
						.getIstat() != null
						&& castOther.getIstat() != null && this.getIstat()
						.equals(castOther.getIstat())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getProvincia() == null ? 0 : this.getProvincia().hashCode());
		result = 37 * result
				+ (getArrivati() == null ? 0 : this.getArrivati().hashCode());
		result = 37 * result
				+ (getPartiti() == null ? 0 : this.getPartiti().hashCode());
		result = 37 * result
				+ (getIstat() == null ? 0 : this.getIstat().hashCode());
		return result;
	}

}
