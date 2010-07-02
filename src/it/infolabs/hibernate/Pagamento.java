package it.infolabs.hibernate;

// Generated 3-lug-2010 0.47.58 by Hibernate Tools 3.2.4.GA

import java.util.HashSet;
import java.util.Set;

/**
 * Pagamento generated by hbm2java
 */
public class Pagamento implements java.io.Serializable {

	private long idpagamento;
	private String nome;
	private Set<Scarico> scaricosForPagamento = new HashSet<Scarico>(0);
	private Set<Scarico> scaricosForIdpagamento = new HashSet<Scarico>(0);

	public Pagamento() {
	}

	public Pagamento(long idpagamento, String nome) {
		this.idpagamento = idpagamento;
		this.nome = nome;
	}

	public Pagamento(long idpagamento, String nome,
			Set<Scarico> scaricosForPagamento,
			Set<Scarico> scaricosForIdpagamento) {
		this.idpagamento = idpagamento;
		this.nome = nome;
		this.scaricosForPagamento = scaricosForPagamento;
		this.scaricosForIdpagamento = scaricosForIdpagamento;
	}

	public long getIdpagamento() {
		return this.idpagamento;
	}

	public void setIdpagamento(long idpagamento) {
		this.idpagamento = idpagamento;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Set<Scarico> getScaricosForPagamento() {
		return this.scaricosForPagamento;
	}

	public void setScaricosForPagamento(Set<Scarico> scaricosForPagamento) {
		this.scaricosForPagamento = scaricosForPagamento;
	}

	public Set<Scarico> getScaricosForIdpagamento() {
		return this.scaricosForIdpagamento;
	}

	public void setScaricosForIdpagamento(Set<Scarico> scaricosForIdpagamento) {
		this.scaricosForIdpagamento = scaricosForIdpagamento;
	}

}
