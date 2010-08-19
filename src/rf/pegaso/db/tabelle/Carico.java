/**
 *
 */
package rf.pegaso.db.tabelle;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;

import rf.pegaso.db.exception.ResultSetVuoto;
import rf.pegaso.db.tabelle.exception.NumeroCaricoEsistente;
import rf.utility.db.DBManager;
import rf.utility.db.MyResultSet;
import rf.utility.db.eccezzioni.IDNonValido;

/**
 * @author Hunter
 *
 */
public class Carico {
	private int iva_doc = 1;

	/**
	 * @param dbm2
	 * @param text
	 * @param i
	 * @return
	 * @throws SQLException
	 */
	public static boolean codiceBarrePresenteInScarico(String codbarre,
			int idcarico) throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		String query = "select codbarre from articoli_caricati_view where codbarre=? and idcarico=?";
		PreparedStatement st = dbm.getNewPreparedStatement(query);
		st.setString(1, codbarre);
		st.setInt(2, idcarico);
		rs = st.executeQuery();
		rs.next();
		boolean trovato = false;
		if (rs.getRow() < 1)
			trovato = false;
		else
			trovato = true;
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return trovato;
	}
	
	public static boolean idArticoloPresenteInScarico(int idArticolo, int idcarico) throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		String query = "select codbarre from articoli_caricati_view where idarticolo=? and idcarico=?";
		PreparedStatement st = dbm.getNewPreparedStatement(query);
		st.setInt(1, idArticolo);
		st.setInt(2, idcarico);
		rs = st.executeQuery();
		rs.next();
		boolean trovato = false;
		if (rs.getRow() < 1)
			trovato = false;
		else
			trovato = true;
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return trovato;
	}

	private Date dataCarico;

	private Date dataDocumento;

	private DBManager dbm;

	private int idCarico;

	private int idDocumento;

	private int idFornitore;

	private String note;

	private String numDocumento;

	private Time oraCarico;

	private double totDocumento = 0;

	private int sospeso;

	private int rifDoc = -1;

	private int primaNota;

	private int sconto;
	
	private int riferimentoOrdine;

	public Carico() {
		this.dbm = DBManager.getIstanceSingleton();
	}

	public void caricaDati(int idCarico) throws SQLException {
		Statement st = null;
		ResultSet rs = null;
		String query = "select * from carico where idcarico=" + idCarico;
		st = dbm.getNewStatement();
		rs = st.executeQuery(query);
		if(rs.next()){
			this.idCarico = rs.getInt("idcarico");
			this.idFornitore = rs.getInt("idfornitore");
			this.dataCarico = rs.getDate("data_carico");
			this.oraCarico = rs.getTime("ora_carico");
			this.note = rs.getString("note");
			this.dataDocumento = rs.getDate("data_documento");
			this.idDocumento = rs.getInt("iddocumento");
			this.numDocumento = rs.getString("num_documento");
			this.totDocumento = rs.getDouble("totale_documento");
			this.sospeso = rs.getInt("sospeso");
			this.rifDoc = rs.getInt("rif_doc");
			this.iva_doc=rs.getInt("iva_documento");
			this.sconto=rs.getInt("sconto");
			this.primaNota=rs.getInt("ins_pn");
			this.riferimentoOrdine=rs.getInt("riferimento_ordine");
		}
		
		if (st != null)
			st.close();
	}
	
	public Object [] getQtaPrezzoArticoloCaricata(int idarticolo) throws SQLException{
		Object [] obj = new Object[2];
		Statement st = null;
		ResultSet rs = null;
		String query = "select qta, prezzo_acquisto from dettaglio_carico where idcarico = " + idCarico +" and idarticolo = "+idarticolo;
		st = dbm.getNewStatement();
		rs = st.executeQuery(query);
		if(rs.next()){
			obj[0] = rs.getInt("qta");
			obj[1] = rs.getDouble("prezzo_acquisto");
		}
		
		if (st != null)
			st.close();
		return obj;
	}

	public int getSconto() {
		return sconto;
	}

	public void setSconto(int sconto) {
		this.sconto = sconto;
	}

	public void deleteAllArticoliCaricati() throws SQLException {
		String query = "delete from dettaglio_carico where idcarico="
				+ idCarico;
		Statement st = dbm.getNewStatement();
		st.executeUpdate(query);
		if (st != null)
			st.close();
		dbm.notifyDBStateChange();
	}

	public void deleteArticolo(int idArticolo) throws SQLException {
		String query = "delete from dettaglio_carico where idArticolo=? and idCarico=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, idArticolo);
		pst.setInt(2, idCarico);
		// inserimento
		pst.executeUpdate();
		updateTotDocumentoIvato(this.idCarico);
		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public int deleteCarico(int idCarico) throws IDNonValido {

		if(idCarico==0){
			return -1;
		}
		String delete = "";
		Statement st = dbm.getNewStatement();
		int cancellati = 0;
		if (idCarico <= -1)
			throw new IDNonValido();
		delete = "DELETE FROM carico WHERE idcarico=" + idCarico;

		try {
			cancellati = st.executeUpdate(delete);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (st != null)
					st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		dbm.notifyDBStateChange();
		return cancellati;
	}

	public Object[][] getAllArticoliCaricati() throws SQLException {
		String query = "SELECT A.codBarre, A.descrizione, A.iva, A.um, D.qta, D.prezzo_Acquisto "
				+ "FROM Articolo AS A, carico AS C, Dettaglio_carico AS D, Fornitore AS F "
				+ "WHERE A.idArticolo=D.idArticolo AND C.idCarico=D.idCarico AND C.idFornitore=F.idFornitore";

		Statement pst = dbm.getNewStatement();
		ResultSet rs = pst.executeQuery(query);
		MyResultSet mrs = new MyResultSet(rs);
		Object[][] o = mrs.getAllObject();
		if (pst != null)
			pst.close();
		if (rs != null)
			rs.close();
		return o;
	}
	
	public Object[][] getAllArticoliCaricatiByIdDocumento(long id) throws SQLException {
		String query = "SELECT A.idarticolo, a.codFornitore, A.codBarre, A.descrizione, A.iva, A.um, D.qta, D.prezzo_Acquisto "
				+ "FROM Articolo AS A, carico AS C, Dettaglio_carico AS D, Fornitore AS F "
				+ "WHERE A.idArticolo=D.idArticolo AND C.idCarico=D.idCarico AND C.idFornitore=F.idFornitore and C.idcarico="+id;

		Statement pst = dbm.getNewStatement();
		ResultSet rs = pst.executeQuery(query);
		MyResultSet mrs = new MyResultSet(rs);
		Object[][] o = mrs.getAllObject();
		if (pst != null)
			pst.close();
		if (rs != null)
			rs.close();
		return o;
	}
	
	

	/**
	 * @return the dataCarico
	 */
	public Date getDataCarico() {
		return dataCarico;
	}

	public Date getDataDocumento() {
		return dataDocumento;
	}

	/**
	 * @return the idCarico
	 */
	public int getIdCarico() {
		return idCarico;
	}

	public int getIdDocumento() {
		return idDocumento;
	}

	/**
	 * @return the idFornitore
	 */
	public int getIdFornitore() {
		return idFornitore;
	}

	/**
	 *
	 */
	public int getNewID() {
		return dbm.getNewID("carico", "idCarico");

	}

	public static double getTotIngrossoImposta(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum((prezzo_acquisto/100*iva)*qta) from articoli_caricati_view where idcarico="
				+ idScarico2;
		rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}


	/**
	 * @param i
	 * @return
	 * @throws SQLException
	 */
	public static boolean isNumeroCaricoEsistente(String numDocumento) throws SQLException,NumeroCaricoEsistente {
		DBManager dbm = DBManager.getIstanceSingleton();
		Statement st = dbm.getNewStatement();
		ResultSet rs = null;
		String query = "select num_documento from carico where num_documento='" + numDocumento+"'";
		rs = st.executeQuery(query);
		rs.last();
		int nRow = rs.getRow();
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		if (nRow <= 0)
			return false;
		return true;
	}

	public static double getTotIngrossoImponibile(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(prezzo_acquisto*qta) from articoli_caricati_view where idcarico="
				+ idScarico2;
		rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}

	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}

	public String getNumDocumento() {
		return numDocumento;
	}

	/**
	 * @return the oraCarico
	 */
	public Time getOraCarico() {
		return oraCarico;
	}

	/**
	 * @param idArticolo
	 * @return
	 * @throws SQLException
	 * @throws IDNonValido
	 * @throws ResultSetVuoto
	 */
	public double getQuantitaCaricata(int idArticolo) throws SQLException,
			IDNonValido, ResultSetVuoto {
		if (this.idCarico <= 0)
			throw new IDNonValido();
		String query = "select qta from dettaglio_carico where idarticolo=? and idcarico=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, idArticolo);
		pst.setInt(2, this.idCarico);
		ResultSet rs = pst.executeQuery();
		double qta=0;
		while(rs.next()){
			qta = rs.getDouble(1);
		}
		if (pst != null)
			pst.close();
		if (rs != null)
			rs.close();
		return qta;
	}

	public boolean haArticoli() throws SQLException,
			IDNonValido, ResultSetVuoto {
		if (this.idCarico < 0)
			throw new IDNonValido();
		String query = "select * from dettaglio_carico where idcarico=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, this.idCarico);
		ResultSet rs = pst.executeQuery();
		rs.next();
		boolean ha=true;
		if (rs.getRow() < 1)
			ha=false;
		if (pst != null)
			pst.close();
		return ha;
	}

	public void insertArticolo(int idArticolo, double qta, double prezzoAcquisto)
			throws SQLException {

		String query = "insert into dettaglio_carico values(?,?,?,?)";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, idArticolo);
		pst.setInt(2, idCarico);
		pst.setDouble(3, qta);
		pst.setDouble(4, prezzoAcquisto);

		// inserimento
		pst.executeUpdate();
		updateTotDocumentoIvato(idCarico);
		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public void updateTotDocumentoIvato(int id) throws SQLException {
		String query = "update carico set totale_documento=? where idcarico=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		double tot=Carico.getTotIngrossoImponibile(id)+ Carico.getTotIngrossoImposta(id);
		Carico c=new Carico();
		c.caricaDati(id);
		int sconto=c.getSconto();
		if(sconto>0){
			tot-=(tot/100*sconto);
		}
		pst.setDouble(1,tot );
		pst.setInt(2, id);
		// inserimento
		pst.executeUpdate();

		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();

	}

	public int insertCarico() {

		idCarico = dbm.getNewID("carico", "idCarico");
		int ok = 0;
		PreparedStatement pst = null;
		String update = "insert into carico values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		// preleviamo la data di inserimento
		// e la impostiamo nelle proprietà
		java.util.Date data = new java.util.Date();
		// this.dataCarico = new Date(data.getTime());
		this.dataDocumento = dataDocumento;
		this.oraCarico = new Time(data.getTime());
		pst = dbm.getNewPreparedStatement(update);
		try {
			pst.setInt(1, idCarico);
			pst.setInt(2, idFornitore);
			pst.setDate(3, dataCarico);
			pst.setTime(4, oraCarico);
			pst.setString(5, note);
			pst.setInt(6, idDocumento);
			pst.setString(7, numDocumento);
			pst.setDate(8,this.dataDocumento);
			pst.setDouble(9, totDocumento);
			pst.setInt(10, this.sospeso);
			pst.setInt(11, this.rifDoc);
			pst.setInt(12, this.sconto);
			pst.setInt(13, this.iva_doc);
			pst.setInt(14, this.primaNota);
			pst.setInt(15, this.riferimentoOrdine);

			ok = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		dbm.notifyDBStateChange();
		return ok;
	}

	/**
	 * @param i
	 * @return
	 * @throws SQLException
	 */
	public boolean isInsert(int idcarico) throws SQLException {
		Statement st = dbm.getNewStatement();
		ResultSet rs = null;
		String query = "select * from carico where idcarico=" + idcarico;
		rs = st.executeQuery(query);
		rs.last();
		int nRow = rs.getRow();
		if (nRow <= 0)
			return false;
		return true;
	}

	/**
	 * @param dataCarico
	 *            the dataCarico to set
	 */
	public void setDataCarico(Date dataCarico) {
		this.dataCarico = dataCarico;
	}

	public void setDataDocumento(Date dataDocumento) {
		this.dataDocumento = dataDocumento;
	}

	/**
	 * @param idCarico
	 *            the idCarico to set
	 */
	public void setIdCarico(int idCarico) {
		this.idCarico = idCarico;
	}

	public void setIdDocumento(int idDocumento) {
		this.idDocumento = idDocumento;
	}

	/**
	 * @param idFornitore
	 *            the idFornitore to set
	 */
	public void setIdFornitore(int idFornitore) {
		this.idFornitore = idFornitore;
	}

	/**
	 * @param note
	 *            the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}

	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}

	/**
	 * @param oraCarico
	 *            the oraCarico to set
	 */
	public void setOraCarico(Time oraCarico) {
		this.oraCarico = oraCarico;
	}

	public void updateArticolo(int idArticolo, double qta, double prezzoAcquisto)
			throws SQLException {

		String query = "update dettaglio_carico set qta=?,prezzo_acquisto=? where idcarico=? and idarticolo=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);

		pst.setDouble(1, qta);
		pst.setDouble(2, prezzoAcquisto);
		pst.setInt(3, idCarico);
		pst.setInt(4, idArticolo);

		// inserimento
		pst.executeUpdate();
		updateTotDocumentoIvato(idCarico);
		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public int updateCarico() throws IDNonValido {

		if (idCarico <= -1)
			throw new IDNonValido();
		int ok = 0;
		PreparedStatement pst = null;
		String update = "UPDATE carico SET idcarico=?,"
				+ "idfornitore=?,data_carico=?,ora_carico=?,note=?,iddocumento=?,num_documento=?,data_documento=?,totale_documento=?,sospeso=?,rif_doc=?,sconto=?,iva_documento=?,ins_pn=?,riferimento_ordine=? WHERE idcarico=?";
		 dataCarico = new Date(new java.util.Date().getTime());
		 oraCarico = new Time(new java.util.Date().getTime());
		pst = dbm.getNewPreparedStatement(update);
		try {
			pst.setInt(1, this.idCarico);
			pst.setInt(2, idFornitore);
			pst.setDate(3, dataCarico);
			pst.setTime(4, oraCarico);
			pst.setString(5, this.note);
			pst.setInt(6, idDocumento);
			pst.setString(7, numDocumento);
			pst.setDate(8, dataDocumento);
			pst.setDouble(9, this.totDocumento);
			pst.setInt(10, sospeso);
			pst.setInt(11, rifDoc);
			pst.setInt(12, this.sconto);
			pst.setInt(13, this.iva_doc);
			pst.setInt(14, primaNota);
			pst.setInt(15, this.riferimentoOrdine);
			pst.setInt(16, this.idCarico);

			ok = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		dbm.notifyDBStateChange();
		return ok;
	}

	public void setTotaleDocumentoIvato(double totaleIvato) {
		this.totDocumento = totaleIvato;

	}

	public double getTotaleIvato() {
		// TODO Auto-generated method stub
		return this.totDocumento;
	}

	public static double getTotAcquistoImponibileByOrder(int id)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(qta*prezzo_acquisto-((qta*prezzo_acquisto)/100*sconto)) from articoli_caricati_view where idcarico="
				+ id;
		rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}

	public static double getTotAcquistoImpostaByOrder(int idScarico)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(((prezzo_acquisto-(prezzo_acquisto/100*sconto))/100*iva)*qta) from articoli_caricati_view where idcarico="
				+ idScarico;
		rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}

	public void setSospeso(int sospeso) {
		this.sospeso = sospeso;

	}

	public int getSospeso() {
		// TODO Auto-generated method stub
		return this.sospeso;
	}

	public void setRiferimentoDoc(int idCarico2) {
		this.rifDoc = idCarico2;

	}

	public int getRiferimentoDoc() {
		return this.rifDoc;

	}

	public void moveCaricoToRiferimentoDoc() throws SQLException {
		if (rifDoc == -1)
			return;
		String query = "update dettaglio_carico set idcarico=? where idcarico=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, this.rifDoc);
		pst.setInt(2, idCarico);
		// inserimento
		pst.executeUpdate();

		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public void switchCarico() throws SQLException, IDNonValido, ResultSetVuoto {
		if (rifDoc == -1)
			return;
		if(haArticoli())
			return;
		String query = "update dettaglio_carico set idcarico=? where idcarico=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, this.idCarico);
		pst.setInt(2, rifDoc);
		// inserimento
		pst.executeUpdate();

		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public void setInsertByPN(int i) {
		this.primaNota=i;

	}

	public int getInsertByPN(){
		return primaNota;
	}

	public static double getTotAcquistoImponibileByPrimaNota() throws SQLException, IDNonValido, ResultSetVuoto {
		double tot=0.0;
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String queryID="select idcarico from carico where iddocumento=1 or iddocumento=3 or iddocumento=4";
		//String query = "select sum(totale_documento-(totale_documento/100*iva_documento)) from ordini where tipo_documento=1 or tipo_documento=3 or tipo_documento=4";
		rs = st.executeQuery(queryID);
		while(rs.next()){
			int id=rs.getInt(1);
			Carico c=new Carico();
			c.caricaDati(id);
			if(c.haArticoli()){
				tot+=Carico.getTotAcquistoImponibileByOrder(id);
			}else{

				tot+=(c.getTotaleIvato()-(c.getTotaleIvato()*c.getIva_doc()/(100+c.getIva_doc())));
			}
		}
		//double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}


	public static double getTotAcquistoImpostaByPrimaNota() throws SQLException, IDNonValido, ResultSetVuoto {
		double tot=0.0;
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String queryID="select idcarico from carico where iddocumento=1 or iddocumento=3 or iddocumento=4";
		//String query = "select sum(totale_documento-(totale_documento/100*iva_documento)) from ordini where tipo_documento=1 or tipo_documento=3 or tipo_documento=4";
		rs = st.executeQuery(queryID);
		while(rs.next()){
			int id=rs.getInt(1);
			Carico c=new Carico();
			c.caricaDati(id);
			if(c.haArticoli()){
				tot+=Carico.getTotAcquistoImpostaByOrder(id);
			}else{
				tot+=(c.getTotaleIvato()*c.getIva_doc()/(100+c.getIva_doc()));
			}
		}
		//double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}




	public int getIva_doc() {
		return iva_doc;
	}

	public void setIva_doc(int iva_doc) {
		this.iva_doc = iva_doc;
	}

	public int getRiferimentoOrdine() {
		return riferimentoOrdine;
	}

	public void setRiferimentoOrdine(int riferimentoOrdine) {
		this.riferimentoOrdine = riferimentoOrdine;
	}





}
