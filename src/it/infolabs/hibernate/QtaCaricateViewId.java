package it.infolabs.hibernate;

// Generated 23-lug-2009 0.07.34 by Hibernate Tools 3.2.4.GA

/**
 * QtaCaricateViewId generated by hbm2java
 */
public class QtaCaricateViewId implements java.io.Serializable {

	private Long idarticolo;
	private String codbarre;
	private Double sum;

	public QtaCaricateViewId() {
	}

	public QtaCaricateViewId(Long idarticolo, String codbarre, Double sum) {
		this.idarticolo = idarticolo;
		this.codbarre = codbarre;
		this.sum = sum;
	}

	public Long getIdarticolo() {
		return this.idarticolo;
	}

	public void setIdarticolo(Long idarticolo) {
		this.idarticolo = idarticolo;
	}

	public String getCodbarre() {
		return this.codbarre;
	}

	public void setCodbarre(String codbarre) {
		this.codbarre = codbarre;
	}

	public Double getSum() {
		return this.sum;
	}

	public void setSum(Double sum) {
		this.sum = sum;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof QtaCaricateViewId))
			return false;
		QtaCaricateViewId castOther = (QtaCaricateViewId) other;

		return ((this.getIdarticolo() == castOther.getIdarticolo()) || (this
				.getIdarticolo() != null
				&& castOther.getIdarticolo() != null && this.getIdarticolo()
				.equals(castOther.getIdarticolo())))
				&& ((this.getCodbarre() == castOther.getCodbarre()) || (this
						.getCodbarre() != null
						&& castOther.getCodbarre() != null && this
						.getCodbarre().equals(castOther.getCodbarre())))
				&& ((this.getSum() == castOther.getSum()) || (this.getSum() != null
						&& castOther.getSum() != null && this.getSum().equals(
						castOther.getSum())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getIdarticolo() == null ? 0 : this.getIdarticolo()
						.hashCode());
		result = 37 * result
				+ (getCodbarre() == null ? 0 : this.getCodbarre().hashCode());
		result = 37 * result
				+ (getSum() == null ? 0 : this.getSum().hashCode());
		return result;
	}

}
