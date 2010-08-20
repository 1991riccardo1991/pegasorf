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
import java.util.Vector;

import rf.pegaso.db.exception.ResultSetVuoto;
import rf.pegaso.db.tabelle.exception.NumeroOrdineEsistente;
import rf.utility.Constant;
import rf.utility.db.DBManager;
import rf.utility.db.eccezzioni.IDNonValido;

/**
 * @author Hunter
 *
 */
public class Scarico {
	public static boolean codiceBarrePresenteInScarico(String codbarre,
			int idordine) throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		String query = "select codbarre from articoli_scaricati_view where codbarre=? and idordine=?";
		PreparedStatement st = dbm.getNewPreparedStatement(query);
		st.setString(1, codbarre);
		st.setInt(2, idordine);
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

	public static int getMaxID() {
		DBManager dbm = DBManager.getIstanceSingleton();
		return dbm.getNewID("scarico", "idordine") - 1;
	}

	public static double getTotDettaglioImponibile(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(prezzo_dettaglio*qta) from articoli_scaricati_view where idordine="
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

	public static double getTotDettaglioImposta(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum((prezzo_dettaglio/100*iva)*qta) from articoli_scaricati_view where idordine="
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

	public static double getTotIngrossoImponibile(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(prezzo_ingrosso*qta) from articoli_scaricati_view where idordine="
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

	public static double getTotAcquistoImponibileByOrder(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(prezzo_acquisto*qta) from articoli_scaricati_view where idordine="
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

	public static double getTotAcquistoImponibileAllOrders(java.util.Date start, java.util.Date end, int idReparto, String dalle, String alle)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		PreparedStatement pst;
		String query;
		if ( start != null && idReparto != -1 ){
//			query = "select sum(prezzo_vendita*qta) from articoli_scaricati_view where data_ordine >=? and data_ordine <= ?";
			query = "select sum(d.prezzo_vendita * d.qta) " +
					"from scarico o, dettaglio_scarico d, articolo a " +
					"where o.idordine = d.idordine " +
					"and a.idarticolo = d.idarticolo " +
					"and o.ora_ordine >= '"+dalle+"' and o.ora_ordine<='"+alle+"' " +
					"and a.idreparto = ? and data_ordine >= ? and data_ordine <= ?";
		}
		else if ( start != null ){
			query = "select sum(d.prezzo_vendita * d.qta) " +
			"from scarico o, dettaglio_scarico d, articolo a " +
			"where o.idordine = d.idordine " +
			"and a.idarticolo = d.idarticolo " +
			"and o.ora_ordine >= '"+dalle+"' and o.ora_ordine<='"+alle+"' " +
			"and data_ordine >= ? and data_ordine <= ?";
		}
		else{
			query = "select sum(prezzo_vendita*qta) from articoli_scaricati_view";
		}
		pst = dbm.getNewPreparedStatement(query);
		if ( start != null && idReparto != -1){
			pst.setInt(1, idReparto);
			pst.setDate(2, new java.sql.Date(start.getTime()));
			pst.setDate(3, new java.sql.Date(end.getTime()));
		}
		else if ( start != null ){
			pst.setDate(1, new java.sql.Date(start.getTime()));
			pst.setDate(2, new java.sql.Date(end.getTime()));
		}
		rs = pst.executeQuery();
//		rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}

	public static double getTotVenditeImponibileByPrimaNota()
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(totale_documento-(totale_documento*iva_documento/(100.0+iva_documento))) from scarico where tipo_documento=1 or tipo_documento=3 or tipo_documento=4";
		rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}

	public static double getTotVenditeImpostaByPrimaNota()
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum(totale_documento*iva_documento/(100.0+iva_documento)) from scarico where tipo_documento=1 or tipo_documento=3 or tipo_documento=4";
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
		String query = "select sum((prezzo_acquisto/100*iva)*qta) from articoli_scaricati_view where idordine="
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

//	public static double getTotAcquistoImpostaAllOrders() throws SQLException {
//		DBManager dbm = DBManager.getIstanceSingleton();
//		ResultSet rs = null;
//		Statement st = dbm.getNewStatement();
//		String query = "select sum((prezzo_acquisto/100*iva)*qta) from articoli_scaricati_view";
//		rs = st.executeQuery(query);
//		rs.next();
//		double tot = rs.getDouble(1);
//		if (st != null)
//			st.close();
//		if (rs != null)
//			rs.close();
//		return tot;
//	}
	
	public static double getTotAcquistoImpostaAllOrders(java.util.Date start, java.util.Date end, int idReparto, String dalle, String alle)
	throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		PreparedStatement pst;
		String query;
		if ( start != null && idReparto != -1 ){
			//	query = "select sum(prezzo_vendita*qta) from articoli_scaricati_view where data_ordine >=? and data_ordine <= ?";
			query = "select sum((d.prezzo_acquisto/100*d.iva)*d.qta) " +
			"from scarico o, dettaglio_scarico d, articolo a " +
			"where o.idordine = d.idordine " +
			"and a.idarticolo = d.idarticolo " +
			"and o.ora_ordine >= '"+dalle+"' and o.ora_ordine<='"+alle+"' " +
			"and a.idreparto = ? and data_ordine >= ? and data_ordine <= ?";
		}
		else if ( start != null ){
			query = "select sum((d.prezzo_acquisto/100*d.iva)*d.qta) " +
			"from scarico o, dettaglio_scarico d, articolo a " +
			"where o.idordine = d.idordine " +
			"and a.idarticolo = d.idarticolo " +
			"and o.ora_ordine >= '"+dalle+"' and o.ora_ordine<='"+alle+"' " +
			"and data_ordine >= ? and data_ordine <= ?";
		}
		else{
			query = "select sum((prezzo_acquisto/100*iva)*qta) from articoli_scaricati_view";
		}
		pst = dbm.getNewPreparedStatement(query);
		if ( start != null && idReparto != -1){
			pst.setInt(1, idReparto);
			pst.setDate(2, new java.sql.Date(start.getTime()));
			pst.setDate(3, new java.sql.Date(end.getTime()));
		}
		else if ( start != null ){
			pst.setDate(1, new java.sql.Date(start.getTime()));
			pst.setDate(2, new java.sql.Date(end.getTime()));
		}
		rs = pst.executeQuery();
		//rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}
	
	public static double getTotAgioAllOrders(java.util.Date start, java.util.Date end, int idReparto, String dalle, String alle)
	throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		PreparedStatement pst;
		String query;
		if ( start != null && idReparto != -1 ){
			//	query = "select sum(prezzo_vendita*qta) from articoli_scaricati_view where data_ordine >=? and data_ordine <= ?";
			query = "select sum((d.prezzo_vendita - d.prezzo_acquisto)*d.qta) " +
			"from scarico o, dettaglio_scarico d, articolo a " +
			"where o.idordine = d.idordine " +
			"and a.idarticolo = d.idarticolo " +
			"and o.ora_ordine >= '"+dalle+"' and o.ora_ordine<='"+alle+"' " +
			"and a.idreparto = ? and data_ordine >= ? and data_ordine <= ?";
		}
		else if ( start != null ){
			query = "select sum((d.prezzo_vendita - d.prezzo_acquisto)*d.qta) " +
			"from scarico o, dettaglio_scarico d, articolo a " +
			"where o.idordine = d.idordine " +
			"and a.idarticolo = d.idarticolo " +
			"and o.ora_ordine >= '"+dalle+"' and o.ora_ordine<='"+alle+"' " +
			"and data_ordine >= ? and data_ordine <= ?";
		}
		else{
			query = "select sum((d.prezzo_vendita - d.prezzo_acquisto)*qta) from articoli_scaricati_view";
		}
		pst = dbm.getNewPreparedStatement(query);
		if ( start != null && idReparto != -1){
			pst.setInt(1, idReparto);
			pst.setDate(2, new java.sql.Date(start.getTime()));
			pst.setDate(3, new java.sql.Date(end.getTime()));
		}
		else if ( start != null ){
			pst.setDate(1, new java.sql.Date(start.getTime()));
			pst.setDate(2, new java.sql.Date(end.getTime()));
		}
		rs = pst.executeQuery();
		//rs = st.executeQuery(query);
		rs.next();
		double tot = rs.getDouble(1);
		if (st != null)
			st.close();
		if (rs != null)
			rs.close();
		return tot;
	}

	public static double getTotIngrossoImposta(int idScarico2)
			throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		ResultSet rs = null;
		Statement st = dbm.getNewStatement();
		String query = "select sum((prezzo_ingrosso/100*iva)*qta) from articoli_scaricati_view where idordine="
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

	public static int insertScaricoInizialeZero(int idArticolo) {
		DBManager dbm = DBManager.getIstanceSingleton();
		// Inseriamo lo scarico all'interno del db
		int idScarico = 0;
		int idCliente = 0;
		String note = "";
		int ok = 0;
		PreparedStatement pst = null;
		try {
			if (!Scarico.isOrderExsist(idScarico)) {

				String update = "insert into scarico values (?,?,?,?,?,?,?,?,?,?)";
				// preleviamo la data di inserimento
				// e la impostiamo nelle proprietà
				java.util.Date data = new java.util.Date();
				Date dataScarico = new Date(data.getTime());
				Time oraScarico = new Time(data.getTime());
				pst = dbm.getNewPreparedStatement(update);
				try {
					pst.setInt(1, idScarico);
					pst.setInt(2, idCliente);
					pst.setDate(3, dataScarico);
					pst.setTime(4, oraScarico);
					pst.setString(5, note);
					pst.setInt(6, 0);
					pst.setString(7, "");
					pst.setDate(8, null);
					pst.setDouble(9, 0);
					pst.setInt(10, Constant.getCodiceIva20());
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
				}//fine finally
			}//fine if
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// Inseriamo l'articolo all'interno del db
		// con qta 0 per effettuare il calcolo della
		// giacenza
		double qta = 0;
		int sconto = 0;
		String query = "insert into dettaglio_scarico values(?,?,?,?)";
		pst = dbm.getNewPreparedStatement(query);
		try {
			pst.setInt(1, idScarico);
			pst.setInt(2, idArticolo);
			pst.setDouble(3, qta);
			pst.setInt(4, sconto);
			// inserimento
			pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (pst != null)
			try {
				pst.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		dbm.notifyDBStateChange();
		return ok;
	}

	/**
	 * @param i
	 * @return
	 * @throws SQLException
	 */
	public static boolean isOrderExsist(int idordine) throws SQLException {
		DBManager dbm = DBManager.getIstanceSingleton();
		Statement st = dbm.getNewStatement();
		ResultSet rs = null;
		String query = "select * from scarico where idordine=" + idordine;
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

	/**
	 * @param i
	 * @return
	 * @throws SQLException
	 */
	public static boolean isNumeroOrdineEsistente(String numDocumento) throws SQLException,NumeroOrdineEsistente {
		DBManager dbm = DBManager.getIstanceSingleton();
		Statement st = dbm.getNewStatement();
		ResultSet rs = null;
		String query = "select num_documento from scarico where num_documento='" + numDocumento+"'";
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

	private Date dataScarico;

	private DBManager dbm;

	private int idCliente;

	private int idScarico;

	private String note;

	private Time oraScarico;

	private Date dataDocumento;

	private String numDocumento;

	private int idDocumento;

	private int idPagamento;
	private int idCausale;
	private double speseIncasso=0;
	private double speseTrasporto=0;
	private Date dataTrasporto;
	private Time oraTrasporto;
	private int colli=0;
	private double peso=0;
	private String consegna;
	private String porto;
	private String destDiversa;
	private int idAspetto;
	private int sconto=0;

	private Vendita vendita;

	private double totIvato = 0;

	private int ivaDocumento;

	private int primaNota;

	private int docEmesso;

	private int docFiscale;

	public Scarico() {
		this.dbm = DBManager.getIstanceSingleton();
	}

	public Scarico(Vendita vendita) {
		this.vendita = vendita;
	}

	public void caricaDati(int id) throws SQLException {
		Statement st = null;
		ResultSet rs = null;
		String query = "select * from scarico where idordine=" + id;
		st = dbm.getNewStatement();
		rs = st.executeQuery(query);
		rs.next();
		this.idScarico = rs.getInt("idordine");
		this.idCliente = rs.getInt("idcliente");
		this.dataScarico = rs.getDate("data_ordine");
		this.oraScarico = rs.getTime("ora_ordine");
		this.note = rs.getString("note");
		this.dataDocumento = rs.getDate("data_documento");
		this.numDocumento = rs.getString("num_documento");
		this.idDocumento = rs.getInt("tipo_documento");
		this.totIvato = rs.getInt("totale_documento");
		this.ivaDocumento = rs.getInt("iva_documento");
		this.docEmesso = rs.getInt("doc_emesso");
		this.docFiscale = rs.getInt("doc_fiscale");
		this.primaNota = rs.getInt("ins_pn");
		idPagamento=rs.getInt("idpagamento");
		idCausale=rs.getInt("idcausale");
		speseIncasso=rs.getDouble("spese_incasso");
		speseTrasporto=rs.getDouble("spese_trasporto");
		dataTrasporto=rs.getDate("data_trasp");
		oraTrasporto=rs.getTime("ora_trasp");
		colli=rs.getInt("colli");
		peso=rs.getDouble("peso");
		consegna=rs.getString("consegna");
		porto=rs.getString("porto");
		destDiversa=rs.getString("diversa_dest");
		idAspetto=rs.getInt("idaspetto");
		sconto=rs.getInt("sconto");

		if (st != null)
			st.close();
	}

	public void deleteArticolo(int idArticolo) throws SQLException {
		String query = "delete from dettaglio_scarico where idArticolo=? and idordine=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, idArticolo);
		pst.setInt(2, idScarico);
		// inserimento
		pst.executeUpdate();
		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public int deleteScarico(int idScarico) throws IDNonValido {

		String delete = "";
		Statement st = dbm.getNewStatement();
		int cancellati = 0;
		if (idScarico <= -1)
			throw new IDNonValido();
		delete = "DELETE FROM scarico WHERE idordine=" + idScarico;

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

	/**
	 * @return the dataScarico
	 */
	public Date getDataScarico() {
		return dataScarico;
	}

	/**
	 * @return the idCliente
	 */
	public int getIdCliente() {
		return idCliente;
	}

	/**
	 * @return the idScarico
	 */
	public int getIdScarico() {
		return idScarico;
	}

	/**
	 *
	 */
	public int getNewID() {
		return dbm.getNewID("scarico", "idordine");

	}

	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @return the oraScarico
	 */
	public Time getOraScarico() {
		return oraScarico;
	}

	public double getQuantitaScaricata(int idArticolo) throws IDNonValido,
			SQLException, ResultSetVuoto {
		if (this.idScarico <= 0)
			throw new IDNonValido();
		String query = "select qta from dettaglio_scarico where idarticolo=? and idordine=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, idArticolo);
		pst.setInt(2, this.idScarico);
		ResultSet rs = pst.executeQuery();
		rs.next();
		if (rs.getRow() < 1)
			throw new ResultSetVuoto();
		double qta = rs.getDouble(1);
		if (pst != null)
			pst.close();
		if (rs != null)
			rs.close();
		return qta;
	}

	public void insertArticolo(int idArticolo, double qta, int sconto,double prezzoAcquisto,double prezzoVendita,int iva)
			throws SQLException {

		String query = "insert into dettaglio_scarico values(?,?,?,?,?,?,?)";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		pst.setInt(1, idScarico);
		pst.setInt(2, idArticolo);
		pst.setDouble(3, qta);
		pst.setInt(4, sconto);
		pst.setDouble(5, prezzoAcquisto);
		pst.setDouble(6, prezzoVendita);
		pst.setInt(7, iva);

		// inserimento
		pst.executeUpdate();

		if (pst != null)
			pst.close();
		updateTotDocumentoIvato(idScarico);
		dbm.notifyDBStateChange();
	}

	/*public int insertScarico(Vendita vendita) throws SQLException {
		// prepariamo i dati da inserire
		setDataDocumento(vendita.getData_vendita());
		setDataScarico(vendita.getData_vendita());
		setIdCliente(vendita.getCliente());
		setIdDocumento(vendita.getTipoDocumento());
		setIdScarico(this.getNewID());
		setNote("");
		setNumDocumento(vendita.getNumVendita());
		setOraScarico(vendita.getOra_vendita());

		// effettuiamo l'inserimento
		int r1 = insertScarico();

		// inseriamo il dettaglio della vendita prelevando i dati
		DettaglioOrdine dv = new DettaglioOrdine();
		Vector<DettaglioOrdine> dett = null;
		// se uguale ad uno è una fattura
		if (vendita.getTipoDocumento() == 1) {
			dett = dv.caricaDatiByDB(vendita.getIdVendita(),
					"dettaglio_ordini", "idordine");
		} else
		// qui siamo nel caso sia una vendita al banco
		if (vendita.getTipoDocumento() == 4) {
			dett = dv.caricaDatiByDB(vendita.getIdVendita(), "dettaglio_ordini",
					"idvendita");
		}

		for (DettaglioOrdine tmp : dett) {
			insertArticolo(tmp.getIdArticolo(), tmp.getQta(), tmp.getSconto(),tmp.getPrezzoAcquisto(),tmp.getPrezzoVendita(),tmp.getIva());
		}
		return r1;
	}*/

	public int insertScarico() {

		idScarico = dbm.getNewID("scarico", "idordine");
		int ok = 0;
		PreparedStatement pst = null;
		String update = "insert into scarico values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		// preleviamo la data di inserimento
		// e la impostiamo nelle proprietà
		java.util.Date data = new java.util.Date();
		this.dataScarico = new Date(data.getTime());
		this.oraScarico = new Time(data.getTime());
		pst = dbm.getNewPreparedStatement(update);
		try {
			pst.setInt(1, idScarico);
			pst.setInt(2, idCliente);
			pst.setDate(3, dataScarico);
			pst.setTime(4, oraScarico);
			pst.setString(5, note);
			pst.setInt(6, this.idDocumento);
			pst.setString(7, numDocumento);
			pst.setDate(8, dataDocumento);
			pst.setDouble(9, this.totIvato);
			pst.setInt(10, ivaDocumento);
			pst.setInt(11, this.docEmesso);
			pst.setInt(12, this.docFiscale);
			pst.setInt(13, primaNota);
			pst.setInt(14, idPagamento);
			pst.setInt(15, idCausale);
			pst.setDouble(16, speseIncasso);
			pst.setDouble(17, speseTrasporto);
			pst.setDate(18, dataTrasporto);
			pst.setTime(19, oraTrasporto);
			pst.setInt(20, colli);
			pst.setDouble(21, peso);
			pst.setString(22, consegna);
			pst.setString(23, porto);
			pst.setString(24, destDiversa);
			pst.setInt(25, idAspetto);
			pst.setInt(26, sconto);
			ok = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			ok = -1;
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				ok = -1;
			}
		}

		dbm.notifyDBStateChange();
		return ok;
	}

	public void updateTotDocumentoIvato(int idScarico2) throws SQLException {
		String query = "update scarico set totale_documento=? where idordine=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);

		pst.setDouble(1, Scarico.getTotIngrossoImponibile(idScarico2)
				+ Scarico.getTotIngrossoImposta(idScarico2));
		pst.setInt(2, idScarico2);
		// inserimento
		pst.executeUpdate();

		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();

	}

	/**
	 * @param i
	 * @return
	 * @throws SQLException
	 */
	public boolean isInsert(int idordine) throws SQLException {
		Statement st = dbm.getNewStatement();
		ResultSet rs = null;
		String query = "select * from scarico where idordine=" + idordine;
		rs = st.executeQuery(query);
		rs.last();
		int nRow = rs.getRow();
		if (nRow <= 0)
			return false;
		return true;
	}

	/**
	 * @param dataScarico
	 *            the dataScarico to set
	 */
	public void setDataScarico(Date dataCarico) {
		this.dataScarico = dataCarico;
	}

	/**
	 * @param idCliente
	 *            the idCliente to set
	 */
	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	/**
	 * @param idScarico
	 *            the idScarico to set
	 */
	public void setIdScarico(int idCarico) {
		this.idScarico = idCarico;
	}

	/**
	 * @param note
	 *            the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * @param oraScarico
	 *            the oraScarico to set
	 */
	public void setOraScarico(Time oraCarico) {
		this.oraScarico = oraCarico;
	}

	public void updateArticolo(int idArticolo, double qta, int sconto,double prezzoAcquisto,double prezzoVendita,int iva)
			throws SQLException {

		String query = "update dettaglio_scarico set qta=?,sconto=?,prezzo_acquisto=?,prezzo_vendita=?,iva=? where idordine=? and idarticolo=?";
		PreparedStatement pst = dbm.getNewPreparedStatement(query);

		pst.setDouble(1, qta);
		pst.setDouble(2, sconto);
		pst.setDouble(3, prezzoAcquisto);
		pst.setDouble(4, prezzoVendita);
		pst.setInt(5, iva);
		pst.setInt(6, idScarico);
		pst.setInt(7, idArticolo);

		// inserimento
		pst.executeUpdate();
		updateTotDocumentoIvato(idScarico);
		if (pst != null)
			pst.close();
		dbm.notifyDBStateChange();
	}

	public int updateScarico() throws IDNonValido {

		if (idScarico <= -1)
			throw new IDNonValido();
		int ok = 0;
		PreparedStatement pst = null;
		String update = "UPDATE scarico SET idordine=?,"
				+ "idcliente=?,data_ordine=?,ora_ordine=?,note=?, tipo_documento=?,num_documento=?," +
						"data_documento=?,totale_documento=?,iva_documento=?,doc_emesso=?,doc_fiscale=?," +
						"ins_pn=?,idpagamento=?,idcausale=?,spese_incasso=?,spese_trasporto=?," +
						"data_trasp=?,ora_trasp=?,colli=?,peso=?,consegna=?,porto=?,diversa_dest=?," +
						"idaspetto=?,sconto=? WHERE idordine=?";

		pst = dbm.getNewPreparedStatement(update);
		try {
			pst.setInt(1, this.idScarico);
			pst.setInt(2, idCliente);
			pst.setDate(3, dataScarico);
			pst.setTime(4, oraScarico);
			pst.setString(5, this.note);
			pst.setInt(6, idDocumento);
			pst.setString(7, numDocumento);
			pst.setDate(8, dataDocumento);
			pst.setDouble(9, totIvato);
			pst.setInt(10, ivaDocumento);
			pst.setInt(11, this.docEmesso);
			pst.setInt(12, this.docFiscale);
			pst.setInt(13, primaNota);
			pst.setInt(14, idPagamento);
			pst.setInt(15, idCausale);
			pst.setDouble(16, speseIncasso);
			pst.setDouble(17, speseTrasporto);
			pst.setDate(18, dataTrasporto);
			pst.setTime(19, oraTrasporto);
			pst.setInt(20, colli);
			pst.setDouble(21, peso);
			pst.setString(22, consegna);
			pst.setString(23, porto);
			pst.setString(24, destDiversa);
			pst.setInt(25, idAspetto);
			pst.setInt(26, sconto);
			pst.setInt(27, idScarico);
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

	private double getTotIvato(int idScarico2) throws SQLException {
		return Scarico.getTotIngrossoImponibile(idScarico2)
				+ Scarico.getTotIngrossoImposta(idScarico2);

	}

	public void setDataDocumento(Date date) {
		this.dataDocumento = date;

	}

	public void setIdDocumento(int idDocumento) {
		this.idDocumento = idDocumento;
	}

	public int getIdDocumento() {
		return idDocumento;
	}

	public void setNumDocumento(String text) {
		this.numDocumento = text;

	}

	public void deleteAllArticoliScaricati() throws SQLException {
		String query = "delete from dettaglio_scarico where idordine="
				+ idScarico;
		Statement st = dbm.getNewStatement();
		st.executeUpdate(query);
		if (st != null)
			st.close();
		dbm.notifyDBStateChange();

	}

	public String getNumDocumento() {
		return this.numDocumento;
	}

	public java.util.Date getDataDocumento() {
		return this.dataDocumento;
	}

	public void setTotaleDocumentoIvato(double tot) {
		this.totIvato = tot;

	}

	public double getTotaleIvato() {
		// TODO Auto-generated method stub
		return this.totIvato;
	}

	public void setIvaDocumento(int iva) {
		// TODO Auto-generated method stub
		this.ivaDocumento = iva;
	}

	public int getIvaDocumento() {
		// TODO Auto-generated method stub
		return this.ivaDocumento;
	}

	public void setInsertByPN(int i) {
		this.primaNota = i;

	}

	public int getInsertByPN() {
		return primaNota;
	}

	public int getColli() {
		return colli;
	}

	public void setColli(int colli) {
		this.colli = colli;
	}

	public String getConsegna() {
		return consegna;
	}

	public void setConsegna(String consegna) {
		this.consegna = consegna;
	}

	public Date getDataTrasporto() {
		return dataTrasporto;
	}

	public void setDataTrasporto(Date dataTrasporto) {
		this.dataTrasporto = dataTrasporto;
	}

	public String getDestDiversa() {
		return destDiversa;
	}

	public void setDestDiversa(String destDiversa) {
		this.destDiversa = destDiversa;
	}

	public int getDocEmesso() {
		return docEmesso;
	}

	public void setDocEmesso(int docEmesso) {
		this.docEmesso = docEmesso;
	}

	public int getDocFiscale() {
		return docFiscale;
	}

	public void setDocFiscale(int docFiscale) {
		this.docFiscale = docFiscale;
	}

	public int getIdAspetto() {
		return idAspetto;
	}

	public void setIdAspetto(int idAspetto) {
		this.idAspetto = idAspetto;
	}

	public int getIdCausale() {
		return idCausale;
	}

	public void setIdCausale(int idCausale) {
		this.idCausale = idCausale;
	}

	public int getIdPagamento() {
		return idPagamento;
	}

	public void setIdPagamento(int idPagamento) {
		this.idPagamento = idPagamento;
	}

	public Time getOraTrasporto() {
		return oraTrasporto;
	}

	public void setOraTrasporto(Time oraTrasporto) {
		this.oraTrasporto = oraTrasporto;
	}

	public double getPeso() {
		return peso;
	}

	public void setPeso(double peso) {
		this.peso = peso;
	}

	public String getPorto() {
		return porto;
	}

	public void setPorto(String porto) {
		this.porto = porto;
	}

	public int getPrimaNota() {
		return primaNota;
	}

	public void setPrimaNota(int primaNota) {
		this.primaNota = primaNota;
	}

	public int getSconto() {
		return sconto;
	}

	public void setSconto(int sconto) {
		this.sconto = sconto;
	}

	public double getSpeseIncasso() {
		return speseIncasso;
	}

	public void setSpeseIncasso(double speseIncasso) {
		this.speseIncasso = speseIncasso;
	}

	public double getSpeseTrasporto() {
		return speseTrasporto;
	}

	public void setSpeseTrasporto(double speseTrasporto) {
		this.speseTrasporto = speseTrasporto;
	}

	public double getTotIvato() {
		return totIvato;
	}

	public void setTotIvato(double totIvato) {
		this.totIvato = totIvato;
	}


}
