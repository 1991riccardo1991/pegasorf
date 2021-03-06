package rf.pegaso.db.tabelle;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import rf.pegaso.db.exception.CodiceBarreInesistente;
import rf.utility.db.DBManager;

public class DettaglioOrdine {

	private int idArticolo;
	private String codiceBarre;
	private int idOrdine;
	private String descrizione;
	private String um;
	private double qta;
	private double disponibilita;
	private double prezzoAcquisto;
	private double prezzoVendita;
	private int iva;
	private int sconto;

	private DBManager dbm;


	public DettaglioOrdine() {
		this.idArticolo = 0;
		this.codiceBarre = "";
		this.idOrdine = 0;
		this.descrizione = "";
		this.um = "";
		this.qta = 0;
		disponibilita = 0;
		this.prezzoAcquisto = 0.0;
		this.prezzoVendita = 0.0;
		this.iva = 0;
		this.sconto = 0;
		this.dbm = DBManager.getIstanceSingleton();
	}

	public int getIdArticolo() {
		return idArticolo;
	}

	public void setIdArticolo(int codice) {
		this.idArticolo = codice;
	}

	public int getIdVendita() {
		return idOrdine;
	}

	public void setIdVendita(int codice) {
		this.idOrdine = codice;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public double getPrezzoAcquisto() {
		return prezzoAcquisto;
	}

	public void setPrezzoAcquisto(double prezzoAcquisto) {
		this.prezzoAcquisto = prezzoAcquisto;
	}

	public double getPrezzoVendita() {
		return prezzoVendita;
	}

	public void setPrezzoVendita(double prezzoVendita) {
		this.prezzoVendita = prezzoVendita;
	}

	public int getSconto() {
		return sconto;
	}

	public void setSconto(int sconto) {
		this.sconto = sconto;
	}

	public int getIva() {
		return iva;
	}

	public void setIva(int iva) {
		this.iva = iva;
	}

	public String getCodiceBarre() {
		return codiceBarre;
	}

	public void setCodiceBarre(String codiceBarre) {
		this.codiceBarre = codiceBarre;
	}

	public String getUm() {
		return um;
	}

	public void setUm(String um) {
		this.um = um;
	}

	public double getQta() {
		return qta;
	}

	public void setQta(double qta) {
		this.qta = qta;
	}

	public double getDisponibilita() {
		return disponibilita;
	}

	public void setDisponibilita(double disponibilita) {
		this.disponibilita = disponibilita;
	}

	/**
	 * Questo metodo carica in memoria i dettagli di un articolo
	 * identificato tramite il codice a barre
	 *
	 * @param codice
	 * @return int per verifica
	 */
	public int loadByCB(String codice){
		//verifichiamo che il codice inserito sia valido
		if (codice.equalsIgnoreCase(""))
			return -1;
		//carichiamo l'articolo in memoria
		Articolo a = new Articolo();
		try {
			if (a.findByCodBarre(codice)) {
				if ( a.getGiacenza2() < 1 )
					return 0;
				idArticolo = a.getIdArticolo();
				descrizione = a.getDescrizione();
				UnitaDiMisura udm = new UnitaDiMisura();
				udm.caricaDati(a.getUm());
				um = udm.getNome();
				prezzoAcquisto = a.getPrezzoAcquisto();
				prezzoVendita = a.getPrezzoIngrosso();
				codiceBarre = a.getCodBarre();
				iva = a.getIva();
				qta = 1.0;
				disponibilita = a.getGiacenza2() - 1;
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (CodiceBarreInesistente e1) {
			e1.printStackTrace();
		}
		return 1;
	}

	/**
	 * Questo metodo carica in memoria i dettagli di un articolo
	 * identificato tramite l'indice identificativo
	 *
	 * @param id
	 * @return int per verifica
	 */
	public int loadByID(int id){
		//viene verificato il codice inserito
		if ( id == 0 )
			return -1;
		Articolo a = new Articolo();
		try {
			a.caricaDati(id);
			if ( a.getGiacenza2() < 1 )
				return 0;
			idArticolo = a.getIdArticolo();
			descrizione = a.getDescrizione();
			UnitaDiMisura udm = new UnitaDiMisura();
			udm.caricaDati(a.getUm());
			um = udm.getNome();
			prezzoAcquisto = a.getPrezzoAcquisto();
			prezzoVendita = a.getPrezzoIngrosso();
			codiceBarre = a.getCodBarre();
			iva = a.getIva();
			qta = 1;
			disponibilita = a.getGiacenza2() - 1;
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return 1;
	}

	/**
	 * Questo metodo verifica se un dettaglio_ordine �
	 * gi� stato inserito nel db
	 *
	 * @param codice
	 * @return int per verifica
	 * @throws SQLException
	 */
	public boolean isInsert() throws SQLException{
		Statement st = dbm.getNewStatement();
		ResultSet rs = null;
		String query = "select * from dettaglio_ordini where idordine=" + idOrdine +"and idarticolo="+idArticolo;
		rs = st.executeQuery(query);
		rs.last();
		int nRow = rs.getRow();
		if (nRow <= 0)
			return false;
		return true;
	}

	/**
	 * Questo metodo rimuove dal db un articolo
	 * identificato tramite il codice a barre
	 *
	 * @param codice
	 * @return int
	 */
	public int remove(String codice){
		return -1;
	}

	/**
	 * Questo metodo inserisce nel db un nuovo dettaglio ordine
	 *
	 * @return int per verifica
	 */
	public int insert(){
		PreparedStatement pst = null;
		try{
			String insert = "insert into dettaglio_ordini values (?,?,?,?,?,?,?)";

			pst = dbm.getNewPreparedStatement(insert);
			pst.setInt(2, idArticolo);
			pst.setInt(1, idOrdine);
			pst.setDouble(3, qta);
			pst.setInt(4, sconto);
			pst.setDouble(5, prezzoAcquisto);
			pst.setDouble(6, prezzoVendita);
			pst.setInt(7, iva);
			pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -1;
			}
		}
		return 1;
	}

	/**
	 * Questo metodo aggiorno un dettaglio ordine gi� presente nel db
	 *
	 * @param codice
	 * @return
	 */
	public int update(){
		PreparedStatement pst = null;
		double qtaIniziale = 0;
		try{
//			Statement st = dbm.getNewStatement();
//			ResultSet rs = null;
//			String query = "select * from dettaglio_ordini where idordine=" + idOrdine +"and idarticolo="+idArticolo;
//			rs = st.executeQuery(query);
//			while ( rs.next() ){
//				qtaIniziale = rs.getDouble("qta");
//			}
			String insert = "update dettaglio_ordini set qta=?,prezzo_acquisto=?,prezzo_vendita=?,sconto=? where idordine=? and idarticolo=?";
			pst = dbm.getNewPreparedStatement(insert);
			pst.setDouble(1, qta);
			pst.setDouble(2, prezzoAcquisto);
			pst.setDouble(3, prezzoVendita);
			pst.setInt(4, sconto);
			pst.setInt(5, idOrdine);
			pst.setInt(6, idArticolo);

			pst.executeUpdate();
			//updateArticolo(qtaIniziale);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -1;
			}
		}
		return 1;
	}

	/**
	 * Questo metodo carica dal db tutti i dettagli ordine all'interno di un Vector
	 *
	 * @param id
	 * @return Vector di dettaglio_ordine
	 */
	public Vector<DettaglioOrdine> caricaDatiByDB(int id) throws SQLException {
		Vector<DettaglioOrdine> dettaglioVendite = new Vector<DettaglioOrdine>();
		Statement st = null;
		ResultSet rs = null;
		String query = "select * from dettaglio_ordini where idordine=" + id;
		st = dbm.getNewStatement();
		rs = st.executeQuery(query);
		while( rs.next()) {
			DettaglioOrdine dv = new DettaglioOrdine();
			dv.setIdVendita(rs.getInt(1));
			dv.setIdArticolo(rs.getInt(2));
			dv.setQta(rs.getDouble(3));
			dv.setSconto(rs.getInt(4));
			dv.setPrezzoAcquisto(rs.getDouble(5));
			dv.setPrezzoVendita(rs.getDouble(6));
			dv.setIva(rs.getInt(7));
			Articolo a = new Articolo();
			a.caricaDati(dv.getIdArticolo());
			dv.setDescrizione(a.getDescrizione());
			dv.setCodiceBarre(a.getCodBarre());
			dv.setDisponibilita(a.getGiacenza());
			UnitaDiMisura udm = new UnitaDiMisura();
			udm.caricaDati(a.getUm());
			dv.setUm(udm.getNome());
			dettaglioVendite.add(dv);

		}
		return dettaglioVendite;
	}

	/*public int salvaInDb(String tabella){
		PreparedStatement pst = null;
		try{
			//CODICE SERGIO----------------------------------------------
//			String insert = "insert into "+tabella+" values (?,?,?,?,?)";
//			if ( !tabella.equals("banco") )
//				insert = "insert into "+tabella+" values (?,?,?,?,?,?)";
			//FINE SERGIO------------------------------------------------

			//CODICE ROCCO-----------------------------------------------
			String insert="";
			if ( !tabella.equals("dettaglio_banco") )
				insert = "insert into "+tabella+" values (?,?,?,?,?,?)";
			else insert = "insert into "+tabella+" values (?,?,?,?,?)";
			//FINE ROCCO-------------------------------------------------

			pst = dbm.getNewPreparedStatement(insert);
			pst.setInt(2, idArticolo);
			pst.setInt(1, idOrdine);
			pst.setDouble(3, qta);
			pst.setDouble(4, prezzoAcquisto);
			pst.setDouble(5, prezzoVendita);
			if ( !tabella.equals("dettaglio_banco") )
				pst.setInt(6, sconto);

			pst.executeUpdate();
			//---ROCCO--------------
			//update viene effettuato con la classe scarico
			//nel passaggio precedente
			//updateArticolo(0);
			//---FINE ROCCO---------

		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -1;
			}
		}
		return 1;
	}

	/*public int updateDettaglioInDb(String tabella, String colonna){
		PreparedStatement pst = null;
		double qtaIniziale = 0;
		try{
			Statement st = dbm.getNewStatement();
			ResultSet rs = null;
			String query = "select * from "+tabella+" where id"+colonna+"=" + idOrdine +"and idarticolo="+idArticolo;
			rs = st.executeQuery(query);
			while ( rs.next() ){
				qtaIniziale = rs.getDouble("qta");
			}
			String insert = "update "+tabella+" set qta=?,prezzo_acquisto=?,prezzo_vendita=? where id"+colonna+"=? and idarticolo=?";
			//"update dettaglio_carichi set qta=?,prezzo_acquisto=? where idcarico=? and idarticolo=?";
			if ( !tabella.equals("banco") )
				insert = "update "+tabella+" set qta=?,prezzo_acquisto=?,prezzo_vendita=?,sconto=? where id"+colonna+"=? and idarticolo=?";
			pst = dbm.getNewPreparedStatement(insert);
			pst.setDouble(1, qtaIniziale-qta);
			pst.setDouble(2, prezzoAcquisto);
			pst.setDouble(3, prezzoVendita);
			if ( !tabella.equals("banco") ){
				pst.setInt(4, sconto);
				pst.setInt(5, idOrdine);
				pst.setInt(6, idArticolo);
			}
			else{
				pst.setInt(4, idOrdine);
				pst.setInt(5, idArticolo);
			}

			pst.executeUpdate();
			updateArticolo(qtaIniziale);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return -1;
			}
		}
		return 1;
	}*/

	/**
	 * Questo metodo aggiorno la disponibilit� degli articoli
	 * dopo l'inserimento di un dettaglio ordini
	 *
	 * @param quantit� presente nel db prima di effettuare l'inserimento
	 */
	public void updateArticolo(double qtaIniziale)
	throws SQLException {
		String query = "update dettaglio_carichi set qta=? where idarticolo=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);

		pst.setDouble(1, (qta - qtaIniziale ));
		pst.setInt(2, idArticolo);

		// inserimento
		pst.executeUpdate();

		if (pst != null)
			pst.close();
	}

	public Vector<Object> trasformaInArray() {
		Vector<Object> v = new Vector<Object>();
		v.add(idArticolo);
		v.add(codiceBarre);
		v.add(descrizione);
		v.add(um);
		v.add(qta);
		v.add(disponibilita);
		v.add(prezzoAcquisto);
		v.add(prezzoVendita);
		if ( sconto == 0)
			v.add(prezzoVendita*qta);
		else
			v.add((prezzoVendita*qta)-(((prezzoVendita*qta)/100)*sconto));
		v.add(sconto);
		v.add(iva);
		return v;
	}

	public boolean equals(DettaglioOrdine o){
		return this.getIdArticolo()==o.getIdArticolo();
	}
}
