package it.infolabs.hibernate;

// Generated 23-lug-2009 0.07.34 by Hibernate Tools 3.2.4.GA

import java.util.HashSet;
import java.util.Set;

/**
 * Pagamento generated by hbm2java
 */
public class Pagamento implements java.io.Serializable {

	private long idpagamento;
	private String nome;
	private Set<Scarico> ordinisForPagamento = new HashSet<Scarico>(0);
	private Set<Scarico> ordinisForPagamento_1 = new HashSet<Scarico>(0);
	private Set<Scarico> ordinisForIdpagamento = new HashSet<Scarico>(0);
	private Set<Scarico> ordinisForPagamento_2 = new HashSet<Scarico>(0);
	private Set<Scarico> ordinisForIdpagamento_1 = new HashSet<Scarico>(0);
	private Set<Scarico> ordinisForIdpagamento_2 = new HashSet<Scarico>(0);

	public Pagamento() {
	}

	public Pagamento(long idpagamento, String nome) {
		this.idpagamento = idpagamento;
		this.nome = nome;
	}

	public Pagamento(long idpagamento, String nome,
			Set<Scarico> ordinisForPagamento, Set<Scarico> ordinisForPagamento_1,
			Set<Scarico> ordinisForIdpagamento,
			Set<Scarico> ordinisForPagamento_2,
			Set<Scarico> ordinisForIdpagamento_1,
			Set<Scarico> ordinisForIdpagamento_2) {
		this.idpagamento = idpagamento;
		this.nome = nome;
		this.ordinisForPagamento = ordinisForPagamento;
		this.ordinisForPagamento_1 = ordinisForPagamento_1;
		this.ordinisForIdpagamento = ordinisForIdpagamento;
		this.ordinisForPagamento_2 = ordinisForPagamento_2;
		this.ordinisForIdpagamento_1 = ordinisForIdpagamento_1;
		this.ordinisForIdpagamento_2 = ordinisForIdpagamento_2;
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

	public Set<Scarico> getOrdinisForPagamento() {
		return this.ordinisForPagamento;
	}

	public void setOrdinisForPagamento(Set<Scarico> ordinisForPagamento) {
		this.ordinisForPagamento = ordinisForPagamento;
	}

	public Set<Scarico> getOrdinisForPagamento_1() {
		return this.ordinisForPagamento_1;
	}

	public void setOrdinisForPagamento_1(Set<Scarico> ordinisForPagamento_1) {
		this.ordinisForPagamento_1 = ordinisForPagamento_1;
	}

	public Set<Scarico> getOrdinisForIdpagamento() {
		return this.ordinisForIdpagamento;
	}

	public void setOrdinisForIdpagamento(Set<Scarico> ordinisForIdpagamento) {
		this.ordinisForIdpagamento = ordinisForIdpagamento;
	}

	public Set<Scarico> getOrdinisForPagamento_2() {
		return this.ordinisForPagamento_2;
	}

	public void setOrdinisForPagamento_2(Set<Scarico> ordinisForPagamento_2) {
		this.ordinisForPagamento_2 = ordinisForPagamento_2;
	}

	public Set<Scarico> getOrdinisForIdpagamento_1() {
		return this.ordinisForIdpagamento_1;
	}

	public void setOrdinisForIdpagamento_1(Set<Scarico> ordinisForIdpagamento_1) {
		this.ordinisForIdpagamento_1 = ordinisForIdpagamento_1;
	}

	public Set<Scarico> getOrdinisForIdpagamento_2() {
		return this.ordinisForIdpagamento_2;
	}

	public void setOrdinisForIdpagamento_2(Set<Scarico> ordinisForIdpagamento_2) {
		this.ordinisForIdpagamento_2 = ordinisForIdpagamento_2;
	}

}
