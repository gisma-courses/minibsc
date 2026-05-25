package org.openoffice.addon;

import java.awt.Frame;

public class Validator {

	private static String TITLE_LABEL = "Geben Sie einen Titel und ein Label an.";

	private static String TITLE = "Geben Sie einen Titel an.";

	private static String LABEL = "Geben Sie ein Label an.";
	
	private static String TERM = "Geben sie einen Glossareintrag an.";
	
	private static String BIBID = "Geben Sie eine eindeutige Kurzbezeichnung für den Eintrag an.";
	
	private static String BIBIDREF = "Geben Sie eine Referenz an für das Zitat.";
	
	private static String TYPE = "Geben Sie einen Typ für den Eintrag an.";

	public MsgBox validateInput(String input) {
		if (input.equals("title")) {
			MsgBox message = new MsgBox(new Frame("Error"), TITLE, false);
			return message;
		} else if (input.equals("label")) {
			MsgBox message = new MsgBox(new Frame("Error"), LABEL, false);
			return message;
		} else if (input.equals("title_label")) {
			MsgBox message = new MsgBox(new Frame("Error"), TITLE_LABEL, false);
			return message;
		} else if (input.equals("term")) {
			MsgBox message = new MsgBox(new Frame("Error"), TERM, false);
			return message;
		} else if (input.equals("bib_type")) {
			MsgBox message = new MsgBox(new Frame("Error"), TYPE, false);
			return message;
		} else if (input.equals("bib_id")) {
			MsgBox message = new MsgBox(new Frame("Error"), BIBID, false);
			return message;
		} else if (input.equals("bibIDRef")) {
			MsgBox message = new MsgBox(new Frame("Error"), BIBIDREF, false);
			return message;
		}
		return null;
	}
}
