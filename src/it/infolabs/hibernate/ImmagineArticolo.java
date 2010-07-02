package it.infolabs.hibernate;

// Generated 3-lug-2010 0.38.48 by Hibernate Tools 3.2.4.GA

/**
 * ImmagineArticolo generated by hbm2java
 */
public class ImmagineArticolo implements java.io.Serializable {

	private long id;
	private Articolo articolo;
	private String nome;
	private String estensione;
	private byte[] file;

	public ImmagineArticolo() {
	}

	public ImmagineArticolo(long id, String nome) {
		this.id = id;
		this.nome = nome;
	}

	public ImmagineArticolo(long id, Articolo articolo, String nome,
			String estensione, byte[] file) {
		this.id = id;
		this.articolo = articolo;
		this.nome = nome;
		this.estensione = estensione;
		this.file = file;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Articolo getArticolo() {
		return this.articolo;
	}

	public void setArticolo(Articolo articolo) {
		this.articolo = articolo;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEstensione() {
		return this.estensione;
	}

	public void setEstensione(String estensione) {
		this.estensione = estensione;
	}

	public byte[] getFile() {
		return this.file;
	}

	public void setFile(byte[] file) {
		this.file = file;
	}

}
