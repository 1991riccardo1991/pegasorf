package rf.utility;

public class Constant {
	
	public static final int ORDINE = 0;
	public static final int CARICO = 1;
	public static final int SCARICO = 2;
	public static final int FATTURA = 3;
	public static final int DOCUMENTO_DI_TRASPORTO = 4;
	public static final String NUM_DOC_SCARICATO_AL_BANCO = "1234";
	public static final int FORNITORE_TABACCHI = 0;
	public static final int REPARTO_TABACCHI = 1;
	public static final int REPARTO_GRATTA_E_VINCI = 4;
	public static final int UNITA_MISURA_PEZZI = 2;
	public static final int CARICO_INIZIALE = 0;
	public static final int CODICE_IVA_20 = 1;
	
	public static int getOrdine() {
		return ORDINE;
	}
	
	public static int getCarico() {
		return CARICO;
	}
	
	public static int getScarico() {
		return SCARICO;
	}
	
	public static int getFattura() {
		return FATTURA;
	}
	
	public static int getDocumentoDiTrasporto() {
		return DOCUMENTO_DI_TRASPORTO;
	}

	public static String getNumeroDocScaricoAlBanco() {
		return NUM_DOC_SCARICATO_AL_BANCO;
	}
	
	public static int getFornitoreTabacchi() {
		return FORNITORE_TABACCHI;
	}
	
	public static int getRepartoTabacchi() {
		return REPARTO_TABACCHI;
	}
	
	public static int getRepartoGrattaEVinci() {
		return REPARTO_GRATTA_E_VINCI;
	}

	public static int getUnitaMisuraPezzi() {
		return UNITA_MISURA_PEZZI;
	}

	public static int getCaricoIniziale() {
		return CARICO_INIZIALE;
	}
	
	public static int getCodiceIva20() {
		return CODICE_IVA_20;
	}
}
